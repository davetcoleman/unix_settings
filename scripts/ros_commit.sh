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

cd /home/dave/ros/ws_base/src
scanThisDirectoryForGit
cd /home/dave/ros/ws_moveit/src
scanThisDirectoryForGit
cd /home/dave/ros/ws_moveit_other/src
scanThisDirectoryForGit
cd /home/dave/ros/ws_robots/src
scanThisDirectoryForGit
cd /home/dave/ros/ws_amazon/src
scanThisDirectoryForGit

cd /home/dave/ros

echo ""
echo "Finished committing all ROS repos!"
echo ""
play -q ~/unix_settings/emacs/success.wav
