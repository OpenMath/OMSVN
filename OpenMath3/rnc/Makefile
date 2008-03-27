RNC = $(shell ls *.rnc) 
RNG = $(RNC:%.rnc=%.rng)

CD.rnc = mathml3-cds-pragmatic.rnc

MathML.rnc = mathml3-strict.rnc mathml3.rnc mathml3-common.rnc mathml3-presentation.rnc mathml3+deprecated.rnc mathml3-pragmatic.rnc mathml3-cds-pragmatic.rnc 

all: 	$(CD.rnc) rng

# this is only supposed to work on MiKo's computer
install: mathml3-cds-pragmatic.rnc 
	cp $(MathML.rnc) $(HOME)/vc/cvs/Math/Group/RelaxNG

rng: $(RNG)
$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@


mathml3-cds-pragmatic.rnc: 
	cd cd; make pragmatic; cd -;\
	rm -f mathml3-cds-pragmatic.rnc;\
	echo "default namespace m = 'http://www.w3.org/1998/Math/MathML'" > $@
	cat cd/mathml3-*-pragmatic.rnc >> $@
