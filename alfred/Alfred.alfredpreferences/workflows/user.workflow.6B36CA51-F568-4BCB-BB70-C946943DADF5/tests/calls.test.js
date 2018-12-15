'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var workflow_1 = require('../js/workflow');
var calls_1 = require('../js/calls');
describe('Intergration: Calls', function() {
  var query = new workflow_1.Query(
    'Get milk @30min @shopping !!2 #[On the road], today'
  );
  describe('getProjectId()', function() {
    it('should', function() {});
  });
  describe('getLabelIds()', function() {
    it('should', function() {});
  });
  describe('refreshCache()', function() {
    it('should', function() {});
  });
  describe('configure()', function() {
    it('should', function() {});
  });
  describe('closeItem()', function() {
    it('should', function() {});
  });
  describe('parseTodo()', function() {
    it('should always return a list with a single "New task" item ', function() {
      var spy = jest.spyOn(console, 'log');
      calls_1.parseTodo(query, {
        projects: null,
        labels: null,
        priorities: null
      });
      expect(spy).toHaveBeenCalledWith(
        JSON.stringify(
          new workflow_1.List([
            {
              title: 'Create new task - Get milk',
              subtitle:
                'ON THE ROAD          ‼ 2          ＠ 30min,shopping          ⧖ today          ',
              uid: 'todoist_create_task',
              arg: JSON.stringify({
                labels: ['30min', 'shopping'],
                priority: '2',
                project: 'On the road',
                date: 'today',
                task: 'Get milk'
              })
            }
          ]).autocompleteAll(
            'Get milk @30min @shopping !!2 #[On the road], today'
          )
        )
      );
    });
  });
  describe('addTodo()', function() {
    it('should', function() {});
  });
  describe('search()', function() {
    it('should', function() {});
  });
  describe('parseSetting()', function() {
    it('should', function() {});
  });
  describe('addSetting()', function() {
    it('should', function() {});
  });
});
