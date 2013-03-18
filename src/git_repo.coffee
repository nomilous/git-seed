GitTools = require './git_tools'

class GitRepo

    @init: (workDir) -> 

        return new GitRepo

            path:   workDir
            origin: GitTools.showOrigin workDir
            branch: GitTools.showBranch workDir
            ref:    GitTools.showRef workDir


    constructor: (properties) ->

        console.log '\ninit GitRepo @ \n', properties


module.exports = GitRepo
