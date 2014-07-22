# To use, source this file then call this function below
function speedUpVideo() # videoName
{
    mencoder $1 \
	-o output.avi \
	-ovc xvid \
	-nosound \
	-speed 2 \
	-xvidencopts pass=1 \
	-sub /home/dave/unix_settings/scripts/speed_up_video/speed_up_video_caption.srt \
	-subalign 0 \
	-subfont-autoscale 0 \
	-subfont-text-scale 30
}

#−subalign <0−2>
#Specify which edge of the subtitles should be aligned at the height given by −subpos.
#0 Align subtitle top edge (original behavior).
#1 Align subtitle center.
#2 Align subtitle bottom edge (default).