module.exports = sync = 

    series: (functionName, targetsArray) ->

        #
        # Where each in targetsArray implements functionName 
        # that accepts an (err, result) callback
        # 

        console.log '%s on %s', functionName, targetsArray

