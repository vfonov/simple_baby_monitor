# Raspberry PI baby monitor

This service works on Raspberry PI, but can be adopted for a PC with Debian/Ubuntu
It is assumed that a webcam with a microphone is attached to USB
And supported by linux kernel, creating /dev/video0 and default audio capture device (ALSA)

## Install dependencies (Raspbian)

```
# prebuilt janus dependencies
apt install libconfig-dev libmicrohttpd-dev libssl-dev

# gst streamer
apt  install gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
            gstreamer1.0-omx-rpi gstreamer1.0-omx-rpi-config  \
            gstreamer1.0-rtsp gstreamer1.0-alsa gstreamer1.0-libav gstreamer1.0-omx 


# some libraries need to be compiled from source
# libnice 0.1.16
curl https://libnice.freedesktop.org/releases/libnice-0.1.16.tar.gz -o libnice-0.1.16.tar.gz -L
tar xzf libnice-0.1.16.tar.gz
cd libnice-0.1.16
./configure --prefix=/usr --no-create --no-recursion
make
sudo make install # will install into /usr
cd ..

# libsrtp 2.3.0
curl https://github.com/cisco/libsrtp/archive/v2.3.0.tar.gz -o libsrtp-2.3.0.tar.gz -L
tar zxf libsrtp-2.3.0.tar.gz
cd libsrtp-2.3.0
./configure --prefix=/usr --enable-openssl
make 
sudo make install # will install into /usr
cd ..
```

## Compiling Janus-gateway itself

```
curl https://github.com/meetecho/janus-gateway/archive/v0.10.9.tar.gz -o janus-gateway-0.10.9.tar.gz -L
tar zxf janus-gateway-0.10.9.tar.gz
cd janus-gateway-0.10.9
./autogen
./configure --prefix=/opt/janus --enable-libsrtp2
make 
sudo make install # will install into /opt/janus
```

## Define janus configuration

```
cp janus.plugin.streaming.jcfg  /opt/janus/etc/janus/janus.plugin.streaming.jcfg
```

## Create services for systemctl 

```
cp janus.service /etc/systemd/system/janus.service
cp capture.service /etc/systemd/system/capture.service

systemctl daemon-reload
sudo systemctl enable janus
sudo systemctl enable capture

```