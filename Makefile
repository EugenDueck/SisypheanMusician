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
IN_MD_FILE := $(IN_DIR)/$(DATE).md
IN_MID_FILE := $(IN_DIR)/$(DATE).mid

IN_ROOT := src
OUT_DIR := $(OUT_ROOT)/$(YEAR)/$(MONTH)

MIDI_DEVICE := $(shell arecordmidi -l|sed -nre 's/^\s*(\S+)\s*Roland Digital Piano.*$$/\1/p')

in-dir:
	mkdir -p $(IN_DIR)

out-dir:
	mkdir -p $(OUT_DIR)

adb-pull-image: out-dir
	adb-pull-last-image 1 $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).pic.jpg
	krita $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).pic.jpg >/dev/null 2>/dev/null
	rm $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).pic.jpg~
	pkill adb

record-mid: in-dir
	arecordmidi -p $(MIDI_DEVICE) $(IN_MID_FILE)

fix-mid:
	midicsv $(IN_MID_FILE) $(IN_DIR)/$(DATE).csv
	sed -i -re '/^1, 0, Note_o(n|ff)_c/d' $(IN_DIR)/$(DATE).csv
	csvmidi $(IN_DIR)/$(DATE).csv $(IN_MID_FILE)
	rm $(IN_DIR)/$(DATE).csv

score-png:
	test $(SCORE)
	musescore3 $(SCORE) -o $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score.png -T 20
	mv $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score-1.png $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score.png

# unused as of yet (WIP):
score-png-alpha:
	test $(SCORE)
	musescore3 $(SCORE) -o $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score.png -T 20
	mv $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score-1.png $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score.png
	convert $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score.png -write MPR:orig -alpha extract \
	\( +clone -colorspace gray -fx "1-j/h/1.5" \)     \
	-compose multiply -composite \
	MPR:orig +swap -compose copyopacity -composite $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).score.alpha.png

watermark:
	test $(VIDEO)
	convert \( -background none -gravity west -pointsize 64 -font DejaVu-Sans-Bold -fill white caption:"$(DATE_SLASH)" \
	    \( +clone -background black -shadow 320x3-0-0  \) +swap -background none -layers merge +repage \) "$(DATE_DASH).png"
	ffmpeg -y -loglevel warning -i "$(VIDEO)" -i "$(DATE_DASH).png" -filter_complex "overlay=W-w-10:10" -codec:v prores -codec:a copy "$(basename $(VIDEO)).watermark.mov"
	rm "$(DATE_DASH).png"

render-mid: out-dir
	scripts/render-mid $(IN_DIR) $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)

render-wav: out-dir
	scripts/render-wav $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)

mount-zoom:
	mountpoint -q /media/eugen/Q4N_SD || mount /media/eugen/Q4N_SD

copy-last-zoom: mount-zoom
	zoom-cp-last-recording-to $(YEAR)$(MONTH)$(DAY).mov

remove-zoom: mount-zoom
	rm /media/eugen/Q4N_SD/DCIM/100_ZOOM/*.MOV
	umount /media/eugen/Q4N_SD

render-mov: out-dir
	scripts/render-mov $(YEAR)$(MONTH)$(DAY).mov $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)
	rm $(YEAR)$(MONTH)$(DAY).mov

play-mid-timidity:
	timidity $(IN_MID_FILE)

play-mid:
	fluidsynth -a alsa -m alsa_seq -l -i /usr/share/sounds/sf2/MuseScore_General_Full.sf2 $(IN_MID_FILE)

play-mid-keyboard:
	aplaymidi -p $(MIDI_DEVICE) $(IN_MID_FILE)

play-mp4:
	mpv --fs $(OUT_DIR)/$(YEAR)$(MONTH)$(DAY).mp4

md: in-dir
	echo '# Day $(DAY_NO): ' > $(IN_MD_FILE)
	emacs -nw $(IN_MD_FILE)
	rm $(IN_MD_FILE)~
	echo $(IN_MD_FILE)

git-commit:
	git add src
	(echo -n '$(YEAR)/$(MONTH)/$(DAY) '; head -1 $(IN_MD_FILE)) | git commit -F -

tag: LAST_GIT_COMMIT_DATE := $(shell git log -1 --format=%cs $(IN_ROOT))
tag:
ifeq ($(LAST_GIT_COMMIT_DATE),$(DATE_DASH))
	git tag $(DATE_SLASH)
else
	$(error Last git commit date $(LAST_GIT_COMMIT_DATE) is different from current date $(DATE_DASH) - please commit the changes first or tag manually)
endif

.PHONY: render-mid render-wav record-mid play-mid play-mid-keyboard play-mid-timidity tag
