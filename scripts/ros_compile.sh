function buildWorkspace()
{

    #if catkin build --parallel-jobs 1 --cmake-args -DCMAKE_BUILD_TYPE=Debug; then  # -j1
    if catkin build --cmake-args -DCMAKE_BUILD_TYPE=Debug; then  # -j1
	echo ""
	echo "------------------------------------------------------"
	echo "Command succeeded"
	echo ""
	return 1
    else
	echo ""
	echo "------------------------------------------------------"
	echo "Command failed"
	echo ""
	play -q ~/unix_settings/emacs/failure.wav
	return 0
    fi
}

# cd /home/dave/ros/ws_base/src
# if buildWorkspace ; then
#     return 1
# fi

cd /home/dave/ros/ws_moveit/src
if buildWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_moveit_other/src
if buildWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_robots/src
if buildWorkspace ; then
    return 1
fi

#cd /home/dave/ros/ws_amazon/src
#if buildWorkspace ; then
#    return 1
#fi

echo ""
echo "Finished compiling all ROS workspaces!"
echo ""
play -q ~/unix_settings/emacs/success.wav
