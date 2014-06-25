Mercurial

## Branches ----------------------------

Create Branch
  hg branch BRANCHNAME

Rename Branch
  hg update stiging
  hg branch staging
  hg commit -m "Changing stiging branch to staging."
  hg update stiging
  hg commit --close-branch -m"This was a typo; use staging instead."
  hg push --new-branch

Close remote branch
  hg ci -m 'Closed branch feature-x' --close-branch
  hg push
  hg co NONCLOSEDBRANCH

Push new branch to remote
  hg co NEWBRANCH
  hg push --new-branch


## Basic -------------------------------

Update Repo
  hg pull
  hg up

Undo all uncommited changes to current branch
  hg up -C



