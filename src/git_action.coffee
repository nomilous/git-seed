colors  = require 'colors'
GitSeed = require('nezkit').seed
fs      = require 'fs'

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

    assign: (program) ->

        GitAction.root    = '.' 
        GitAction.message = program.message
        plugin            = program.packageManager || 'npm'

        try

            GitAction.plugin = require "git-seed-#{plugin}"

        catch error

            console.log '(error) '.red + 'while loading plugin: ' + error.toString()
            process.exit 1

        return GitAction 


    init: -> 

        console.log '(init)'.bold, 'scanning for git repositories in', GitAction.root, '\n'

        GitAction.error = ''

        try

            unless GitAction.gotDirectory GitAction.root + '/.git'

                console.log '(fail)'.red, 'no git reposititory in', GitAction.root, '\n'
                process.exit 2

            GitSeed.init GitAction.root, GitAction.plugin

        catch error

            console.log '(error) '.red + error.toString()
            process.exit 3


    status: ->

        console.log '(status)'.bold, 'for all expected repositories in', GitAction.root, '\n'

        GitAction.error = ''

        try

            (new GitSeed GitAction.root, GitAction.plugin).status()

        catch error

            console.log '(error) '.red + error.toString()
            process.exit 3


    clone: ->

        console.log '(clone)'.bold, 'all missing repositories in', GitAction.root, '\n'

        GitAction.error = ''

        seed = new GitSeed GitAction.root, GitAction.plugin
        seed.clone (error, result) ->

            if error

                console.log '(error) '.red + error.toString()
                process.exit 4

            process.exit 0


    commit: -> 

        console.log '(commit)'.bold, 'on all repositories', 'with staged changes'.bold, 'in', GitAction.root, '\n'

        GitAction.error = ''

        (new GitSeed GitAction.root, GitAction.plugin).commit GitAction.message, (error, result) ->

            if error

                console.log '(error) '.red + error.toString()
                process.exit 6

            process.exit 0



    push: -> 

        GitAction.error = ''
        process.exit 6
        process.exit 7
        

    pull: -> 

        console.log '(pull)'.bold, 'pull root repo', GitAction.root, '\n'

        GitAction.error = ''

        (new GitSeed GitAction.root, GitAction.plugin).pull null, (error, result) -> 

            #
            # First call to pull with a null fetches only the root repo
            # to get the latest .git-seed file
            #

            if error

                console.log '(error) '.red + error.toString()
                process.exit 9


            #
            # load the seed packages again (now with the latest .git-seed)
            # and recall to pull all nested repos
            # 

            console.log '(pull)'.bold, 'all nested repos'

            seed = new GitSeed GitAction.root, GitAction.plugin
            seed.pull seed, (error, result) -> 

                if error

                    console.log '(error) '.red + error.toString()
                    process.exit 10


        process.exit 0

      
        #
        # then pull all with ref differing from .git-seed
        #

        #
        # then package manager install on all
        #
        








