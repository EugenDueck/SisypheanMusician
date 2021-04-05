# wav to midi

## https://github.com/NFJones/audio-to-midi
I tried this, but the produced midi files (e.g. doing `audio-to-midi 20210402.wav -b 120 -t 30` were completely unusable)
I've filed an issue: https://github.com/NFJones/audio-to-midi/issues/11

### building and installing
```
git clone
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
- MIDIVisualizer is taking many minutes for a 56 second video
- it is maxing out my 4/8 cores/threads
- is there a way to use GPU?
  - do I even have a usable GPU on my laptop? I guess not
