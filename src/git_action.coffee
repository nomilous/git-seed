colors  = require 'colors'
GitSeed = require('nezkit').git.seed
Shell   = require('nezkit').shell
Npm     = require('nezkit').npm

module.exports = GitAction =

    isError: -> error == ''

    showError: ->
        console.log GitAction.error

    error: 'unknown or missing command'

    assign: (program) ->

        GitAction.root       = '.' 
        GitAction.message    = program.message
        GitAction.npmInstall = program.npmInstall || false
        return GitAction 



    init: -> 

        console.log '(init)'.bold, 'scanning for git repositories in', GitAction.root, '\n'

        GitAction.error = ''

        try

            unless Shell.gotDirectory GitAction.root + '/.git'

                console.log '(fail)'.red, 'no root reposititory in', GitAction.root, '\n'
                process.exit 1

            GitSeed.init GitAction.root

        catch error

            console.log '(error) '.red + error.toString()
            process.exit 2



    status: ->

        console.log '(status)'.bold, 'for all expected repositories in', GitAction.root, '\n'

        GitAction.error = ''

        try

            (new GitSeed GitAction.root).status()

        catch error

            console.log '(error) '.red + error.toString()
            process.exit 3


    clone: ->

        console.log '(clone)'.bold, 'all missing repositories in', GitAction.root, '\n'

        GitAction.error = ''

        seed = new GitSeed GitAction.root
        seed.clone (error, result) ->

            if error

                console.log '(error) '.red + error.toString()
                process.exit 4

            unless GitAction.npmInstall

                process.exit 0
                

            Npm.install GitAction.root, seed, (error, result) -> 

                if error

                    console.log '(error) '.red + error.toString()
                    process.exit 5

            process.exit 0


    commit: -> 

        console.log '(commit)'.bold, 'on all repositories', 'with staged changes'.bold, 'in', GitAction.root, '\n'

        GitAction.error = ''

        (new GitSeed GitAction.root).commit GitAction.message, (error, result) ->

            if error

                console.log '(error) '.red + error.toString()
                process.exit 6

            process.exit 0



    push: -> 

        GitAction.error = ''
        

    pull: -> 

        GitAction.error = ''
        

