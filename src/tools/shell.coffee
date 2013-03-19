exec   = require 'exec-sync'  # hmmm, broken pipe on 'git clone'??? (every time...)
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


    execSync: (command) ->

        console.log '(run)'.bold, command
        exec command
