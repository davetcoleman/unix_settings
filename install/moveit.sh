#!/bin/bash

# MoveIt Install/Update Script
#   Install: Setups up MoveIt! from source into workspace ~/ros/ws_moveit
#   Update:  Pulls in changes from upstream ros-planning, then pushes changes to davetcoleman github

# ---------------------------------------------------------------------------------
# Settings

MOVEIT_WORKSPACE="/home/dave/ros/ws_moveit"
MOVEIT_WORKSPACE2="/home/dave/ros/ws_moveit_other"
MOVEIT_ROSINSTALL="https://raw.github.com/ros-planning/moveit_docs/hydro-devel/moveit.rosinstall"
INSTALL_ADVANCED=0
INSTALL_PR2=1
INSTALL_ROBOTS=0

# ---------------------------------------------------------------------------------
# One time setup

if [ ! -d "$MOVEIT_WORKSPACE" ]; then # Control will enter here if $MOVEIT_WORKSPACE doesn't exist.
    echo "INSTALLING MoveIt"
    echo "Directory $MOVEIT_WORKSPACE not found. Preparing to setup MoveIt! from source..."
    read -p "Press Ctrl-C to exit or any other key to continue installing"

    # Get the wstool package
    sudo apt-get install python-wstool

    # Make directories
    mkdir -p "$MOVEIT_WORKSPACE/src"
    mkdir -p "$MOVEIT_WORKSPACE2/src"
    cd "$MOVEIT_WORKSPACE/src"

    #  Download the source code
    wstool init .
    wstool merge $MOVEIT_ROSINSTALL
    wstool update

    # Download other source code
    if [ $INSTALL_ADVANCED == 1]; then
	git clone https://github.com/ros-planning/moveit_advance.git
    fi
    if [ $INSTALL_ROBOTS == 1]; then
	git clone https://github.com/ros-planning/moveit_robots.git
    fi
    git clone https://github.com/ros-planning/moveit_ikfast.git
    git clone https://github.com/ros-planning/moveit_plugins.git

    # Add my repo's and make moveit's the remote sources
    #cd geometric_shapes
    #git remote add upstream https://github.com/ros-planning/geometric_shapes.git
    #git config remote.origin.url git@github.com:davetcoleman/geometric_shapes.git

    cd ../moveit_commander
    git remote add upstream https://github.com/ros-planning/moveit_commander.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_commander.git

    cd ../moveit_core
    git remote add upstream https://github.com/ros-planning/moveit_core.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_core.git

    cd ../moveit_docs
    git remote add upstream https://github.com/ros-planning/moveit_docs.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_docs.git

    #cd ../moveit_experimental
    #git remote add upstream https://github.com/ros-planning/moveit_experimental.git
    #git config remote.origin.url git@github.com:davetcoleman/moveit_experimental.git

    cd ../moveit_msgs
    git remote add upstream https://github.com/ros-planning/moveit_msgs.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_msgs.git

    cd ../moveit_planners
    git remote add upstream https://github.com/ros-planning/moveit_planners.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_planners.git

    if [ $INSTALL_PR2 == 1]; then
	cd ../moveit_pr2
	git remote add upstream https://github.com/ros-planning/moveit_pr2.git
	git config remote.origin.url git@github.com:davetcoleman/moveit_pr2.git
    fi

    if [ $INSTALL_ROBOTS == 1]; then
	cd ../moveit_robots
	git remote add upstream https://github.com/ros-planning/moveit_robots.git
	git config remote.origin.url git@github.com:davetcoleman/moveit_robots.git
    fi

    cd ../moveit_ros
    git remote add upstream https://github.com/ros-planning/moveit_ros.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_ros.git

    cd ../moveit_setup_assistant
    git remote add upstream https://github.com/ros-planning/moveit_setup_assistant.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_setup_assistant.git

    cd ../moveit_ikfast
    git remote add upstream https://github.com/ros-planning/moveit_ikfast.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_ikfast.git

    cd ../moveit_plugins
    git remote add upstream https://github.com/ros-planning/moveit_plugins.git
    git config remote.origin.url git@github.com:davetcoleman/moveit_plugins.git

    if [ $INSTALL_ADVANCED == 1]; then
	cd ../moveit_advanced
	git remote add upstream https://github.com/ros-planning/moveit_advanced.git
	git config remote.origin.url git@github.com:davetcoleman/moveit_advanced.git
    fi

    # Move non-crucial packages to other workspace
    mv moveit_plugins "$MOVEIT_WORKSPACE2/src"
    mv moveit_ikfast "$MOVEIT_WORKSPACE2/src"
    mv moveit_setup_assistant "$MOVEIT_WORKSPACE2/src"
    mv moveit_advanced "$MOVEIT_WORKSPACE2/src"
    mv moveit_robots "$MOVEIT_WORKSPACE2/src"
    mv moveit_pr2 "$MOVEIT_WORKSPACE2/src"
    mv moveit_docs "$MOVEIT_WORKSPACE2/src"
    mv moveit_commander "$MOVEIT_WORKSPACE2/src"

    # ----------------------------------------
    # build main workspace
    cd "$MOVEIT_WORKSPACE"

    # Make sure MoveIt! dependencies are installed
    rosdep install --from-paths src --ignore-src --rosdistro hydro -y

    #  Build MoveIt!
    catkin_make

    # Add a shortcut to the workspace folder for updating
    echo "gitmoveit" > update.sh
    touch .catkin_workspace

    # ----------------------------------------
    # build second workspace
    cd "$MOVEIT_WORKSPACE2"

    # Make sure MoveIt! dependencies are installed
    rosdep install --from-paths src --ignore-src --rosdistro hydro -y

    #  Build MoveIt!
    catkin_make

    # Add a shortcut to the workspace folder for updating
    echo "gitmoveit" > update.sh
    touch .catkin_workspace

    echo "Don't forget to source devel/setup.bash or add to your .bashrc!"

    return
