ROS Notes
=======

## Build catkin with tests

Run test for just 1 package

    catkin runs_tests --no-deps --this -i
	
Run test for all packages

    catkin run_tests -i

Run test for 1 package, old catkin_make version

    catkin_make run_tests_control_toolbox
    #catkin_make run_tests_packageName_gtest_testTarget
    catkin_test_results

## Install ROS from Source

NOTE: moved this script to script/ros.sh under 'install_ros_hydro_source'

Then add to .bashrc:

    source ~/ros_catkin_ws/install_isolated/setup.bash

## Optional compile Flags for CATKIN

Before the build section (include_directories section) add:

    set(ROS_COMPILE_FLAGS "-W -Wall -Wno-unused-parameter -fno-strict-aliasing")

Or during build time

    catkin build --cmake-args -DCMAKE_BUILD_TYPE=Release

## Convert URDF to PDF

    urdf_to_graphiz

# View TF as PDF

    tfpdf

## Kill all ROS nodes

    killall rosout 
    killall rosout -9


