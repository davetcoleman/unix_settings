function gitHasChanges() 
{
    gitbranch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'`

    result=${PWD##*/}          # to assign to a variable
    echo -n $gitbranch
    echo -e -n "  \e[00;1;34m"
    printf '%s' "${PWD##*/}" 
    echo -e "\e[00m"
}

function scanThisDirectoryForGit()
{
    for x in `find \`pwd\` -name .git -type d -prune`; do
	cd $x
	cd ../
	gitHasChanges
    done
}

cd /home/dave/ros/ws_base/src
scanThisDirectoryForGit
cd /home/dave/ros/ws_moveit/src
scanThisDirectoryForGit
cd /home/dave/ros/ws_moveit_other/src
scanThisDirectoryForGit
cd /home/dave/ros/ws_robots/src
scanThisDirectoryForGit

cd /home/dave/ros

echo ""
echo "Finished showing all branches"
echo ""
cd ~/unix_settings/scripts/
