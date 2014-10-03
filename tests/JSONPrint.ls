'use strict'

suite 'JSONPrint' !->

    JSONPrint = require '../'

    test 'exports correctly' !->
        expect JSONPrint           .to.be.a Function
        expect JSONPrint.configure .to.be.a Function
        expect JSONPrint.log       .to.be.a Function

    test 'print all primitive types' !->

        # note: regular expression options (/igm) after compile will always be written in the order: /gim
        expect JSONPrint {
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

    test 'print a complex tree' !->

        expect JSONPrint {
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
