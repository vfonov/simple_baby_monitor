#! /bin/sh

if false;then
ffmpeg -f alsa -ac 1 -ar 48000 -i hw:1 -c:a aac   \
       -f video4linux2 -s 640x480 -framerate 15 -i /dev/video0 -c:v h264_omx -zerocopy 1 -profile:v main \
       -b:v 400k -b:a 10k -ar 11025 \
       -f flv -rtmp_buffer 500 -rtmp_live live \
       rtmp://127.0.0.1:1935/live/test \
       -hide_banner
fi
ffmpeg   \
       -f video4linux2 -s 640x480 -framerate 15 -i /dev/video0 -c:v h264_omx -zerocopy 1 -profile:v main \
       -b:v 400k -an \
       -f flv -rtmp_buffer 500 -rtmp_live live \
       rtmp://127.0.0.1:1935/live/test \
       -hide_banner
