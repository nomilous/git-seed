GitSeed = require('nezkit').seed
fs      = require 'fs'
task    = require('when').defer

module.exports = GitAction =

    gotDirectory: (directory) -> 

        try 

            return fs.lstatSync( directory ).isDirectory()

        catch error

            return false

    isError: -> error == ''

    showError: ->
        console.log GitAction.error

    error: 'unknown or missing command'


    configure: (program, onSuccess, onError, onNotify) ->

        if (

            typeof onSuccess == 'undefined' or 
            typeof onError == 'undefined'

        ) then throw new Error 'requires promise handlers'

        GitAction.task = task()
        GitAction.task.notify = onNotify
        GitAction.task.promise.then onSuccess, onError, onNotify


        GitAction.root     = '.' 
        GitAction.message  = program.message
        plugin             = program.packageManager || 'npm'

        try

            GitAction.plugin = require "git-seed-#{plugin}"

        catch error

            onNotify.info.bad 'missing plugin', error.toString()
            process.exit 1

        return GitAction 


    init: -> 

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.normal 'start seed init', 
            "recurse for git repositories in '#{ GitAction.root }'"

        
        GitAction.error = ''

        unless GitAction.gotDirectory GitAction.root + '/.git'

            GitAction.task.notify.info.bad 'missing root repo', 
                "no git reposititory in '#{ GitAction.root }'"
            return

        GitSeed.init GitAction.task, GitAction.root, GitAction.plugin


    status: ->

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.normal 'start seed status', 
            "for all git repositories in '#{ GitAction.root }/.git-seed'"

        GitAction.error = ''

        (new GitSeed GitAction.task, GitAction.root, GitAction.plugin).status()


    clone: ->

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.normal 'start seed clone', 
            "for all git repositories in '#{ GitAction.root }/.git-seed'"

        GitAction.error = ''

        (new GitSeed GitAction.task, GitAction.root, GitAction.plugin).clone()


    commit: -> 

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.normal 'start seed commit', 
            "for any git repositories with staged changes in '#{ GitAction.root }/.git-seed' "

        GitAction.error = ''

        unless GitAction.message
            GitAction.task.notify.info.bad 'missing commit message', 'use -m "message"'
            return

        (new GitSeed GitAction.task, GitAction.root, GitAction.plugin).commit GitAction.message


    pull: -> 

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.normal 'start seed pull', 
            "for all git repositories in '#{ GitAction.root }/.git-seed'"

        GitAction.error = ''

        (new GitSeed GitAction.task, GitAction.root, GitAction.plugin).pullRoot (error, result) -> 

            unless error? 
            
                (new GitSeed GitAction.task, GitAction.root, GitAction.plugin).pull()




