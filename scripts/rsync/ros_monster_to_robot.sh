rsync -avg --progress --delete --exclude 'devel' --exclude 'build' --exclude 'build_isolated' --exclude 'devel_isolated' --exclude 'install_isolated' --exclude 'large_data_files' ~/ros/ws_baxter ruser@$BAXTER_IP_ADDRESS:/home/ruser/ros/


# -v : verbose
# -r : copies data recursively (but don’t preserve timestamps and permission while transferring data
# -a : archive mode, archive mode allows copying files recursively and it also preserves symbolic links, file permissions, user & group ownerships and timestamps
# -z : compress file data
# –delete : delete files that are not there in source directory.

# dropbox before this script: 92 GB
