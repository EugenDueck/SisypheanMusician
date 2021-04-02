DATE = $(shell date +%Y%m%d)
YEAR = $(shell date +%Y)
MONTH = $(shell date +%m)
DAY = $(shell date +%d)

IN_DIR = src/$(YEAR)/$(MONTH)/
IN_MID_FILE = $(MID_DIR)/$(DATE).mid
OUT_DIR = bin/$(YEAR)/$(MONTH)/

DOCKER_LATEST_FILE = docker/latest
DOCKER_LATEST_TAG = $(shell cat ${DOCKER_LATEST_FILE})

all: record-midi render

docker:
	docker build docker -t a_tune_a_day:$(DATE)
	echo $(DATE) > $(DOCKER_LATEST_FILE)

record-midi:
	mkdir -p $(IN_DIR)
	arecordmidi -p 20:0 $(IN_MID_FILE)

render:
	mkdir -p $(OUT_DIR)
	docker run -it --rm -v $(CURDIR):/work -w /work a_tune_a_day:$(DOCKER_LATEST_TAG) render $(IN_DIR) $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)

.PHONY: all docker render
