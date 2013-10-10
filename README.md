[objective](https://github.com/nomilous/git-seed/blob/master/objective)

`sudo npm install git-seed -g`

### Current version 0.0.6 (unstable)

git-seed
========

Todo
----

* Switch to notice-0.0.11
* Inform when switching submodule from git clone to subsequently published npm install (npm wont write into a node_modules folder already populated by git repo clone and vice-versa, best to leave the delete up to the user)
* Inform on multiple nested same submodule on different revision. (This happens when the same unreleased node_module is a doublenested dependency in more than one nested submodule) or see [tip](#got-the-same-module-nested-again-deeper-inside-another)

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

Tip
---

### Got the same module nested again deeper inside another?

```bash
cd node_modules/
rm -fr notice/
ln -s phrase/node_modules/notice
cd ../
git seed status

 info (start seed status) - for all git repositories in './.git-seed'
 info (skip) - no changes .
 info (unpushed changes) - ./node_modules/notice
# On branch develop
# Your branch is ahead of 'origin/develop' by 47 commits.     <----------------SAME
#
nothing to commit (working directory clean)

 info (skip) - no changes ./node_modules/phrase
 info (unpushed changes) - ./node_modules/phrase/node_modules/notice
# On branch develop
# Your branch is ahead of 'origin/develop' by 47 commits.     <----------------SAME
#
nothing to commit (working directory clean)

 info (seed status) - success
 info (seed status results) - 

 ##
 cd node_modules/notice
 git push origin develop
 cd -
 git seed status
 info (start seed status) - for all git repositories in './.git-seed'
 info (skip) - no changes .
 info (skip) - no changes ./node_modules/notice
 info (skip) - no changes ./node_modules/phrase
 info (skip) - no changes ./node_modules/phrase/node_modules/notice
 info (seed status) - success
 info (seed status results) - 


```
