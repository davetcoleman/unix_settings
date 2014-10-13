For baxter notes, see ../scripts/baxter.sh


# Installing emacs on Baxter

    wget SOME-MIRROR/emacs-24.3.tar.xz
    tar xvfJ emacs-24.3.tar.xz
	cd emacs-24.3
	./configure --with-gif=no
	make
	alias emacs="/home/ruser/bin/emacs-24.3/src/emacs"
	


