# Mac Notes

## ZEND/WEB SERVER CONFIG

hosts
	sudo emacs /private/etc/hosts
	dscacheutil -flushcache
httpd.conf
	/usr/local/zend/apache2/conf/httpd.conf 
vhosts.conf
	/usr/local/zend/apache2/conf/extra/httpd-vhosts.conf
Restart 
	sudo /usr/local/zend/bin/apachectl restart

*** If having issues with local mac apache version ***

Change Mac Apache Port
       /private/etc/apache2/httpd.conf

Restart Mac Apache
	sudo /usr/sbin/httpd -k restart

Notes I've used:
      http://akrabat.com/php/some-notes-on-zend-server-ce-for-mac-os-x/


## Setup Matlab on command line:

   sudo ln -s /Applications/MATLAB_R2011a.app/bin/matlab /usr/bin/matlab

## Invert Picture

   control+option+command+8

### Convert owner to Dave's Mac user

    sudo chown -R dave:staff FOLDER/

