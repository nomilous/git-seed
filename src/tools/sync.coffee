module.exports = sync = 

    series: (targetsArray, functionName, args, finalCallback, stepCallback) ->

        #
        # Where each in targetsArray implements functionName 
        # that accepts an (err, result) callback in addition
        # to the provided args.
        # 
        # Each callback from the targets will accumulate 
        # into a results array which is sent to the finalCallback
        # 
        # If any of the targets callback an error, the series
        # will terminate and the error will be sent to the
        # finalCallback along with the partial results array.
        #  
        # If defined, stepCallback will be called with each
        # individual result as it ocurrs.
        # 

        #
        # shallow clone targetsArray, 
        # so's not to shift() the original
        # 

        targets = []
        results = []
        args    = [] unless args

        for target in targetsArray

            targets.push target


        #
        # callback resursion
        # 
        # each call to target[functionName] will 
        # make this callback....
        #

        args.push (error, result) -> 

            #
            # ....which accumulates results and then recurses back
            #     or goes to finalCallback on error
            #

            if typeof stepCallback == 'function'

                stepCallback error, result

            if error

                finalCallback error, results
                return

            results.push result

            sync.recurse results, targets, functionName, args, finalCallback


        #
        # start the recursion
        #

        sync.recurse results, targets, functionName, args, finalCallback


    recurse: (results, targets, fname, args, finalCallback) -> 

        #
        # shift next from targets 
        # terminate recursion when none left
        # or make the call to functionName 
        #

        target = targets.shift() 
        unless target

            finalCallback null, results
            return


        target[fname].apply target, args

