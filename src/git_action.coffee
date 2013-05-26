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

        GitAction.task.notify.info.good 'start seed init', 
            "recurse for git repositories in '#{ GitAction.root }'"

        
        GitAction.error = ''

        unless GitAction.gotDirectory GitAction.root + '/.git'

            GitAction.task.notify.info.bad 'missing root repo', 
                "no git reposititory in '#{ GitAction.root }'"
            return

        GitSeed.init GitAction.root, GitAction.plugin, GitAction.task


    status: ->

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.good 'start seed status', 
            "for all git repositories in '#{ GitAction.root }/.git-seed'"

        GitAction.error = ''

        (new GitSeed GitAction.root, GitAction.plugin, GitAction.task).status()


    clone: ->

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.good 'start seed clone', 
            "for all git repositories in '#{ GitAction.root }/.git-seed'"

        GitAction.error = ''

        (new GitSeed GitAction.root, GitAction.plugin, GitAction.task).clone()


    commit: -> 

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.good 'start seed commit', 
            "for any git repositories with staged changes in '#{ GitAction.root }/.git-seed' "

        GitAction.error = ''

        unless GitAction.message
            GitAction.task.notify.info.bad 'missing commit message', 'use -m "message"'
            return

        (new GitSeed GitAction.root, GitAction.plugin, GitAction.task).commit GitAction.message


    pull: -> 

        if typeof GitAction.task == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.task.notify.info.good 'start seed pull', 
            "for all git repositories in '#{ GitAction.root }/.git-seed'"

        GitAction.error = ''

        # seed = new GitSeed GitAction.root, GitAction.plugin

        # seed.pull null, (error, result) -> 

        #     #
        #     # First call to pull with a null fetches only the root repo
        #     # to get the latest .git-seed file
        #     #

        #     if error

        #         console.log '(error) '.red + error.toString()
        #         process.exit 9


        #     #
        #     # load the seed packages again (now with the latest .git-seed)
        #     # and recall to pull all nested repos
        #     # 

        #     seed = new GitSeed GitAction.root, GitAction.plugin
        #     seed.pull seed, (error, result) -> 

        #         if error

        #             console.log '(error) '.red + error.toString()
        #             process.exit 10

        #         process.exit 0

        #
        # then package manager install on all
        #
        








