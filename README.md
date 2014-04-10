
JSONprint
=========

Print JSON objects pretty. +colours +comma-first +optional-quotes
written in livescript. build:

    make install



example:

    var printJSON = require('printJSON');

    var obj = {
          foo: true
        , bar: /meh/gim
        , baz: {
            qaz: [1, true, 'three']
        }
    };

    console.log( printJSON(obj) );

or directly to the stdout:
    printJSON.log(obj);


![screenshot](http://igl.s3-eu-west-1.amazonaws.com/images/printJSON_sample.png)


## options

printJSON(obj, options)

default values:

    options = {
         'quote': '"' // Use this char as quote
        ,'quoteKeys': true // Quote JSON keys
        ,'colors': false // Klickibunti
        ,'collapseArray': true // Print arrays in one line
        ,'commaFirst': false // Put commas infront of the line
    }

### WIP:
* deeper tests
* html output
