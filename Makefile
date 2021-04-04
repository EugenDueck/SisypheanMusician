YEAR := $(shell date +%Y)
MONTH := $(shell date +%m)
DAY := $(shell date +%d)

docker:
	docker build docker -t sisypheanmusic

render:
	docker run -it --rm -v $(CURDIR):/sisy/work -w /sisy/work sisypheanmusic make -f /sisy/Makefile YEAR=$(YEAR) MONTH=$(MONTH) DAY=$(DAY)

.PHONY: docker render
