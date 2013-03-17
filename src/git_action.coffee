module.exports = GitAction =

    isError: -> error == ''

    showError: ->
        console.log GitAction.error

    error: 'unknown or missing command'

    assign: (program) ->

        GitAction.root = program.root || '.' 
        return GitAction 



    init: -> 

        GitAction.error = ''
        

    status: -> 

        GitAction.error = ''
        

    commit: -> 

        GitAction.error = ''
        message = arguments[0][0].parent.message


    push: -> 

        GitAction.error = ''
        

    pull: -> 

        GitAction.error = ''
        

