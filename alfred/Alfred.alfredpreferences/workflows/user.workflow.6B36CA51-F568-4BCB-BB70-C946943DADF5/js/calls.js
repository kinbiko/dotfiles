'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var createFolder = require('mkdirp');
var child_process_1 = require('child_process');
var workflow_1 = require('./workflow');
var utilities_1 = require('./utilities');
var todoist_1 = require('./todoist');
var adapters_1 = require('./adapters');
var taskAdapter = adapters_1.todoist.taskAdapter,
  labelAdapter = adapters_1.todoist.labelAdapter,
  projectAdapter = adapters_1.todoist.projectAdapter,
  priorityAdapter = adapters_1.todoist.priorityAdapter,
  itemArgumentAdapter = adapters_1.todoist.itemArgumentAdapter;
var priorities = [
  { urgency: '1' },
  { urgency: '2' },
  { urgency: '3' },
  { urgency: '4' }
];
// ############################################################################
// # Workflow API calls
// ############################################################################
/**
 * Get project id from Todoist.
 *
 * @author moranje
 * @param {String} name The project's name.
 * @since  2016-07-04
 * @return {void}
 */
function getProjectId(name, env) {
  return todoist_1
    .getResource(env, ['projects'])
    .then(function(data) {
      if (!Array.isArray(data.projects)) return workflow_1.writeError(data);
      var projects = {};
      data.projects.forEach(function(project) {
        projects[project.name.toLowerCase()] = project.id;
      });
      return projects[name.toLowerCase()];
    })
    .catch(function(err) {
      workflow_1.writeError(err);
    });
}
/**
 * Get a list of labels ids from Todoist.
 *
 * @author moranje
 * @param  {String}   names The label names string.
 * @param  {Object}   env   An object with references to data and cache files.
 * @since  2016-07-04
 * @return {void}
 */
function getLabelIds(names, env) {
  return todoist_1
    .getResource(env, ['labels'])
    .then(function(data) {
      if (!Array.isArray(data.labels)) return workflow_1.writeError(data);
      var labels = [];
      data.labels.forEach(function(label) {
        names.forEach(function(name) {
          if (name === label.name) {
            labels.push(label.id);
          }
        });
      });
      return labels;
    })
    .catch(function(err) {
      workflow_1.writeError(err);
    });
}
/**
 * Refreshes the Todoist data cache.
 *
 * @author moranje
 * @since  2016-08-24
 */
function refreshCache(env) {
  todoist_1
    .getResource(env, ['projects', 'items', 'labels'])
    .then(function(data) {
      if (
        JSON.stringify(env.cache) !== JSON.stringify(data) &&
        data.projects &&
        data.labels
      ) {
        var labelList = data.labels.map(function(label) {
          return labelAdapter(label);
        });
        var projectList = data.projects.map(function(project) {
          return projectAdapter(project);
        });
        var priorityList = priorities.map(function(priority) {
          return priorityAdapter(priority);
        });
        utilities_1.writeToFile(
          data,
          env.settings.cache_path + '/todoist.json'
        );
        utilities_1.writeToFile(labelList, 'json/labels.json');
        utilities_1.writeToFile(projectList, 'json/projects.json');
        utilities_1.writeToFile(priorityList, 'json/priorities.json');
      }
    })
    .catch(function(err) {
      workflow_1.writeError(err);
    });
}
exports.refreshCache = refreshCache;
/**
 * Get a capped list of tasks from Todoist.
 *
 * @author moranje
 * @since  2016-07-03
 * @return {void}
 */
