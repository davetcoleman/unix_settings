#!/bin/bash
# ~/unix_settings/.my.bashrc  Customized bash script for multiple computers

# BASHRC_ENV tells .my.bashrc which environment we are in
   #export BASHRC_ENV=mac

# Source users personal .my.bashrc if it exists.
   #if [[ -f ~/unix_settings/.my.bashrc ]]; then
   # . ~/unix_settings/.my.bashrc
   #fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Clear the screen
clear

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
# Skip for Gento
if [[ $BASHRC_ENV != "ros_baxter" ]]; then
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases for listing files and folders
alias ll='ls -alFh'
alias la='ls -Ah'
alias l='ls -CFh'
alias listfolders='ls -AF | grep /'
#alias listfiles='ls -AF | grep -v /'
alias listfiles="find * -type f -print" # lists files in the current directory
function cdl() {
  cd "$1" && ll
}
# Quick back folder
alias c="cd .."
alias mkdir="mkdir -p"

# Remove line numbers in history
alias history="history | sed 's/^[ ]*[0-9]\+[ ]*//'"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi



# CUSTOM STUFF - NOT UBUNTU DEFAULT---------------------------------------------------------------------

# OS Stuff
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

# IP Addresses Shared btw computers -------------------------------------------------------

# get just the ip address
function myip()
{
    ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
}

# all ip address are hidden for security reasons
source ~/unix_settings_private/ip_addresses.sh

# Generic ROS Stuff --------------------------------------------------------------------
ROS_SEGMENT=`echo $BASHRC_ENV | cut -d'_' -f 1`
if [ $ROS_SEGMENT == "ros" ]; then
    # Shortcuts, aliases and exports
    source ~/unix_settings/scripts/ros.sh

    # shared settings
    ROS_MASTER="localhost" # to be over written

    # make sure the ordering of the ROS sources do not get mixed up
    unset CMAKE_PREFIX_PATH
    unset ROS_PACKAGE_PATH
fi

# Web server environment --------------------------------------------------------
if [ $BASHRC_ENV == "dtc" ]; then
    # Source global definitions
    if [ -f /etc/bashrc ]; then
	. /etc/bashrc
    fi
    export PS1="\W$ "
    echo -ne "Computer: DTC Server"
fi

# Custom environements per computer --------------------------------------------------------
if [ $BASHRC_ENV == "ros_monster" ]; then

    #ROS_MASTER="baxter"
    ROS_MASTER="localhost"
    source ~/unix_settings/scripts/baxter.sh
    source ~/unix_settings/scripts/amazon.sh

    # In-Use Workspaces
    #source /opt/ros/indigo/setup.bash
    #source /home/$USER/ros/ws_base/devel/setup.bash
    #source /home/$USER/ros/ws_moveit/devel/setup.bash
    #source /home/$USER/ros/ws_moveit_other/devel/setup.bash
    source /home/$USER/ros/ws_robots/devel/setup.bash
    #source /home/$USER/ros/ws_amazon/devel/setup.bash

    echo -ne "ROS: indigo | "

    # overwrite the one from ws_ros/install/setup.bash
    export ROSCONSOLE_CONFIG_FILE=~/unix_settings/config/rosconsole.yaml

    # Syncing scripts
    alias sync_ros_monster_to_student="source /home/$USER/unix_settings/scripts/rsync/ros_monster_to_student.sh"

    # PCL hack
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/include

    # Exports
    #export ROS_IP=$ROS_MONSTER_IP
    export ROS_IP=`hostname -I`

    echo -ne "Computer: ros_monster"
fi

if [ $BASHRC_ENV == "ros_baxter" ]; then

    export PATH=$PATH:/home/ruser/software/emacs-24.3/lib-src/
    export PATH=$PATH:/home/ruser/software/emacs-24.3/src/
    export PATH=$PATH:/home/ruser/bin
    export PYTHONPATH="/home/ruser/bin/catkin_tools/lib/python2.7/site-packages:$PYTHONPATH"

    ROS_MASTER="localhost"
    source ~/unix_settings/scripts/baxter.sh

    # In-Use Workspaces
    #source /opt/ros/groovy/setup.bash
    #source /home/ruser/ros/ws_base/devel/setup.bash
    source /home/ruser/ros/ws_baxter/devel/setup.bash

    echo -ne "ROS: groovy | "

    # overwrite the one from ws_ros/install/setup.bash
    export ROSCONSOLE_CONFIG_FILE=~/unix_settings/config/rosconsole.yaml

    # Exports
    # Use ROS_IP if you are specifying an IP address, and ROS_HOSTNAME if you are specifying a host name.
    export ROS_IP=$ROS_BAXTER_IP
    #export ROS_HOSTNAME=$ROS_BAXTER_IP  #http://localhost:11311
    #export ROS_MASTER_URI=http://localhost:11311

    echo -ne "Computer: ros_baxter"

