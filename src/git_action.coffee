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

        GitAction.error = ''

        list  = {}
        array = []

        find = require('findit').find GitAction.root 

        find.on 'end', ->

            tree = GitTree.init array, GitAction.root
            tree.save()

        find.on 'directory', (dir, stat) -> 

            if match = dir.match /(.*)\/.git\//

                return unless typeof list[match[1]] == 'undefined'

                console.log '(found)'.green, "#{match[1]}/.git"
                list[match[1]] = 1
                array.push match[1]


    status: -> 

        GitAction.error = ''
        

    commit: -> 

        GitAction.error = ''
        console.log 'commit with', GitAction.message


    push: -> 

        GitAction.error = ''
        

    pull: -> 

        GitAction.error = ''
        

