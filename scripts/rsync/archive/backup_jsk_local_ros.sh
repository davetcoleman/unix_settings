echo "============= Backup started at " `date` >> /home/dave/cron_backup_log.txt
rsync -avg --progress --delete --exclude 'devel' --exclude 'build' --exclude 'install' --exclude 'build_isolated' --exclude 'devel_isolated' --exclude 'install_isolated' --exclude 'large_data_files_not_backedup' --exclude 'archive'  ~/ros/ ~/Dropbox/jsk_ros/ >> /home/dave/cron_backup_log.txt
echo "============= Backup finished at " `date` >> /home/dave/cron_backup_log.txt

# -v : verbose
# -r : copies data recursively (but don’t preserve timestamps and permission while transferring data
# -a : archive mode, archive mode allows copying files recursively and it also preserves symbolic links, file permissions, user & group ownerships and timestamps
# -z : compress file data
# –delete : delete files that are not there in source directory.

# dropbox before this script: 92 GB