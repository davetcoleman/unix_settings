comm -1 -3 baselist.txt <(dpkg-query -W -f='${Package}\n' | sort)
