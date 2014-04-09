'use strict';

# const
const Colors =
    bold      : [ '\033[1m',  '\033[22m' ]
    italic    : [ '\033[3m',  '\033[23m' ]
    underline : [ '\033[4m',  '\033[24m' ]
    inverse   : [ '\033[7m',  '\033[27m' ]
    white     : [ '\033[37m', '\033[39m' ]
    grey      : [ '\033[90m', '\033[39m' ]
    black     : [ '\033[30m', '\033[39m' ]
    blue      : [ '\033[34m', '\033[39m' ]
    cyan      : [ '\033[36m', '\033[39m' ]
    green     : [ '\033[32m', '\033[39m' ]
    magenta   : [ '\033[35m', '\033[39m' ]
    red       : [ '\033[31m', '\033[39m' ]
    yellow    : [ '\033[33m', '\033[39m' ]

const Default-Options =
    quote         : '"'
    indent        : '    '
    quoteKeys     : true
    colors        : false
    collapseArray : true
    commaFirst    : false

# helper
isString = -> typeof! it == \String
isObject = -> typeof! it == \Object
isArray  = -> typeof! it == \Array

# printer class
JSONPrinter = (options) ->
    defaults = Default-Options <<< options

    # print :: [Any] -> Object -> String
    print = (input, opts) ->
        opts   := {} unless isObject opts
        opts   := (defaults <<< opts)
        input  := (JSON.parse input) unless isObject input

        result = ''
        depth  = 1

        iterate = (obj) ->
            tab = ''
            i   = 0
            len = 0

            isArrayItem = isArray obj
            result += if isArrayItem then \[ else \{

            write-depth = (++depth)
            while --write-depth => tab += opts.indent

            for k, val of obj
                if opts.commaFirst
                    result += if isArrayItem and opts.collapseArray then '' else \\n + tab
                    result += ', ' if len > 0
                else
                    result += ', ' if len > 0
                    result += (\\n + tab) if not isArrayItem and opts.collapseArray

                len += 1

                if not isArrayItem
                    if opts.quoteKeys then
                        result += opts.quote + k + opts.quote + ': '
                    else
                        result += k + ': '

                match typeof! val
                when 'Object'
                    iterate val
                when 'RegExp'
                    result += Colors.red[0] if opts.colors
                    result += val
                    result += Colors.red[1] if opts.colors
                when 'Number'
                    result += Colors.yellow[0] if opts.colors
                    result += val
                    result += Colors.yellow[1] if opts.colors

                when 'String'
                    result += Colors.green[0] if opts.colors
                    result += opts.quote + val + opts.quote
                    result += Colors.green[1] if opts.colors

                when 'Boolean'
                    result += Colors.blue[0] if opts.colors
                    result += val
                    result += Colors.blue[1] if opts.colors

            result += (\\n + tab.replace(opts.indent, '')) if not isArrayItem or (isArrayItem && not opts.collapseArray) # close item
            result += if isArrayItem then \] else \}  # close level
            depth -= 1    # traverse out
            return result
        return iterate input

    # set default options for session
    # configure :: String -> Object -> String
    print.configure = (conf) ->
        for key, value of conf when defaults.hasOwnProperty key
            defaults[key] = value
        this

    # show result in console.log
    # log :: String -> Object -> String
    print.log = (...args) ->
        for arg in args
            console.log print arg
        this

    print

module.exports = JSONPrinter Default-Options

