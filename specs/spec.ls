'use strict'
require! 'expect.js'; should = it

describe 'prettyJSON strings' !->

    printJSON = require '../release'

    should 'require correctly' !->
        expect printJSON           .to.be.a Function
        expect printJSON.configure .to.be.a Function
        expect printJSON.log       .to.be.a Function

    should 'print all primitive types' !->

        result = printJSON {
            foo: true
        }

        console.log '*'
        console.log result
        console.log '*'

        expect result .to.be """
                        {
                            "foo": true
                        }"""

