#!/bin/bash
# Baxter Aliases

    alias be="rostopic pub -1 /robot/set_super_enable std_msgs/Bool True"
    alias bd="rostopic pub -1 /robot/set_super_enable std_msgs/Bool False"
    alias br="rostopic pub -1 /robot/set_super_reset std_msgs/Empty"
    alias bs="rostopic echo -c /robot/state"
    alias bready="rosrun baxter_experimental send_both_ready"
    alias bdcc="rostopic pub -r 6 /robot/limb/right/CollisionAvoidance/suppress_body_avoidance std_msgs/Empty"

    alias bhardware="roslaunch baxter_control baxter_hardware.launch"
    alias bgazebo="roslaunch baxter_gazebo baxter_gazebo.launch"
    alias bvisualize="roslaunch baxter_control baxter_visualization.launch"
    
    alias bm="roslaunch baxter_moveit_config baxter_moveit.launch"
    alias bpp="roslaunch baxter_pick_place block_pick_place.launch"

    alias bw="rosrun joint_velocity wobbler.py"
    alias bsu="rosrun baxter_scripts sonar_enable.py --enable=0"
    alias bsd="rosrun baxter_scripts sonar_enable.py --enable=1"
    alias brtare="rosrun baxter_tools tare.py -l right"
    alias bltare="rosrun baxter_tools tare.py -l left"
    alias brcalibrate="rosrun baxter_tools calibrate_arm.py -l right"
    alias blcalibrate="rosrun baxter_tools calibrate_arm.py -l left"

    # Turn of MoveIt's access to depth data
    alias bdisablesensors="rosparam delete /move_group/sensors"

    # Get Baxter's time offset from my compter
    alias btimeoffset="ntpdate -q 128.138.244.56"

    # Right Gripper
    alias brgripperstate="rostopic echo -c /robot/end_effector/right_gripper/state"
    alias brgrippercal="rostopic pub -1 /robot/end_effector/right_gripper/command baxter_core_msgs/EndEffectorCommand '{command: calibrate, id: 65664, sender: user}'"
    alias brgripperres="rostopic pub -1 /robot/end_effector/right_gripper/command baxter_core_msgs/EndEffectorCommand '{command: reset, id: 65664, sender: user}'"
    alias brgripperopen="rostopic pub -1 /robot/end_effector/right_gripper/command baxter_core_msgs/EndEffectorCommand '{command: release, id: 65664, sender: user}'"
    alias brgripperclose="rostopic pub -1 /robot/end_effector/right_gripper/command baxter_core_msgs/EndEffectorCommand '{command: grip, id: 65664, sender: user}'"
    
    # Left Gripper
    alias blgripperstate="rostopic echo -c /robot/end_effector/left_gripper/state"
    alias blgrippercal="rostopic pub -1 /robot/end_effector/left_gripper/command baxter_core_msgs/EndEffectorCommand '{command: calibrate, id: 65664, sender: user}'"
    alias blgripperres="rostopic pub -1 /robot/end_effector/left_gripper/command baxter_core_msgs/EndEffectorCommand '{command: reset, id: 65664, sender: user}'"
    alias blgripperopen="rostopic pub -1 /robot/end_effector/left_gripper/command baxter_core_msgs/EndEffectorCommand '{command: release, id: 65664, sender: user}'"
    alias blgripperclose="rostopic pub -1 /robot/end_effector/left_gripper/command baxter_core_msgs/EndEffectorCommand '{command: grip, id: 65664, sender: user}'"
    
    ## SSH Access
    alias bssh="ssh osrf@011305P0009.local"
    alias blog="ftp 011305P0009.local"
    alias bkeyboard="rosrun joint_position keyboard.py"
    alias bdownloadlogs="cd ~/ros/baxter_logs/ && rm -rf cu_boulder_ftp_logs.tar.gz 011305p0009.local/ && wget -r ftp://011305P0009.local/ && tar cvzf cu_boulder_ftp_logs.tar.gz 011305p0009.local/ && scp cu_boulder_ftp_logs.tar.gz fabgatec@davetcoleman.com:~/www/"

    # Cameras
    alias brcamera="rosrun image_view image_view image:=/cameras/right_hand_camera/image"
    alias blcamera="rosrun image_view image_view image:=/cameras/left_hand_camera/image"
    alias bacamera="rosrun image_view image_view image:=/camera/image_raw"
    alias bdepthcamera="rosrun image_view image_view image:=/camera/rgb/image_color"