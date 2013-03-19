module.exports = sync = 

    series: (targetsArray, functionName, args, endCallback) ->

        #
        # Where each in targetsArray implements functionName 
        # that accepts an (err, result) callback
        # 

        #
        # shallow clone original target array, 
        # so's not to shift() the original
        # 

        targets = []

        for target in targetsArray

            targets.push target


        #
        # callback resursion
        # 
        # each call to target[functionName] will 
        # make this callback....
        #

        args.push (err, result) -> 

            #
            # ....which then recurses back
            #

            sync.recurse targets, functionName, args, endCallback


        #
        # start the recursion
        #

        sync.recurse targets, functionName, args, endCallback


    recurse: (targets, fname, args, ecb) -> 

        #
        # shift next from targets 
        # terminate recursion when none left
        # or make the call to functionName 
        #

        target = targets.shift() 
        return unless target

        target[fname].apply target, args

