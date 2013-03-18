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

This recurses for nested git repos starting at `.` or `--root /home/me/git/faraway_tree` and 
generates a control file containing details of the found repos.

```bash

$> git nez init

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

