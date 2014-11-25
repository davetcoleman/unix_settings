
### Check video card model:

    lspci | grep VGA

### Restore Video Settings

    cp /etc/X11/xorg.conf.failsafe /etc/X11/xorg.conf


### Boot with Safe Video Settings

add these linux kernel boot options:

    nomodeset nointremap vga=0x361.

### Get video card settings

    glxinfo | grep renderer


