should = require 'should'
notice = require 'notice'

describe 'git_action', -> 

    #note = notice.create 'git-seed', (msg, next) -> 

    context 'assign()', -> 

        it 'expects promise handlers', (done) -> 

            try 

                GitAction.configure( root: '.' )

            catch error

                error.should.match /requires promise handlers/
                done()


        it 'promises a result', (done) -> 

            GitAction.configure( 
                root: '.'
                -> 
                ->
            )
            should.exist GitAction.task
            done()


    context 'init()', -> 

        it 'performs the seed inititialize', (done) -> 

            nezkit.seed.init = -> done()
            GitAction.configure( 
                root: '.' 
                ->
                ->
                note
            ).init()


        it 'passes the deferral onto the seed class', (done) -> 

            nezkit.seed.init = -> 
                arguments[0].should.equal GitAction.task
                done()

            GitAction.configure( 
                root: '.' 
                ->
                ->
                note
            ).init()


    context 'clone()', ->

        it 'npm install in all nested modules', (done) ->

            #
            # TODO: after proper expectations are possible
            #

            # GitAction.npmInstall = true
            # nezkit.git.seed.prototype.clone = (callback) -> callback null 
            # nezkit.npm.install = -> done()
            # GitAction.assign( root: '.' ).clone()


        it 'git clone of the seed repos', (done) ->

            nezkit.seed.prototype.clone = -> done()
            GitAction.configure( 
                root: '.' 
                ->
                ->
                note

            ).clone()


    context 'status()', -> 

        it 'git status of the tree', (done) ->  

            nezkit.seed.prototype.status = -> done()
            GitAction.configure( 
                root: '.' 
                ->
                ->
                note
            ).status()



