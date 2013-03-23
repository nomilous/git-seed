GitTree = require('nez-kit').git.tree

require('nez').realize 'GitAction', (GitAction, test, context, should) -> 

    context 'init()', (performs) -> 

        performs 'the tree inititialize', (done) -> 

            GitTree.init = -> test done
            GitAction.assign( root: '.' ).init()


    context 'clone()', (performs) ->

        performs 'git clone of the tree', (done) ->

            GitTree.must receive clone: -> test done
            GitAction.assign( root: '.' ).clone()


        performs 'npm install in all nested modules', (done) ->

            true.should.equal false
            test done


    context 'status()', (shows) -> 

        shows 'git status of the tree', (done) ->  

            GitTree.prototype.status = -> test done
            GitAction.assign( root: '.' ).status()


