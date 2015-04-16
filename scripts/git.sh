if [[ $BASHRC_ENV != "dtc" && $platform != "osx" && $BASHRC_ENV != "ros_baxter" ]]; then   #only for ubuntu
    alias git=hub
fi
alias gitst='git status'
alias gitlg='git log -p'
alias gitall='git add -A :/ && git commit -a && git push origin --all'
alias gitreadme='git commit README.md -m "Updated README" && git push'
alias gitb='git branch'
alias gitorigin='git remote show -n origin'
alias gitdiff='GIT_PAGER="" git diff --color-words'  # adds word wrap

alias gitlogcompare="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative "
alias gitlogcompare_hydro_indigo="gitlogcompare hydro-devel..indigo-devel"
alias gitlogcompare_indigo_hydro="gitlogcompare indigo-devel..hydro-devel"

alias gitremoteswich="git remote rename origin upstream"

# Find all git repos in pwd and run 'git pull'
function git_pull_all()
{
    original_location=$(pwd);

    for x in `find \`pwd\` -name .git -type d -prune`; do
	cd $x
	cd ../
	echo "--------------------------------------------------------"
	echo -e "\e[00;1;95m"
	pwd
	parse_vc_branch_and_add_brackets
	echo -e "\e[00m"

	if git pull; then
	    echo "Pull successfull"
	else
	    read -p "Error. Continue?" resp
	fi
	echo "--------------------------------------------------------"
    done

    cd $original_location
    echo ""
    echo "Finished pulling all ROS repos!"
    echo ""
    play -q ~/unix_settings/emacs/success.wav
}


# change git ssh to https
function git_ssh_to_https() {
    #-- Script to automate https://help.github.com/articles/why-is-git-always-asking-for-my-password

    REPO_URL=`git remote -v | grep -m1 '^origin' | sed -Ene's#.*(git@[^[:space:]]*).*#\1#p'`
    if [ -z "$REPO_URL" ]; then
	echo "-- ERROR:  Could not identify Repo url."
	echo "   It is possible this repo is already using SSH instead of HTTPS."
	return
    fi

    USER=`echo $REPO_URL | sed -Ene's#git@github.com:([^/]*)/(.*).git#\1#p'`
    if [ -z "$USER" ]; then
	echo "-- ERROR:  Could not identify User."
	return
    fi

    REPO=`echo $REPO_URL | sed -Ene's#git@github.com:([^/]*)/(.*).git#\2#p'`
    if [ -z "$REPO" ]; then
	echo "-- ERROR:  Could not identify Repo."
	return
    fi

    NEW_URL="https://github.com/$USER/$REPO.git"
    echo "Changing repo url from "
    echo "  '$REPO_URL'"
    echo "      to "
    echo "  '$NEW_URL'"
    echo ""

    CHANGE_CMD="git remote set-url origin $NEW_URL"
    `$CHANGE_CMD`

    echo "Success"
}

# change git https to ssh
function git_https_to_ssh() {
    #-- Script to automate https://help.github.com/articles/why-is-git-always-asking-for-my-password

    REPO_URL=`git remote -v | grep -m1 '^origin' | sed -Ene's#.*(https://[^[:space:]]*).*#\1#p'`
    if [ -z "$REPO_URL" ]; then
	echo "-- ERROR:  Could not identify Repo url."
	echo "   It is possible this repo is already using SSH instead of HTTPS."
	return
    fi

    USER=`echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\1#p'`
    if [ -z "$USER" ]; then
	echo "-- ERROR:  Could not identify User."
	return
    fi

    REPO=`echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\2#p'`
    if [ -z "$REPO" ]; then
	echo "-- ERROR:  Could not identify Repo."
	return
    fi

    NEW_URL="git@github.com:$USER/$REPO.git"
    echo "Changing repo url from "
    echo "  '$REPO_URL'"
    echo "      to "
    echo "  '$NEW_URL'"
    echo ""

    CHANGE_CMD="git remote set-url origin $NEW_URL"
    `$CHANGE_CMD`

    echo "Success"
}

# Show what git or hg branch we are in
function parse_vc_branch_and_add_brackets {
    gitbranch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'`

    if [[ "$gitbranch" != '' ]]; then
	echo $gitbranch
    else
	hg branch 2> /dev/null | awk '{print $1 }'
    fi
}

# Opens the github page for the current git repository in your browser.
# Can pass in argument for which remote to use, defaults to 'origin'
function gh() {
  gitremote="$1"
  if [ "$1" == "" ]; then
      gitremote="origin";
  fi

  giturl=$(git config --get remote.$gitremote.url)
  if [ "$giturl" == "" ]; then
     echo "Not a git repository or no remote.origin.url set"
     return
  fi

  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/\/tree}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=$giturl/$branch

  if [[ $platform != 'osx' ]]; then
      xdg-open $giturl # linux
  else
      open $giturl # mac
  fi
}

function bb() {
  gitremote="$1"
  if [ "$1" == "" ]; then
      gitremote="origin";
  fi

  giturl=$(git config --get remote.$gitremote.url)
  if [ "$giturl" == "" ]; then
     echo "Not a git repository or no remote.origin.url set"
     return
  fi

  giturl=${giturl/git\@bitbucket\.org\:/https://bitbucket.org/}
  giturl=${giturl/\.git/\/commits\/branch}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=$giturl/$branch

  if [[ $platform != 'osx' ]]; then
      xdg-open $giturl # linux
  else
      open $giturl # mac
  fi
}

#https://github.com/davetcoleman/moveit_ros/tree/add-joystick-interface
#https://bitbucket.org/davetcoleman/moveit_ros/branch/all_dev_combined_indigo



# Show git branch at prompt:
#export PS1="\[\033[0;32m\]\$(parse_vc_branch_and_add_brackets)\[\033[0m\] \W$ "
export PS1="\[\033[34m\][\h]\[\033[0m\]\[\033[0;32m\]\$(parse_vc_branch_and_add_brackets)\[\033[0m\] \W$ " 

#export PS1="0;36 `hostname` 0;30"

