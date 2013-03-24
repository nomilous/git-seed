#
# TODO: Move nezkit.injector into nezcore
#       injecting nezkit:git here is injection 
#       the instance in nez/node_modules/nezkit
# 
#       nezkit should not be inside nez
#       it should be on top
#

git = require('nezkit').git

require('nez').realize 'GitAction', (GitAction, test, context, should) -> 

    context 'init()', (performs) -> 

        performs 'the seed inititialize', (done) -> 

            git.seed.init = -> test done
            GitAction.assign( root: '.' ).init()


    context 'clone()', (performs) ->

        performs 'git clone of the seed repos', (done) ->

            git.seed.prototype.clone = -> test done
            GitAction.assign( root: '.' ).clone()


        performs 'npm install in all nested modules', (done) ->

            true.should.equal false
            test done


    context 'status()', (shows) -> 

        shows 'git status of the tree', (done) ->  

            git.seed.prototype.status = -> test done
            GitAction.assign( root: '.' ).status()

