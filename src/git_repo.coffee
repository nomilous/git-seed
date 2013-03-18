Git   = require './tools/git'
Shell = require './tools/shell'

class GitRepo

    @init: (workDir, seq) -> 

        return new GitRepo

            root:   seq == 0
            path:   workDir
            origin: Git.showOrigin workDir
            branch: Git.showBranch workDir
            ref:    Git.showRef workDir


    constructor: (properties) ->

        for property of properties

            @[property] = properties[property]

            if property == 'ref' and @root

                #
                # root repo has special ref
                # 
                # - no need to carry the root repo ref
                # - catch22 on root commit if we do
                # 

                @[property] = 'ROOT_REPO_REF'


    printStatus: -> 

        unless Shell.gotDirectory @path + '/.git'

            console.log "MISSING repo @ #{@path}".red
            return

        


module.exports = GitRepo
