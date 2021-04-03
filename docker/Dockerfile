FROM debian:unstable-20210329-slim

WORKDIR /build

RUN apt-get update \
#
	# install apt-utils first and separately, because it is needed by the next apt-get call
	# and I believe (though haven't verified) that  installing it in the same apt-get call
	# would not address this warning:
	# "debconf: delaying package configuration, since apt-utils is not installed"
	&& apt-get install apt-utils \
#
	&& apt-get install -y --no-install-recommends \
#
	# ffmpeg of course for processing video/audio
	ffmpeg \
#
	# imagemagick contains the 'convert' tool
	imagemagick \
#
	# fluidsynth and soundfont to render midi to audio
	fluidsynth \
	musescore-general-soundfont-lossless \
#
	# in order to get and build MIDIVisualizer
	git \
	build-essential \
	xorg-dev \
	libglu1-mesa-dev \
	libgtk-3-dev \
	libasound2-dev \
	ffmpeg \
	libavcodec-dev \
	libavformat-dev \
	libavdevice-dev \
	cmake

# to address the following error:
# fatal: unable to access 'https://github.com/kosua20/MIDIVisualizer/': server certificate verification failed. CAfile: none CRLfile: none
RUN git config --global http.sslverify false

# get and build MIDIVisualizer
RUN git clone -b v6.3 --depth 1 https://github.com/kosua20/MIDIVisualizer
RUN mkdir MIDIVisualizer/build
RUN cd MIDIVisualizer/build && cmake ../ && make

# install xserver as one is needed by MIDIVisualizer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xserver-xorg-video-dummy
COPY video-dummy.conf .

# add main script to path
COPY render /usr/bin
