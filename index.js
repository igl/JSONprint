'use strict';
/*
* printJSON
* module.exports(object)
* exports.log(object)
* exports.config(object)
*/

var util = require('util')
,	col = require('./lib/colors')
;


var cfg = {
	 'quote': '"'
	,'quoteKeys': true
	,'colors': true
	,'collapseArray': true
	,'commaFirst': true
};

exports = module.exports = function printJSON(obj) {
	var res = ''
	,	depth = 0
	;

	function reiterate(o) {
		var isArray = o instanceof Array
		,	tabs = ''
		,	length = 0
		,	i = 0
		,	k
		;

		depth += 1;
		res += isArray ? '[' : '{';
		for (i = 0; i < depth; i += 1) tabs += '\t';

		for (k in o) {
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
					if (cfg.colors) res += col.red[0];
					res += o[k]
					if (cfg.colors) res += col.red[1];
				} else {
					reiterate( o[k] );
				}
			}
			if (typeof o[k] === 'number') {
				if (cfg.colors) res += col.yellow[0];
				res += o[k]
				if (cfg.colors) res += col.yellow[1];
			}
			if (typeof o[k] === 'string') {
				if (cfg.colors) res += col.green[0];
				res += cfg.quote + o[k] + cfg.quote
				if (cfg.colors) res += col.green[1];
			}
			if (typeof o[k] === 'boolean') {
				if (cfg.colors) res += col.blue[0];
				res += o[k]
				if (cfg.colors) res += col.blue[1];
			}
		}

		if (!isArray || (isArray && !cfg.collapseArray))
			res += '\n' + tabs.replace('\t', '');
		res += isArray ? ']' : '}';
		depth -= 1;
	}

	if (typeof obj === 'string') {
		obj = JSON.parse(obj);
	}

	reiterate(obj);

	return res;
};

exports.config = function(obj) {
	var k;
	for (k in obj) {
		if (cfg.hasOwnProperty(k))
			cfg[k] = obj[k];
	}
	return cfg;
};

exports.log = function(o) {
	process.stdout.write( exports(o) + '\n');
}