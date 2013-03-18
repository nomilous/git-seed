GitRepos = require './git_repos'

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

            GitRepos.init array, GitAction.root

        find.on 'directory', (dir, stat) -> 

            if match = dir.match /(.*)\/.git\//

                return unless typeof list[match[1]] == 'undefined'

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
        

