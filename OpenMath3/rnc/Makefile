RNC = $(shell ls *.rnc) 
RNG = $(RNC:%.rnc=%.rng)

CD.rnc = mathml3-cds-pragmatic.rnc

all: rng
	cd cd; make all

rng: $(RNG)
$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@


mathml3-cds-pragmatic.rnc: 
	cd cd; make pragmatic; cd -;\
	rm -f mathml3-cds-pragmatic.rnc;\
	cat cd/mathml3-*-pragmatic.rnc > mathml3-cds-pragmatic.rnc 
