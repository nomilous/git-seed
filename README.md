git-seed
========

[objective](https://github.com/nomilous/git-seed/blob/master/objective)

### Current version 

0.0.4

Install
-------

### Global install with npm

```bash
sudo npm install git-seed -g
```

### Integrate / Personalize

Output from a `git seed` run can be intercepted by defining an alternative 'git-seed' notification middleware function in `$HOME/.notice/middleware.js`

```js

module.exports = {

    'git-seed': function( msg, next ) {
        console.log(msg.content);
        next();
    }

}

```

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


### Step 6 - pull

* This first pulls the root repo to get the latest `.git-seed` control file
* Then it pulls all the nested repos.
* Before pulling a nested repo a comparison is made against the `.git-seed` file. Pulls are skipped if the local clone **is already at the version specified** or **is on a different branch**.
* It runs `npm install` across all repos once the pulls are complete.

```bash
> git seed pull
(pull) pull all where necessary . 

(run) git pull git@github.com:nomilous/git-seed.git refs/heads/develop (in .)
From github.com:nomilous/git-seed
 * branch            develop    -> FETCH_HEAD
Already up-to-date.
(skip) ./node_modules/git-seed-npm already up-to-date with .git-seed
(skip) ./node_modules/git-seed-npm/node_modules/git-seed-core already up-to-date with .git-seed
(run) npm install (in .)
(run) npm install (in ./node_modules/git-seed-npm)
(run) npm install (in ./node_modules/git-seed-npm/node_modules/git-seed-core)

```


### Step 7 - push

Herein lies intricacy... *Thinking*

