fs      = require 'fs'
colors  = require 'colors'  
GitRepo = require './git_repo'

class GitTree

    @init: (array, root) -> 

        repoArray = []

        for path in array

            repoArray.push GitRepo.init path

        return new GitTree root, repoArray


    constructor: (@root, list) -> 

        if list instanceof Array

            @array = list

    save: -> 

        try

            fs.writeFileSync "#{@root}/.git_tree", 
                JSON.stringify( @array, null, 2 )

        catch error

            console.log error.red
            throw error


module.exports = GitTree
