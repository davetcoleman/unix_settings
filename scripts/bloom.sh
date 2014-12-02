# Scripts for speeding up the release of ROS packages into Debian

alias bcgc="catkin_generate_changelog"
alias bctc="catkin_tag_changelog --bump "
alias bccl="git commit -a -m 'Updated changelogs'"
alias bcclft="git add -A && git commit -a -m 'Created CHANGELOG.rst' && git push"
alias bcpr="catkin_prepare_release --bump "

alias indigo_brgrp="bloom-release gazebo_ros_pkgs -t indigo -r indigo"
alias indigo_brrc="bloom-release ros_control -t indigo -r indigo"
alias indigo_brrcl="bloom-release ros_controllers -t indigo -r indigo"
alias indigo_brrt="bloom-release realtime_tools -t indigo -r indigo"
alias indigo_brct="bloom-release control_toolbox -t indigo -r indigo"
alias indigo_brrvt="bloom-release rviz_visual_tools -t indigo -r indigo"
alias indigo_brgm="bloom-release graph_msgs -t indigo -r indigo"
alias indigo_brovt="bloom-release ompl_visual_tools -t indigo -r indigo"
alias indigo_brrn="bloom-release random_numbers -t indigo -r indigo"
#MoveIt
alias indigo_brmvt="bloom-release moveit_visual_tools -t indigo -r indigo"
alias indigo_brmsg="bloom-release moveit_simple_grasps -t indigo -r indigo"
alias indigo_brmsa="bloom-release moveit_setup_assistant -t indigo -r indigo"
