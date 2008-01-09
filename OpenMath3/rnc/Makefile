MCD.dir = ../cd/MathML

MCD= #$(filter-out leftovers.mcd,$(shell cd $(MCD.dir); ls *.mcd))
MCD.rnc = $(MCD:%.mcd=%.rnc)

STS.dir = ../cd/MathML
STS = $(shell cd $(STS.dir);ls *.sts)
STS.rnc = $(STS:%.sts=%.rnc)

RNC = $(shell ls *.rnc)
RNG = $(RNC:%.rnc=%.rng)

all: $(STS.rnc) #rng

rng: $(RNG)
$(STS.rnc):	%.rnc:	$(STS.dir)/%.sts sts2rnc.xsl
	xsltproc -o $@ sts2rnc.xsl $(firstword $<)

$(MCD.rnc):	%.rnc: $(MCD.dir)/%.mcd mcd2rnc.xsl 
	xsltproc -o $@ mcd2rnc.xsl $(firstword $<)

$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@

echo:	
	echo $(STS.rnc)
