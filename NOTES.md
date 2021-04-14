# fix video concatenation problem
docker run -it --rm -v /home/sisy/SisypheanMusic:/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile render-mid YEAR=2021 MONTH=04 DAY=13
mkdir -p bin/2021/04
/sisy/render-mid src/2021/04 bin/2021/04 2021 04 13
+ IN_FOLDER=src/2021/04
+ OUT_FOLDER=bin/2021/04
+ YEAR=2021
+ MONTH=04
+ DAY=13
+ DATE=20210413
+ DATE_SLASH=2021/04/13
+ IN_FILE=src/2021/04/20210413.mid
+ OUT_FILE_PREFIX=bin/2021/04/20210413
+ OUT_AUDIO=bin/2021/04/20210413.wav
+ OUT_AUDIO_MP3=bin/2021/04/20210413.mp3
+ OUT_IMAGE=bin/2021/04/20210413.png
+ OUT_VIDEO_ONLY=bin/2021/04/20210413.vid.mp4
+ OUT_VIDEO_AUDIO=bin/2021/04/20210413.vid-aud.mp4
+ OUT_PIC=bin/2021/04/20210413.pic.jpg
+ OUT_PIC_VIDEO=bin/2021/04/20210413.pic.mp4
+ OUT_PIC_VIDEO_AUDIO=bin/2021/04/20210413.pic.sound.mp4
+ OUT_VIDEO=bin/2021/04/20210413.mp4
+ ffmpeg -loglevel warning -y -i bin/2021/04/20210413.vid-aud.mp4 -i bin/2021/04/20210413.pic.sound.mp4 -filter_complex '[0]scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1[v0];[1]scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1[v1];[v0][0:a:0][v1][1:a:0]concat=n=2:v=1:a=1[v][a]' -map '[v]' -map '[a]' bin/2021/04/20210413.mp4
[mp4 @ 0x5629a1783340] Frame rate very high for a muxer not efficiently supporting it.
Please consider specifying a lower framerate, a different muxer or -vsync 2
[libx264 @ 0x5629a1786140] MB rate (8160000000) > level limit (16711680)
More than 1000 frames duplicated
More than 10000 frames duplicated
More than 100000 frames duplicated
^Cmake: *** [/sisy/Makefile:26: render-mid] Interrupt
make: *** wait: No child processes.  Stop.
^Cmake: *** [Makefile:18: render-mid] Error 2

# wav to midi

## https://github.com/kichiki/WaoN

Initial results are quite promising! I tried this with a clean, timidity-generated wav file, as well as with a microphone recorded scale played on the flute. In addition to the notes I had actually played on the flute, a couple of pretty quiet notes ended up in the midi file, and for the middle register, WaoN sometimes also generated the lower octave note - but my tone in the middle register was not very good, which probably was the reason for that.

### installation
```
git clone https://github.com/kichiki/WaoN
cd WaoN
libao-dev libgtk2.0-dev libsamplerate0-dev libsndfile1-dev libfftw3-dev libncurses5-dev libncursesw5-dev
make
```

## https://github.com/NFJones/audio-to-midi
I tried this, but the produced midi files (e.g. doing `audio-to-midi 20210402.wav -b 120 -t 30`) were completely unusable, even for the most simple and clean wav file inputs.
I've filed an issue: https://github.com/NFJones/audio-to-midi/issues/11

### installation
```
git clone https://github.com/NFJones/audio-to-midi
cd audio-to-midi
python3 ./setup.py install --user
```

## https://github.com/justinsalamon/audio_to_midi_melodia
Haven't tried it yet, as it depends on [MELODIA](https://www.justinsalamon.com/melody-extraction.html#software), which is free only for non-commercial use, so it may be prohibitive to use, depending on where I'm going to go with this project (Youtube monetarization?).

# fix the tag make target
It fails, although last commit date is equal to the current date
```
$ make tag
Makefile:46: *** Last git commit date 2021-04-03 is different from current date 2021-04-03 - please commit the changes first or tag manually.  Stop.
```
# MIDIVisualizer performance
- close to 40 minutes for 167 seconds of video
- MIDIVisualizer is taking many minutes for a 56 second video
- it is maxing out my 4/8 cores/threads
- is there a way to use GPU?
  - do I even have a usable GPU on my laptop? I guess not
