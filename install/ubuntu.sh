#!/bin/bash
# AUTO CONFIGURE SCRIPT FOR DAVE'S SETTINGS
# This is for Ubuntu 14.04 only

## INSTALLATION ON UBUNTU------------------------------------------------------------------------
  # Stuff I can use on any linux machine
  function coreinstall() {
      sudo apt-get install -y git-core mercurial colordiff tree udisks || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
      
      # emacs
      sudo apt-get install -y emacs emacs-goodies-el || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
      
      # for use with emacs 'play' command for finishing compiling
      sudo apt-get install -y sox || echo -e "\e[00;31mAPT-GET FAILED\e[00m"

      # disable caps lock - works in xwindows
      echo "DISABLING CAPSLOCK"
      cp ~/unix_settings/install/ubuntu/.Xmodmap ~/
      xmodmap ~/.Xmodmap
  
      # disable caps lock - works in virtual consoles
      sudo cp ~/unix_settings/install/ubuntu/keyboard /etc/default/keyboard
      sudo dpkg-reconfigure keyboard-configuration
      
      # turn off caps lock just in case it was still on (by command line)
      python -c 'from ctypes import *; X11 = cdll.LoadLibrary("libX11.so.6"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'
  }

  function ubuntuinstall() {
      sudo apt-get install -y xclip terminator synaptic || echo -e "\e[00;31mAPT-GET FAILED\e[00m"

      # old gnome... should i stop using this?
      sudo apt-get install -y indicator-applet-complete gnome-panel gnome-sushi mesa-utils gnome-do compizconfig-settings-manager compiz-plugins-extra || echo -e "\e[00;31mAPT-GET FAILED\e[00m"

      # gives windows thicker border for resizing
      sudo cp ~/unix_settings/install/ubuntu/metacity-theme-1.xml /usr/share/themes/Ambiance/metacity-1/metacity-theme-1.xml 
      # manually:
      # se /usr/share/themes/Ambiance/metacity-1/metacity-theme-1.xml
      #      <distance name="left_width" value="3"/>
      #      <distance name="right_width" value="3"/>
      #      <distance name="bottom_height" value="3"/>

      # makes nautilus always show the file path dialogue
      #gsettings set org.gnome.nautilus.preferences always-use-location-entry true   
      # customize terminator
      mkdir -p ~/.config/terminator
      cp ~/unix_settings/install/ubuntu/terminator.config ~/.config/terminator/config
      # setup terminator to autostart
      mkdir -p ~/.config/autostart      
      cp ~/unix_settings/install/ubuntu/autostart/terminator.desktop ~/.config/autostart/terminator.desktop
      # customize gnome-do
      #cp -R ~/unix_settings/install/ubuntu/gnome-do ~/.gconf/apps/
      # make terminator default
      gconftool --type string --set /desktop/gnome/applications/terminal/exec terminator
  }

  # Install Wine
  function wineinstall() {
      sudo add-apt-repository -y ppa:ubuntu-wine/ppa
      sudo apt-get update
      sudo apt-get install wine1.6 winetricks || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
  }

  function benchmarkinstall() {
    sudo apt-get install -y hardinfo
    hardinfo
  }
  
  # Install Chrome on 12.04
  function chromeinstall() {
      wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
      echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee -a /etc/apt/sources.list.d/google-chrome.list
      #sudo add-apt-repository -y 'deb http://dl.google.com/linux/chrome/deb/ stable main'
      sudo apt-get update
      sudo apt-get install -y google-chrome-stable || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
      # set chrome to auto start
      mkdir -p ~/.config/autostart      
      cp ~/unix_settings/install/ubuntu/autostart/google-chrome-dave.desktop ~/.config/autostart/google-chrome-dave.desktop
      # finally, go to /etc/apt/sources.list.d/ and sudo rm google.list* to remove duplicate warning if needed

      # about:gpu
  }

  #Install Spotify: http://www.spotify.com/us/download/previews/
  function spotifyinstall() {
      sudo add-apt-repository -y 'deb http://repository.spotify.com stable non-free'
      sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 
      sudo apt-get update 
      sudo apt-get -y install spotify-client
  }

  #Install Dropbox
  function dropboxinstall() {
      # download dropbox
      cd ~ 
      wget -O - 'https://www.dropbox.com/download?plat=lnx.x86_64' | tar xzf - 

      # Make dropbox auto start
      mkdir -p ~/.config/autostart      
      cp ~/unix_settings/install/ubuntu/autostart/dropbox.desktop ~/.config/autostart/dropbox.desktop

      # Start dropbox
      ~/.dropbox-dist/dropboxd &

      # The Linux version of the Dropbox desktop application is limited from monitoring more than 10000 folders by default. Anything over that is not watched and, therefore, ignored when syncing. There's an easy fix for this. Open a terminal and enter the following:
      echo fs.inotify.max_user_watches=100000 | sudo tee -a /etc/sysctl.conf; sudo sysctl -p

      # Check if dropbox is running:
      #sudo service dropbox status

  }

  # Install flux
  function fluxinstall() {
      sudo add-apt-repository -y ppa:kilian/f.lux
      sudo apt-get update
      sudo apt-get install fluxgui -y || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
  }

  #Install good video & image stuff, Adobe Reader, and PDF Printer
  function mediainstall() {
      #sudo apt-get install -y vlc vlc-plugin-pulse gimp cups-pdf
      sudo apt-get install -y gimp
  }

  #Recording desktop image
  function recordinstall() {
      #sudo apt-get install -y gtk-recordMyDesktop
      sudo apt-get install -y openshot kazam
  }

  #Install ROS Indigo:
  function installros_indigo() {
      sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
      wget http://packages.ros.org/ros.key -O - | sudo apt-key add - 
      sudo apt-get update 
      sudo apt-get install -y ros-indigo-desktop-full || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
      # seperate incase the pkg is not available yet
      sudo apt-get install -y python-rosdep python-rosinstall python-bloom ros-indigo-rqt python-wstool python-bloom python-pip python-catkin-lint  || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
      sudo apt-get install -y rosemacs-el
      sudo rosdep init
      rosdep update      

      # setup catkin_tools config
      mkdir -p /home/dave/.config/catkin/verb_aliases
      ln -s ~/unix_settings/config/01-dave-aliases.yaml /home/dave/.config/catkin/verb_aliases/01-dave-aliases.yaml
  }

  #Install Gazebo for ubuntu 12.04 - FIRST INSTALL ROS
  function gazeboinstall() {
      sudo sh -c "echo 'deb http://packages.osrfoundation.org/gazebo/ubuntu '$(lsb_release -cs)' main' > /etc/apt/sources.list.d/gazebo-latest.list"
      wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - 
      sudo apt-get update 
      sudo apt-get install gazebo || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
  }

  #Install PR2 ROS:
  alias installrospr2="sudo apt-get install -y ros-indigo-pr2-desktop ros-indigo-pr2-apps"

  # Setup Github:
  function githubsetup() {
      unalias git  # git is an alias for hub in my config

      git config --global user.name 'Dave Coleman' 
      git config --global user.email 'davetcoleman@gmail.com' 
      git config --global core.autoctrlf input 
      git config --global credential.helper cache 
      git config --global credential.helper 'cache --timeout=7200' 
      git config --global color.ui auto
      
      # Setup Hub for Github
      sagi rake
      cd ~/
      git clone git://github.com/github/hub.git
      cd hub
      sudo rake install
  }
  
  # Matlab - Documentation: https://help.ubuntu.com/community/MATLAB
  function matlabinstall()
  {
      sudo apt-get install -y openjdk-6-jre icedtea-netx-common  || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
      firefox 'http://www.mathworks.com/downloads/web_downloads/select_release?mode=gwylf'
      read -p 'Now go to mathworks website and download to start installation. Press any key when matlab is done being installed, and then it installs matlab-support'
      sudo apt-get install -y matlab-support || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
  }

  # Latex - use kile to edit. change pdf viewer to evince in kile
  function latexinstall(){
      sudo apt-get install -y texlive-full lmodern texlive-fonts-recommended latex-beamer etoolbox kile
  }
  
  # R
  function rinstall(){
      # ess = emacs mode for lots of stats languages
      # r-cran-rcmdr = R Commander
      sudo apt-get install -y r-base r-base-dev ess r-cran-rcmdr
  }
  
  # TrueCrypt
  function truecryptinstall()
  {
      if [ ! -f "/home/dave/Dropbox/Documents/2014/truecrypt/truecrypt-7.1a-linux-x64.tar.gz" ]; then
	  zenity --info --text 'Is dropbox setup and 2014 files synced? Truecrypt will not install without those files and currently cannot find the tar.gz file. Skipping.'
      else
	  chmod a+rx ~/unix_settings/install/truecrypt-install-local.sh 
	  sudo ~/unix_settings/install/truecrypt-install-local.sh
      fi
  }

  # VirtualBox 4.2 Install 
  function virtualboxinstall()
  {
      sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list" 
      wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
      sudo apt-get update
      sudo apt-get install -y virtualbox-4.3 dkms
  }

  # Install Adobe Acrobat
  function acrobatinstall() {
      sudo add-apt-repository -y "deb http://archive.canonical.com/ '$(lsb_release -cs)' partner"
      sudo apt-get update && sudo apt-get install acroread -y || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
  }

  # Install workrave break manager
  function workraveinstall() {
    sudo apt-get install -y workrave || echo -e "\e[00;31mAPT-GET FAILED\e[00m"
    # set workrave to auto start
    mkdir -p ~/.config/autostart      
    cp ~/unix_settings/install/ubuntu/autostart/workrave.desktop ~/.config/autostart/workrave.desktop
  }

  # Install python tools
  function pythoninstall() {
      sudo apt-get install -y ipython python-numpy python-scipy python-matplotlib
  }

  # Setup secondary hard drive and ROS workspace sync? (for Dropbox)
  function secondarydriveinstall() {
      # Mount Data Drive (Secondary Drive), see notes/ubuntu.md
      zenity --info --text 'Preparing to mount secondary hard drive - see terminal'
      
      read -p "Does the hard drive have the name 'DataDrive'? If not, rename now" mount_resp1
      echo "\n\nWhat is the mount location of the secondary drive?"      
      lsblk -o KNAME,TYPE,SIZE,MODEL
      read -p "Name (e.g. /dev/sdb1):" ubuntuMountName

      echo "Attempting to mount device now:"
      udisksctl mount --block-device $ubuntuMountName

      # setup mount to autostart
      echo "Attempting to add as a startup application:"
      mkdir -p ~/.config/autostart
      cp ~/unix_settings/install/ubuntu/autostart/udisks.desktop ~/.config/autostart/udisks.desktop
      sed -i "s,MOUNTPOINT,$ubuntuMountName,g" ~/.config/autostart/udisks.desktop

      echo "Attempting to symblink Dropbox folders:"
      ln -s /media/dave/DataDrive/Dropbox ~/Dropbox
      ln -s /media/dave/DataDrive/Dropbox/Documents/2014 ~/2014

      mkdir -p ~/ros
      echo "TODO: crontab for ros folder syncing"
      # crontab -e
      # Add:
      # */10 * * * * /home/dave/unix_settings/scripts/rsync/backup_cu2_local_ros.sh  #every 10 min

      read -p "Done with secondary harddrive setup. Continue Ubuntu setup? (Ctrl-C to cancel)" mount_resp2
  }

  function baxterinstall() {

      sudo apt-get install -y ntp || echo -e "\e[00;31mAPT-GET FAILED\e[00m"

  }

  # Setup SSH Access
  function sshinstall() {
      sudo apt-get install -y openssh-server || echo -e "\e[00;31mAPT-GET FAILED\e[00m"

      # Setup SSH keys
      mkdir -p ~/.ssh
      chmod 700 ~/.ssh
      ssh-keygen -t rsa -b 4096

      # copy public key to various websites
      gedit ~/.ssh/id_rsa.pub
      firefox 'https://my.hostmonster.com/web-hosting/cplogin' 
      firefox 'https://github.com/settings/ssh'
      firefox 'https://bitbucket.org/account/user/davetcoleman/ssh-keys/'
  }

  # COPY KEY TO NEW COMPUTER: ssh-copy-id <username>@<host>
  # then disable password access on other computer using:
  #    se /etc/ssh/sshd_config
  #    set PasswordAuthentication to 'no'

  # Change hostname
  #    se /etc/hostname
  #    se /etc/hosts  #change self's name
  #    sudo shutdown -r 0 # restart computer

  # Add hostname to another computer
  #    se /etc/hosts

  # Disable firewall ubuntu
  #    sudo ufw disable

  # Debug port access issues
  #   nmap -PN -p 22 $ros_andy


  # ** DISPLAY ROTATE ** -----------------------
  # http://tuxtweaks.com/2010/05/ubuntu-enable-rotation-nvidia/
  # 
  # se /etc/X11/xorg.conf
  # Find section "Drive "nvidia""
  # Add line: Option"RandRRotation""on"
  # Nvidia Control Panel:
  #   Align monitors first before doing rotation
  # Command Line:
  #   xrand -o left
  # Done.

