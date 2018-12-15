'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var crypto = require('crypto');
var fuzzaldrin_1 = require('fuzzaldrin');
var utilities_1 = require('./utilities');
/**
 * Output to the workflow console
 *
 * @author moranje
 * @since  2017-06-12
 * @param  {Object|String}   output Any output.
 * @return {String}                 Stringified output.
 */
function write() {
  var args = [];
  for (var _i = 0; _i < arguments.length; _i++) {
    args[_i] = arguments[_i];
  }
  var formatted = args.map(function(arg) {
    if (arg instanceof Error) {
      return 'Error: ' + arg.message;
    } else if (typeof arg === 'object') {
      return JSON.stringify(arg);
    }
    return arg;
  });
  return console.log.apply(null, formatted);
}
exports.write = write;
/**
 * A error wrapper for write.
 *
 * @author moranje
 * @since  2017-06-12
 * @param  {Object|String} output The error
 * @return {String}               The error string output
 */
function writeError() {
  var args = [];
  for (var _i = 0; _i < arguments.length; _i++) {
    args[_i] = arguments[_i];
  }
  // Do not modify Error instances
  if (!(args[0] instanceof Error)) {
    // Add Error identifier as first argument
    args.unshift('Error:');
  }
  return write.apply(null, args);
}
exports.writeError = writeError;
/**
 * Class item
 *
 * @author moranje
 * @since  2017-06-12
 * @param  {Object} options Item options
 * @return {Item}           A workflow item
 */
var Item = /** @class */ (function() {
  function Item(options) {
    if (!options.title) {
      throw new Error('Items need at least a title');
    }
    this.title = options.title;
    // Optional values
    this.uid =
      options.uid ||
      crypto
        .createHash('md5')
        .update(options.title)
        .digest('hex');
    this.arg = options.arg || '';
    this.type = options.type || 'default';
    this.valid = options.valid !== undefined ? options.valid : true;
    this.autocomplete = options.autocomplete || '';
    this.icon = options.icon || 'icon.png';
    this.subtitle = options.subtitle || 'Hit ENTER';
  }
  /**
     * Set workflow item title.
     *
     * @author moranje
     * @since  2017-06-20
     * @param  {String}   title The title name.
     */
  Item.prototype.setTitle = function(title) {
    this.title = title;
  };
  /**
     * Set workflow item subtitle.
     *
     * @author moranje
     * @since  2017-06-20
     * @param  {String}   subtitle The subtitle name.
     */
  Item.prototype.setSubtitle = function(subtitle) {
    this.subtitle = subtitle;
  };
  /**
     * Set workflow item argument.
     *
     * @author moranje
     * @since  2017-06-20
     * @param  {String}   arg The workflow argument.
     */
  Item.prototype.setArg = function(arg) {
    this.arg = arg;
  };
  /**
     * Set workflow item autocomplete sequence.
     *
     * @author moranje
     * @since  2017-06-20
     * @param  {String}   autocomplete The workflow autocomplete sequence.
     * @param  {Boolean}  concat       Add before existing value.
     */
  Item.prototype.setAutocomplete = function(autocomplete, concat) {
    if (concat === void 0) {
      concat = false;
    }
    if (concat) {
      this.autocomplete = autocomplete + this.autocomplete;
    } else {
      this.autocomplete = autocomplete;
    }
  };
  /**
     * Output item instance to console.
     *
     * @author moranje
     * @since  2017-06-20
     */
  Item.prototype.write = function() {
    write(this);
  };
  return Item;
})();
exports.Item = Item;
// TODO: View class
// export class View {
//   subject: string;
//   action: string;
//   head: string;
//   tags: string[];
//   dictionary: any;
//   delimiter: string;
//   constructor(
//     subject: string,
//     action: string,
//     head: string,
//     tags: string[],
//     dictionary?: any,
//     delimiter?: string
//   ) {
//     this.subject = subject;
//     this.action = action;
//     this.head = head;
//     this.tags = tags;
//     this.dictionary = dictionary || {};
//     this.delimiter = delimiter || '          ';
//   }
//
//   getHead() {
//     return `${this.head.toUpperCase()}${this.delimiter}`;
//   }
//
//   getTags() {}
//
//   serialize() {
//     return {
//       title: '',
//       subtitle: `${this.getHead()}${this.getHead()}`
//     };
//   }
// }
/**
 * Class list
 *
 * @author moranje
 * @since  2017-06-12
 * @param  {Array}      items An array of items
 * @return {List}             A list of items
 */
