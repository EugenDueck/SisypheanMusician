YEAR := $(shell date +%Y)
MONTH := $(shell date +%m)
DAY := $(shell date +%d)

DATE := $(YEAR)$(MONTH)$(DAY)
DATE_SLASH := $(YEAR)/$(MONTH)/$(DAY)
DATE_DASH := $(YEAR)-$(MONTH)-$(DAY)

IN_ROOT := src
OUT_ROOT := bin

IN_DIR := $(IN_ROOT)/$(YEAR)/$(MONTH)
IN_MID_FILE := $(IN_DIR)/$(DATE).mid
OUT_DIR := $(OUT_ROOT)/$(YEAR)/$(MONTH)

DOCKER_LATEST_FILE := docker/latest

all: record-midi render

docker:
	docker build docker -t SisypheanMusic:$(DATE)
	echo $(DATE) > $(DOCKER_LATEST_FILE)

record-midi:
	mkdir -p $(IN_DIR)
	arecordmidi -p 20:0 $(IN_MID_FILE)

play-midi:
	timidity $(IN_MID_FILE)

render: DOCKER_LATEST_TAG := $(shell cat $(DOCKER_LATEST_FILE))
render:
	mkdir -p $(OUT_DIR)
	docker run -it --rm -v $(CURDIR):/work -w /work SisypheanMusic:$(DOCKER_LATEST_TAG) render $(IN_DIR) $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)

login: DOCKER_LATEST_TAG := $(shell cat $(DOCKER_LATEST_FILE))
login:
	mkdir -p $(OUT_DIR)
	docker run -it --rm -v $(CURDIR):/work -w /work SisypheanMusic:$(DOCKER_LATEST_TAG) /bin/bash

tag: LAST_GIT_COMMIT_DATE := $(shell git log -1 --format=%cs $(IN_ROOT))
tag:
ifeq ($(LAST_GIT_COMMIT_DATE),$(DATE_DASH))
	git tag $(DATE_SLASH)
else
	$(error Last git commit date $(LAST_GIT_COMMIT_DATE) is different from current date $(DATE_DASH) - please commit the changes first or tag manually)
endif

.PHONY: all docker record-midi play-midi render tag
