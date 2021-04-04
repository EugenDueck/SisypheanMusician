# Daily artwork

The daily artifacts can be seen at
- https://t.me/s/SisypheanMusic
- https://www.youtube.com/channel/UCGF-056DP2TMoM7onyGPAUw

# Do try this at home

## Setup

> The following steps will download something like 1 or 2 GBs off the internet, so don't try this with a slow internet connection

- make sure you have [Docker installed](https://docs.docker.com/get-started/#download-and-install-docker)
- download and unzip https://github.com/EugenDueck/SisypheanMusic/archive/refs/heads/master.zip
- run the following commands (this will take 5 minutes or more, depending on internet connection and machine spec)
```
cd SisypheanMusic-master
docker build docker -t sisypheanmusic
```

## Render MIDI -> MP4

The rendering is slow and takes minutes, depending on the length of the midi file.

### Windows
```
docker run -it --rm -v %cd%:/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile YEAR=2021 MONTH=04 DAY=02
```

### Unix/Linux/Mac
```
docker run -it --rm -v $(CURDIR):/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile YEAR=2021 MONTH=04 DAY=02
```

# Motivation

The motivation to start the "one musical work a day" project was to improve my musical skills, by forcing myself to create something musical - however small - every day, but I guess the goals will change over time. Mike Winkelmann's [Everydays](https://www.beeple-crap.com/everydays) were the inspiration for this project.

One new goal - in addition to improving my musical skills - appeared the very first day: Mastering the technologies needed to quickly create new musical pieces, by e.g. playing something on a MIDI keyboard and then letting the software create the finished work in form of a video automatically.

# Self-set rules

- create something musical **every single  day**, without exception
  - which means there will be days where I will be able to spend only 10 minutes or so on the piece
- the work must be finished by midnight every day
  - either in a common video (e.g. mp4) file format
  - or in a common audio (e.g. ogg, flac, mp3, wav) file format
  - or (worst case) on a physical (for those that remember) piece of paper, if circumstances require low-tech
- the work must be committed to the git repository, if possible on the same day
- the work must be published on a publically available channel
- the length of a piece may be anywhere from 1 second to a couple of minutes, hours, or even years (obviously not recorded live in the latter case), but it must contain more audible content than a MIDI->AUDIO rendering of John Cage's 4′33″
- the work must be free of copyrights
- the musical part of the piece (live playing, composition) must be created completely from scratch that day
  - this does not however include any software that I write for this, which will (hopefully) grow incrementally over time, and which I will be able to use for my daily pieces

# My goals

- provide "source files" to the work if possible, e.g. in the form of midi a file
- also provide the tools (e.g. in the form of a Dockerfile) to make it possible to reproduce the work by anyone, as far as possible
  - if the work of a day is e.g. directly recorded using a video camera (including sound), there will of course not be much in terms of "source files" that can be used to automatically reproduce the work

# Tools used

## Hardware

- [Any old laptop will do](https://psref.lenovo.com/syspool/Sys/PDF/ThinkPad/ThinkPad_X1_Carbon_6th_Gen/ThinkPad_X1_Carbon_6th_Gen_Spec.PDF)
  - but rendering of midi -> mp4 consumes lots and lots of CPU (and perhaps GPU?) and is still slow
- [AKAI Professional MPK Mini Play](https://www.akaipro.com/mpk-mini-play-mpkminiplay)
- [Roland FP-7F](https://www.roland.com/global/products/fp-7f/)

## Software

- [Debian Linux](https://www.debian.org/)
- [Docker](https://www.docker.com/)
- [ffmpeg](https://ffmpeg.org/)
- [FluidSynth](https://www.fluidsynth.org/)
- [ImageMagick](https://imagemagick.org/)
- [midicsv](https://www.fourmilab.ch/webtools/midicsv/)
- [MIDIVisualizer](https://github.com/kosua20/MIDIVisualizer)
- [MuseScore SoundFont MuseScore_General_Full.sf2](https://musescore.org/en/handbook/3/soundfonts-and-sfz-files)
- [timidity](http://timidity.sourceforge.net/)

## Infrastructure
- [Telegram messenger](https://telegram.org/)

# Notes

## 2021/4/3: reverting from ogg to mp3, because ogg audio does not play in videos uploaded to Telegram on the 2 Huawei mobile phones I tested
- also reverting from 48kHz to 44.1kHz, because ffmpeg conversion (when using `-f s32le`?) seems to assume 44.1kHz, and the a 48kHz wav rendered to mp3 gets longer (and video / audio gets out of sync, and I guess the audio pitch drops as well)
