FROM debian:testing-20210329

WORKDIR /sisy

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
	git \
	ca-certificates \
	build-essential \
	tree \
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
	# MIDIVisualizer to render midi to video
	xorg-dev \
	libglu1-mesa-dev \
	libgtk-3-dev \
	libasound2-dev \
	libavcodec-dev \
	libavformat-dev \
	libavdevice-dev \
	cmake

# get and build MIDIVisualizer
RUN git clone -b v6.3 --depth 1 https://github.com/kosua20/MIDIVisualizer
RUN mkdir MIDIVisualizer/build
RUN cd MIDIVisualizer/build && cmake ../ && make

# in order to run MIDIVisualizer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends xserver-xorg-video-dummy
COPY video-dummy.conf ./

# normalization
RUN apt-get install -y --no-install-recommends normalize-audio

COPY Makefile render-wav render-mid ./
