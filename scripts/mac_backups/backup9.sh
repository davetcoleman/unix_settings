echo "============= Backup started at " `date`
rsync -a --inplace --progress --delete --exclude 'VMs' --exclude 'Spotify' --exclude 'Software' --exclude '.Trashes' \
      /Volumes/Dave/ /Volumes/Backup9/Dave/
echo "============= Backup finished at " `date`

# -v : verbose
# -r : copies data recursively (but don’t preserve timestamps and permission while transferring data
# -a : archive mode, archive mode allows copying files recursively and it also preserves symbolic links, file permissions, user & group ownerships and timestamps
#      see http://serverfault.com/questions/141773/what-is-archive-mode-in-rsync
# -z : compress file data
# –delete : delete files that are not there in source directory.

# dropbox before this script: 92 GB
