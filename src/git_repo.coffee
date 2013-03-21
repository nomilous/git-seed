Git   = require('nez-kit').git
Shell =require('nez-kit').shell

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


    printMissing: -> 

        console.log "(MISSING) repo: #{@path}".red
        false


    printStatus: -> 

        unless Shell.gotDirectory @path + '/.git'
            
            return @printMissing()

        status = Git.showStatus @path, false

        #
        # lazy moment (revist this properly)
        #

        show = true

        if status.match /nothing to commit \(working directory clean\)/

            show = false

        if status.match /Your branch is ahead/

            show = true

        if show

            console.log '\n(change)'.green, @path.bold
            console.log status + '\n'

        else

            console.log '(skip)'.green, "no change at #{@path}"


    clone: (callback) ->

        Git.clone @path, @origin, @branch, callback


    commit: (message, callback) -> 

        Git.commit @path, @branch, message, callback
        


module.exports = GitRepo
