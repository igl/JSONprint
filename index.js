'use strict';
var util = require('util');

/*
* printJSON
* module.exports(object)
* exports.log(object)
* exports.config(object)
*/

var colors = require('./lib/colors');

var cfg = {
	 'quote': '"'
	,'quoteKeys': true
	,'colors': true
	,'collapseArray': true
	,'commaFirst': true
};

exports = module.exports = function printJSON(obj) {
	var res = ''
	,	depth = 0;

	if (typeof obj === 'string')
		obj = JSON.parse(obj);

	return (function reiterate(o) {
		var isArray = o instanceof Array
		,	tabs = ''
		,	length = 0
		,	i = 0;

		depth += 1;

		res += isArray ? '[' : '{';
		for (i = 0; i < depth; i += 1) tabs += '\t';

		for (var k in o) {
			if (cfg.commaFirst) {
				res += (isArray && cfg.collapseArray) ? '' : '\n' + tabs;
				if (length > 0) res += ', ';
			} else {
				if (length > 0) res += ', ';
				res += (isArray && cfg.collapseArray) ? '' : '\n' + tabs;
			}

			length += 1;

			if (!isArray) {
					if (cfg.quoteKeys) {
						res += cfg.quote + k + cfg.quote + ': ';
					} else {
						res += k + ': ';
					}
			}
			if (typeof o[k] === 'object') {
				if (o[k] instanceof RegExp) {
					if (cfg.colors) res += colors.red[0];
					res += o[k]
					if (cfg.colors) res += colors.red[1];
				} else {
					reiterate( o[k] );
				}
			} else if (typeof o[k] === 'number') {
				if (cfg.colors) res += colors.yellow[0];
				res += o[k]
				if (cfg.colors) res += colors.yellow[1];
			} else if (typeof o[k] === 'string') {
				if (cfg.colors) res += colors.green[0];
				res += cfg.quote + o[k] + cfg.quote
				if (cfg.colors) res += colors.green[1];
			} else if (typeof o[k] === 'boolean') {
				if (cfg.colors) res += colors.blue[0];
				res += o[k]
				if (cfg.colors) res += colors.blue[1];
			}
		}

		if (!isArray || (isArray && !cfg.collapseArray))
			res += '\n' + tabs.replace('\t', '');
		res += isArray ? ']' : '}';
		depth -= 1;

		return res;

	}(obj));
};

exports.config = function(obj) {

	for (var k in obj) {
		if (cfg.hasOwnProperty(k))
			cfg[k] = obj[k];
		else
			console.error('printJSON - Invalid options:', k);
	}

	return exports;
};

exports.log = function(o) {
	process.stdout.write( exports(o) + '\n');
	return exports;
}