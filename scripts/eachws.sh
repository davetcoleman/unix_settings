function commitGit() 
{
    if git diff-index --quiet HEAD --; then
	echo "No changes detected in git repo"
    else
	echo ""
	echo "Changes have been detected in git repo:"
	echo "--------------------------------------------------------"
	echo -e "\e[00;1;95m"
	pwd
	parse_vc_branch_and_add_brackets
	echo -e "\e[00m"
	echo "--------------------------------------------------------"
	echo ""
	git status
	read -p "View git diff? (y/n): " resp
	if [ "$resp" = "y" ]; then
	    echo ""
	    git diff
	    read -p "Commit with gitall? (y/n): " resp
	    if [ "$resp" = "y" ]; then
		gitall
		read -p "Continue? " resp
	    fi	
	fi 
    fi
}

function compileWS()
{
    if catkin build --cmake-args -DCMAKE_BUILD_TYPE=Debug; then  # -j1
	echo ""
	echo "------------------------------------------------------"
	echo "Command succeeded"
	echo ""
	return 1
    else
	echo ""
	echo "------------------------------------------------------"
	echo "Command failed"
	echo ""
	play -q ~/unix_settings/emacs/failure.wav
	return 0
    fi
}

function pullGit()
{
    pwd
    git pull
}

function checkBranch()
{
    gitbranch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'`

    result=${PWD##*/}          # to assign to a variable
    echo -n $gitbranch
    echo -e -n "  \e[00;1;34m"
    printf '%s' "${PWD##*/}" 
    echo -e "\e[00m"
}

# ---------------------------------------------------------------------
# ---------------------------------------------------------------------
# ---------------------------------------------------------------------
# ---------------------------------------------------------------------

function eachws
{
    workspaces=( "/home/$USER/ros/ws_picknik/src" )

    for i in "${workspaces[@]}"
    do :
	cd "$i"
	if eval "$1 $2"; then
	    echo ""
	    echo "------------------------------------------------------"
	    echo "Command succeeded in workspace"
	    echo ""
	else
	    echo ""
	    echo "------------------------------------------------------"
	    echo "Command failed in workspace"
	    echo ""
	    play -q ~/unix_settings/emacs/failure.wav
	    return 0
	fi
    done
}

function eachgit
{
    for x in `find \`pwd\` -name .git -type d -prune`; do
	cd $x
	cd ../
	if eval "$1"; then
	    echo ""
	else
	    echo ""
	    echo "------------------------------------------------------"
	    echo "Command failed in git"
	    echo ""
	    play -q ~/unix_settings/emacs/failure.wav
	    return 0
	fi
    done
}

# Shortcuts
alias eachws_commit="eachws eachgit commitGit"
alias eachws_pull="eachws eachgit pullGit"
alias eachws_branch="eachws eachgit checkBranch"
alias eachws_compile="eachws compileWS"
alias eachws_clean="eachws catclean"
