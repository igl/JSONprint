'use strict';

var printJSON = require('../index')

var obj = {
	  foo: true
	, bar: /meh/igm
	, baz: {
		qaz: [1, true, 'three']
	}
};

console.log( printJSON(obj) );