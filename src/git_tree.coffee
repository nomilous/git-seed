fs      = require 'fs'
colors  = require 'colors'  
GitRepo = require './git_repo'

class GitTree

    @init: (root, array) -> 

        repoArray = []

        for path in array

            repoArray.push GitRepo.init path

        return new GitTree root, repoArray


    constructor: (@root, list) -> 

        @control = "#{@root}/.git_tree"

        if list instanceof Array

            @array = list

        else if typeof list == 'undefined'

            @array = @load()


    save: -> 

        try

            fs.writeFileSync "#{@root}/.git_tree", 
                JSON.stringify( @array, null, 2 )

        catch error

            console.log error.red
            throw error


    load: -> 

        try 

            @noControl() unless fs.lstatSync(  @control  ).isFile()

        catch error

            @noControl error

        try

            json = JSON.parse fs.readFileSync @control

            array = []

            for properties in json

                array.push new GitRepo properties

            return array

        catch error

            @noControl error


    noControl: (ex) ->

        throw error = ex || new Error( 

            'Expected control file, not this:' + @control

        )

        


module.exports = GitTree