fi

# ---------------------------------------------------------------------------------
# Update MoveIt

echo "UPDATING MoveIt"
read -p "Press Ctrl-C to exit or any other key to continue updating"
return

cd $MOVEIT_WORKSPACE

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing geometric_shapes"
cd src/geometric_shapes
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/groovy-devel
git push origin groovy-devel
cd -

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_commander"
cd src/moveit_commander
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/hydro-devel
git push origin hydro-devel
cd -

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_core"
cd src/moveit_core
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/hydro-devel
git push origin hydro-devel
cd -

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_docs"
cd src/moveit_docs
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/hydro-devel
git push origin hydro-devel
cd -

# ---------------------------------------------------------------------------------
if [ 'true' = 'false' ]; then
    echo -e "\n------ Editing moveit_experimental"
    cd src/moveit_experimental
    git status
    if [ -n "$(git status --porcelain)" ]; then
	echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
	read -p "Press Ctrl-C to exit or any other key to continue updating"
    fi
    git fetch upstream
    git merge upstream/master
    git push origin master
    cd -
fi

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_msgs"
cd src/moveit_msgs
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/hydro-devel
git push origin hydro-devel
cd -

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_planners"
cd src/moveit_planners
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/hydro-devel
git push origin hydro-devel
cd -

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_pr2"
cd src/moveit_pr2
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/hydro-devel
git push origin hydro-devel
cd -

# ---------------------------------------------------------------------------------
if [ $INSTALL_ROBOTS == 1]; then
    echo -e "\n------ Editing moveit_robots"
    cd src/moveit_robots
    git status
    if [ -n "$(git status --porcelain)" ]; then
	echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
	read -p "Press Ctrl-C to exit or any other key to continue updating"
    fi
    git fetch upstream
    git merge upstream/master
    git push origin master
    cd -
fi

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_ros"
cd src/moveit_ros
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/hydro-devel
git push origin hydro-devel
cd -

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_ikfast"
cd src/moveit_ikfast
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/master
git push origin master
cd -

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_plugins"
cd src/moveit_plugins
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/master
git push origin master
cd -

# ---------------------------------------------------------------------------------
if [ $INSTALL_ADVANCED == 1]; then
    echo -e "\n------ Editing moveit_advanced"
    cd src/moveit_advanced
    git status
    if [ -n "$(git status --porcelain)" ]; then
	echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
	read -p "Press Ctrl-C to exit or any other key to continue updating"
    fi
    git fetch upstream
    git merge upstream/hydro-devel
    git push origin hydro-devel
    cd -
fi

# ---------------------------------------------------------------------------------
echo -e "\n------ Editing moveit_setup_assistant"
cd src/moveit_setup_assistant
git status
if [ -n "$(git status --porcelain)" ]; then
    echo -e "\e[0;31m -> There are changes that first need to be committed!\e[00m"
    read -p "Press Ctrl-C to exit or any other key to continue updating"
fi
git fetch upstream
git merge upstream/hydro-devel
git push origin hydro-devel
cd -


# ---------------------------------------------------------------------------------
function countdown ()
{
    if (($# != 1)) || [[ $1 = *[![:digit:]]* ]]; then
	echo "Usage: countdown seconds";
	return;
    fi;
    local t=$1 remaining=$1;
    SECONDS=0;
    while sleep .2; do
	printf '\rMoveIt will start bulding in seconds: '"$remaining"'';

        if (( (remaining=t-SECONDS) <=0 )); then
            printf '\rseconds remaining to proceed' 0;
            break;
        fi;
    done
}

countdown 9
echo "Building MoveIt!"

cd $MOVEIT_WORKSPACE

catkin_make
