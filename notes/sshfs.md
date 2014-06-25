SSHFS
===================
From https://help.ubuntu.com/community/SSHFS

##Setup

sagi sshfs
sudo gpasswd -a $USER fuse

##Connect from remote maschine to ros_monster

sshfs -o idmap=user dave@128.138.244.112:/home/dave/ros ~/ros

##Unmount

fusermount -u ~/far_projects
