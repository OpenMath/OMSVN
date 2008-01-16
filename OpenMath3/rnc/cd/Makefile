STS.dir = ../../cd/MathML
STS = $(shell cd $(STS.dir);ls *.sts)
STS.OM.rnc-arity = $(STS:%.sts=om3-%-arity.rnc)
STS.OM.rnc-sts = $(STS:%.sts=om3-%-sts.rnc)
STS.MathML.rnc-arity = $(STS:%.sts=mathml3-%-arity.rnc)
STS.MathML.rnc-sts = $(STS:%.sts=mathml3-%-sts.rnc)
RNC = $(STS.OM.rnc-sts) $(STS.MathML.rnc-sts) $(STS.OM.rnc-arity) $(STS.MathML.rnc-arity) 

RNG = $(RNC:%.rnc=%.rng)

all: $(RNC) #rng

rng: $(RNG)

$(STS.OM.rnc-sts):	om3-%-sts.rnc:	$(STS.dir)/%.sts $(STS.dir)/%.ocd sts2rnc-sts.xsl
	xsltproc -o $@ --stringparam format OpenMath --stringparam thecd $(word 2, $^) sts2rnc-sts.xsl $<

$(STS.MathML.rnc-sts): mathml3-%-sts.rnc:	$(STS.dir)/%.sts $(STS.dir)/%.ocd sts2rnc-sts.xsl
	xsltproc -o $@ --stringparam format MathML --stringparam thecd $(word 2, $^) sts2rnc-sts.xsl $<

$(STS.OM.rnc-arity):	om3-%-arity.rnc:	$(STS.dir)/%.sts $(STS.dir)/%.ocd sts2rnc-arity.xsl
	xsltproc -o $@ --stringparam format OpenMath --stringparam thecd $(word 2, $^) sts2rnc-arity.xsl $<

$(STS.MathML.rnc-arity): mathml3-%-arity.rnc:	$(STS.dir)/%.sts $(STS.dir)/%.ocd sts2rnc-arity.xsl
	xsltproc -o $@ --stringparam format MathML --stringparam thecd $(word 2, $^) sts2rnc-arity.xsl $<

$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@

echo:	
	echo $(STS.rnc)
