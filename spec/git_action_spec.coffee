require('nez').realize 'GitAction', (GitAction, test, context, should) -> 

    context 'dependancies', (it) -> 

        it 'does not use exec-sync', (done) -> 

            try 

                require 'exec-sync'

            catch error

                error.should.match /Cannot find module/
                test done

            true.should.equal false


    context 'init()', (generates) -> 

        generates 'the control file', (done) -> 

            true.should.equal false
            test done


    context 'clone()', (performs) ->

        performs 'git clones of all nested git repos', (done) ->

            true.should.equal false
            test done

        parforms 'npm install for all nested npm modules', (done) ->

            true.should.equal false
            test done


    context 'status()', (shows) -> 

        shows 'git status across all nested modules', (done) ->  

            true.should.equal false
            test done


