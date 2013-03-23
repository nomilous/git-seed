require('nez').realize 'GitAction', (GitAction, test, context, nezkit, should) -> 

    console.log nezkit

    context 'init()', (performs) -> 

        performs 'the tree inititialize', (done) -> 

            nezkit.git.tree.init = -> test done
            GitAction.assign( root: '.' ).init()


    context 'clone()', (performs) ->

        performs 'git clone of the tree', (done) ->

            test done
            # nezkit.git.tree.must receive clone: -> test done
            # GitAction.assign( root: '.' ).clone()


        performs 'npm install in all nested modules', (done) ->

            true.should.equal false
            test done


    context 'status()', (shows) -> 

        shows 'git status of the tree', (done) ->  

            nezkit.git.tree.prototype.status = -> test done
            GitAction.assign( root: '.' ).status()