fi

if [ $BASHRC_ENV == "ros_student" ]; then

    ROS_MASTER="baxter"
    source ~/unix_settings/scripts/baxter.sh

    # In-Use Workspaces
    source /opt/ros/indigo/setup.bash
    #source /home/$USER/ros/ws_base/devel/setup.bash
    #source /home/$USER/ros/ws_moveit/devel/setup.bash
    #source /home/$USER/ros/ws_moveit_other/devel/setup.bash
    #source /home/$USER/ros/ws_baxter/devel/setup.bash
    source /home/$USER/ros/ws_nasa/devel/setup.bash
    #source /home/$USER/ros/ws_vision/devel/setup.bash
    #source /home/$USER/ros/ws_moveit/devel/setup.bash
    #source /home/$USER/ros/ws_moveit_other/devel/setup.bash
    #source /home/$USER/ros/ws_baxter/devel/setup.bash

    echo -ne "ROS: indigo | "

    # overwrite the one from ws_ros/install/setup.bash
    export ROSCONSOLE_CONFIG_FILE=~/unix_settings/config/rosconsole.yaml

    # Syncing scripts
    alias sync_ros_student_to_monster="source /home/$USER/unix_settings/scripts/rsync/ros_student_to_monster.sh"

    # Exports
    export ROS_IP=$ROS_STUDENT_IP

    echo -ne "Computer: ros_student"
fi

if [ $BASHRC_ENV == "ros_mac" ]; then

    #ROS_MASTER="baxter"
    ROS_MASTER="localhost"
    source ~/unix_settings/scripts/baxter.sh

    # In-Use Workspaces
    source /opt/ros/indigo/setup.bash
    #source /home/$USER/ros/ws_base/devel/setup.bash
    #source /home/$USER/ros/ws_moveit/devel/setup.bash
    #source /home/$USER/ros/ws_moveit_other/devel/setup.bash
    #source /home/$USER/ros/ws_baxter/devel/setup.bash
    #source /home/$USER/ros/ws_nasa/devel/setup.bash

    echo -ne "ROS: indigo | "

    # overwrite the one from ws_ros/install/setup.bash
    export ROSCONSOLE_CONFIG_FILE=~/unix_settings/config/rosconsole.yaml

    # Aliases
    alias runmatlab="/usr/local/MATLAB/R2013b/bin/matlab"

    # Exports
    #export ROS_IP=$ROS_MONSTER_IP
    export ROS_IP=`hostname -I`

    echo -ne "Computer: ros_mac"
fi

if [ $BASHRC_ENV == "ros_gateway" ]; then

    # Settings
    ROS_MASTER="baxter"

    #In-Use Workspaces
    #source /opt/ros/hydro/setup.bash
    #source /home/$USER/ros/ws_baxter/devel/setup.bash
    source /home/$USER/ros/ws_baxter/devel/setup.bash

    source ~/unix_settings/scripts/baxter.sh

    echo -ne "ROS: hydro | "

    # Use external webcam
    export GSCAM_CONFIG="v4l2src device=/dev/video0 ! video/x-raw-rgb,framerate=30/1 ! ffmpegcolorspace"

    # you might need to first do: sudo chmod 777 /dev/video0
    alias rungscam="sudo chmod 777 /dev/video0 & rosrun gscam gscam &"

    # Pulse Audio
    export PULSE_SERVER=$ROS_MONSTER_IP

    # Exports
    export ROS_HOSTNAME=$ROS_GATEWAY_IP

    echo -ne "Computer: ros_gateway"
fi

