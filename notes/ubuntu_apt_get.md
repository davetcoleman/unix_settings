## Fix broken apt-get

     sudo apt-get -o Dpkg::Options::="--force-overwrite" -f install

## Clear old kernals from boot drive to make space for new ones

See current kernel:

    uname -r

Delete older ones from:

    ls -lah /boot
     
# See where files are installed from debian

    dpkg -L DEBIAN_PKG_NAME

# Fix Broken Dependencies

    http://askubuntu.com/questions/140246/how-do-i-resolve-unmet-dependencies-after-adding-a-ppa
