'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var querystring = require('querystring');
var es6_promise_1 = require('es6-promise');
var workflow_1 = require('./workflow');
var utilities_1 = require('./utilities');
var request_1 = require('./request');
/**
 * Create a subtitle string with the available information a task object.
 *
 * @author moranje
 * @since  2017-06-17
 * @param  {Task}         task     An item (task) object from todoist.
 * @param  {Array}        projects An array of projects from todoist.
 * @param  {Array}        labels   An array of labels from todoist.
 * @return {String}                A subtitle string.
 */
function taskString(task, projects, labels) {
  if (projects === void 0) {
    projects = [];
  }
  if (labels === void 0) {
    labels = [];
  }
  // TODO: Fugly
  var space = '          ';
  var string = '';
  var projectName = 'INBOX';
  var labelNames = [];
  labels.forEach(function(label) {
    task.labels.forEach(function(id) {
      if (id === label.id) {
        labelNames.push(label.name);
      }
    });
  });
  projects.forEach(function(project) {
    if (project.id === task.project_id) {
      projectName = '' + project.name.toUpperCase();
    }
  });
  string += '' + projectName + space;
  if (task.date_string) {
    string += '' + task.date_string + space;
  }
  if (task.priority > 1) {
    string += '\u203C ' + task.priority + space;
  }
  if (labelNames.length > 0) {
    string += '\uFF20 ' + labelNames.join(',') + space;
  }
  return string + ' (\u21B5 to complete)';
}
exports.taskString = taskString;
/**
 * A Todoist query parser.
 *
 * @author moranje
 * @since  2017-08-13
 * @param  {Query}    query The query instance.
 */
var Parser = /** @class */ (function() {
  function Parser(query) {
    if (!(query instanceof workflow_1.Query)) {
      throw new Error('Parser must be instantiated with a Query instance.');
    }
    this.query = query;
  }
  /**
     * Get task from query.
     *
     * @author moranje
     * @since  2017-08-13
     * @return {string}   The task description.
     */
  Parser.prototype.getTask = function() {
    this.query.remove(/#\[.*?\] ?/);
    this.query.remove(/#[^ ,]* ?/);
    this.query.remove(/@[^ ,]* ?/);
    this.query.remove(/!![1-4] ?/);
    var delimited = this.query.mutated.split(',');
    // Restore original query
    this.query.mutated = this.query.query;
    return (delimited[0] || '').trim();
  };
  /**
     * Get dat from query
     *
     * @author moranje
     * @since  2017-08-13
     * @return {string}   The date.
     */
  Parser.prototype.getDate = function() {
    this.query.remove(/#\[.*?\] ?/);
    this.query.remove(/#[^ ,]* ?/);
    this.query.remove(/@[^ ,]* ?/);
    this.query.remove(/!![1-4] ?/);
    var delimited = this.query.mutated.split(',');
    // Restore original query
    this.query.mutated = this.query.query;
    return (delimited[1] || '').trim();
  };
  /**
     * Get project from query.
     *
     * @author moranje
     * @since  2017-08-13
     * @return {string}   The project name.
     */
  Parser.prototype.getProject = function() {
    var project = utilities_1.first(this.query.find(/#\[(.*?)\]/));
    if (!project) {
      project = utilities_1.first(this.query.find(/#([^ ,]*)/));
    }
    return project || 'Inbox';
  };
  /**
     * Get labels from query.
     *
     * @author moranje
     * @since  2017-08-13
     * @return {string[]} An array of label names.
     */
  Parser.prototype.getLabels = function() {
    return this.query.find(/@([^ ,]*)/) || [];
  };
  /**
     * Get priority from query.
     *
     * @author moranje
     * @since  2017-08-13
     * @return {string}   The priority from 1 to 4.
     */
  Parser.prototype.getPriority = function() {
    return utilities_1.first(this.query.find(/!!([1-4])/)) || 1;
  };
  /**
     * Get an object with all values. 'getTask' modifies querystring so should be
     * run last.
     *
     * @author moranje
     * @since  2017-08-13
     * @return {Object}      An object with parsed values.
     */
  Parser.prototype.getAll = function() {
    return {
      labels: this.getLabels(),
      priority: this.getPriority(),
      project: this.getProject(),
      date: this.getDate(),
      task: this.getTask()
    };
  };
  return Parser;
})();
exports.Parser = Parser;
/******************************************************************************
 * API calls
 ******************************************************************************/
/**
  * Build the url to the Todoist API.
  *
  * @author moranje
  * @since  2016-07-03
  * @param  {Object}   queryParams API params.
  * @return {Object}
  */
function buildUrl(queryParams) {
  return {
    hostname: 'todoist.com',
    path: '/API/v7/sync?' + querystring.stringify(queryParams)
  };
}
exports.buildUrl = buildUrl;
/**
 * Get one or more resources from the todoist API
 *
 * @author moranje
 * @since  2017-06-12
 * @param  {Object}   env   An object with references to data and cache files.
 * @param  {Array}    types The resource types
 * @return {Promise}        The API response
 */
function getResource(env, types) {
  if (env.cache.seq_no_global) {
    return es6_promise_1.Promise.resolve(env.cache);
  }
  return request_1.request(
    buildUrl({
      token: env.settings.token,
      seq_no: 0,
      resource_types: JSON.stringify(types)
    })
  );
}
exports.getResource = getResource;
/**
 * Create a todoist item (task).
 *
 * @author moranje
 * @since  2016-07-03
 * @param  {Object}   env     An object with references to data and cache files.
 * @param  {Object}   args    Todoist item arguments.
 * @param  {String}   method  The todoist item method to call.
 * @return {Promise}          The API response
 */
function getCommand(env, args, method) {
  return request_1.request(
    buildUrl({
      token: env.settings.token,
      commands: JSON.stringify([
        {
          type: method,
          temp_id: '',
          uuid: utilities_1.uuid(),
          args: args
        }
      ])
    })
  );
}
exports.getCommand = getCommand;
/**
 * Create a todoist item (task).
 *
 * @author moranje
 * @since  2016-07-03
 * @param  {Object}   env     An object with references to data and cache files.
 * @param  {Object}   args    Todoist item arguments
 * @return {Promise}          The API response
 */
function createItem(env, args) {
  return getCommand(env, args, 'item_add');
}
exports.createItem = createItem;
/**
 * Mark a task 'done'.
 *
 * @author moranje
 * @since  2016-07-03
 * @param  {Object}   env     An object with references to data and cache files.
 * @param  {Object}   args    A task id.
 * @return {Promise}          The API response
 */
function removeItem(env, args) {
  return getCommand(env, args, 'item_close');
}
exports.removeItem = removeItem;
