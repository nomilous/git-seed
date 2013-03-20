git-nez
=======

git plugin for nez

### Install

```bash
sudo npm install git-nez -g
```


### Usage

#### Step 0 

```bash
git nez -h
```

#### Step 1 - init

* This recurses for nested git repos starting at `.` or `--root /home/me/git/faraway_tree`.
* It generates a control file `./git_tree` containing details of the found repos.
* The `./git_tree` should be committed. 
* It enables **others** in the team to generate **an identical tree** of cloned repos.


```bash

> git nez init
(init) scanning for git repositories in .

(found) ./.git
(found) ./node/node_modules/brix/.git
(found) ./node/node_modules/brix/node_modules/trix/.git
(found) ./node_modules/nez/.git
(found) ./root/node_modules/elix/.git
(run) git --git-dir=./.git config --get remote.origin.url
(run) cat ./.git/HEAD

...etc

(run) cat ./root/node_modules/elix/.git/HEAD
(run) cat ./root/node_modules/elix/.git/refs/heads/develop
(write) ./.git_tree
> 

```

#### Step 2 - status 

* This step is being performed **at another workstation** 
* Only the root repo has been checked out there.
* It uses the `./git_tree` control file to report on the status across all nested repositories that should be and/or are present.

```bash

> git nez status
(status) for all expected repositories in . 

STATUS @ .
(run) git --git-dir=./.git --work-tree=. status
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#
nothing to commit (working directory clean)

MISSING repo @ ./node/node_modules/brix

MISSING repo @ ./node/node_modules/brix/node_modules/trix

STATUS @ ./node_modules/nez
(run) git --git-dir=./node_modules/nez/.git --work-tree=./node_modules/nez status
# On branch develop
nothing to commit (working directory clean)

MISSING repo @ ./root/node_modules/elix

>

```


### Step 3 - clone

* This clones all the missing repositories.
* It also checkouts the branches as specified in the `./git_tree` control file

```bash

> git nez clone
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
(skip) already cloned ./node_modules/nez
(run) mkdir -p ./root/node_modules/elix
(run) git clone git@github.com:nomilous/elix.git ./root/node_modules/elix
Cloning into './root/node_modules/elix'...
(run) git --git-dir=./root/node_modules/elix/.git --work-tree=./root/node_modules/elix checkout develop
Branch develop set up to track remote branch develop from origin.
Switched to a new branch 'develop'

#
# doing it again has the expected result
#

> git nez clone
(clone) all missing repositories in . 

(skip) already cloned .
(skip) already cloned ./node/node_modules/brix
(skip) already cloned ./node/node_modules/brix/node_modules/trix
(skip) already cloned ./node_modules/nez
(skip) already cloned ./root/node_modules/elix

>
```

### **Important point** 

* The `./git_tree` control file specifies the branch that each repo should be on.
* Running a clone will checkout that branch

```bash

> cd ./node/node_modules/brix/node_modules/trix
> git checkout master
> cd -
> git nez clone
(clone) all missing repositories in . 

(skip) already cloned .
(skip) already cloned ./node/node_modules/brix
(skip) already cloned ./node/node_modules/brix/node_modules/trix
(run) git --git-dir=./node/node_modules/brix/node_modules/trix/.git --work-tree=./node/node_modules/brix/node_modules/trix checkout feature/test
Switched to branch 'feature/test'
(skip) already cloned ./node_modules/nez
(skip) already cloned ./root/node_modules/elix

```

### Step 4 - commit

* **First** it should be pointed out that this commit will enact a commit across **all** repos that have pending files **staged** (ie. files that were `git add <file>`ed)
* This global commit may therefore not be ideal because it commits with common log message for all.
* **It is suggested that in most cases commits should be done manually in each repo**

```bash

> git nez commit -m 'shared commit log message'

pending

```

