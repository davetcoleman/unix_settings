function gitHasChanges() {
    if git diff-index --quiet HEAD --; then
	echo "No changes detected in git repo"
    else
	echo ""
	echo ""
	echo "Changed detected in git repo:"
	pwd
	git diff
	read -p "Press enter to gitall" resp
	gitall
	read -p "Continue?" resp
    fi
}

cd /home/dave/ros/ws_moveit/src/hrl_kinematics
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_hrp2
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_humanoid_stability
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_msgs
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_planners
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_ros
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_visual_tools
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_whole_body_ik
gitHasChanges
cd /home/dave/ros/ws_moveit/src/ompl
gitHasChanges
cd /home/dave/ros/ws_moveit/src/ompl_experience_demos
gitHasChanges
cd /home/dave/ros/ws_moveit/src/ompl_thunder
gitHasChanges
cd /home/dave/ros/ws_moveit/src/ompl_visual_tools
gitHasChanges
cd /home/dave/ros/ws_moveit/src/ros_private_pkgs
gitHasChanges

export USE_BAXTER_REPOS='true'

if [[ $USE_BAXTER_REPOS == "true" ]]; then
    cd /home/dave/ros/ws_baxter/src/baxter/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_common/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_cpp/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_examples/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_experimental/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_interface/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_tools/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/rosbag_record_cpp/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/ros_control/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/ros_controllers/
    gitHasChanges
fi

echo ""
echo "Done - everything committed!"
cd /home/dave/ros/ws_moveit/src
pwd
