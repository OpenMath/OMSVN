MCD.dir = ../spec/xml/cds
MCD= $(filter-out leftovers.mcd,$(shell cd $(MCD.dir); ls *.mcd))
MCD.rnc = $(MCD:%.mcd=%.rnc)
RNC = $(shell ls *.rnc)
RNG = $(RNC:%.rnc=%.rng)

all: $(MCD.rnc) rng
echo: 	
	echo $(MCD.rnc)

rng: $(RNG)

$(MCD.rnc):	%.rnc: $(MCD.dir)/%.mcd mcd2rnc.xsl 
	xsltproc -o $@ mcd2rnc.xsl $(firstword $<)

$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@

