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
_hasOwnProperty = Object.prototype.hasOwnProperty
_toString       = Object.prototype.toString

isType = (t, o) ->
    t is (_toString.call o .slice 8, -1)

# printer class
JSONPrinter = (options) ->
    defaults = Default-Options <<< options

    # print :: [Any] -> Object -> String
    print = (input, opts) ->
        opts   := {} unless isType 'Object' opts
        opts   := (defaults <<< opts)
        try
            input  := (JSON.parse input)
        catch
            err = new Error 'Failed to parse object: ' + e.message
            err.stack = e.stack
            throw err

        result = ''
        depth  = 0

        iterate = (obj) ->
            tabN = ''
            tabP = ''
            i   = 0
            len = 0
            isAfterObject = result[*-2] is \}
            isInsideArray = result[*-1] is \[
            isArrayObject = isArray obj
            write-depth = (++depth)
            while write-depth-- then
                tabN += opts.indent
            tabP := tabN.replace opts.indent, ''

            result += (\\n + tabP) if isInsideArray or isAfterObject
            result += if isArrayObject then \[ else \{

            for k, val of obj
                if opts.commaFirst
                    result += (\\n + tabN) if not isArrayObject and opts.collapseArray
                    result += ',' if len > 0
                else
                    result += ',' if len > 0
                    result += (\\n + tabN) if not isArrayObject and opts.collapseArray

                len += 1

                unless isArrayObject
                    result +=
                        if opts.quoteKeys then
                            opts.quote + k + opts.quote + ': '
                        else k + ': '

                match _toString.call val .slice 8, -1
                when 'Object' or 'Array'
                    iterate val
                when 'RegExp'
                    result += Colors.yellow[0] if opts.colors
                    result += val
                    result += Colors.yellow[1] if opts.colors
                when 'Number'
                    result += Colors.white[0] if opts.colors
                    result += val
                    result += Colors.white[1] if opts.colors

                when 'String'
                    result += Colors.green[0] if opts.colors
                    result += opts.quote + val + opts.quote
                    result += Colors.green[1] if opts.colors

                when 'Boolean'
                    result += Colors.blue[0] if opts.colors
                    result += val
                    result += Colors.blue[1] if opts.colors

            result += (\\n + tabP) if not isArrayObject or (isArrayObject && not opts.collapseArray) # close item
            isLeavingArray = result[*-1] is \} and isArrayObject
            result += (\\n + tabP) if isLeavingArray
            result += if isArrayObject then \] else \}  # close level
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

