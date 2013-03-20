exec   = require 'exec-sync'  # (TODO remove this) hmmm, broken pipe on 'git clone'??? (every time...)
spawn  = require('child_process').spawn
colors = require 'colors' 
fs     = require 'fs'

module.exports = shell = 

    gotDirectory: (directory) -> 

        try 

            return fs.lstatSync( directory ).isDirectory()

        catch error

            return false

    makeDirectory: (directory) ->

        try

            exec "mkdir -p #{directory}"

        catch error

            console.log error.red
            throw error


    execSync: (command, log = false) ->

        if log then console.log '(run)'.bold, command
        exec command


    spawn: (command, opts, callback) -> 

        console.log '(run)'.bold, command, opts.join ' '

        child = spawn command, opts

        #
        # TODO: optionally read these into result
        #

        child.stdout.pipe process.stdout
        child.stderr.pipe process.stderr

        child.on 'close', (code, signal) ->

            if code > 0

                callback new Error "'#{command} #{opts.join(' ')}'" + ' exited with errorcode: ' + code

            else 

                callback null
