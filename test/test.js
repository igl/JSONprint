'use strict';

var printJSON = require('../index')

var testy = {
	  foo: true
	, bar: 1000
	, baz: {
		  'myArr': [1,2,'three']
		, 'even-deeper': {
			'blah': /blub/igm
		}
	}
};

printJSON.log(testy);

