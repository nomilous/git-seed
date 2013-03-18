Git = require './tools/git'

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
                # root repo as special ref
                # 
                # - no need to carry the root repo
                # - catch22 on root commit if we do
                # 

                @[property] = 'ROOT_REPO_REF'


module.exports = GitRepo