// export function getTasksCapped(): void {
//   getResources(settings.token, ['items', 'projects', 'labels'], (err, data) => {
//     if (err) return writeError(err);
//     if (!Array.isArray(data.items)) return writeError(data);
//     var list = new List(
//       data.items.map((task: Task) =>
//         taskAdapter(task, data.projects, data.labels)
//       )
//     );
//
//     return list.capAt(settings.max_items).write();
//   });
// }
// function match(query: string, pattern: RegExp, strip: string): string[] {
//   let matches: string[] | null = query.match(pattern);
//
//   if (matches) {
//     return matches.map(project => project.replace(strip, '').toLowerCase());
//   }
//
//   return [];
// }
//
// function parser(query: string): any {
//   let projects = match(query, /#\S*/gi, '#');
//   let labels = match(query, /@\S*/gi, '@');
//   let priorities = match(query, /!![1-4]/gi, '!!');
//   let task = query
//     .replace(/ ?#\S*/gi, '')
//     .replace(/ ?@\S*/gi, '')
//     .replace(/ ?!![1-4]/gi, '')
//     .trim();
//
//   return { projects, labels, priorities, task };
// }
//
// function filter(parsed: any, data: any): Task[] {
//   let projects: any = {};
//   let labels: any = {};
//   let filtered: Task[] = [];
//
//   data.projects.forEach((project: Project) => {
//     projects[project.id] = project;
//   });
//   data.labels.forEach((label: Label) => {
//     labels[label.id] = label;
//   });
//
//   return data.items
//     .filter((task: Task): boolean => {
//       return (
//         parsed.projects.length === 0 ||
//         parsed.projects.indexOf(
//           projects[task.project_id].name.toLowerCase()
//         ) !== -1
//       );
//     })
//     .filter((task: Task): boolean => {
//       if (parsed.labels.length === 0) return true;
//
//       let labelNames = task.labels.map((id: number) => labels[id].name);
//       let hasLabel = false;
//
//       parsed.labels.forEach((label: string) => {
//         if (labelNames.indexOf(label) !== -1) {
//           hasLabel = true;
//         }
//       });
//
//       return hasLabel;
//     })
//     .filter((task: Task): boolean => {
//       return (
//         parsed.priorities.length === 0 ||
//         parsed.priorities.indexOf(task.priority) !== -1
//       );
//     });
// }
//
// function sort(filtered: Task[]): Task[] {
//   return filtered.sort(function(a, b) {
//     if (a.due_date_utc === null) return 1;
//     if (b.due_date_utc === null) return -1;
//     return +new Date(b.due_date_utc) - +new Date(a.due_date_utc);
//   });
// }
//
// export function search(query: string) {
//   let list = new List();
//   let parsed = parser(query);
//
//   return getResources(
//     settings.token,
//     ['items', 'projects', 'labels'],
//     (err, data) => {
//       let filtered: Task[] = filter(parsed, data); // Filter by projects, labels and priority
//       let sorted: Task[] = sort(filtered); // Sort by due date
//
//       sorted.forEach((task: Task) => {
//         // Strip extra arguments from query
//         if (fuzzy(parsed.task.toLowerCase(), task.content.toLowerCase())) {
//           list.add(taskAdapter(task, data.projects, data.labels));
//         }
//       });
//
//       return list.write();
//     }
//   );
// }
/**
 * Search (fuzzy) the todoist tasks
 *
 * @author moranje
 * @since  2016-08-24
 * @param  {String}   query The search query string.
 * @return {void}
 */
// export function searchTasks(query: string): void {
//   getResources(settings.token, ['items', 'projects', 'labels'], (err, data) => {
//     if (err) return writeError(err);
//     if (!Array.isArray(data.items)) return writeError(data);
//
//     let list = new List();
//
//     data.items.forEach((task: Task) => {
//       if (fuzzy(query.toLowerCase(), task.content.toLowerCase())) {
//         list.add(taskAdapter(task, data.projects, data.labels));
//       }
//     });
//
//     return list.write();
//   });
// }
/**
 * Run configuration code
 *
 * @author moranje
 * @since  2017-08-20
 * @param  {Object}   env environment variables.
 */
