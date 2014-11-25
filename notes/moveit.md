MoveIt Notes
=========

## Make a function deprecated

Include:
```
#include <moveit/macros/deprecation.h>
````
Then add ``MOVEIT_DEPRECATED`` in front of header function


## Print backtrace without gdb

See [moveit_visual_tools/README.md](https://github.com/davetcoleman/moveit_visual_tools) at bottom.

## Build a test

```
catkin_make run_tests
```

## Clear octomap

There is a clear button on the Rviz plugin

## See state of the planning scene monitor

```
rosrun moveit_ros_planning moveit_print_planning_model_info 
```

## Indigo commits to not merge into Hydro

## OMPL Profiling

    #include "ompl/tools/debug/Profiler.h"

    ompl::tools::Profiler::Clear();
    ompl::tools::Profiler::Start();

    ompl::tools::Profiler::Begin("SPARStwo::getSimilarPaths::findGraphNeighbors start");
    ...
    ompl::tools::Profiler::End("SPARStwo::getSimilarPaths::findGraphNeighbors start");

    ompl::tools::Profiler::ScopedBlock("SPARStwo::constructSolution");
