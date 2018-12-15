'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var todoist_1 = require('./todoist');
/******************************************************************************
 * TODOIST
 ******************************************************************************/
exports.todoist = {
  /**
   * Adapter for tasks retrieved from todoists API.
   *
   * @author moranje
   * @since  2017-06-17
   * @param  {Task}         task     An item (task) object from todoist.
   * @param  {Array}        projects An array of projects from todoist.
   * @param  {Array}        labels   An array of labels from todoist.
   * @return {WorkflowItem}          An Alfred workflow item.
   */
  taskAdapter: function(task, projects, labels) {
    return {
      title: task.content || '',
      subtitle: todoist_1.taskString(task, projects, labels),
      arg: JSON.stringify({ id: task.id }),
      valid: true
    };
  },
  /**
   * Adapter for projects retrieved from todoists API.
   *
   * @author moranje
   * @since  2017-06-17
   * @param  {Project}       project A project object from todoist.
   * @return {WorkflowItem}          An Alfred workflow item.
   */
  projectAdapter: function(project) {
    var autocomplete = '';
    if (project.name) {
      autocomplete =
        project.name.indexOf(' ') >= 0
          ? '[' + project.name + ']'
          : project.name;
    }
    return {
      title: project.name || '',
      subtitle: 'Add to ' + (project.name || 'none'),
      arg: JSON.stringify({ id: project.id || -1 }),
      valid: false,
      autocomplete: autocomplete,
      icon: { path: 'project.png' }
    };
  },
  /**
   * Adapter for labels retrieved from todoists API.
   *
   * @author moranje
   * @since  2017-06-17
   * @param  {Label}        label A label object from todoist
   * @return {WorkflowItem}       An Alfred workflow item.
   */
  labelAdapter: function(label) {
    return {
      title: label.name || '',
      subtitle: 'Add ' + (label.name || 'label') + ' to task',
      arg: JSON.stringify({ id: label.id || -1 }),
      valid: false,
      autocomplete: label.name || '',
      icon: { path: 'label.png' }
    };
  },
  /**
   * Adapter for a priority item.
   *
   * @author moranje
   * @since  2017-06-17
   * @param  {Object}          object A priority object.
   * @return {WorkflowItem}           An Alfred workflow item.
   */
  priorityAdapter: function(object) {
    return {
      title: object.urgency || '',
      subtitle: 'Set task priority to ' + (object.urgency || 1),
      valid: false,
      autocomplete: object.urgency || '',
      icon: { path: 'priority.png' }
    };
  },
  /**
   * An adapter for formatting task options for the todoist 'Item' API.
   *
   * @author moranje
   * @since  2017-08-13
   * @param  {Object}      args The tasks' option values.
   * @return {Object}           The adapted item object.
   */
  itemArgumentAdapter: function(args) {
    return {
      content: args.task || '',
      date_string: args.date || '',
      project_id: args.projectId || '',
      labels: args.labelIds || '',
      priority: args.priority || '',
      date_lang: args.language || ''
    };
  }
};
/******************************************************************************
 * UTILITIES
 ******************************************************************************/
/**
 * Whitelist certain settings to make sure none are sent unintentionally
 *
 * @author moranje
 * @since  2017-08-26
 * @param  {Object}      settings The env.settings object.
 * @return {Object}               A whitelisted settings object.
 */
function statisticsAdapter(settings) {
  return {
    uuid: settings.uuid,
    language: settings.language,
    max_items: settings.max_items,
    version: settings.version,
    nodejs: process.version
  };
}
exports.statisticsAdapter = statisticsAdapter;