if [ $BASHRC_ENV == "ros_baxter_control" ]; then

    export LIBGL_ALWAYS_SOFTWARE=1

    # Settings
    ROS_MASTER="baxter"
    source ~/unix_settings/scripts/baxter.sh

    #In-Use Workspaces
    source /opt/ros/hydro/setup.bash
    source /home/$USER/ros/ws_baxter/devel/setup.bash

    echo -ne "ROS: hydro | "

    # Exports
    export ROS_HOSTNAME=$ROS_BAXTER_CONTROL_IP

    echo -ne "Computer: ros_baxter_control"
fi

# Custom environements per computer --------------------------------------------------------
if [ $BASHRC_ENV == "ros_block" ]; then

    ROS_MASTER="baxter"
    #ROS_MASTER="localhost"
    source ~/unix_settings/scripts/baxter.sh
    source ~/unix_settings/scripts/amazon.sh

    # In-Use Workspaces
    source /opt/ros/indigo/setup.bash
    #source /home/$USER/ros/ws_base/devel/setup.bash
    #source /home/$USER/ros/ws_moveit/devel/setup.bash
    #source /home/$USER/ros/ws_moveit_other/devel/setup.bash
    #source /home/$USER/ros/ws_robots/devel/setup.bash
    #source /home/$USER/ros/ws_amazon/devel/setup.bash

    echo -ne "ROS: indigo | "

    # overwrite the one from ws_ros/install/setup.bash
    export ROSCONSOLE_CONFIG_FILE=~/unix_settings/config/rosconsole.yaml

    # Exports
    export ROS_IP=`hostname -I`

    echo -ne "Computer: ros_block"
fi

if [ $BASHRC_ENV == "janus" ]; then
    use Moab
    use Torque
    use .hdf5-1.8.6
    use OpenMPI-1.4.3
    use CMake
    #use G_DISABLED_it
    alias emacs='/home/daco5652/software/emacs/bin/emacs-23.4'
    export BOOST_ROOT=/projects/daco5652/software/boost/1.42.0/
    cd /lustre/janus_scratch/daco5652/scriptbots/
    echo -ne "Computer: Janus"
fi
if [ $BASHRC_ENV == "mac" ]; then

    alias web='cd /Volumes/$USER/Web'
    alias brewwork='cd /usr/local/Library/Formula'

    # For homebrew / ROS Mac
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH

    # For gedit
    PATH=$PATH:/Applications/gedit.app/Contents/MacOS

    # Colors!
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    # Chrome
    alias google-chrome='open -a Google\ Chrome --args --allow-file-access-from-files'

    echo "Computer: MBP"
fi
if [ $BASHRC_ENV == "ros_vm" ]; then

    #In-Use Workspaces
    source /opt/ros/indigo/setup.bash
    #source /home/$USER/ros/ws_ros_control/devel/setup.bash


    # Change display method for VM graphics card
    export OGRE_RTT_MODE=Copy

    echo -ne "Computer: ROS VM"
fi

# Set ROS MASTER URI for our robot or locally
if [ $ROS_SEGMENT == "ros" ]; then
    if [ $ROS_MASTER == "baxter" ]; then  # Use Baxter externally
	export ROS_MASTER_URI="http://"$ROS_BAXTER_IP":11311"

	echo -ne " | ROS Master: baxter"
    elif [ $ROS_MASTER == "special" ]; then  # Internal Baxter
	export ROS_MASTER_URI=$ROS_BAXTER_IP

	echo -ne " | ROS Master: i_am_baxter"
    else # Localhost
	export ROS_MASTER_URI=http://localhost:11311

	echo -ne " | ROS Master: localhost"
    fi

    # New line
    echo ""

    # clean out the stupid logs
    rosclean purge -y

    # Display the package path if this is a ROS computer
    rosPackagePath
fi

# Text Editor
if [[ $platform == "osx" ]]; then   #only mac
    alias e="emacs"
    alias se="sudo emacs -nw"
    export EDITOR='emacs'
else
    alias e="emacsclient -nw -t" #new_window, t does something for server/client
    alias se="sudo emacs -nw"
    export EDITOR='emacsclient -nw -t'
    function re() {
	emacsclient -nw -t -e "(find-file-read-only \"$1\")"
    }
fi
export ALTERNATE_EDITOR="" # this evokes emacs server/client stuff somehow

# Python
alias p="python"
alias pylab="ipython --pylab"

# Clipboard
alias xc="xclip" # copy
alias xv="xclip -o" # paste
alias pwdxc="pwd | xclip"

