#!/bin/bash

################################################################################
# TrueCrypt Installer for Ubuntu Linux
#
# Tested on and designed for:
# - Ubuntu 10.04 Lucid (32bit and 64bit), TrueCrypt 7.0a
# - Ubuntu 10.10 Maverick (32bit and 64bit), TrueCrypt 7.0a
#
# Newer Ubuntu and/or TrueCrypt releases may not work out of the box. Please
# check for an update of this script when a new version of Ubuntu and/or
# TrueCrypt is released: <http://readm3.org/app/truecrypt/truecrypt-install.sh>
#
# Usage:
# 1) Call this script with SUPERUSER privileges (->sudo)
# 2) If something fails, correct the thing which prevents the succesful
#    execution and call it again. This script is designed in a way that
#    re-calling it should be no problem.
#
#
# LICENSE: This file is open source software (OSS) and may be copied under
#          certain conditions. See the links below for details or try to contact
#          the author(s) of this file in doubt.
#
# @author Andreas Haerter <andreas.haerter@dev.mail-node.com>
# @copyright 2010, Andreas Haerter
# @license GPLv2 (http://www.gnu.org/licenses/gpl2.html)
# @license New/3-clause BSD (http://opensource.org/licenses/bsd-license.php)
# @link http://readm3.org/app/truecrypt/truecrypt-install.sh
# @link http://readm3.org/app/truecrypt/
# @link http://andreas-haerter.com
# @version 2010-09-06
################################################################################


################################################################################
# Configuration
################################################################################
TC_VER="7.1a"



################################################################################
# DO NOT TOUCH ANYTHING BEHIND THIS POINT WITHOUT KNOWING WHAT YOU ARE DOING!
################################################################################



################################################################################
# Process
################################################################################
#change working dir to the current parent dir
cd $(dirname ${0})

#welcome user
clear
echo "###############################################################################"
echo "# TrueCrypt ${TC_VER} installer/updater for Ubuntu Linux"
echo "# Found Ubuntu: $(lsb_release -rs) $(lsb_release -cs)"
echo "#"
echo "# Notes: - working internet connection is mandatory!"
echo "#        - eventually existing, older version of TrueCrypt will be removed"
echo "#          automatically to prevent problems."
echo "###############################################################################"

#check: are we root (=script called with sudo)?
if [ $(id -u) -ne 0 ]
then
	echo ""
	echo "Superuser privileges needed. Please call this script using 'sudo'." 1>&2
	exit 1
fi
echo -n "Would you like to install TrueCrypt ${TC_VER} now? [y|n]: "
read INPUT
if [ "${INPUT}" == "y" ] ||
   [ "${INPUT}" == "Y" ] ||
   [ "${INPUT}" == "j" ] || #German keyboard
   [ "${INPUT}" == "J" ]
