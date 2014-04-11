
JSONprint
=========

Print JSON objects pretty. +colours +comma-first +optional-quotes
written in livescript. build:

    make           => make build test
    make install   => npm install and make build

example:

    var JSONprint = require('JSONprint');

    var obj = {
        foo: true,
        bar: /meh/gim,
        baz: { qaz: [1, true, 'three'] }
    };

    console.log( JSONprint(obj) );

or directly to the stdout:
    JSONprint.log(obj);

![screenshot](http://igl.s3-eu-west-1.amazonaws.com/images/JSONprint_sample.png)

## Options

JSONprint :: String | Object -> Object? -> String

defaults:
    {
        quote         : '"'   -- Use this char as quote
        quoteKeys     : true  -- Quote JSON keys
        collapseArray : true  -- Print arrays in one line
        colors        : false -- Klickibunti
        commaFirst    : false -- place commas after \n
    }

### WIP:
* new lexer
* deeper tests
* html output
