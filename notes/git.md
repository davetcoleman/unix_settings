Dave's Git Cheat Sheet
============

Setup
  git config status.showuntrackedfiles no

Delete/Remove Commit =========================================================

Remove Last Commit (unpushed) but leave the changed code there as "Changes to be committed"
  git reset --soft HEAD~1    # increase 1 to any number to delete more commits

Reflect the reset (deleted commmits) on the remote
  git push origin +HEAD  # force-push the new HEAD commit

Remove Last Commit that has been pushed. This creates a new commit that reverses everything from accidental commit
  git revert HEAD

Removes staged and working directory changes.
  git reset --hard  HEAD

Removes the last commit
  git reset --hard  HEAD~1

Delete all untracked files in a Git repo (careful!) including directories
  git clean -f -d

Removes a commit from remote
  git push upstream +dd61ab32^:master
  upstream - remote name
  dd61ab32 - commit id
  master - remote branch

Remove a specific past commit
  git revert COMMIT_NUM
  ... # fix merge issues
  git revert --continue

When there is a merge conflict in a file, just keep mine or theirs:
  git checkout --ours src/file.cpp
  git checkout --theirs src/file.cpp

Copy a version of a single file from one git branch to another
  git checkout otherbranch myfile.txt

View the difference in commits between two branches
  git log A..B

Branch Stuff =========================================================

Replace master branch entirely with another branch
  git checkout seotweaks
  git merge -s ours master
  git checkout master
  git merge seotweaks

Graphical editor
  gitk

Create new branch and push to Github
  git branch NEWBRANCH
  git push -u origin NEWBRANCH

Delete a remote (Github) branch:
  git push origin --delete <branchName>
  OR
  git push origin :BRANCH_NAME

Delete a local branch:
  git branch -D <branchName>

Sync a github fork with its parent repo
  #ONE TIME
  git remote add upstream ...
  #EVERY TIME
  git fetch upstream
  git merge upstream/master
  git push origin master

Git GUI
  gitg

Move a commit to another branch
  git co BRANCH_WITH_COMMIT
  git log -1                     // get COMMIT_ID to move
  git co BRANCH_TO_MOVE_COMMIT
  git cherry-pick COMMIT_ID
  
  // Delete prev commit location

Delete A Remote Tag
  git tag -d 12345
  git push origin :refs/tags/12345

Track Remote Branch Locally
  git co -b [branch] [remotename]/[branch]

Clear out tracked branches that no longer exist on remotes
  git branch prune origin --dry-run

Stash =========================================================

Stash current changes
  git stash
  or
  git stash save

Recall stash
  git stash pop

See all stashes
  git stash list

Remove all old staets
  git stash clear

Working with Documents / Latex =========================================================

Make Diff word wrap for the whole repo:
  git config core.pager 'less -r' 

See word-by-word highlights
  git diff --word-diff A B

Other Stuff =========================================================

Delete all untracked files
  git clean -f

View the log with file modification info
  git log --stat

Combine commits from one branch and merge into current branch
  git merge squash --feature    

Commit part of a file / partial file
  git add -p filename 

  y to stage that hunk, or
  n to not stage that hunk, or
  e to manually edit the hunk (useful when git can't split it automatically)
  d to exit or go to the next file.
  ? to get the whole list of available options.

Create new branch and check it out
  git checkout -b feature

Combine commits into one
  git rebase -i BASE_COMMIT
  for every commit, change 'pick' to 's' and the first line to 'r' (reword)

See what git did under the hood
  git reflog

Interactive rebase
  git rebase -i
  then you can delete commit lines to permanetly delete certain changes
  change the pick to r to allow you to reword the commit

See what I'm about to push to a remote repo:
  git diff --stat origin/master

Graphical Interface
  gitk

Hub
  https://github.com/github/hub