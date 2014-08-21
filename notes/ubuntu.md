# UBUNTU NOTES

## Video Editing

### Rotate video

    I just tried it with avidemux. I use xvid and also I don't use the english version of avidemux so I may not describe it perfectly but you'll get it.

    1. start avidemux and load your video.

    2. choose avi from the button at the (almost) bottom left.

    3. choose the line containing Xvid4 on the top video button at the left.

    4. Press the filters button which is the third button on the left.

    5. Find rotate filter, double click it, choose angle and click ok.

    6. Now close filters windows.

    7. Press the Save button and enter a new name name.avi.





## High Level Software

### Kill a program that is not responding

    Ctrl-z 
    kill %

### Command to mount disks at startup

    Add to Startup Applications:
    /usr/bin/udisks --mount /dev/sdb3

    Instructions: https://help.ubuntu.com/community/AutomaticallyMountPartitions


### Last Resort Shutdown

    First, we’ll try and kill all the process on your current terminal. To do this, hold down the following keys -
    ALT + SysReq + k
    What the heck is a SysReq key? Look for it on your PrtSc or Print Screen key. The k in this instance stands for Kill.
    If that doesn’t work for you, it’s time to take drastic action. You’ll now enter a series of keystrokes that will tell your computer to do some housekeeping before shutting down.
    ALT + SysReq + r
    This stands for Raw keyboard mode.
    ALT + SysReq + s
    This syncs the disk.
    ALT + SysReq + e
    This terminates all processes
    ALT + SysReq + i
    Kill’s all processes that weren’t terminated nicely.
    ALT + SysReq + u
    Remounts all filesystems as read only.
    ALT + SysReq + b
    Reboots.
    That’s a heck of a lot better than simply holding down the power button and hoping everything works out okay.
    How will you ever remember all those keystrokes? There is a long held mnemonic that makes it a bit easier:
    Raising Skinny Elephants Is Utterly Boring – RSEIUB
    You should use this method only if other methods (mentioned above) fail.


### View Hardware

    lspci


### View connected partitions

    blkid


### Mount Filesystem while in Recovery Mode

    When you boot into Recovery Mode, enter the following two commands before doing anything else:

    mount --options remount,rw /
    mount --all

    These commands will set Recovery Mode to how it should have been.


### Mount USB Drive while in Recovery Mode

See list of mountable names
    sudo fdisk -l

Make the mount point
    mkdir /media/usb_drive

Mount it
    mount -t vfat /dev/sdc /media/usb_drive


### Restore Video Settings

    cp /etc/X11/xorg.conf.failsafe /etc/X11/xorg.conf


### Boot with Safe Video Settings
    add these linux kernel boot options: nomodeset nointremap vga=0x361.


### See Disk Free Space of Filesystem

    df -h


### Virual Box Resize
    VBoxManage modifyhd YOUR_HARD_DISK.vdi --resize SIZE_IN_MB


### Compare Two Directories, Excluding git files
    diff -r -x '.rosinstall*' -x '*.git' moveit/src moveit_dave/src


### Set CMakeLists to debug mode
    set(CMAKE_BUILD_TYPE Debug)


### See the contents of a cpp library
    ldd libmoveit_manipulation_visualization.so | grep ros


### Kill all ROS nodes
    killall rosout 
    killall rosout -9


### See all processes with certain name
    ps -e | grep WORD


### Delete all subdirecetories with folder name '.svn'

First check what you will delete:
    find . -name .svn -exec ls {} \;

Then delete them:
    find . -name .svn -exec rm -rf {} \;

Patterns work too:
    find . -name "*.FILEEXTENSION" -exec ls {} \;

### Delete all files with contents CONTENTS but first put the rm command into a file for safety
    find . | xargs grep CONTENTS | sed -e 's/:.*//g' | awk '{print "rm "$1}' > doit.sh
    . doit.sh


### Run things on startup
    edit /etc/rc.local


### General tool for network discovery
    avahi-browse -a 


### Shutdown a process the correct way
    killall -s INT


### Run gdb on a running process
    ps aux | grep gzserver# get process id
    sudo gdb -p 23845     # connect to that id


### Add a new nameserver to internet lookup
    se /etc/resolv.conf 
    add
    nameserver 8.8.8.8


### Get video card settings
    glxinfo | grep renderer


### Reset ethernet connection
    ifconfig eth0 down
    ifconfig eth0 up


### Search system ignoring errors
    gr NEEDLE 2> /dev/null


### Kill all processs with given partial name
    pkill -9 -f gazebo


### Useful tools
    strace 

a useful diagnostic, instructional, and debugging tool.  System administrators, diagnosticians and trouble-shooters will find it invaluable for solving problems with programs for which  the  source  is  not  readily
available  since they do not need to be recompiled in order to trace them.  Students, hackers and the overly-curious will find that a great deal can be learned about a system and its system calls by tracing even ordinary pro‐
grams.  And programmers will find that since system calls and signals are events that happen at the user/kernel interface, a close examination of this boundary is very useful for bug isolation, sanity checking and  attempting
to capture race conditions.

### pgrep - search for proccesses. if you see a number it is running


### See all proccesses with certain name
    ps -e | grep ros


### Change keyboard layout
    sudo dpkg-reconfigure keyboard-configuration


### Get folder sizes
    du


### Upper case all file extensions in a folder:

    for i in *.dae; do ext=$(echo ${i##*.} | tr '[:lower:]' '[:upper:]'); name=$(basename "$i" ".${i##*.}").$ext; cp $i ../$name; done

### Get number of cores on Ubuntu
    cat /proc/cpuinfo | grep processor | wc -l

### Show all files in directory with no details

    ls -AF | grep -v /$

### Rename all files in a folder with a certain extension

(From file name *.m4b to *.m4a)
Remove ``-vn`` to actually use (this is test mode)
    
    rename 's/.m4b$/.m4a/' *.m4b -vn

### Make symbolic link

ln -s source_file destination_file