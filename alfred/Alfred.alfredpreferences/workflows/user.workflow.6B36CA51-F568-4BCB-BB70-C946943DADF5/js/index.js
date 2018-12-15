'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var yargs = require('yargs');
var workflow_1 = require('./workflow');
var utilities_1 = require('./utilities');
var calls_1 = require('./calls');
var query = new workflow_1.Query('');
var args;
var envObject;
yargs
  .option('method', {
    alias: 'm',
    describe: 'Provide a method to call',
    demandOption: true
  })
  .option('query', {
    alias: 'q',
    describe: 'Provide an Alfred query'
  })
  .option('args', {
    alias: 'a',
    describe: 'Provide a JSON string'
  })
  .option('data', {
    alias: 'd',
    describe: 'Provide the path to store data files with Alfred',
    demandOption: true
  })
  .option('cache', {
    alias: 'c',
    describe: 'Provide the path to store cache files with Alfred',
    demandOption: true
  })
  .help().argv;
// Create an object with environment variables
envObject = utilities_1.env(yargs.argv.d, yargs.argv.c);
// Should a query be passed, instantiate a new Query
if (yargs.argv.query) {
  query = new workflow_1.Query(yargs.argv.query);
}
// Should an args argument be supplied, parse it
if (yargs.argv.args) {
  args = JSON.parse(yargs.argv.args);
}
if (yargs.argv.m === 'configure') {
  calls_1.configure(envObject);
} else if (yargs.argv.m === 'refreshCache') {
  calls_1.refreshCache(envObject);
} else if (yargs.argv.m === 'parseTodo') {
  var options = require('../json/todo-options.json');
  var projects = require('../json/projects.json');
  var labels = require('../json/labels.json');
  var priorities = require('../json/priorities.json');
  calls_1.parseTodo(query, {
    options: options,
    projects: projects,
    labels: labels,
    priorities: priorities
  });
} else if (yargs.argv.m === 'addTodo') {
  calls_1.addTodo(args, envObject);
} else if (yargs.argv.m === 'search') {
  calls_1.search(query, envObject);
} else if (yargs.argv.m === 'closeItem') {
  calls_1.closeItem(args, envObject);
} else if (yargs.argv.m === 'parseSetting') {
  calls_1.parseSetting(query);
} else if (yargs.argv.m === 'addSetting') {
  calls_1.addSetting(args, envObject);
}
