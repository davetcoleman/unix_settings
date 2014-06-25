ROS Bloom Release System Notes
------------

**First time release to Bloom
  Source: http://wiki.ros.org/bloom/Tutorials/FirstTimeRelease

```
roscd PACKAGE
bcgc --all  
e CHANGELOG.rst
git add -A && git commit -a -m "Created changelog" && git push
bcpr patch
# CREATE PACKAGE on github.com/davetcoleman named PACKAGE-release
# COPY THE HTTPS URL
bloom-release --rosdistro hydro --track hydro PACKAGE --edit
```

**Updating to Bloom

Catkin Steps:
```
roscd PACKAGE
bcgc			    # catkin_generate_changelog
e CHANGELOG.rst             # Cleanup changelog
bccl			    # git commit -a -m "Updated changelogs"
bcpr {major,minor,patch}    # catkin_prepare_release --bump {major,minor,patch}
```

Bloom Steps:
```
indigo_brgrp      bloom-release gazebo_ros_pkgs -t indigo -r indigo
indigo_brrc       bloom-release ros_control -t indigo -r indigo
indigo_brrcl      bloom-release ros_controllers -t indigo -r indigo
indigo_brmvt      bloom-release moveit_visual_tools -t indigo -r indigo
indigo_brmsg      bloom-release moveit_simple_grasps -t indigo -r indigo
indigo_brrt       bloom-release realtime_tools -t indigo -r indigo
indigo_brct       bloom-release control_toolbox -t indigo -r indigo
indigo_brgm       bloom-release grasp_msgs -t indigo -r indigo

hydro_brgrp      bloom-release gazebo_ros_pkgs -t hydro -r hydro
hydro_brrc       bloom-release ros_control -t hydro -r hydro
hydro_brrcl      bloom-release ros_controllers -t hydro -r hydro
hydro_brmvt      bloom-release moveit_visual_tools -t hydro -r hydro
hydro_brmsg      bloom-release moveit_simple_grasps -t hydro -r hydro
hydro_brrt       bloom-release realtime_tools -t hydro -r hydro
hydro_brct       bloom-release control_toolbox -t hydro -r hydro
hydro_brgm       bloom-release grasp_msgs -t hydro -r hydro
```
