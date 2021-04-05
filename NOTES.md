# fix tag target:
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
