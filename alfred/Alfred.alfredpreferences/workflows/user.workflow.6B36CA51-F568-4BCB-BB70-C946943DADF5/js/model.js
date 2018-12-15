'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var request = require('request-promise');
var Model = /** @class */ (function() {
  function Model(type, uri) {
    if (type === void 0) {
      type = null;
    }
    if (uri === void 0) {
      uri = 'https://beta.todoist.com/API/v8/';
    }
    this.type = type;
    this.uri = uri;
  }
  Model.prototype.find = function(id, options) {
    // Check cache
    return request({
      uri: '' + this.uri + this.type + 's/' + id,
      qs: options.queryparams,
      headers: options.headers,
      json: true
    });
  };
  Model.prototype.query = function(options) {
    return this.findAll(options).filter(function() {
      // Do something
      return true;
    });
  };
  Model.prototype.findAll = function(options) {
    // Check cache
    return request({
      uri: '' + this.uri + this.type + 's',
      qs: options.queryparams,
      headers: options.headers,
      json: true
    });
  };
  Model.prototype.create = function(options) {
    return request({
      method: 'POST',
      uri: '' + this.uri + this.type + 's',
      qs: options.queryparams,
      headers: options.headers,
      json: true
    });
  };
  Model.prototype.update = function(options) {
    return request({
      method: 'POST',
      uri: '' + this.uri + this.type + 's',
      qs: options.queryparams,
      headers: options.headers,
      json: true
    });
  };
  Model.prototype.remove = function(options) {
    return request({
      method: 'POST',
      uri: '' + this.uri + this.type + 's',
      qs: options.queryparams,
      headers: options.headers,
      json: true
    });
  };
  return Model;
})();
