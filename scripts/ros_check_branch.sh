function gitHasChanges() 
{

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
