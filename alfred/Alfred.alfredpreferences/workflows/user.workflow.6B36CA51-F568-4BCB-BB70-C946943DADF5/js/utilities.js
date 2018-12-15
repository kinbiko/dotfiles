'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var fs = require('fs');
var path = require('path');
var querystring = require('querystring');
var workflow_1 = require('./workflow');
var request_1 = require('./request');
/**
 * Use alfred environments to get data and cache files.
 *
 * @author moranje
 * @since  2017-08-13
 * @param  {string}   dataPath  The path to Alfreds data folder.
 * @param  {string}   cachePath The path to Alfreds cache folder.
 * @return {Object}             An object with references to data and cache
 *                              files.
 */
function env(dataPath, cachePath) {
  var settings = {};
  var cache = {};
  var pckage = {};
  if (fs.existsSync(dataPath + '/settings.json')) {
    settings = require(dataPath + '/settings.json');
  }
  settings['data_path'] = dataPath;
  settings['cache_path'] = cachePath;
  if (fs.existsSync(cachePath + '/todoist.json')) {
    cache = require(cachePath + '/todoist.json');
  }
  if (
    require.main &&
    fs.existsSync(
      path.normalize(require.main.filename + '/../..') + '/package.json'
    )
  ) {
    pckage = require(path.normalize(require.main.filename + '/../..') +
      '/package.json');
  }
  return {
    settings: settings,
    cache: cache,
    package: pckage
  };
}
exports.env = env;
/**
 * Global match values in the first RegExp group in a pattern.
 *
 * @author moranje
 * @since  2017-08-03
 * @param  {string}        string  String to match.
 * @param  {RegExp}        pattern The pattern with a group (only matches first)
 * @return {string[]}         Array of matches.
 */
function matchGroups(string, pattern) {
  return (string.match(pattern) || []).map(function(match) {
    return match.replace(pattern, '$1');
  });
}
/**
 * Test if a regular expression holds a group.
 *
 * @author moranje
 * @since  2017-08-03
 * @param  {RegExp}   pattern The RegExp pattern.
 * @return {boolean}          Match or no match.
 */
function hasGroups(pattern) {
  return pattern.source.search(/\(.*?\)/) !== -1;
}
/**
 * Escape special characters in a string.
 *
 * @author moranje
 * @since  2017-08-03
 * @param  {string}   string The string that needs escaping.
 * @return {string}          The escaped string
 */
function escapeRegExp(string) {
  return string.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, '\\$1');
}
/**
 * Match a string or RegExp paatern.
 *
 * @author moranje
 * @since  2017-08-03
 * @param  {string}         string  The string to match.
 * @param  {string|RegExp}  pattern The match pattern
 * @return {string[]}               An array of matches.
 */
function match(string, pattern) {
  if (pattern instanceof RegExp) {
    pattern = new RegExp(pattern.source, 'g');
    if (hasGroups(pattern)) {
      return matchGroups(string, pattern);
    }
  } else {
    pattern = new RegExp(pattern, 'g');
  }
  // Convert Array-like object to Array
  return Array.prototype.slice.call(string.match(pattern) || []);
}
exports.match = match;
/**
 * Replace a pattern in a string.
 *
 * @author moranje
 * @since  2017-08-03
 * @param  {string}         string      The string to replace
 * @param  {string|RegExp}  pattern     The pattern to match
 * @param  {string}         replacement The replacement string, can be $n
 * @return {string}                     The replaced string
 */
function replace(string, pattern, replacement) {
  if (pattern instanceof RegExp) {
    pattern = new RegExp(pattern.source, 'g');
  } else {
    pattern = new RegExp(escapeRegExp(pattern), 'g');
  }
  return string.replace(pattern, replacement);
}
exports.replace = replace;
/**
 * Get the the first item from an array or return null or undefined.
 *
 * @author moranje
 * @since  2017-08-06
 * @param  {any[]|null|undefined} array An array or not...
 * @return {any|null|undefined}         The first or only value.
 */
function first(array) {
  if (Array.isArray(array)) {
    return array[0];
  }
  return array;
}
exports.first = first;
/**
 * Generate a UUID.
 *
 * @author moranje
 * @since  2016-07-03
 * @return {String}
 */
function uuid() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = (Math.random() * 16) | 0,
      v = c == 'x' ? r : (r & 0x3) | 0x8;
    return v.toString(16);
  });
}
exports.uuid = uuid;
/**
 * Sugar for serializing files
 *
 * @author moranje
 * @since  2017-06-11
 * @param  {Object}   data           The object to serialize.
 * @param  {String}   filePath       The file path to serialize to.
 * @param  {boolean}  relativeToRoot Prepend project root
 * @return {void}
 */
function writeToFile(data, filePath, relativeToRoot) {
  if (relativeToRoot === true && require.main) {
    filePath =
      path.normalize(require.main.filename + '/../..') + '/' + filePath;
  }
  fs.writeFile(filePath, JSON.stringify(data), function(err) {
    if (err) return workflow_1.writeError(err);
  });
}
exports.writeToFile = writeToFile;
/**
 * Safely add keys to an object.
 *
 * @author moranje
 * @since  2017-08-20
 * @param  {Object}   object The object.
 * @param  {string}   key      The key.
 * @param  {any}      value    It's value
 * @return {Object}            The mutated object.
 */
function safeAddToObject(object, key, value) {
  if (object === void 0) {
    object = {};
  }
  if (object[key] === undefined) {
    object[key] = value;
  }
  return object;
}
exports.safeAddToObject = safeAddToObject;
/**
 * Send some information on the setup to a google document. The following
 * information is sent:
 *
 * uuid: to identify an installation with anonymously
 * setting information: language, max_items (to get a sense for sensible
 *    defaults)
 * workflow version
 * node.js version
 *
 * @author moranje
 * @since  2017-08-26
 * @param  {Object}   queryParams The information
 * @return {Promise}              A request promise.
 */
function statistics(queryParams) {
  return request_1.request({
    hostname: 'script.google.com',
    path:
      '/macros/s/AKfycbwB-_8anBZGdTKZYUXNfMp86KkEA8Ht1W88TCNlsyehRwrPZoY/exec?' +
      querystring.stringify(queryParams)
  });
}
exports.statistics = statistics;
