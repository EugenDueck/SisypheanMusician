SHELL=/bin/bash

YEAR = $(shell date +%Y)
MONTH = $(shell date +%m)
DAY = $(shell date +%d)

DATE := $(YEAR)$(MONTH)$(DAY)
DATE_SLASH := $(YEAR)/$(MONTH)/$(DAY)
DATE_DASH := $(YEAR)-$(MONTH)-$(DAY)

DAY_SECS_0 := $(shell date --date="2021/04/01" +%s)
DAY_SECS_TODAY := $(shell date --date="$(YEAR)/$(MONTH)/$(DAY)" +%s)
DAY_NO := $(shell echo '($(DAY_SECS_TODAY)-$(DAY_SECS_0))/(3600*24)' | bc)

IN_ROOT := src
OUT_ROOT := bin

IN_DIR := $(IN_ROOT)/$(YEAR)/$(MONTH)
IN_MID_FILE := $(IN_DIR)/$(DATE).mid

IN_ROOT := src
OUT_DIR := $(OUT_ROOT)/$(YEAR)/$(MONTH)

MIDI_DEVICE := $(shell arecordmidi -l|sed -nre 's/^\s*(\S+)\s*Roland Digital Piano.*$$/\1/p')

record-mid:
	mkdir -p $(IN_DIR)
	arecordmidi -p $(MIDI_DEVICE) $(IN_MID_FILE)

score-png:
	test $(SCORE)
	musescore3 $(SCORE) -o $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score.png -T 20
	mv $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score-1.png $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score.png

render-mid:
	mkdir -p $(OUT_DIR)
	scripts/render-mid $(IN_DIR) $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)

render-wav:
	mkdir -p $(OUT_DIR)
	scripts/render-wav $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)

play-mid-timidity:
	timidity $(IN_MID_FILE)

play-mid:
	fluidsynth -a alsa -m alsa_seq -l -i /usr/share/sounds/sf2/MuseScore_General_Full.sf2 $(IN_MID_FILE)

play-mid-keyboard:
	aplaymidi -p $(MIDI_DEVICE) $(IN_MID_FILE)

play-mp4:
	mpv --fs $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).mp4

git-commit:
	git add src
	git commit -m '$(YEAR)/$(MONTH)/$(DAY) - Day $(DAY_NO)'

tag: LAST_GIT_COMMIT_DATE := $(shell git log -1 --format=%cs $(IN_ROOT))
tag:
ifeq ($(LAST_GIT_COMMIT_DATE),$(DATE_DASH))
	git tag $(DATE_SLASH)
else
	$(error Last git commit date $(LAST_GIT_COMMIT_DATE) is different from current date $(DATE_DASH) - please commit the changes first or tag manually)
endif

.PHONY: render-mid render-wav record-mid play-mid play-mid-keyboard play-mid-timidity tag render-mid-host render-mid-gpu
