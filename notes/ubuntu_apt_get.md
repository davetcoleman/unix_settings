## Fix broken apt-get

     sudo apt-get -o Dpkg::Options::="--force-overwrite" -f install

## Clear old kernals from boot drive to make space for new ones

See current kernel:

    uname -r

Delete older ones from:

    ls -lah /boot
     
