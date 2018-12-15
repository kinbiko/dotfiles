'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var todoist_1 = require('../js/todoist');
var workflow_1 = require('../js/workflow');
var envStub = {
  cache: { seq_no_global: true, item: 'todo' },
  settings: { token: '2' }
};
describe('Unit: Todoist', function() {
  describe('Class: Parser', function() {
    it("should throw when it's initialised with anything but a Query instance", function() {
      var error = 'Parser must be instantiated with a Query instance.';
      expect(function() {
        return new todoist_1.Parser();
      }).toThrow(error);
      expect(function() {
        return new todoist_1.Parser(null);
      }).toThrow(error);
      expect(function() {
        return new todoist_1.Parser(undefined);
      }).toThrow(error);
      expect(function() {
        return new todoist_1.Parser('This is not a Query instance');
      }).toThrow(error);
    });
    it('should instantiate with an empty Query instance', function() {
      expect(function() {
        return new todoist_1.Parser(new workflow_1.Query(''));
      }).not.toThrow();
    });
    describe('getTask()', function() {
      it('should extract the task from a query string', function() {
        var query = new workflow_1.Query(
          'Get milk #Personal @30min !!2, today'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getTask()).toBe('Get milk');
      });
    });
    describe('getTask()', function() {
      it('should extract the task from a query string', function() {
        var query = new workflow_1.Query(
          'Get milk #Personal @30min !!2, today'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getTask()).toBe('Get milk');
      });
      it('should return an empty string if no task exists', function() {
        var query = new workflow_1.Query('#Personal @30min !!2, today');
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getTask()).toBe('');
      });
    });
    describe('getDate()', function() {
      it('should extract the date string from a query string', function() {
        var query = new workflow_1.Query(
          'Get milk #Personal @30min !!2, today'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getDate()).toBe('today');
      });
      it('should return an empty string if no date exists', function() {
        var query = new workflow_1.Query('Get milk #Personal @30min !!2');
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getDate()).toBe('');
      });
    });
    describe('getProject()', function() {
      it("should return the default 'Inbox' when no project is explicity named", function() {
        var query = new workflow_1.Query('Get milk @30min !!2, today');
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getProject()).toBe('Inbox');
      });
      it('should extract the project with # from a query string', function() {
        var query = new workflow_1.Query(
          'Get milk #Personal @30min !!2, today'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getProject()).toBe('Personal');
      });
      it('should extract the project with #[] from a query string', function() {
        var query = new workflow_1.Query(
          'Get milk #[Awaiting response] @30min !!2, today'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getProject()).toBe('Awaiting response');
      });
      it("should prioritize parsing of '#' project over old api style project", function() {
        var query = new workflow_1.Query(
          'Get milk #Personal @30min !!2, today, Awaiting response'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getProject()).toBe('Personal');
      });
    });
    describe('getLabels()', function() {
      it('should extract the labels from a query string', function() {
        var query = new workflow_1.Query(
          'Get milk #Personal @30min @ontheroad !!2, today'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getLabels()).toEqual(['30min', 'ontheroad']);
      });
      it('should return an empty array if no labels exist', function() {
        var query = new workflow_1.Query('Get milk #Personal !!2, today');
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getLabels()).toEqual([]);
      });
    });
    describe('getPriority()', function() {
      it('should extract the priority from a query string', function() {
        var query = new workflow_1.Query(
          'Get milk #Personal @30min !!2, today'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getPriority()).toBe('2');
      });
      it('should ignore more priority match and return only the first match', function() {
        var query = new workflow_1.Query(
          'Get milk #Personal @30min !!2 !!3 !!4, today'
        );
        var parsed = new todoist_1.Parser(query);
        expect(parsed.getPriority()).toBe('2');
      });
    });
  });
  describe('buildUrl()', function() {
    it('should return a valid https options object', function() {
      expect(todoist_1.buildUrl({})).toMatchObject({
        hostname: 'todoist.com',
        path: '/API/v7/sync?'
      });
    });
    it('should serialize an object to a query string', function() {
      var options = todoist_1.buildUrl({
        name: 'todoist',
        year: 2017,
        isQuery: true,
        labels: [1, 2, 3]
      });
      expect(options.path).toBe(
        '/API/v7/sync?name=todoist&year=2017&isQuery=true&labels=1&labels=2&labels=3'
      );
    });
  });
  describe('getResource()', function() {
    it('should return a promise', function() {
      var resource = todoist_1.getResource(envStub, ['dummy']);
      expect(typeof resource.then).toBe('function');
    });
    it('should try a lookup from cache before doing a network request', function() {
      // let env = {
      //   cache: { seq_no_global: true, item: 'todo' },
      //   settings: { token: '2' }
      // };
      // let resource = getResource(env, ['dummy']);
      //
      // expect(resource).resolves.toEqual({
      //   seq_no_global: false,
      //   item: 'todo'
      // });
    });
  });
  describe('getCommand()', function() {
    it('should return a promise', function() {
      var resource = todoist_1.getCommand(envStub, {}, 'method');
      expect(typeof resource.then).toBe('function');
    });
  });
  describe('createItem()', function() {
    // Use spy
    it('should exist', function() {
      expect(todoist_1.createItem(envStub, {})).toBeDefined();
    });
  });
  describe('removeItem()', function() {
    it('should exist', function() {
      expect(todoist_1.removeItem(envStub, {})).toBeDefined();
    });
  });
});
