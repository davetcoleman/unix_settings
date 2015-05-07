### See Disk Free Space of Filesystem

    df -h

### Get folder sizes

	du -hs /path/to/directory

### Get all file sizes

    du -a -h --max-depth=2 | sort -hr 

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


### Show all files in directory with no details

    ls -AF | grep -v /$

### Rename all files in a folder with a certain extension

(From file name *.m4b to *.m4a)
Remove ``-vn`` to actually use (this is test mode)
    
    rename 's/.m4b$/.m4a/' *.m4b -vn

### Make symbolic link

    ln -s source_file destination_file

### Check Swap Space

Two options:

    sudo swapon -s
    free -M's
	
### Make a swap file

See https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04

    sudo fallocate -l 4G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

### Make swap partition permanent:

    sudo emacs /etc/fstab

And add the line to the bottom:

	/swapfile   none    swap    sw    0   0
	
	
# Change ownership

    sudo chown robots:robots -R ros/

# Change persmissions

    sudo chmod +x file
