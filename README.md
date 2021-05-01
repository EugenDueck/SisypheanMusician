# Daily musical snippet

The daily musical snippet can be seen on the *Sisyphean Musician* channels on
- [Youtube](https://www.youtube.com/channel/UCGF-056DP2TMoM7onyGPAUw)
- [Telegram](https://t.me/s/SisypheanMusic)

# Motivation

The motivation to start the "one musical snippet a day" project was to improve my musical skills, by forcing myself to create something musical - however small - every day, but I guess the goals will change over time. Mike Winkelmann's [Everydays](https://www.beeple-crap.com/everydays) were the inspiration for this project.

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

# Tools used

## Hardware

- [ThinkPad X1 Carbon](https://psref.lenovo.com/syspool/Sys/PDF/ThinkPad/ThinkPad_X1_Carbon_6th_Gen/ThinkPad_X1_Carbon_6th_Gen_Spec.PDF)
  - but rendering of midi -> mp4 consumes lots and lots of CPU (and perhaps GPU?) and is still slow
- [AKAI Professional MPK Mini Play](https://www.akaipro.com/mpk-mini-play-mpkminiplay)
- [Roland FP-7F](https://www.roland.com/global/products/fp-7f/)
- [BOSS RC-202 Looper](https://www.boss.info/global/products/rc-202/)
- [ZOOM Q4n](https://zoomcorp.com/en/jp/video-recorders/video-recorders/q4n/)

## Software

- [Debian Linux](https://www.debian.org/)
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
