Linux Backups and Encryption
================

** Backup Locally Using Crontab

Open settings
```
crontab -e
```

Add this:
```
*/10 * * * * /home/dave/unix_settings/scripts/rsync/backup_jsk_local_ros.sh  #every 10 min
```

** Dropbox Encryption

```
sudo apt-get install encfs
encfs /dave/.encrypted/ /dave/private/
```

Source: http://www.webupd8.org/2011/06/encrypt-your-private-dropbox-data-with.html

