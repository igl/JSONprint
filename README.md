
printJSON
=========

Print pretty objects. wif colours!1

###example:
	var printJSON = require('printJSON');

	var obj = {
		  foo: true
		, bar: 1000
		, baz: [1, true, 'three']
		}
	};

	console.log( printJSON(obj) );

###or directly to the stdout:
	printJSON.log(obj);

###printJSON.config(options) (default values:)
	
	options = {
		 'quote': '"' // Use this char as quote
		,'quoteKeys': true // Quote JSON keys
		,'colors': true // Klickibunti
		,'collapseArray': true // Print arrays in one line
		,'commaFirst': true // Put commas infront of the line
	}