function configure(env) {
  var previous = JSON.stringify(env.settings);
  // Guarded edit of settings
  env.settings = utilities_1.safeAddToObject(env.settings, 'language', 'en');
  env.settings = utilities_1.safeAddToObject(env.settings, 'max_items', '9');
  env.settings = utilities_1.safeAddToObject(
    env.settings,
    'anonymous_statistics',
    true
  );
  env.settings = utilities_1.safeAddToObject(env.settings, 'token', '');
  env.settings = utilities_1.safeAddToObject(
    env.settings,
    'uuid',
    utilities_1.uuid()
  );
  env.settings.version = env.package.version;
  // Create these folders if they do not aldready exist
  createFolder.sync(env.settings.data_path);
  createFolder.sync(env.settings.cache_path);
  // Refresh todoist cache
  refreshCache(env);
  // Collect some statistics
  if (env.settings.anonymous_statistics && env.package.first) {
    utilities_1
      .statistics(adapters_1.statisticsAdapter(env.settings))
      .catch(function(err) {
        if (err) workflow_1.writeError(err);
      });
  }
  if (env.package.first) {
    env.package.first = false;
    utilities_1.writeToFile(env.package, 'package.json', true);
  }
  // Save settings if anything changed
  if (previous !== JSON.stringify(env.settings)) {
    utilities_1.writeToFile(
      env.settings,
      env.settings.data_path + '/settings.json'
    );
  }
}
exports.configure = configure;
/**
 * Mark a todo item 'done'.
 *
 * @author moranje
 * @since  2017-08-20
 * @param  {Object}      args Call arguments.
 * @param  {Object}      env  environment variables.
 */
function closeItem(args, env) {
  todoist_1
    .removeItem(env, args)
    .then(function(data) {
      var sync = data.sync_status[Object.keys(data.sync_status)[0]];
      if (sync.error)
        throw new Error(sync.error + ' (' + sync.error_extra + ')');
      workflow_1.write('Task completed!');
    })
    .catch(function(err) {
      workflow_1.writeError(err);
    });
}
exports.closeItem = closeItem;
/**
 * Get individual values from a todo query string.
 *
 * @author moranje
 * @since  2017-08-13
 * @param  {Query}    query The todo Query instance.
 */
