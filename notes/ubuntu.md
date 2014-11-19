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

### Command line copy to clipboad

    cat ~/.ssh/id_rsa.pub | pbcopy

### Kill a program that is not responding

    Ctrl-z 
    kill %

### Command to mount disks at startup

    Find the disk name:
    ```
    mount
    ```

    Add to Startup Applications:
    udisksctl mount --block-device /dev/sdb3
    Instructions: https://askubuntu.com/questions/299298/how-can-i-change-the-mount-point-path-while-using-udisks

    OLD VERSION:
    /usr/bin/udisks --mount /dev/sdb3
    Instructions: https://help.ubuntu.com/community/AutomaticallyMountPartitions


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

add these linux kernel boot options:

    nomodeset nointremap vga=0x361.

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


### Debugging Tool

a useful diagnostic, instructional, and debugging tool.  System administrators, diagnosticians and trouble-shooters will find it invaluable for solving problems with programs for which  the  source  is  not  readily
available  since they do not need to be recompiled in order to trace them.  Students, hackers and the overly-curious will find that a great deal can be learned about a system and its system calls by tracing even ordinary pro‐
grams.  And programmers will find that since system calls and signals are events that happen at the user/kernel interface, a close examination of this boundary is very useful for bug isolation, sanity checking and  attempting
to capture race conditions.

    strace 

### search for proccesses. if you see a number it is running

    pgrep
	
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

## Apt-Get Commands

### Fix broken apt-get

     sudo apt-get -o Dpkg::Options::="--force-overwrite" -f install

