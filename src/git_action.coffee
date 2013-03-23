colors  = require 'colors'
GitTree = require('nezkit').git.tree

module.exports = GitAction =

    isError: -> error == ''

    showError: ->
        console.log GitAction.error

    error: 'unknown or missing command'

    assign: (program) ->

        GitAction.root    = program.root || '.' 
        GitAction.message = program.message
        return GitAction 



    init: -> 

        console.log '(init)'.bold, 'scanning for git repositories in', GitAction.root, '\n'

        GitAction.error = ''

        try

            GitTree.init GitAction.root

        catch error

            console.log '(error) '.red + error.toString()
            process.exit GitAction.exitCode



    status: ->

        console.log '(status)'.bold, 'for all expected repositories in', GitAction.root, '\n'

        GitAction.error = ''

        try

            (new GitTree GitAction.root).status()

        catch error

            console.log '(error) '.red + error.toString()
            process.exit GitAction.exitCode


    clone: ->

        console.log '(clone)'.bold, 'all missing repositories in', GitAction.root, '\n'

        GitAction.error = ''

        (new GitTree GitAction.root).clone (error, result) ->

            if error

                console.log '(error) '.red + error.toString()
                process.exit 4

            process.exit 0


    commit: -> 

        console.log '(commit)'.bold, 'on all repositories', 'with staged changes'.bold, 'in', GitAction.root, '\n'

        GitAction.error = ''

        (new GitTree GitAction.root).commit GitAction.message, (error, result) ->

            if error

                console.log '(error) '.red + error.toString()
                process.exit 5

            process.exit 0



    push: -> 

        GitAction.error = ''
        

    pull: -> 

        GitAction.error = ''
        