## ----------------------------------------------------------------------------------------------

export UBUNTU_VERSION=`lsb_release --codename | cut -f2`

read -p "Press any key to setup settings for Ubuntu '$UBUNTU_VERSION', or CTRL-C to cancel"

#set -x          # activate debugging from here
unalias -a git  # git is an alias for hub in my config

# Make new bashrc file
echo "Name of this computer for the bashrc environment?"
read -p "Press enter to keep name '$BASHRC_ENV'" bashrc_answer
if [ "$bashrc_answer" != "" ]; then
    rm ~/.bashrc
    echo "export BASHRC_ENV=$bashrc_answer && . ~/unix_settings/.my.bashrc" > ~/.bashrc

    # Clone the private repo as well
    git clone fabgatec@davetcoleman.com:~/src/unix_settings_private

    # Source the bashrc for the first time
    source ~/.bashrc

    # Create simulinks from /unix_settings folder in the home folder
    echo "Creating simulinks in home folder to custom scripts"
    ln -s ~/unix_settings_private/.gitconfig ~/.gitconfig
    ln -s ~/unix_settings/.hgrc ~/.hgrc

    ln -s ~/unix_settings/emacs ~/emacs
    ln -s ~/unix_settings/.emacs.d ~/.emacs.d
    ln -s ~/unix_settings/.emacs ~/.emacs

