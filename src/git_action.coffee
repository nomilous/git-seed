colors  = require 'colors'
console.log 'remove colors'
GitSeed = require('nezkit').seed
fs      = require 'fs'
w       = require 'when'

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


    assign: -> GitAction.configure  #DEPRECATE
    configure: (program, onSuccess, onError, onNotify) ->

        if (

            typeof onSuccess == 'undefined' or 
            typeof onError == 'undefined'

        ) then throw new Error 'requires promise handlers'

        GitAction.deferral = w.defer()
        GitAction.deferral.promise.then onSuccess, onError, onNotify


        GitAction.root     = '.' 
        GitAction.message  = program.message
        plugin             = program.packageManager || 'npm'

        try

            GitAction.plugin = require "git-seed-#{plugin}"

        catch error

            console.log '(error) '.red + 'while loading plugin: ' + error.toString()
            process.exit 1

        return GitAction 


    init: -> 

        if typeof GitAction.deferral == 'undefined' 
            throw new Error 'configure() was not called'

        GitAction.deferral.notify 

            #
            # notification framework later
            #

            cli:
                event: 'init'
                detail: "scanning for git repositories in '#{ GitAction.root }'"

        
        GitAction.error = ''  # ???

        unless GitAction.gotDirectory GitAction.root + '/.git'

            GitAction.deferral.reject new Error "no git reposititory in '#{ GitAction.root }'"
            return


        GitSeed.init GitAction.root, GitAction.plugin, GitAction.deferral


    status: ->

        if typeof GitAction.deferral == 'undefined' 
            throw new Error 'configure() was not called'

        # console.log '(status)'.bold, 'for all expected repositories in', GitAction.root, '\n'

        # GitAction.error = ''

        # try

        #     (new GitSeed GitAction.root, GitAction.plugin).status()

        # catch error

        #     console.log '(error) '.red + error.toString()
        #     process.exit 3


    clone: ->

        if typeof GitAction.deferral == 'undefined' 
            throw new Error 'configure() was not called'

        # console.log '(clone)'.bold, 'all missing repositories in', GitAction.root, '\n'

        # GitAction.error = ''

        # seed = new GitSeed GitAction.root, GitAction.plugin
        # seed.clone (error, result) ->

        #     if error

        #         console.log '(error) '.red + error.toString()
        #         process.exit 4

        #     process.exit 0


    commit: -> 

        if typeof GitAction.deferral == 'undefined' 
            throw new Error 'configure() was not called'

        # console.log '(commit)'.bold, 'on all repositories', 'with staged changes'.bold, 'in', GitAction.root, '\n'

        # GitAction.error = ''

        # (new GitSeed GitAction.root, GitAction.plugin).commit GitAction.message, (error, result) ->

        #     if error

        #         console.log '(error) '.red + error.toString()
        #         process.exit 6

        #     process.exit 0



    push: -> 

        if typeof GitAction.deferral == 'undefined' 
            throw new Error 'configure() was not called'

        # GitAction.error = ''
        # process.exit 6
        # process.exit 7
        

    pull: -> 

        if typeof GitAction.deferral == 'undefined' 
            throw new Error 'configure() was not called'

        # console.log '(pull)'.bold, 'pull all where necessary', GitAction.root, '\n'

        # GitAction.error = ''

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
        








