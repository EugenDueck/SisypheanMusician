ifndef YEAR
$(error YEAR is not set)
endif

ifndef MONTH
$(error MONTH is not set)
endif

ifndef DAY
$(error DAY is not set)
endif

DATE := $(YEAR)$(MONTH)$(DAY)
DATE_SLASH := $(YEAR)/$(MONTH)/$(DAY)
DATE_DASH := $(YEAR)-$(MONTH)-$(DAY)

IN_ROOT := src
OUT_ROOT := bin

IN_DIR := $(IN_ROOT)/$(YEAR)/$(MONTH)
IN_MID_FILE := $(IN_DIR)/$(DATE).mid
OUT_DIR := $(OUT_ROOT)/$(YEAR)/$(MONTH)

render-mid:
	mkdir -p $(OUT_DIR)
	/sisy/render-mid $(IN_DIR) $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)

render-wav:
	mkdir -p $(OUT_DIR)
	/sisy/render-wav $(OUT_DIR) $(OUT_DIR) $(YEAR) $(MONTH) $(DAY)

.PHONY: render