fi

# Start the installs
read -p "Install core terminal stuff? (y/n)" resp1

# What version of ubuntu?
if [ "$UBUNTU_VERSION" = "trusty" ]; then
    # 14.04
    read -p "Install Ubuntu 14.04 stuff? (y/n)" resp22
    read -p "Install ros indigo? (y/n)" resp71
    #read -p "Install Adobe Acrobat? (y/n)" resp19 # not available in trusty yet
else
    echo "ERROR - unknown ubuntu version $UBUNTU_VERSION"
    return
fi

#read -p "Install chrome? (y/n)" resp3
read -p "Setup secondary hard drive and ROS workspace sync? (for Dropbox) (y/n)" resp27
read -p "Install Flux? (y/n)" resp20
read -p "Install spotify? (y/n)" resp4
read -p "Install media stuff? (y/n)" resp6
#read -p "Install Gazebo? (y/n)" resp16
read -p "Setup github? (y/n)" resp8
read -p "Setup SSH & key? (y/n)" resp9
read -p "Install VirtualBox? (y/n)" resp12
read -p "Install dropbox? (y/n)" resp5
read -p "Install recording software? (y/n)" resp13
read -p "Install latex? (y/n)" resp14
read -p "Install R? (y/n)" resp28
read -p "Install truecrypt? (y/n)" resp15
read -p "Install Matlab? (y/n)" resp21
read -p "Install Wine? (y/n)" resp23
read -p "Install and run Benchmarking? (y/n)" resp24
read -p "Install Workrave break reminder? (y/n)" resp25
read -p "Install python tools? (y/n)" resp26

