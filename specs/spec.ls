'use strict'
require! 'expect.js'; should = it

describe 'prettyJSON strings' !->

    printJSON = require '../release'

    should 'require correctly' !->
        expect printJSON           .to.be.a Function
        expect printJSON.configure .to.be.a Function
        expect printJSON.log       .to.be.a Function

    should 'print all primitive types' !->
        # note: regular expression options (/igm) after compile will always be written in the order: /gim
        expect printJSON {
            bool: true
            str: "string1"
            str2: 'string2'
            array : [1,2,3]
            object : { foo: "bar" }
            num: 948.5
            rx: /(f[o]+)/gim
        } .to.be """
        {
            "bool": true,
            "str": "string1",
            "str2": "string2",
            "array": [1,2,3],
            "object": {
                "foo": "bar"
            },
            "num": 948.5,
            "rx": /(f[o]+)/gim
        }
        """

    should 'print a complex tree' !->
        expect printJSON {
            root: {
                "level-1": [ { a: 1 }, { b: 2 }, { c: { "three": { "four": [1 2 3] } } } ]
            }
        } .to.be """
        {
            "root": {
                "level-1": [
                    {
                        "a": 1
                    },
                    {
                        "b": 2
                    },
                    {
                        "c": {
                            "three": {
                                "four": [1,2,3]
                            }
                        }
                    }
                ]
            }
        }
        """
