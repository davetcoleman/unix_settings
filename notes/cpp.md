C++ Programming Tricks
=================

### Output file and line to console:

    ROS_ERROR("Failed to call service %s at %s:%d",
      service_name.c_str(),
      __FILE__,
      __LINE__);

### See the contents of a cpp library

    ldd libmoveit_manipulation_visualization.so | grep ros

### Debugging Tool

a useful diagnostic, instructional, and debugging tool.  System administrators, diagnosticians and trouble-shooters will find it invaluable for solving problems with programs for which  the  source  is  not  readily
available  since they do not need to be recompiled in order to trace them.  Students, hackers and the overly-curious will find that a great deal can be learned about a system and its system calls by tracing even ordinary pro‐
grams.  And programmers will find that since system calls and signals are events that happen at the user/kernel interface, a close examination of this boundary is very useful for bug isolation, sanity checking and  attempting
to capture race conditions.

    strace 

