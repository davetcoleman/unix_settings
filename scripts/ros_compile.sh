function buildWorkspace()
{

    if catkin bd; then
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
	return 0
    fi
}

cd /home/dave/ros/ws_base/src
if buildWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_moveit/src
if buildWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_moveit_other/src
if buildWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_baxter/src
if buildWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_nasa/src
if buildWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_clam/src
if buildWorkspace ; then
    return 1
fi

echo ""
echo "Finished compiling all ROS workspaces!"
echo ""
