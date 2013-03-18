GitRepo = require './git_repo'

class GitRepos

    @init: (array, root) -> 

        for path in array

            repo = GitRepo.init path


    constructor: (controlFile) -> 



module.exports = GitRepos
