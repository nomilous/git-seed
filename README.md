git-seed
========

[objective](https://github.com/nomilous/git-seed/blob/master/objective)

### Current version 

0.0.4

Install
-------

```bash
sudo npm install git-seed -g
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





### Step 5 - commit

* **First** it should be pointed out that this commit will enact a commit across **all** repos that have pending files **staged** (ie. files that were `git add <file>`ed)
* This global commit may therefore not be ideal because it commits with a common log message for all.
* **It is suggested that in most cases commits should be done manually in each repo**

```bash

> cd ./root/node_modules/elix
> git add requirements/manageability.coffee 
> cd ../../ 
> git seed commit -m 'it propagates a config hup into the tree'
(commit) on all repositories with staged changes in . 

(skip) no staged changes in .
(skip) no staged changes in ./node/node_modules/brix
(skip) no staged changes in ./node/node_modules/brix/node_modules/trix
(skip) no staged changes in ./node_modules/nez
(run) git --git-dir=./root/node_modules/elix/.git --work-tree=./root/node_modules/elix commit -m it propagates a config hup into the tree
[develop 74d5db8] it propagates a config hup into the tree
 1 file changed, 1 insertion(+)

>

#
# the new status as expected
#

> git seed status
(status) for all expected repositories in . 

(skip) no change at .
(skip) no change at ./node/node_modules/brix
(skip) no change at ./node/node_modules/brix/node_modules/trix
(skip) no change at ./node_modules/nez

(change) ./root/node_modules/elix
# On branch develop
# Your branch is ahead of 'origin/develop' by 1 commit.
#
nothing to commit (working directory clean)

>

```


#### **Important point** 

* It may be that one of your repos has forgetccidentally been left checkedout on the wrong branch (according to the `.git-seed` control file)
* The commit run **will report this case of affairs and take no further action** for that repo.  

```bash

> cd ./root/node_modules/elix
> git checkout master
> cd -
> git seed commit -m 'shared commit log message'
(commit) on all repositories with staged changes in . 

(skip) no staged changes in .
(skip) no staged changes in ./node/node_modules/brix
(skip) no staged changes in ./node/node_modules/brix/node_modules/trix
(skip) no staged changes in ./node_modules/nez
( SKIPPED ) ./root/node_modules/elix SHOULD BE ON BRANCH refs/heads/develop NOT refs/heads/master

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

