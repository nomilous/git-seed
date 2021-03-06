require('nez').realize 'GitAction', (GitAction, test, context, should, nezkit, notice) -> 

    note = notice.create 'git-seed', (msg, next) -> 

    context 'assign()', (it) -> 

        it 'expects promise handlers', (done) -> 

            try 

                GitAction.configure( root: '.' )

            catch error

                error.should.match /requires promise handlers/
                test done


        it 'promises a result', (done) -> 

            GitAction.configure( 
                root: '.'
                -> 
                ->
            )
            should.exist GitAction.task
            test done


    context 'init()', (it) -> 

        it 'performs the seed inititialize', (done) -> 

            nezkit.seed.init = -> test done 
            GitAction.configure( 
                root: '.' 
                ->
                ->
                note
            ).init()


        it 'passes the deferral onto the seed class', (done) -> 

            nezkit.seed.init = -> 
                arguments[0].should.equal GitAction.task
                test done

            GitAction.configure( 
                root: '.' 
                ->
                ->
                note
            ).init()


    context 'clone()', (performs) ->

        performs 'npm install in all nested modules', (done) ->

            #
            # TODO: after proper expectations are possible
            #

            # GitAction.npmInstall = true
            # nezkit.git.seed.prototype.clone = (callback) -> callback null 
            # nezkit.npm.install = -> test done
            # GitAction.assign( root: '.' ).clone()


        performs 'git clone of the seed repos', (done) ->

            nezkit.seed.prototype.clone = -> test done
            GitAction.configure( 
                root: '.' 
                ->
                ->
                note

            ).clone()


    context 'status()', (shows) -> 

        shows 'git status of the tree', (done) ->  

            nezkit.seed.prototype.status = -> test done 
            GitAction.configure( 
                root: '.' 
                ->
                ->
                note
            ).status()



