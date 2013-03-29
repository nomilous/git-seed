require('nez').realize 'GitAction', (GitAction, test, context, should, nezkit) -> 

    context 'init()', (performs) -> 

        performs 'the seed inititialize', (done) -> 

            nezkit.seed.init = -> test done 
            GitAction.assign( root: '.' ).init()


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
            GitAction.assign( root: '.' ).clone()


    context 'status()', (shows) -> 

        shows 'git status of the tree', (done) ->  

            nezkit.seed.prototype.status = -> test done 
            GitAction.assign( root: '.' ).status()

