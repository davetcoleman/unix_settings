## Benchmark

1) Have these packages in the workspace:

drwxrwxr-x  5 dave dave 4096 Sep  4 18:56 hrl_kinematics/
drwxrwxr-x 28 dave dave 4096 Sep 15 00:25 moveit_core/
drwxrwxr-x  5 dave dave 4096 Sep  4 18:58 moveit_hrp2/
drwxrwxr-x  7 dave dave 4096 Sep 15 10:59 moveit_humanoid_stability/
drwxrwxr-x  7 dave dave 4096 Sep 15 00:41 moveit_msgs/
drwxrwxr-x  7 dave dave 4096 Sep  4 18:58 moveit_planners/
drwxrwxr-x 14 dave dave 4096 Sep  4 18:58 moveit_ros/
drwxrwxr-x  7 dave dave 4096 Sep  4 18:58 moveit_visual_tools/
drwxrwxr-x  4 dave dave 4096 Sep 15 00:33 moveit_whole_body_ik/
drwxrwxr-x 10 dave dave 4096 Sep 15 01:14 ompl/
drwxrwxr-x  8 dave dave 4096 Sep  7 22:52 ompl_experience_demos/
drwxrwxr-x  5 dave dave 4096 Sep 15 01:14 ompl_thunder/
drwxrwxr-x  9 dave dave 4096 Sep  4 18:58 ompl_visual_tools/
drwxrwxr-x  4 dave dave 4096 Sep 15 01:14 ros_private_pkgs/

2) Make sure they are all compiled

3) Edit the file moveit_core/robot_model/include/moveit/robot_model/robot_model.h
   - Add the function at the top of the file in the class:

  void dummyFunctionTest()
  {
    std::cout << "Dummy" << std::endl;
  }

4) Record the time it takes to recompile everything, from within emacs, using the compile command:

 cd /home/dave/ros/ws_moveit/ && catkin bd

5) Get the resulting time from:



## RESULTS
Old ros_monster Correll lab computer re-compile time:

Runtime: 6 minutes and 41.1 seconds

New ros_monster:

Runtime: 4 minutes and 44.2 seconds
