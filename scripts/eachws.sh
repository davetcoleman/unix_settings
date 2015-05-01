function gitHasChanges() 
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
	gitst
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

function scanThisDirectoryForGit()
{
    for x in `find \`pwd\` -name .git -type d -prune`; do
	cd $x
	cd ../
	gitHasChanges
    done
}

function buildWorkspace()
{

    #if catkin build --parallel-jobs 1 --cmake-args -DCMAKE_BUILD_TYPE=Debug; then  # -j1
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

function pullEachRepo()
{
    for x in `find \`pwd\` -name .git -type d -prune`; do
	cd $x
	cd ../
	pwd
	git pull
    done
}

function checkBranch()
{
    for x in `find \`pwd\` -name .git -type d -prune`; do
	cd $x
	cd ../
	gitbranch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'`

	result=${PWD##*/}          # to assign to a variable
	echo -n $gitbranch
	echo -e -n "  \e[00;1;34m"
	printf '%s' "${PWD##*/}" 
	echo -e "\e[00m"
    done
}

function cleanWorkspace()
{
    if catclean; then
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

# ---------------------------------------------------------------------
# ---------------------------------------------------------------------
# ---------------------------------------------------------------------
# ---------------------------------------------------------------------


files=( "/home/dave/ros/ws_picknik/src" )

for i in "${files[@]}"
do :
    if [ "$1" = "commit" ]; then
	cd $i
	scanThisDirectoryForGit
    fi
    if [ "$1" = "compile" ]; then
	cd $i
	buildWorkspace
    fi
    if [ "$1" = "pull" ]; then
	cd $i
	pullEachRepo
    fi
    if [ "$1" = "branch" ]; then
	cd $i
	checkBranch
    fi
    if [ "$1" = "clean" ]; then
	cd $i
	cleanWorkspace
    fi
done
