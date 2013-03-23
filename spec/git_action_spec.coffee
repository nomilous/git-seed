require('nez').realize 'GitAction', (GitAction, test, context, nezkit, should) -> 

    context 'init()', (performs) -> 

        performs 'the seed inititialize', (done) -> 

            nezkit.git.seed.init = -> test done
            GitAction.assign( root: '.' ).init()


    context 'clone()', (performs) ->

        performs 'git clone of the seed repos', (done) ->

            nezkit.git.seed.prototype.clone = -> test done
            GitAction.assign( root: '.' ).clone()


        performs 'npm install in all nested modules', (done) ->

            true.should.equal false
            test done


    context 'status()', (shows) -> 

        shows 'git status of the tree', (done) ->  

            nezkit.git.seed.prototype.status = -> test done
            GitAction.assign( root: '.' ).status()

