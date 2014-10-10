if [[ $BASHRC_ENV != "dtc" && $platform != "osx" ]]; then   #only for ubuntu
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

# change git https to ssh
function gitsshfix() {
    #-- Script to automate https://help.github.com/articles/why-is-git-always-asking-for-my-password

    REPO_URL=`git remote -v | grep -m1 '^origin' | sed -Ene's#.*(https://[^[:space:]]*).*#\1#p'`
    if [ -z "$REPO_URL" ]; then
	echo "-- ERROR:  Could not identify Repo url."
	echo "   It is possible this repo is already using SSH instead of HTTPS."
	exit
    fi

    USER=`echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\1#p'`
    if [ -z "$USER" ]; then
	echo "-- ERROR:  Could not identify User."
	exit
    fi

    REPO=`echo $REPO_URL | sed -Ene's#https://github.com/([^/]*)/(.*).git#\2#p'`
    if [ -z "$REPO" ]; then
	echo "-- ERROR:  Could not identify Repo."
	exit
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

# Show git branch at prompt:
export PS1="\[\033[0;32m\]\$(parse_vc_branch_and_add_brackets)\[\033[0m\] \W$ "


