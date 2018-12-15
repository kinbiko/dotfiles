'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var adapters_1 = require('../js/adapters');
var taskAdapter = adapters_1.todoist.taskAdapter,
  projectAdapter = adapters_1.todoist.projectAdapter,
  labelAdapter = adapters_1.todoist.labelAdapter,
  priorityAdapter = adapters_1.todoist.priorityAdapter,
  itemArgumentAdapter = adapters_1.todoist.itemArgumentAdapter;
describe('Unit: Adapters', function() {
  describe('taskAdapter()', function() {
    var match = {
      title: '',
      subtitle: 'INBOX           (↵ to complete)',
      arg: '{}',
      valid: true
    };
    var extra = Object.assign({}, match, {
      this: '',
      is: '',
      matched: ''
    });
    it('should adapt api properties', function() {
      expect(taskAdapter(extra)).toMatchObject(match);
    });
  });
  describe('projectAdapter()', function() {
    var match = {
      title: '',
      subtitle: 'Add to none',
      arg: '{"id":-1}',
      valid: false,
      autocomplete: ''
    };
    var extra = Object.assign({}, match, {
      this: '',
      name: '',
      matched: ''
    });
    it('should adapt api properties', function() {
      expect(projectAdapter(extra)).toMatchObject(match);
    });
    it('should add project name to autocomplete', function() {
      extra.name = 'Work';
      match.autocomplete = 'Work';
      match.title = 'Work';
      match.subtitle = 'Add to Work';
      expect(projectAdapter(extra)).toMatchObject(match);
    });
    it('should add surround multi word projects with brackets', function() {
      extra.name = 'Work load';
      match.autocomplete = '[Work load]';
      match.title = 'Work load';
      match.subtitle = 'Add to Work load';
      expect(projectAdapter(extra)).toMatchObject(match);
    });
  });
  describe('labelAdapter()', function() {
    var match = {
      title: '',
      subtitle: 'Add label to task',
      arg: '{"id":-1}',
      valid: false,
      autocomplete: ''
    };
    var extra = Object.assign({}, match, {
      this: '',
      is: '',
      matched: ''
    });
    it('should adapt api properties', function() {
      expect(labelAdapter(extra)).toMatchObject(match);
    });
  });
  describe('priorityAdapter()', function() {
    var match = {
      title: '',
      subtitle: 'Set task priority to 1',
      valid: false,
      autocomplete: ''
    };
    var extra = Object.assign({}, match, {
      this: '',
      is: '',
      matched: ''
    });
    it('should adapt api properties', function() {
      expect(priorityAdapter(extra)).toMatchObject(match);
    });
  });
  describe('itemArgumentAdapter()', function() {
    var match = {
      content: '',
      date_string: '',
      project_id: '',
      labels: '',
      priority: '',
      date_lang: ''
    };
    var extra = Object.assign({}, match, {
      this: '',
      is: '',
      matched: ''
    });
    it('should adapt api properties', function() {
      expect(itemArgumentAdapter(extra)).toMatchObject(match);
    });
  });
  describe('statisticsAdapter()', function() {
    var match = {
      uuid: '',
      language: '',
      max_items: '',
      version: '',
      nodejs: process.version
    };
    var extra = Object.assign({}, match, {
      this: '',
      is: '',
      matched: ''
    });
    it('should whitelist safe properties', function() {
      expect(adapters_1.statisticsAdapter(extra)).toMatchObject(match);
    });
  });
});
