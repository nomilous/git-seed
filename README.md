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

```

#### Step 2 - status 

* This step is being performed **at another workstation** 
* Only the root repo has been checked out there.
* It uses the `./git_tree` control file to report on the status across all nested repositories that should be and/or are present.

```bash

> git nez status
(status) for all expected repositories in .
MISSING repo @ ./node/node_modules/brix
MISSING repo @ ./node/node_modules/brix/node_modules/trix
MISSING repo @ ./root/node_modules/elix

```
