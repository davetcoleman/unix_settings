C++ Programming Tricks
=================

--------------------------
Output file and line to console:
    ROS_ERROR("Failed to call service %s at %s:%d",
      service_name.c_str(),
      __FILE__,
      __LINE__);
