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

render-mid:
	docker run -it --rm -v $(CURDIR):/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile render-mid YEAR=$(YEAR) MONTH=$(MONTH) DAY=$(DAY)

#render-mid-gpu: # fails (docker seemingly only supports NVIDIA)
#	docker run -it --rm --gpus all -v $(CURDIR):/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile render-mid YEAR=$(YEAR) MONTH=$(MONTH) DAY=$(DAY)
#render-mid-host: # unfortunately, this does not make use of the host's GPU
#	docker run -it --rm -e DISPLAY=172.17.0.1$(DISPLAY) -v $(CURDIR):/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile render-mid YEAR=$(YEAR) MONTH=$(MONTH) DAY=$(DAY)

render-wav:
	docker run -it --rm -v $(CURDIR):/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile render-wav YEAR=$(YEAR) MONTH=$(MONTH) DAY=$(DAY)

record-mid:
	mkdir -p $(IN_DIR)
	arecordmidi -p 20:0 $(IN_MID_FILE)

play-mid:
	timidity $(IN_MID_FILE)

tag: LAST_GIT_COMMIT_DATE := $(shell git log -1 --format=%cs $(IN_ROOT))
tag:
ifeq ($(LAST_GIT_COMMIT_DATE),$(DATE_DASH))
	git tag $(DATE_SLASH)
else
	$(error Last git commit date $(LAST_GIT_COMMIT_DATE) is different from current date $(DATE_DASH) - please commit the changes first or tag manually)
endif

.PHONY: docker render-mid render-wav record-mid play-mid tag
