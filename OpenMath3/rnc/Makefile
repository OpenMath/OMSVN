RNC = $(shell ls *.rnc)
RNG = $(RNC:%.rnc=%.rng)

all: rng
	cd cd; make all

rng: $(RNG)
$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@