if [ "$resp1" = "y" ]; then
    coreinstall
fi
if [ "$resp3" = "y" ]; then
    chromeinstall
fi
if [ "$resp27" = "y" ]; then
    secondarydriveinstall
fi
if [ "$resp22" = "y" ]; then
    ubuntuinstall
fi
if [ "$resp5" = "y" ]; then
    dropboxinstall
fi
if [ "$resp19" = "y" ]; then
    acrobatinstall
fi
if [ "$resp20" = "y" ]; then
    fluxinstall
fi
if [ "$resp4" = "y" ]; then
    spotifyinstall
fi
if [ "$resp6" = "y" ]; then
    mediainstall
fi
if [ "$resp11" = "y" ]; then
    installrospr2
fi
if [ "$resp8" = "y" ]; then
    githubsetup
fi
if [ "$resp9" = "y" ]; then
    sshinstall
fi
if [ "$resp12" = "y" ]; then
    virtualboxinstall
fi
if [ "$resp71" = "y" ]; then
    installros_indigo
fi
if [ "$resp13" = "y" ]; then
    recordinstall
fi
if [ "$resp14" = "y" ]; then
    latexinstall  
fi
if [ "$resp28" = "y" ]; then
    rinstall  
fi
if [ "$resp15" = "y" ]; then
    truecryptinstall
fi
if [ "$resp16" = "y" ]; then
    gazeboinstall
fi
if [ "$resp21" = "y" ]; then
    matlabinstall
fi
if [ "$resp23" = "y" ]; then
    wineinstall
fi
if [ "$resp24" = "y" ]; then
    benchmarkinstall
fi
if [ "$resp25" = "y" ]; then
    workraveinstall
fi
if [ "$resp26" = "y" ]; then
    pythoninstall
fi

# Now cleanup 
sudo apt-get autoremove -y
sudo apt-get dist-upgrade -y
sudo apt-get clean

set +x          # stop debugging from here

# Rerun config
. ~/unix_settings/.my.bashrc

# Fix the unix_settings repo to use ssh
cd ~/unix_settings
gitsshfix
