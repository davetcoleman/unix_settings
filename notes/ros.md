ROS Notes
=======

## Install ROS from Source

NOTE: moved this script to script/ros.sh under 'install_ros_hydro_source'

Then add to .bashrc:
```
source ~/ros_catkin_ws/install_isolated/setup.bash
```

## Optional compile Flags for CATKIN

Before the build section (include_directories section) add:
```
set(ROS_COMPILE_FLAGS "-W -Wall -Wno-unused-parameter -fno-strict-aliasing")
```

## Build catkin with tests

New catkin tools

  catkin build [...] --catkin-make-args run_tests

OLD catkin
  catkin_make run_tests_control_toolbox
  #catkin_make run_tests_packageName_gtest_testTarget
  catkin_test_results
