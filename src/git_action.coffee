colors  = require 'colors'
GitSeed = require('nezkit').git.seed

module.exports = GitAction =

    isError: -> error == ''

    showError: ->
        console.log GitAction.error

    error: 'unknown or missing command'

    assign: (program) ->

        GitAction.root       = program.root || '.' 
        GitAction.message    = program.message
        GitAction.npmInstall = program.npmInstall || false
        return GitAction 



    init: -> 

        console.log '(init)'.bold, 'scanning for git repositories in', GitAction.root, '\n'

        GitAction.error = ''

        try

            GitSeed.init GitAction.root

        catch error

            console.log '(error) '.red + error.toString()
            process.exit GitAction.exitCode



    status: ->

        console.log '(status)'.bold, 'for all expected repositories in', GitAction.root, '\n'

        GitAction.error = ''

        try

            (new GitSeed GitAction.root).status()

        catch error

            console.log '(error) '.red + error.toString()
            process.exit GitAction.exitCode


    clone: ->

        console.log '(clone)'.bold, 'all missing repositories in', GitAction.root, '\n'

        GitAction.error = ''

        (new GitSeed GitAction.root).clone (error, result) ->

            if error

                console.log '(error) '.red + error.toString()
                process.exit 4


            if GitAction.npmInstall 

                console.log 'npm install'

            process.exit 0


    commit: -> 

        console.log '(commit)'.bold, 'on all repositories', 'with staged changes'.bold, 'in', GitAction.root, '\n'

        GitAction.error = ''

        (new GitSeed GitAction.root).commit GitAction.message, (error, result) ->

            if error

                console.log '(error) '.red + error.toString()
                process.exit 5

            process.exit 0



    push: -> 

        GitAction.error = ''
        

    pull: -> 

        GitAction.error = ''
        

