    # Shortcuts
    alias ros="cd ~/ros/"
    alias rviz="rosrun rviz rviz"
    alias rqt="rosrun rqt_gui rqt_gui"

    alias myrosconsole="e ~/unix_settings/config/rosconsole.yaml"

    alias catbuild="catkin b" # catkin build
    alias catbuilddebug="catkin bd" #catkin build cmake-args -DCMAKE_BUILD_TYPE=Debug
    alias catbuildrelease="catkin br" #catkin build cmake-args -DCMAKE_BUILD_TYPE=Release
    alias catclean="catkin clean -a"
    alias catcleanbuild="catclean && catbuild"
    alias catcleanbuilddebug="catclean && catbuilddebug"
    alias catcleanbuildrelease="catclean && catbuildrelease"

    alias rosreindex="rm ~/.ros/rospack_cache && rospack profile"

    alias disablepkg="mv package.xml package.xml.disabled"
    alias enablepkg="mv package.xml.disabled package.xml"

    alias rosdepinstall_indigo="rosdep install -y --from-paths src --ignore-src --rosdistro indigo"

    # Maintain workspaces
    source ~/unix_settings/scripts/eachws.sh

    # ROSCD
    # alias roscdbase="cd ~/ros/ws_base/src && ll"
    # alias roscdmoveit="cd ~/ros/ws_moveit/src && ll"
    # alias roscdmoveitother="cd ~/ros/ws_moveit_other/src && ll"
    # alias roscdclam="cd ~/ros/ws_clam/src && ll"
    # alias roscdnasa="cd ~/ros/ws_nasa/src && ll"
    # alias roscdbaxter="cd ~/ros/ws_baxter/src && ll"
    # alias roscdmisc="cd ~/ros/ws_misc/src && ll"
    # alias roscdgazebo="cd ~/ros/ws_gazebo/src && ll"
    # alias roscdamazon="cd ~/ros/ws_amazon/src && ll"
    # alias roscdros="cd ~/ros/ws_ros/src && ll"
    # alias roscdompl="cd ~/ros/ws_moveit/src/ompl/src/ompl && ll"
    alias roscdpicknik="cd ~/ros/ws_picknik/src && ll"

    alias moveitplanningscene="rosrun moveit_ros_planning moveit_print_planning_model_info"
    alias iscore="ps aux | grep roscore"
    alias killgazebo="killall -9 gazebo & killall -9 gzserver  & killall -9 gzclient"

    # Time
    alias rossimtime="rosparam set /use_sim_time true"

    ## Sync My Dev machine time to Baxter's syncing server
    alias syncmytime="sudo ntpdate pool.ntp.org"

    # TF
    alias tfpdf='cd /var/tmp && rosrun tf view_frames && open frames.pdf &'

    # MoveIt branch management shortcut
    alias moveit_hydro_to_indigo="git pull-request -o -m \"Sync Hydro to Indigo Branch\" -b ros-planning:indigo-devel -h ros-planning:hydro-devel"

    # Bloom shortcuts
    alias bloom_alias_load="source ~/unix_settings/scripts/bloom.sh"

    # Testing communication
    #rostopic pub /test std_msgs/Bool true -r 10
    #rostopic echo /test

    function roscleanworkspace()
    {
	# make sure the ordering of the ROS sources do not get mixed up
	unset CMAKE_PREFIX_PATH
	unset ROS_PACKAGE_PATH

	echo "Displaying ros package path:"
	rosPackagePath
    }
    
    # Source public moveit workspace
    function source_moveit_public()
    {	
	clear_ros

	source ~/ros/ws_moveit_public/devel/setup.bash

	# Display the package path if this is a ROS computer
	rosPackagePath
    }

    # Building ROS from source shortcuts
    function install_ros_hydro_source()
    {
	mkdir -p ~/ros/ws_ros/src
	cd ~/ros/ws_ros/
	rosinstall_generator desktop_full --rosdistro hydro --deps --wet-only --tar > hydro-desktop-full-wet.rosinstall
	wstool init -j8 src hydro-desktop-full-wet.rosinstall	
	# Add ROS dependencies I use:
	rosinstall_generator moveit_full --rosdistro hydro --deps --wet-only --tar >> moveit.rosinstall
	rosinstall_generator pr2_moveit_plugins --rosdistro hydro --deps --wet-only --tar >> moveit.rosinstall
	rosinstall_generator posedetection_msgs --rosdistro hydro --deps --wet-only --tar >> moveit.rosinstall
	rosinstall_generator openni_launch --rosdistro hydro --deps --wet-only --tar >> moveit.rosinstall
	wstool merge -t src moveit.rosinstall 
	wstool update -t src

	# add moveit deps:
	cd ~/ros/ws_ros
	rm moveit.rosinstall
	rosinstall_generator moveit_ros --rosdistro hydro --deps --wet-only --tar >> moveit.rosinstall   
	rosinstall_generator moveit_setup_assistant --rosdistro hydro --deps --wet-only --tar >> moveit.rosinstall   
	rosinstall_generator moveit_core --rosdistro hydro --deps --wet-only --tar >> moveit.rosinstall 
	rosinstall_generator ros_control --rosdistro hydro --deps --wet-only --tar >> moveit.rosinstall 
	# REMOVE THOSE IN moveit.rosinstall THAT WE ARE BUILDING OURSELVES
	wstool merge -t src moveit.rosinstall

	# apply my hydro customizations to hide excessive output
	cd src
	rm -rf urdfdom/
	git clone git@github.com:ros/urdfdom.git
	wget https://raw.github.com/ros-gbp/urdfdom-release/debian/hydro/precise/urdfdom/package.xml urdfdom/package.xml

	rm -rf classloader/
	git clone git@github.com:ros/class_loader.git
	
	rm -rf rosconsole_bridge
	git clone git@github.com:ros/rosconsole_bridge.git

	rm -rf urdfdom_headers
	git clone git@github.com:ros/urdfdom_headers.git
	wget https://raw.githubusercontent.com/ros-gbp/urdfdom_headers-release/debian/hydro/precise/urdfdom_headers/package.xml urdfdom_headers/package.xml

	rm -rf robot_model
	git clone git@github.com:ros/robot_model.git -b indigo-devel
	# or to prevent future breaks:
	# git co 8e71379d07c715f7d9cafc3eb6ebd301088576af

	rm -rf rviz
	git clone git@github.com:ros-visualization/rviz.git
	# apply indigo patch to hydro cause im a badass
	cd rviz
	git cherry-pick 09bc0e0b0526c984199e6734221bbdeeaead95a3
	cd ../
	
	# download external deps:
	cd ../ 
	rosdep install --from-paths src --ignore-src --rosdistro hydro -y

	# Build all
	#./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
    }
    
    function ros_add_dependency()
    {
	#cd ~/ros/ws_ros_catkin/
	rosinstall_generator "$1" --rosdistro hydro --deps --wet-only --tar >> new_packages.rosinstall
	read -p "Merge with wstool?"
	wstool merge -t src new_packages.rosinstall
	read -p "Wstool update?"
	wstool update -t src/
	read -p "catkin build --install ?"
	catkin build --install
    }

    function ros_build_all_ws()
    {
	cd /home/dave/ros/ws_ros/
	catbuild --install
	cd /home/dave/ros/ws_ompl/
	catbuild
	cd /home/dave/ros/ws_ros_control/
	catbuild
	cd /home/dave/ros/ws_moveit/        
	catbuild
	cd /home/dave/ros/ws_moveit_other/        	
	catbuild
        cd /home/dave/ros/ws_baxter/
	catbuild
	cd /home/dave/ros/ws_clam/
	catbuild
	cd /home/dave/ros/ws_hrp2/
	catbuild
        cd /home/dave/ros/ws_nasa/
	catbuild
	cd /home/dave/ros/ws_jsk/
	catbuild
    }

    #Gazebo
    alias gazebocheck='sh ~/ros/gazebo/tools/code_check.sh'

    # other
    alias roseus="rosrun roseus roseus "

    # Testing
    alias rostestpub="rostopic pub /basic_test -r 1 std_msgs/Float32 99.9"
    alias rostestecho="rostopic echo /basic_test"

    # ROS STUFF
    export ROSCONSOLE_CONFIG_FILE=~/unix_settings/.my.rosconsole
    #export ROS_PYTHON_LOG_CONFIG_FILE=~/unix_settings/.my.rosconsole_python
    export ROSCONSOLE_FORMAT='${severity} ${logger}: ${message}'

    function rosPackagePath()
    {
	arr=$(echo $CMAKE_PREFIX_PATH | tr ":" "\n")
	for x in $arr
	do
	    rootpath1="/home/$USER/ros/"
	    rootpath2="/opt/ros/"
	    x=${x#${rootpath1}}
	    echo "  " ${x#${rootpath2}}

	done
    };

    function rosgatewaysync()
    {
	source ~/unix_settings/scripts/backup_rsync_ros_gateway.sh
    }

    function syncNTPServer()
    {
	sudo service ntp stop
	sudo ntpdate pool.ntp.org
	ntpdate -q 128.138.244.56
	sudo service ntp start
    }

    function gitpr() # davetcoleman_branch_name
    {
        # requires 1 parameter
	eval "git pull-request -b ros-planning:hydro-devel -h davetcoleman:$1 -o"
    }
