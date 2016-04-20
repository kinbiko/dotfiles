'use babel';

import fs from 'fs-extra';
import temp from 'temp';
import { vouch } from 'atom-build-spec-helpers';
import { provideBuilder } from '../lib/gradle';

describe('gradle', () => {
  let directory;
  let builder;
  const Builder = provideBuilder();

  beforeEach(() => {
    waitsForPromise(() => {
      return vouch(temp.mkdir, 'atom-build-gradle-spec-')
        .then((dir) => directory = `${dir}/`)
        .then((dir) => builder = new Builder(dir));
    });
  });

  afterEach(() => {
    fs.removeSync(directory);
  });

  describe('build.gradle file exists and wrapper is installed', () => {
    beforeEach(() => {
      waitsForPromise(() => vouch(fs.copy, `${__dirname}/fixture/build.gradle`, `${directory}/build.gradle`));
      waitsForPromise(() => vouch(fs.copy, `${__dirname}/fixture/wrapper`, directory));
    });

    it('should be eligible', () => {
      expect(builder.isEligible()).toEqual(true);
    });

    it('should resolve tasks in settings', () => {
      waitsForPromise(() => {
        expect(builder.isEligible()).toEqual(true);
        return builder.settings().then((settings) => {
          const targets = settings.map(s => s.name);
          const atLeast = [ 'Gradle: init', 'Gradle: wrapper', 'Gradle: dependencies', 'Gradle: help', 'Gradle: wheelOfTime' ];
          const missing = atLeast.filter((e) => targets.indexOf(e) === -1);
          expect(missing.length).toEqual(0);
          const target = settings.find(s => s.name === 'Gradle: wheelOfTime');
          expect(target.exec).toBe(`${directory}gradlew`);
          expect(target.sh).toBe(false);
          expect(target.args).toEqual([ 'wheelOfTime' ]);
          expect(target.errorMatch.length).toBeGreaterThan(1);
        });
      });
    });
  });

  describe('build.gradle exists, but no wrapper installed', () => {
    beforeEach(() => {
      waitsForPromise(() => vouch(fs.copy, `${__dirname}/fixture/build.gradle`, `${directory}/build.gradle`));
    });

    it('should be eligible', () => {
      expect(builder.isEligible()).toEqual(true);
    });

    it('should error when trying to get settings', () => {
      waitsForPromise(() => {
        expect(builder.isEligible()).toEqual(true);
        // Make sure no potential global gradle gets picked up
        const ORIG_PATH = process.env.PATH;
        process.env.PATH = '';
        return builder.settings().then(() => {
          expect(true).toBe(false);
          throw new Error('retrieved settings with no gradlew');
        }).catch(e => {
          expect(e.code).toBe(127);
        }).finally(() => process.env.PATH = ORIG_PATH);
      });
    });
  });

  describe('build.gradle file does not exist', () => {
    it('should not be eligible', () => {
      expect(builder.isEligible()).toEqual(false);
    });
  });
});
