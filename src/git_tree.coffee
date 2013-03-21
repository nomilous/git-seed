fs       = require 'fs'
colors   = require 'colors'  
GitRepo  = require './git_repo'
actionOn = require('nez-kit').set.series

class GitTree

    @init: (root, array) -> 

        repoArray = []

        seq = 0

        for path in array

            repoArray.push GitRepo.init path, seq++

        return new GitTree root, repoArray


    constructor: (@root, list) -> 

        @control = "#{@root}/.nez_tree"

        if list instanceof Array

            @array = list

        else if typeof list == 'undefined'

            @array = @load()

    save: -> 

        try

            fs.writeFileSync "#{@root}/.nez_tree", 
                JSON.stringify( @array, null, 2 )

            console.log '(write)'.green, "#{@root}/.nez_tree"

        catch error

            console.log error.red
            throw error


    load: -> 

        try 

            throw '' unless fs.lstatSync(  @control  ).isFile()

        catch error

            require('./git_action').exitCode = 2
            throw "explected control file: #{@root}/.nez_tree"

        try

            json = JSON.parse fs.readFileSync @control

            array = []

            for properties in json

                array.push new GitRepo properties

            return array

        catch error

            require('./git_action').exitCode = 3
            throw "error loading control file: #{@root}/.nez_tree #{error.toString()}"


    status: -> 

        for repo in @array

            repo.printStatus()


    clone: (callback) -> 

        actionOn @array, 'clone', null, callback


    commit: (message, callback) ->

        actionOn @array, 'commit', [message], callback


    noControl: (ex) ->

        throw error = ex || new Error( 

            'Expected control file, not this:' + @control

        )



module.exports = GitTree
