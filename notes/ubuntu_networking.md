### General tool for network discovery
    avahi-browse -a 

### Add a new nameserver to internet lookup
    se /etc/resolv.conf 
    add
    nameserver 8.8.8.8

### Reset ethernet connection
    ifconfig eth0 down
    ifconfig eth0 up


