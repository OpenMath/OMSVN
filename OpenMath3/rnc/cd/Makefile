STS.dir = ../../cd/MathML
STS = $(shell cd $(STS.dir);ls *.sts)
STS.OM.rnc = $(STS:%.sts=om3-%.rnc)
STS.MathML.rnc = $(STS:%.sts=mathml3-%.rnc)
RNC = $(STS.OM.rnc) $(STS.MathML.rnc) 
RNG = $(RNC:%.rnc=%.rng)

all: $(RNC) #rng

rng: $(RNG)

$(STS.OM.rnc):	om3-%.rnc:	$(STS.dir)/%.sts sts2rnc.xsl
	xsltproc -o $@ --stringparam format OpenMath sts2rnc.xsl $(firstword $<)

$(STS.MathML.rnc): mathml3-%.rnc:	$(STS.dir)/%.sts sts2rnc.xsl
	xsltproc -o $@ --stringparam format MathML sts2rnc.xsl $(firstword $<)

$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@

echo:	
	echo $(STS.rnc)
