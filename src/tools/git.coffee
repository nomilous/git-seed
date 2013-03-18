Shell  = require './shell'
colors = require 'colors'

module.exports = git = 

    showOrigin: (workDir) -> 

        gitDir = git.gitDir workDir
        
        try

            return Shell.execSync(

                "git --git-dir=#{gitDir} config --get remote.origin.url"

            )

        catch error

            console.log error.red
            throw error


    showBranch: (workDir) -> 

        gitDir = git.gitDir workDir

        try

            return Shell.execSync(

                "cat #{gitDir}/HEAD"

            ).match(

                /ref: (.*)$/

            )[1]

        catch error

            console.log error.red
            throw error


    showRef: (workDir) -> 

        gitDir = git.gitDir workDir
        branch = git.showBranch workDir

        try

            return Shell.execSync(

                "cat #{gitDir}/#{branch}"

            )

        catch error

            console.log error.red
            throw error


    showStatus: (workDir) -> 

        gitDir = git.gitDir workDir

        try

            return Shell.execSync( 

                "git --git-dir=#{gitDir} --work-tree=#{workDir} status"

            )

        catch error

            console.log error.red
            throw error


    gitDir: (workDir) -> 

        workDir + '/.git'