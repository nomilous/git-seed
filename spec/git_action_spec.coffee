should = require 'should'
notice = require 'notice'
GitAction = require '../lib/git_action'
gitseed   = require 'gitseed'   

describe 'git_action', -> 

    note = notice.create 'git-seed'

    context 'configure()', -> 

        beforeEach -> 
            @create = gitseed.create

        afterEach -> 
            gitseed.create = @create


        it 'initializes gitseed with a notifier', (done) -> 

            gitseed.create = (opts) -> 

                opts.notice.should.equal 'NOTIFIER'
                done()
                throw 'no further'

            try GitAction.configure {}, 'NOTIFIER'


        it 'assigns message and plugin', (done) -> 

            seed = {}
            gitseed.create = (opts) -> 
                return seed

            GitAction.configure {

                message: 'commit log message'
                

            }, {}

            console.log seed



    xcontext 'init()', -> 

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


    xcontext 'clone()', ->

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


    xcontext 'status()', -> 

        it 'git status of the tree', (done) ->  

            nezkit.seed.prototype.status = -> done()
            GitAction.configure( 
                root: '.' 
                ->
                ->
                note
            ).status()



