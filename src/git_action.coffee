colors  = require 'colors'
GitTree = require('nez-kit').git.tree

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

        list  = {}
        arrayOfGitWorkdirs = []

        find = require('findit').find GitAction.root

        find.on 'end', ->

            tree = GitTree.init GitAction.root, arrayOfGitWorkdirs
            tree.save()

        find.on 'directory', (dir, stat) -> 

            if match = dir.match /(.*)\/.git\//

                return unless typeof list[match[1]] == 'undefined'

                console.log '(found)'.green, "#{match[1]}/.git"
                list[match[1]] = 1
                arrayOfGitWorkdirs.push match[1]


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
        

