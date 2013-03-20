Shell     = require './shell'
colors    = require 'colors'
waterfall = require('async').waterfall

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


    clone: (workDir, origin, branch, finalCallback) -> 

        console.log 'clone %s into %s and checkout %s', origin, workDir, branch

        #
        # TODO: test that the clone is acutally necessary
        #

        waterfall [

            #
            # calls in serial, proceeds no further on fail
            #

            (callback) -> 

                Shell.spawn 'sleep', [0], (error, result) ->

                    callback error, result

            (arg, callback) -> 

                Shell.spawn 'sleep', [1], (error, result) ->

                    callback error, result

        ], finalCallback



