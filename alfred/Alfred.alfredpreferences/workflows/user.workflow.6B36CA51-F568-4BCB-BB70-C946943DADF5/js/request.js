'use strict';
Object.defineProperty(exports, '__esModule', { value: true });
var es6_promise_1 = require('es6-promise');
var follow_redirects_1 = require('follow-redirects');
/**
 * Make a request that returns a promise.
 *
 * @author moranje
 * @since  2016-07-03
 * @param  {Object}   options   The query parameters.
 */
function request(options) {
  return new es6_promise_1.Promise(function(resolve, reject) {
    var req = follow_redirects_1.https.get(options, function(res) {
      var data = '';
      res.on('data', function(chunk) {
        data += chunk;
      });
      res.on('end', function() {
        resolve(JSON.parse(data));
      });
      // Return response errors
      res.on('error', function(err) {
        reject(err);
      });
    });
    // Return request errors
    req.on('error', function(err) {
      reject(err);
    });
  });
}
exports.request = request;
