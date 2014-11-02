distccd --daemon --allow $ROS_STUDENT_IP
export DISTCC_POTENTIAL_HOSTS='localhost ros-student'
echo "Started"
distcc --show-hosts

