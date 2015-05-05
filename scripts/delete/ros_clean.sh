function cleanWorkspace()
{
    if catclean; then
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

cd /home/dave/ros/ws_base/src
if cleanWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_moveit/src
if cleanWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_moveit_other/src
if cleanWorkspace ; then
    return 1
fi

cd /home/dave/ros/ws_amazon/src
if cleanWorkspace ; then
    return 1
fi

echo ""
echo "Finished compiling all ROS workspaces!"
echo ""
play -q ~/unix_settings/emacs/success.wav