var List = /** @class */ (function() {
  function List(items) {
    if (items === void 0) {
      items = [];
    }
    var _this = this;
    this.items = [];
    if (Array.isArray(items)) {
      items.forEach(function(item) {
        _this.add(item);
      });
    }
  }
  /**
     * Add a workflow item to the list.
     *
     * @author moranje
     * @since  2017-06-20
     * @param  {WorkflowItem} item An Alfred workflow item.
     */
  List.prototype.add = function(item) {
    if (item instanceof Item) {
      this.items.push(item);
    } else {
      this.items.push(new Item(item));
    }
  };
  /**
     * Return a list with a secified number of items.
     *
     * @author moranje
     * @since  2017-06-20
     * @param  {Number}   number The amount of items.
     * @return {List}            A List instance.
     */
  List.prototype.capAt = function(number) {
    return new List(this.items.slice(0, number));
  };
  /**
     * Set a autocomplete sequence for all items in the list.
     *
     * @author moranje
     * @since  2017-08-11
     * @param  {string}   autocomplete The autocomplete sequence.
     * @return {List}                  The current List instance.
     */
  List.prototype.autocompleteAll = function(autocomplete) {
    this.items.forEach(function(item) {
      item.setAutocomplete(autocomplete, true);
    });
    return this;
  };
  /**
     * Filter items in list using fuzzy matching.
     *
     * @author moranje
     * @since  2017-08-13
     * @param  {string}   query The search string
     * @return {List}           A new list instance with filtered items.
     */
  List.prototype.filter = function(query) {
    return new List(fuzzaldrin_1.filter(this.items, query, { key: 'title' }));
  };
  /**
     * Merge lists with current instance.
     *
     * @author moranje
     * @since  2017-08-13
     * @param  {List[]}   lists One or more lists to merge.
     * @return {List}           The current list instance.
     */
  List.prototype.merge = function() {
    var _this = this;
    var lists = [];
    for (var _i = 0; _i < arguments.length; _i++) {
      lists[_i] = arguments[_i];
    }
    lists.forEach(function(list) {
      list &&
        list.items.forEach(function(item) {
          _this.add(item);
        });
    });
    return this;
  };
  /**
     * Output list instance to console.
     *
     * @author moranje
     * @since  2017-06-20
     */
  List.prototype.write = function() {
    write({ items: this.items });
  };
  return List;
})();
exports.List = List;
/**
 * The Query class.
 *
 * @author moranje
 * @since  2017-08-13
 * @param  {string|null|undefined} query A string.
 */
var Query = /** @class */ (function() {
  function Query(query) {
    if (query === null || query === undefined) {
      throw new Error('Not a valid query: ' + query);
    }
    this.query = query;
    this.mutated = query;
  }
  /**
     * Find a substring.
     *
     * @author moranje
     * @since  2017-08-13
     * @param  {string|RegExp}      pattern A string matching pattern.
     * @return {Array|null}                 An array of matches or null.
     */
  Query.prototype.find = function(pattern) {
    if (this.mutated.match(pattern)) {
      return utilities_1.match(this.mutated, pattern);
    }
    return null;
  };
  /**
     * Find a substring and remove it memory.
     *
     * @author moranje
     * @since  2017-08-13
     * @param  {string|RegExp}      pattern A string matching pattern.
     * @return {Array|null}                 An array of matches or null.
     */
  Query.prototype.findAndRemove = function(pattern) {
    var removePattern = pattern;
    if (pattern instanceof RegExp) {
      removePattern = new RegExp(pattern.source.replace(/\(|\)/g, ''), 'g');
    }
    var found = this.find(pattern);
    if (found !== null) this.remove(removePattern);
    return found;
  };
  /**
     * Update a substring.
     *
     * @author moranje
     * @since  2017-08-13
     * @param  {string|RegExp}  pattern     A string matching pattern.
     * @param  {string}         replacement The replacemnt (can be a RegExp
     *                                      group).
     * @return {string}                     The mutated query.
     */
  Query.prototype.update = function(pattern, replacement) {
    var mutation = utilities_1.replace(this.mutated, pattern, replacement);
    return (this.mutated = mutation);
  };
  /**
     * Remove a substring from query.
     *
     * @author moranje
     * @since  2017-08-13
     * @param  {string|RegExp}      pattern A string matching pattern.
     * @return {string}                     The mutated query.
     */
  Query.prototype.remove = function(pattern) {
    return this.update(pattern, '');
  };
  /**
     * Set up a pattern to listen for in a query. When a match is found return a
     * list instance. Results are filtered using the 'filterPattern'.
     *
     * @author moranje
     * @since  2017-08-13
     * @param  {string|RegExp}      pattern       The trigger pattern.
     * @param  {string|RegExp}      filterPattern The pattern for filtering
     *                                            results in a list.
     * @param  {List}               list          The list instance.
     * @return {List}                             The filtered list instance.
     */
  Query.prototype.trigger = function(pattern, filterPattern, list) {
    if (this.find(pattern)) {
      var filter_1 = utilities_1.match(this.mutated, filterPattern);
      return list.filter(filter_1[0]);
    }
    // Always return a list instance
    return new List();
  };
  return Query;
})();
exports.Query = Query;
