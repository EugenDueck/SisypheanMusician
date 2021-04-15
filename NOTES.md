# too quiet:
04/07
04/10
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
