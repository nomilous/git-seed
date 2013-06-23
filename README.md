[objective](https://github.com/nomilous/git-seed/blob/master/objective)

`sudo npm install git-seed -g`

### Current version 0.0.6 (unstable)

git-seed
========

Integrate / Personalize
-----------------------

Output from a `git seed` run can be intercepted by defining an alternative 'git-seed' notification middleware function in `$HOME/.notice/middleware.js`

```js

module.exports = {

    'git-seed': function( msg, next ) {
        console.log(msg.content);
        next();
    }

}

```
More on that [here](https://github.com/nomilous/notice)


Usage
=====

```
git seed --help
```

git seed init
-------------

Make/Update the `.git-seed` file

```bash

> git seed init

 info (start seed init) - recurse for git repositories in '.'
 info (found repo) - ./.git
 info (found repo) - ./node_modules/git-seed-npm/.git
 info (found repo) - ./node_modules/git-seed-npm/node_modules/git-seed-core/.git
 info (found repo) - ./node_modules/nezkit/.git
 info (found repo) - ./node_modules/notice/.git
 info (found repo) - ./node_modules/notice-cli/.git
EVENT [seed update] - wrote file: ./.git-seed

```

git seed clone
--------------

Clone all repos according to the `.git-seed` file

* The `.git-seed` **control file specifies the branch** that each repo should be on.
* Running a clone will checkout that branch

```bash

> git seed clone

 info (start seed clone) - for all git repositories in './.git-seed'
 info (skip) - already cloned .
 info (skip) - already cloned ./node_modules/git-seed-npm
 info (skip) - already cloned ./node_modules/git-seed-npm/node_modules/git-seed-core
 info (skip) - already cloned ./node_modules/nezkit
 info (skip) - already cloned ./node_modules/notice
 info (skip) - already cloned ./node_modules/notice-cli
EVENT [seed clone] - success
 info (seed clone results) - undefined
 info (shell) - run npm install, (in .)
 info (shell) - run npm install, (in ./node_modules/git-seed-npm)
 info (shell) - run npm install, (in ./node_modules/git-seed-npm/node_modules/git-seed-core)
 info (shell) - run npm install, (in ./node_modules/nezkit)
 info (shell) - run npm install, (in ./node_modules/notice)
 info (shell) - run npm install, (in ./node_modules/notice-cli)
EVENT [seed install] - success
 info (seed install results) - undefined

```

git seed status
---------------

Report status across all repos in the `.git-seed` file

```bash

> git seed status

info (start seed status) - for all git repositories in './.git-seed'
 info (has changes) - .
# On branch develop
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#   modified:   README.md
#
no changes added to commit (use "git add" and/or "git commit -a")

 info (skip) - no changes ./node_modules/git-seed-npm
 info (skip) - no changes ./node_modules/git-seed-npm/node_modules/git-seed-core
 info (skip) - no changes ./node_modules/nezkit
 info (skip) - no changes ./node_modules/notice
 info (skip) - no changes ./node_modules/notice-cli
 info (seed status) - success
 info (seed status results) - undefined

```


git seed commit
---------------

Commit with a common message across all repos with staged changes

```bash

> git seed commit -m 'commit uses pipeline'

info (start seed commit) - for any git repositories with staged changes in './.git-seed' 
 info (skip) - no staged changes .
 info (skip) - no staged changes ./node_modules/git-seed-npm
 info (shell) - run git --git-dir=./node_modules/git-seed-npm/node_modules/git-seed-core/.git --work-tree=./node_modules/git-seed-npm/node_modules/git-seed-core commit -m commit uses pipeline
 info (commit) - ./node_modules/git-seed-npm/node_modules/git-seed-core
[develop aa5c505] commit uses pipeline
 4 files changed, 117 insertions(+), 91 deletions(-)

 info (skip) - no staged changes ./node_modules/git-seed-npm/node_modules/git-seed-core
 info (skip) - no staged changes ./node_modules/nezkit
 info (skip) - no staged changes ./node_modules/notice
 info (skip) - no staged changes ./node_modules/notice-cli
 info (seed commit) - success
 info (seed commit results) - undefined

```


git seed pull
-------------

Pull across all repos

* Pull first pulls the root repo to get the latest seed file 
* Pull only pulls other repos if their local version differs from that in the seed file

```bash

> git seed pull

info (start seed pull) - for all git repositories in './.git-seed'
 info (pull) - .
 info (shell) - run git pull git@github.com:nomilous/git-seed.git refs/heads/develop, (in .)
 info (seed pull) - success
 info (seed pull results) - undefined
 info (skip) - already up-to-date ./node_modules/nezkit
 info (skip) - already up-to-date ./node_modules/notice
 info (skip) - already up-to-date ./node_modules/notice-cli
 info (seed pull) - success
 info (seed pull results) - undefined
 info (shell) - run npm install, (in .)
npm http GET https://registry.npmjs.org/git-seed-npm/0.0.3
npm http 304 https://registry.npmjs.org/git-seed-npm/0.0.3
npm http GET https://registry.npmjs.org/git-seed-core/0.0.2
...
npm http 304 https://registry.npmjs.org/traverse
npm http 304 https://registry.npmjs.org/traverse
git-seed-npm@0.0.3 node_modules/git-seed-npm
└── git-seed-core@0.0.2 (when@2.1.0, fs-extra@0.6.1, findit@0.1.2)
 info (shell) - run npm install, (in ./node_modules/nezkit)
 info (shell) - run npm install, (in ./node_modules/notice)
 info (shell) - run npm install, (in ./node_modules/notice-cli)
EVENT [seed install] - success
 info (seed install results) - undefined



```
