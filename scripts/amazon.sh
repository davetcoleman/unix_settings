# Startup

alias apc_hardware="roslaunch jacob_control jacob_hardware.launch"
alias apc_simulation="roslaunch jacob_control jacob_simulation.launch"
alias apc_rviz="roslaunch picknik_main rviz.launch"
alias apc_camera="roslaunch picknik_perception multi_xtion.launch"
alias apc_calibrate="roslaunch picknik_perception multi_xtion_calibrate.launch"
alias apc_main="roslaunch picknik_main jacob_apc.launch mode:=1"
alias apc_perception="roslaunch picknik_perception perception_server_ddtr.launch"

# Building
alias picknik_default="source /home/$USER/ros/ws_picknik/devel/setup.bash && 
  rosPackagePath &&
  cd ~/ros/ws_picknik &&
  catkin profile set default"
alias picknik_debug="source /home/$USER/ros/ws_picknik/devel_debug/setup.bash && 
  rosPackagePath &&
  cd ~/ros/ws_picknik &&
  catkin profile set debug"
alias picknik_release="source /home/$USER/ros/ws_picknik/devel_release/setup.bash && 
  rosPackagePath &&
  cd ~/ros/ws_picknik &&
  catkin profile set release"
    
# DDTR
alias roscdddtr="cd ~/ros/perception/DDTR/DDTR/"
