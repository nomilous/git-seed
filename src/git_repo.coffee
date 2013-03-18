Git = require './tools/git'

class GitRepo

    @init: (workDir) -> 

        return new GitRepo

            path:   workDir
            origin: Git.showOrigin workDir
            branch: Git.showBranch workDir
            ref:    Git.showRef workDir


    constructor: (properties) ->

        for property of properties

            @[property] = properties[property]


module.exports = GitRepo