function parseTodo(query, lists) {
  var parser = new todoist_1.Parser(query);
  // Set triggers
  var projectList = query
    .trigger(/#[^ ,]{0,3}$/, /#(.*?)$/, new workflow_1.List(lists.projects))
    .autocompleteAll(utilities_1.first(query.find(/^.*#/)));
  var labelList = query
    .trigger(/.*@[^ ,]{0,3}$/, /.*@(.*?)$/, new workflow_1.List(lists.labels))
    .autocompleteAll(utilities_1.first(query.find(/^.*@/)));
  var priorityList = query
    .trigger(/!!$/, /!!(.*?)$/, new workflow_1.List(lists.priorities))
    .autocompleteAll(utilities_1.first(query.find(/^.*!!/)));
  var parsed = parser.getAll();
  // Subtitle logic
  var space = '          ';
  var subtitle = parsed.project.toUpperCase() + space;
  if (parsed.priority) subtitle += '\u203C ' + parsed.priority + space;
  if (parsed.labels.length > 0) subtitle += '\uFF20 ' + parsed.labels + space;
  if (parsed.date) subtitle += '\u29D6 ' + parsed.date + space;
  // Return list from trigger and nothing else
  if (
    projectList.items.length > 0 ||
    labelList.items.length > 0 ||
    priorityList.items.length > 0
  ) {
    return new workflow_1.List()
      .merge(projectList, labelList, priorityList)
      .write();
  }
  return new workflow_1.List([
    {
      title: 'Create new task - ' + parsed.task,
      subtitle: subtitle,
      uid: 'todoist_create_task',
      arg: JSON.stringify(parsed)
    }
  ])
    .autocompleteAll('' + query.query.trim())
    .merge(
      new workflow_1.List(lists.options).autocompleteAll(
        query.query.trim() + ' '
      )
    )
    .write();
}
exports.parseTodo = parseTodo;
/**
 * Add task to todoist.
 *
 * @author moranje
 * @since  2017-08-13
 * @param  {Object}      args The parsed values.
 */
function addTodo(args, env) {
  args['language'] = env.settings.language;
  getProjectId(args.project, env)
    .then(function(projectId) {
      args['projectId'] = projectId;
      return getLabelIds(args.labels, env);
    })
    .then(function(labelIds) {
      args['labelIds'] = labelIds;
      return todoist_1.createItem(env, itemArgumentAdapter(args));
    })
    .then(function(data) {
      var sync = data.sync_status[Object.keys(data.sync_status)[0]];
      if (sync.error)
        throw new Error(
          sync.error + ' (' + JSON.stringify(sync.error_extra) + ')'
        );
      if (sync === 'ok') {
        workflow_1.write('Task added to ' + args.project);
      } else {
        workflow_1.writeError(JSON.stringify(data));
      }
    })
    .catch(function(err) {
      workflow_1.writeError(err);
    });
}
exports.addTodo = addTodo;
function search(query, env) {
  var parsed = new todoist_1.Parser(query).getAll();
  return todoist_1
    .getResource(env, ['projects', 'items', 'labels'])
    .then(function(data) {
      var list = new workflow_1.List(
        data.items.map(function(item) {
          return taskAdapter(item, data.projects, data.labels);
        })
      );
      return list.filter(query.query).write();
    });
}
exports.search = search;
/**
 * Parse setting information
 *
 * @author moranje
 * @since  2017-08-26
 * @param  {Query}    query The setting query.
 */
function parseSetting(query) {
  var value = '<input>';
  var autocomplete = '';
  if (query.find(/^token.*?/) && query.find(/[0-9a-f]{40}$/)) {
    value = utilities_1.first(query.find(/[0-9a-f]{40}$/));
    autocomplete = value;
  }
  if (
    query.find(/^language.*?/) &&
    query.find(/(en|da|pl|zh|ko|de|pt|ja|it|fr|sv|ru|es|nl)$/)
  ) {
    value = utilities_1.first(
      query.find(/(en|da|pl|zh|ko|de|pt|ja|it|fr|sv|ru|es|nl)$/)
    );
    autocomplete = value;
  }
  if (query.find(/^items.*?/) && query.find(/[0-9]+$/)) {
    value = utilities_1.first(query.find(/[0-9]+$/));
    autocomplete = value;
  }
  return new workflow_1.List([
    {
      title: 'Store token',
      subtitle: 'Token: ' + value,
      uid: 't:token',
      autocomplete: 'token ' + autocomplete,
      arg: JSON.stringify({
        call: 'token',
        argument: value,
        success: 'New token stored',
        error: 'not a valid token'
      })
    },
    {
      title: 'Store language',
      subtitle: 'Language: ' + value,
      uid: 't:language',
      autocomplete: 'language ' + autocomplete,
      arg: JSON.stringify({
        call: 'language',
        argument: value,
        success: 'Language set to ' + value,
        error: 'not a valid language'
      })
    },
    {
      title: 'Store max. items shown',
      subtitle: 'Max. items: ' + value,
      uid: 't:max_items',
      autocomplete: 'items ' + autocomplete,
      arg: JSON.stringify({
        call: 'max_items',
        argument: value,
        success: 'Max. items is now ' + value,
        error: 'not a valid number'
      })
    },
    {
      title: 'Install Node.js',
      subtitle:
        "Won't install anything if a node.js version is already present",
      uid: 't:Node',
      autocomplete: 'node',
      arg: JSON.stringify({
        call: 'node'
      })
    }
  ])
    .filter(utilities_1.first(query.find(/^(.*?)(?: |$)/)))
    .write();
}
exports.parseSetting = parseSetting;
/**
 * Store setting information to a file.
 *
 * @author moranje
 * @since  2017-08-26
 * @param  {Object}      arg The arguments passed from parseSetting function.
 * @param  {Object}      env The environment variables.
 */
function addSetting(arg, env) {
  if (arg.call === 'node') {
    // Some things are easier in shell script
    child_process_1.exec('shell/t.node.sh');
  } else if (arg.argument !== '<input>') {
    env.settings[arg.call] = arg.argument;
    utilities_1.writeToFile(
      env.settings,
      env.settings.data_path + '/settings.json'
    );
    workflow_1.write(arg.success);
  } else {
    workflow_1.writeError(arg.error);
  }
}
exports.addSetting = addSetting;
function test() {
  var args = [];
  for (var _i = 0; _i < arguments.length; _i++) {
    args[_i] = arguments[_i];
  }
  console.log(args);
  return args;
}
exports.test = test;
