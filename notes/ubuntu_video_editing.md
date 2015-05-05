# Video Editing Notes

## Screen Capture

Kazam
RecordMyDesktop - suchs because .ogv
Try http://www.maartenbaert.be/simplescreenrecorder/

## Setup converter for videos

    sudo apt-get install mencoder

## Run converter

    mencoder out.ogv -of lavf -lavfopts format=mp4 -oac mp3lame -lameopts cbr:br=128 -ovc x264 -x264encopts bitrate=1000 -o final.mp4 - See more at: http://biofeed.tumblr.com/post/15395563944/mencoder#sthash.k3l4UTeI.dpuf

## Video Editing

OpenShot - seems crappy

### Speedup Video

See scripts/speed_up_video/speed_up_video.sh to add 

### Rotate video

    I just tried it with avidemux. I use xvid and also I don't use the english version of avidemux so I may not describe it perfectly but you'll get it.

    1. start avidemux and load your video.

    2. choose avi from the button at the (almost) bottom left.

    3. choose the line containing Xvid4 on the top video button at the left.

    4. Press the filters button which is the third button on the left.

    5. Find rotate filter, double click it, choose angle and click ok.

    6. Now close filters windows.

    7. Press the Save button and enter a new name name.avi.


