DATE = $(shell date +%Y%m%d)
YEAR = $(shell date +%Y)
MONTH = $(shell date +%m)
MID_DIR = src/$(YEAR)/$(MONTH)/
MID_FILE = $(MID_DIR)/$(DATE).mid
OUT_DIR = bin/$(YEAR)/$(MONTH)/

all: record-midi render

docker:
	docker build docker -t a_tune_a_day:$(DATE)

record-midi:
	mkdir -p $(MID_DIR)
	arecordmidi -p 20:0 $(MID_FILE)
render:
	mkdir -p $(OUT_DIR)
	docker run -it --rm -v $(CURDIR):/work -w /work a_tune_a_day:20210402 render $(MID_FILE) $(OUT_DIR)/$(DATE)

.PHONY: all docker render
