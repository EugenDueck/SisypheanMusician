YEAR := $(shell date +%Y)
MONTH := $(shell date +%m)
DAY := $(shell date +%d)

DATE := $(YEAR)$(MONTH)$(DAY)
DATE_SLASH := $(YEAR)/$(MONTH)/$(DAY)
DATE_DASH := $(YEAR)-$(MONTH)-$(DAY)

IN_ROOT := src

IN_DIR := $(IN_ROOT)/$(YEAR)/$(MONTH)
IN_MID_FILE := $(IN_DIR)/$(DATE).mid

docker:
	docker build docker -t sisypheanmusic

render:
	docker run -it --rm -v $(CURDIR):/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile YEAR=$(YEAR) MONTH=$(MONTH) DAY=$(DAY)

record-midi:
	mkdir -p $(IN_DIR)
	arecordmidi -p 20:0 $(IN_MID_FILE)

play-midi:
	timidity $(IN_MID_FILE)

tag: LAST_GIT_COMMIT_DATE := $(shell git log -1 --format=%cs $(IN_ROOT))
tag:
ifeq ($(LAST_GIT_COMMIT_DATE),$(DATE_DASH))
	git tag $(DATE_SLASH)
else
	$(error Last git commit date $(LAST_GIT_COMMIT_DATE) is different from current date $(DATE_DASH) - please commit the changes first or tag manually)
endif

.PHONY: docker render record-midi play-midi tag
