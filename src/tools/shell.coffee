exec   = require 'exec-sync'
colors = require 'colors' 
fs     = require 'fs'

module.exports = shell = 

    gotDirectory: (directory) -> 

        try 

            return fs.lstatSync( directory ).isDirectory()

        catch error

            return false


    execSync: (command) ->

        console.log '(run)'.bold, command
        exec command
