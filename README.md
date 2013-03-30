git-seed
========

[objective](https://github.com/nomilous/git-seed/blob/master/objective)


### Current version 

0.0.2

### Pending functionality

* push across all nested repos with commits pending
* pull across all repos

### Install

```bash
sudo npm install git-seed -g
```

### Package Manager Plugins

Default package manager plugin module is [git-seed-npm](https://github.com/nomilous/git-seed-npm). Alternative plugins might come to exist.

To use an alternative:

```bash

#
# the plugin will need to be installed globally (once)
#

sudo npm install git-seed-bundler -g

#
# seed initialization can the specify
#

git seed --package-manager bundler init 

```



Usage
-----

### Step 0 

```bash
git seed -h
```

### Step 1 - init

* This recurses for nested git repos starting at `.`
* It generates a control file `.git-seed` containing details of the found repos.
* The `.git-seed` should be committed. 
* It enables **others** in the team to generate **an identical tree** of cloned repos.


```bash

> git seed init
(init) scanning for git repositories in . 

(found) ./.git
(found) ./node/node_modules/brix/.git
(found) ./node/node_modules/brix/node_modules/trix/.git
(found) ./node_modules/nez/.git
(found) ./root/node_modules/elix/.git
(write) ./.git-seed

> 

```

### Step 2 - status 

* This step is being performed **at another workstation** 
* Only the root repo has been checked out there.
* It uses the `.git-seed` control file to report on the status across all nested repositories that should be and/or are present.

```bash

> git seed status
(status) for all expected repositories in . 

(skip) no change at .
(MISSING) repo: ./node/node_modules/brix
(MISSING) repo: ./node/node_modules/brix/node_modules/trix
(MISSING) repo: ./node_modules/nez
(MISSING) repo: ./root/node_modules/elix

>

```


### Step 3 - clone

* This clones all the missing repositories.
* It also checkouts the branches as specified in the `.git-seed` control file

```bash

> git seed clone
(clone) all missing repositories in . 

(skip) already cloned .
(run) mkdir -p ./node/node_modules/brix
(run) git clone git@github.com:nomilous/brix.git ./node/node_modules/brix
Cloning into './node/node_modules/brix'...
(run) mkdir -p ./node/node_modules/brix/node_modules/trix
(run) git clone git@github.com:nomilous/trix.git ./node/node_modules/brix/node_modules/trix
Cloning into './node/node_modules/brix/node_modules/trix'...
(run) git --git-dir=./node/node_modules/brix/node_modules/trix/.git --work-tree=./node/node_modules/brix/node_modules/trix checkout feature/test
Switched to a new branch 'feature/test'
Branch feature/test set up to track remote branch feature/test from origin.
(run) mkdir -p ./node_modules/nez
(run) git clone git@github.com:nomilous/nez.git ./node_modules/nez
Cloning into './node_modules/nez'...
(run) git --git-dir=./node_modules/nez/.git --work-tree=./node_modules/nez checkout develop
Branch develop set up to track remote branch develop from origin.
Switched to a new branch 'develop'
(run) mkdir -p ./root/node_modules/elix
(run) git clone git@github.com:nomilous/elix.git ./root/node_modules/elix
Cloning into './root/node_modules/elix'...
(run) git --git-dir=./root/node_modules/elix/.git --work-tree=./root/node_modules/elix checkout develop
Switched to a new branch 'develop'
Branch develop set up to track remote branch develop from origin.

>

#
# doing it again has the expected result
#

> git seed clone
(clone) all missing repositories in . 

(skip) already cloned .
(skip) already cloned ./node/node_modules/brix
(skip) already cloned ./node/node_modules/brix/node_modules/trix
(skip) already cloned ./node_modules/nez
(skip) already cloned ./root/node_modules/elix

>
```

#### **Important point** 

* The `.git-seed` **control file specifies the branch** that each repo should be on.
* Running a clone will checkout that branch

```bash

> cd ./node/node_modules/brix/node_modules/trix
> git checkout master
> cd -
> git seed clone
(clone) all missing repositories in . 

(skip) already cloned .
(skip) already cloned ./node/node_modules/brix
(skip) already cloned ./node/node_modules/brix/node_modules/trix
(run) git --git-dir=./node/node_modules/brix/node_modules/trix/.git --work-tree=./node/node_modules/brix/node_modules/trix checkout feature/test
Switched to branch 'feature/test'
(skip) already cloned ./node_modules/nez
(skip) already cloned ./root/node_modules/elix

```

### Step 4 - status

* After modification in one of the nested modules

```bash

> git seed status
(status) for all expected repositories in . 

(skip) no change at .
(skip) no change at ./node/node_modules/brix
(skip) no change at ./node/node_modules/brix/node_modules/trix
(skip) no change at ./node_modules/nez

(change) ./root/node_modules/elix
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#   modified:   requirements/manageability.coffee
#
no changes added to commit (use "git add" and/or "git commit -a")

>

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
