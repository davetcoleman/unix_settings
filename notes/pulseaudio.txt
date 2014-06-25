
** First Steps
http://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/FirstSteps/

** Network
http://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Network/

** Easy intruction
https://www.linux.com/learn/tutorials/332418-weekend-project-using-pulseaudio-to-share-sound-across-all-your-computers

** Enter command mode
pacmd

** Show GUI
pavucontrol

** Stream Music From Main PC to LAN

SENDER SIDE:
load-module module-null-sink sink_name=rtp
load-module module-rtp-send source=rtp.monitor
set-default-sink rtp

CLIENT SIDES:
load-module module-rtp-recv
