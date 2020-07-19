#! /bin/bash

gst-launch-1.0     \
 -v v4l2src device=/dev/video0 ! \
      video/x-raw,width=640,height=480,framerate=30/1 ! \
      videorate ! videoconvert !\
      omxh264enc target-bitrate=240000 control-rate=variable !\
      h264parse !\
      rtph264pay config-interval=1 pt=96 !\
      udpsink host=127.0.0.1 port=8004  \
   alsasrc device=plughw:1  ! \
      audioresample quality=1 ! \
      audio/x-raw,rate=16000,channels=1 ! \
      opusenc bitrate=10000 ! \
      rtpopuspay ! \
      udpsink host=127.0.0.1 port=8002
