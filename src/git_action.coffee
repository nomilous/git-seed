colors  = require 'colors'
GitTree = require './git_tree'

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

        console.log '(init)'.bold, 'scanning for git repositories in', GitAction.root

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

        console.log '(status)'.bold, 'for all git repositories in', GitAction.root

        GitAction.error = ''

        tree = new GitTree GitAction.root

        console.log tree
        

    commit: -> 

        GitAction.error = ''
        console.log 'commit with', GitAction.message


    push: -> 

        GitAction.error = ''
        

    pull: -> 

        GitAction.error = ''
        