then
	#remove existing, old versions
	TC_UNINSTALL="/usr/bin/truecrypt-uninstall.sh"
	if [ -f "${TC_UNINSTALL}" ] #check if file is existing
	then
		echo -e "\nExisting TrueCrypt found, executing '${TC_UNINSTALL}' to remove it.\n"
		${TC_UNINSTALL}
		if [ $? -ne 0 ]
		then
			echo "Could not remove existing TrueCrypt installation via '${TC_UNINSTALL}'. Please remove TrueCrypt manually and re-execute this script." 1>&2
			exit 1
		fi
		echo ""
	fi
	#define some stuff
	if [ "$(uname -m)" == "x86_64" ]
	then
		TC_DOWNLOADURL="http://www.truecrypt.org/download/truecrypt-${TC_VER}-linux-x64.tar.gz"
	else
		TC_DOWNLOADURL="http://www.truecrypt.org/download/truecrypt-${TC_VER}-linux-x86.tar.gz"
	fi
	TC_DOWNLOADLOCALPATH=$(mktemp -d "/tmp/truecrypt.XXXXXXXXXXXXX") #prevent symlink race condition...
	TC_DOWNLOADLOCALNAME="truecrypt.tar.gz"
	#download
	echo "Downloading... "
	mkdir -p ${TC_DOWNLOADLOCALPATH} > /dev/null 2>&1
	wget "${TC_DOWNLOADURL}" -O "${TC_DOWNLOADLOCALPATH}/${TC_DOWNLOADLOCALNAME}"
	if [ $? -ne 0 ]
	then
		echo -e "Download failed: '${TC_DOWNLOADURL}'\n\nPlease check if your internet connection is working and http://www.truecrypt.org is reachable." 1>&2
		exit 1
	fi
	#untar
	cd ${TC_DOWNLOADLOCALPATH}
	tar -xzvf "${TC_DOWNLOADLOCALPATH}/${TC_DOWNLOADLOCALNAME}"
	if [ $? -ne 0 ]
	then
		echo "untar failed: '${TC_DOWNLOADLOCALPATH}/${TC_DOWNLOADLOCALNAME}'" 1>&2
		exit 1
	fi
	#install
	echo ""
	echo "Please choose 'Install TrueCrypt' and follow instructions of the installer..."
	read -sp "Press [Enter] to continue."
	if [ "$(uname -m)" == "x86_64" ]
	then
		${TC_DOWNLOADLOCALPATH}/truecrypt-${TC_VER}-setup-x64
	else
		${TC_DOWNLOADLOCALPATH}/truecrypt-${TC_VER}-setup-x86
	fi
	if [ $? -ne 0 ]
	then
		echo -e "\n\nTrueCrypt installer exits reporting an error!\n\nIf you aborted the installation program accidentally, simply restart the script." 1>&2
		exit 1
	fi
	echo ""
	echo "Installation of TrueCrypt should be done."
	echo ""
	sleep 1
	#/etc/sudoers
	echo ""
	echo ""
	echo "If you enter your username, a \"tcusers\" group and an proper entry"
	echo "within '/etc/sudoers'will be created."
	echo ""
	echo "Advantage: members of the \"tcusers\" group will not be asked for a"
	echo "sudo pwd when mounting TC volumes. If you do not type/press anything"
	echo "but ENTER, nothing will be touched."
	echo ""
	echo -n "Username to add to the \"tcusers\" group? "
	read TC_USERNAME
	TC_USERNAME_OK="n"
	while [ ! "${TC_USERNAME_OK}" == "y" ] &&
	      [ ! "${TC_USERNAME_OK}" == "Y" ] &&
	      [ ! "${TC_USERNAME_OK}" == "j" ] &&
	      [ ! "${TC_USERNAME_OK}" == "J" ]
	do
		if [ "${TC_USERNAME}" == "" ]
		then
			echo -e -n "You did NOT typed a username, '/etc/sudoers' won't be touched.\nIs this correct? [y|n]: "
			read TC_USERNAME_OK
		else
			echo -n "You typed '${TC_USERNAME}'. Is this correct? [y|n]: "
			read TC_USERNAME_OK
		fi
		if [ "${TC_USERNAME_OK}" == "y" ] ||
		   [ "${TC_USERNAME_OK}" == "Y" ] ||
		   [ "${TC_USERNAME_OK}" == "j" ] || #German keyboard
		   [ "${TC_USERNAME_OK}" == "J" ]
		then
			break 1
		else
			echo -n "Username to add to the \"tcusers\" group? "
			read TC_USERNAME
			continue 1
		fi
	done
	#modify /etc/sudoers
	if [ ! "${TC_USERNAME}" == "" ]
	then
		IFS_ORIG=${IFS} #copy original IFS (Internal Field Separator)
		IFS=$'\n'
		#check if the needed entry is alread existing
		TC_ENTRYALREADYSET="0"
		for TC_INTERIM in $(< "/etc/sudoers"); do
			if [ "${TC_INTERIM}" == "%tcusers ALL=(root) NOPASSWD:/usr/bin/truecrypt" ]
			then
				TC_ENTRYALREADYSET="1"
				break 1
			fi
		done
		IFS=${IFS_ORIG}
		if [ "${TC_ENTRYALREADYSET}" == "0" ]
		then
			echo -e "\n# Members of the tcusers group may run TrueCrypt without password\n%tcusers ALL=(root) NOPASSWD:/usr/bin/truecrypt\n" >> "/etc/sudoers"
		else
			echo -e "\nNothing to do: fitting 'etc/sudoers' entry is already existing, going on without modifying the file.\n\n"
		fi
		unset IFS_ORIG
		unset TC_INTERIM
		unset TC_ENTRYALREADYSET
		groupadd tcusers > /dev/null 2>&1 #groupadd returns an error if the group is already existing, therefore no error checking via [ $? -ne 0 ] :-(
		adduser "${TC_USERNAME}" tcusers
		if [ $? -ne 0 ]
		then
			echo "error: could not add '${TC_USERNAME}' to the tcusers group!" 1>&2
			exit 1
		fi
	fi
	#clean up
	rm --preserve-root -rf "${TC_DOWNLOADLOCALPATH}/"
	unset TC_VER
	unset TC_DOWNLOADURL
	unset TC_DOWNLOADLOCALPATH
	unset TC_DOWNLOADLOCALNAME
	unset TC_USERNAME
	unset TC_USERNAME_OK
	#finished
	echo ""
	echo ""
	echo "###############################################################################"
	echo "# SUCCESS! TrueCrypt installation was done."
	echo "###############################################################################"
fi
unset INPUT
exit 0