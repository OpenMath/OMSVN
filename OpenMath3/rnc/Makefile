MathML.rnc.dir = $(HOME)/vc/cvs/Math/Group/RelaxNG/mathml3
MathML.rnc = $(shell ls $(MathML.rnc.dir))
RNC = $(shell ls *.rnc) 
RNG = $(RNC:%.rnc=%.rng)

CD.rnc = mathml3-cds-pragmatic.rnc

all: 	update $(CD.rnc) rng

# this is only supposed to work on MiKo's computer
install: $(CD.rnc)
	cp $(CD.rnc) $(MathML.rnc.dir)
update: $(MathML.rnc)
	cp $(MathML.rnc) .

rng: $(RNG)
$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@


mathml3-cds-pragmatic.rnc: $(shell ls cd/mathml3-*-pragmatic.rnc)
	cd cd; make pragmatic; cd -;\
	rm -f mathml3-cds-pragmatic.rnc;\
	echo "default namespace m = 'http://www.w3.org/1998/Math/MathML'" > $@
	cat cd/mathml3-*-pragmatic.rnc >> $@
