exec   = require 'exec-sync'
colors = require 'colors' 

module.exports = shell = 

    execSync: (command) ->

        console.log '(run)'.bold, command
        exec command
