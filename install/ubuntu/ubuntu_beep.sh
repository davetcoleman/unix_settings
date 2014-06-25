First run sudo modprobe pcspkr and then beep should work.

The reason this doesn't is because by default Ubuntu no longer loads the hardware driver that produce beeps.

If this works for you then to enable the loading of pcspkr permanently edit the /etc/modprobe.d/blacklist.conf file (using gksudo gedit perhaps) and comment out line that says blacklist pcspkr so it looks like this:

# ugly and loud noise, getting on everyone's nerves; this should be done by a
# nice pulseaudio bing (Ubuntu: #77010)
# blacklist pcspkr