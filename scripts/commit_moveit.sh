function gitHasChanges() {
    if git diff-index --quiet HEAD --; then
	echo "No changes detected in git repo"
    else
	echo ""
	echo ""
	echo "Changed detected in git repo:"
	pwd
	git diff
	read -p "Type 'y' and press enter to gitall" resp
	if [ "$resp" = "y" ]; then
	    gitall
	    read -p "Continue?" resp
	fi	
    fi
}

# Base Workspace
cd /home/dave/ros/ws_base/src/geometric_shapes
gitHasChanges
cd /home/dave/ros/ws_base/src/graph_msgs
gitHasChanges
cd /home/dave/ros/ws_base/src/hrl_kinematics
gitHasChanges
cd /home/dave/ros/ws_base/src/moveit_msgs
gitHasChanges
cd /home/dave/ros/ws_base/src/ros_private_pkgs
gitHasChanges

# Main MoveIt
cd /home/dave/ros/ws_moveit/src/moveit_hrp2
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_humanoid_stability
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_core
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_ros
gitHasChanges
cd /home/dave/ros/ws_moveit/src/moveit_planners
gitHasChanges
cd /home/dave/ros/ws_moveit/src/rviz_visual_tools
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

# MoveIt Other

cd /home/dave/ros/ws_moveit_other/src/moveit_commander/
gitHasChanges
cd /home/dave/ros/ws_moveit_other/src/moveit_docs/
gitHasChanges
cd /home/dave/ros/ws_moveit_other/src/moveit_ikfast/
gitHasChanges
cd /home/dave/ros/ws_moveit_other/src/moveit_plugins/
gitHasChanges
cd /home/dave/ros/ws_moveit_other/src/moveit_pr2/
gitHasChanges
cd /home/dave/ros/ws_moveit_other/src/moveit_resources/
gitHasChanges
cd /home/dave/ros/ws_moveit_other/src/moveit_setup_assistant/
gitHasChanges
cd /home/dave/ros/ws_moveit_other/src/moveit_simple_grasps/
gitHasChanges

# Baxter
export USE_BAXTER_REPOS='true'

if [[ $USE_BAXTER_REPOS == "true" ]]; then
    cd /home/dave/ros/ws_baxter/src/baxter/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_common/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_cpp/
    gitHasChanges
    cd /home/dave/ros/ws_baxter/src/baxter_ssh/
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
