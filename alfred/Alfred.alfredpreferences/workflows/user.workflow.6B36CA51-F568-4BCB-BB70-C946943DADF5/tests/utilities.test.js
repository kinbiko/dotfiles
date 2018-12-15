'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var utilities_1 = require('../js/utilities');
describe('Unit: Utilities', function() {
  describe('match()', function() {
    it('should return single matches for string patterns', function() {
      expect(
        utilities_1.match('Check out this @interesting @work', '@work')
      ).toEqual(['@work']);
    });
    it('should return multiple matches for string patterns', function() {
      expect(
        utilities_1.match('Check out this @interesting @work', '@')
      ).toEqual(['@', '@']);
    });
    it('should return multiple matches for string patterns', function() {
      expect(
        utilities_1.match('Check out this @interesting @work', '@')
      ).toEqual(['@', '@']);
    });
    it('should return single matches for regex patterns', function() {
      expect(
        utilities_1.match('Check out this @interesting @work', /@in[^ ]+/)
      ).toEqual(['@interesting']);
    });
    it('should return multiple matches for regex patterns', function() {
      expect(
        utilities_1.match('Check out this @interesting @work', /@[^ ]+/)
      ).toEqual(['@interesting', '@work']);
    });
    it('should return a ampty array when no match exists', function() {
      expect(
        utilities_1.match('Check out this @interesting @work', '!')
      ).toEqual([]);
      expect(
        utilities_1.match('Check out this @interesting @work', /!/)
      ).toEqual([]);
      // expect(match('Check out this @interesting @work', '')).toEqual([]);
      // expect(match('', '')).toEqual([]);
    });
  });
  describe('replace()', function() {
    it('should replace string patterns', function() {
      expect(
        utilities_1.replace('Check out this @interesting @work', ' @work', '')
      ).toBe('Check out this @interesting');
    });
    it('should replace string patterns', function() {
      expect(
        utilities_1.replace('Check out this @interesting @work', ' @work', '')
      ).toBe('Check out this @interesting');
    });
    it('should replace multiple regex matches', function() {
      expect(
        utilities_1.replace(
          'Check out this @interesting @work',
          / ?@[^ ]+ ?/,
          ''
        )
      ).toBe('Check out this');
    });
  });
  describe('first()', function() {
    it('should return the first array item', function() {
      expect(utilities_1.first(['first', 'second', 'third'])).toBe('first');
    });
    it('should return undefined for empty arrays', function() {
      expect(utilities_1.first([])).toBe(undefined);
    });
    it('should return anything else if the value is not an array', function() {
      expect(utilities_1.first(null)).toBe(null);
      expect(utilities_1.first(undefined)).toBe(undefined);
    });
  });
  describe('uuid()', function() {
    it('should always output a valid uuid', function() {
      // Valid RFC4122 UUID
      var uuidMatch = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
      // Generate 5 uuids
      for (var i = 0; i <= 10; i++) {
        expect(utilities_1.uuid()).toMatch(uuidMatch);
      }
    });
  });
  describe('safeAddToObject()', function() {
    var todo = { remember: 'milk' };
    it('should add a property to an object', function() {
      expect(utilities_1.safeAddToObject(todo, 'time', 11)).toMatchObject(
        Object.assign({}, todo, { time: 11 })
      );
    });
    it('should not overwrite existing properties', function() {
      expect(
        utilities_1.safeAddToObject(todo, 'remember', 'appointment')
      ).toMatchObject({
        remember: 'milk'
      });
    });
  });
});