## GREP / FIND --------------------------------------------------------------------------------

# Searching within files, recursive from current location
gr() { grep -I --color=always --ignore-case --line-number --recursive  "$1" . ;}
grcase() { grep -I --color=always --line-number --recursive  "$1" . ;}

# Exclude certain directories from grep. this doesn't work for osx
if [[ $platform != 'osx' ]]; then
    export GREP_OPTIONS="--exclude-dir=\build --exclude-dir=\.svn --exclude-dir=\.hg --exclude-dir=\.git --exclude=\.#* --exclude=*.dae"
fi

#grep -r -i "WORD" .     # search recursively in directory for case-insensitive word

# Find a file with a string and open with emacs (kinda like e gr STRING)
gre() { grep -l -I --ignore-case --recursive $1 . | xargs emacsclient -nw -t ;}

# Find files with name in directory
findfile()
{
    if [[ $platform != 'osx' ]]; then
	find -iname $1 2>/dev/null
    else
	#find . -name '[mM][yY][fF][iI][lL][eE]*' # makes mac case insensitive
	echo "'$1*'" |perl -pe 's/([a-zA-Z])/[\L\1\U\1]/g;s/(.*)/find . -name \1/'|sh
    fi
}

# Find files recursively by file type and copy them to a directory
#find . -name "*.rst" -type f -exec cp {} ~/Desktop/ \;

# Find files and delete them
#find -name *conflicted* -delete

# Also:
# find . -iname '*.so'
#
# Find and replace string in all files in a directory
#  param1 - old word
#  param2 - new word
findreplace() { grep -lr -e "$1" * | xargs sed -i "s/$1/$2/g" ;}

# Find installed programs in Ubuntu:
findprogram() { sudo find /usr -name "$1*" ;}

## COMPRESSION --------------------------------------------------------------------------------

# Compressed aliases
alias untargz='tar xvfz ' #file.tar.gz
alias untarxz='tar xvfJ ' #file.tar.xz
alias untgz='untargz' # same as above
alias dotargz='tar cfz ' #file.tar.gz folder/
alias untar='tar xvf ' #file.tar
alias dotar='tar cvwf ' #file.tar folder/

# Quick edit this file
alias mybash="e ~/unix_settings/.my.bashrc && . ~/unix_settings/.my.bashrc"
alias mybashr=". ~/unix_settings/.my.bashrc"
alias myemacs="e ~/unix_settings/.emacs"
alias myubuntuinstall="e ~/unix_settings/install/ubuntu.sh"

# Diff with color
alias diff="colordiff"

# Update Ubuntu
alias sagu="sudo apt-get update && sudo apt-get dist-upgrade -y"
alias sagi="sudo apt-get install "

# Quick cmake
alias maker="sudo clear && cmake ../ && make -j8 && sudo make install"
alias maker_local="cmake ../ -DCMAKE_INSTALL_PREFIX=$HOME/local && make -j8 && make install"
alias dmaker="sudo clear && cmake ../ -DCMAKE_BUILD_TYPE=debug && make -j8 && sudo make install"

# Build Latex document and open it
alias quicktex="ls *.tex | pdflatex && open *.pdf"

# Search running processes
alias pp="ps aux | grep "

# Show fake hacker script
alias hacker='hexdump -C /dev/urandom | grep "fd b4"'

# gdb
alias gdbrun='gdb --ex run --args '
alias rosrungdb='gdb --ex run --args ' #/opt/ros/hydro/lib/rviz/rviz

## More Scripts -----------------------------------------------------------------------

# Ubuntu only
if [[ $platform != 'osx' ]]; then
    source /home/$USER/unix_settings/scripts/ubuntu.sh
fi

# git aliases and functions
source ~/unix_settings/scripts/git.sh

# Notes
source ~/unix_settings/notes/aliases.sh

function selfdestruct()
{
    seconds=10; date1=$((`date +%s` + $seconds));
    while [ "$date1" -ne `date +%s` ]; do
	echo -ne "Self Destruct In $(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r";
    done
    echo ""
}

function dired() {
    emacsclient -e "(dired \"$PWD\")"
}

# Cause remote messages to display
#   sagi libnotify-bin
#   export DISPLAY=:0.0
#   notify-send "Nikolaus Correll Says" "PUBLISH PUBLISH PUBLISH"
