# run on first computer
dpkg-query -W -f='${Package}\n' | sort > baselist.txt
