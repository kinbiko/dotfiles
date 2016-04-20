'use babel';
'use strict';

import { existsSync, stat, watch } from 'fs';
import os from 'os';
import path from 'path';
import Promise from 'bluebird';
import { exec } from 'child_process';
import EventEmitter from 'events';

export function provideBuilder() {
  const statAsync = Promise.promisify(stat);
  const execAsync = Promise.promisify(exec);
  const errorMatch = [
    '(?<file>/[^:\\n]+\\.java):(?<line>\\d+):',
    '(?::compile(?:Api)?(?:Scala|Java|Groovy))?(?<file>.+):(?<line>\\d+):\\s.+[;:]'
  ];

  const lineToTask = function (line) {
    /* jshint validthis:true */
    if (line.match(/^[\w ]+? tasks$/)) {
      this.state = 'header';
      return null;
    }

    if ('header' === this.state && line.match(/^-+$/)) {
      this.state = 'divider';
      return null;
    }

    if (-1 !== [ 'divider', 'task' ].indexOf(this.state)) {
      this.state = 'task';
      const match = line.match(/^([^\s]+).*$/);
      if (!match) {
        this.state = 'idle';
        return null;
      }
      return match[1];
    }
  };

  const taskToConfig = function (executable, task) {
    return {
      name: 'Gradle: ' + task,
      exec: executable,
      args: [ task ],
      errorMatch: errorMatch,
      sh: false
    };
  };

  return class GradleBuildProvider extends EventEmitter {
    constructor(cwd) {
      super();
      this.cwd = cwd;
      this.fileWatcher = null;
    }

    getNiceName() {
      return 'Gradle';
    }

    isEligible() {
      this.file = path.join(this.cwd, 'build.gradle');
      return existsSync(this.file);
    }

    settings() {
      const refresh = new Date();
      this.fileWatcher = watch(this.file, () => {
        // Gradle touches the file when it's done, which will trigger this watch to
        // go off again. Require at least 3 second to pass before refreshing.
        if (new Date() - refresh > 3000) {
          this.emit('refresh');
        }
      });

      const wrapperFile = /^win/.test(process.platform) ? 'gradlew.bat' : 'gradlew';
      let executable;
      return statAsync(path.join(this.cwd, wrapperFile)).then(() => {
        executable = path.join(this.cwd, wrapperFile);
      }).catch(err => {
        executable = 'gradle';
      }).then(() => {
        return execAsync(executable + ' tasks', { cwd: this.cwd });
      }).then(outputBuffer => {
        const lineContext = { state: 'idle' };
        return outputBuffer
          .toString('utf8')
          .split(os.EOL)
          .map(lineToTask.bind(lineContext))
          .filter(Boolean)
          .map(taskToConfig.bind(null, executable));
      });
    }
  };
}
