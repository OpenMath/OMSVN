CD.dir = ../../cd/MathML
CD = $(shell cd $(CD.dir);ls *.ocd)
CD.OM.rnc-arity = $(CD:%.ocd=om3-%-arity.rnc)
CD.OM.rnc-sts = $(CD:%.ocd=om3-%-sts.rnc)
CD.MathML.rnc-arity = $(CD:%.ocd=mathml3-%-arity.rnc)
CD.MathML.rnc-sts = $(CD:%.ocd=mathml3-%-sts.rnc)

CD3 = $(shell cd $(CD.dir);ls *.cd3)
CD3.OM.rnc-arity = $(CD3:%.cd3=om3-%-arity.rnc)
CD3.OM.rnc-sts = $(CD3:%.cd3=om3-%-sts.rnc)
CD3.MathML.rnc-arity = $(CD3:%.cd3=mathml3-%-arity.rnc)
CD3.MathML.rnc-sts = $(CD3:%.cd3=mathml3-%-sts.rnc)


RNC = $(CD.OM.rnc-sts) $(CD.MathML.rnc-sts) $(CD.OM.rnc-arity) $(CD.MathML.rnc-arity) 
RNC3 = $(CD3.OM.rnc-sts) $(CD3.MathML.rnc-sts) $(CD3.OM.rnc-arity) $(CD3.MathML.rnc-arity) 

RNG = $(RNC:%.rnc=%.rng) 
RNG3 = $(RNC3:%.rnc=%.rng) 

all: $(RNC3) #rng

rng: $(RNG)

$(CD.OM.rnc-sts):	om3-%-sts.rnc:	$(CD.dir)/%.ocd $(CD.dir)/%.sts sts2rnc-sts.xsl
	xsltproc -o $@ --stringparam format OpenMath --stringparam sts $(word 2, $^) sts2rnc-sts.xsl $<

$(CD.MathML.rnc-sts): mathml3-%-sts.rnc: $(CD.dir)/%.ocd $(CD.dir)/%.sts sts2rnc-sts.xsl
	xsltproc -o $@ --stringparam format MathML --stringparam sts $(word 2, $^) sts2rnc-sts.xsl $<

$(CD.OM.rnc-arity):	om3-%-arity.rnc: $(CD.dir)/%.ocd $(CD.dir)/%.sts sts2rnc-arity.xsl
	xsltproc -o $@ --stringparam format OpenMath --stringparam sts $(word 2, $^) sts2rnc-arity.xsl $<

$(CD.MathML.rnc-arity): mathml3-%-arity.rnc: $(CD.dir)/%.ocd $(CD.dir)/%.sts sts2rnc-arity.xsl
	xsltproc -o $@ --stringparam format MathML --stringparam sts $(word 2, $^) sts2rnc-arity.xsl $<


$(CD3.OM.rnc-sts):	om3-%-sts.rnc:	$(CD.dir)/%.cd3 $(CD.dir)/%.sts sts2rnc-sts.xsl
	xsltproc -o $@ --stringparam format OpenMath --stringparam sts $(word 2, $^) sts2rnc-sts.xsl $<

$(CD3.MathML.rnc-sts): mathml3-%-sts.rnc: $(CD.dir)/%.cd3 $(CD.dir)/%.sts sts2rnc-sts.xsl
	xsltproc -o $@ --stringparam format MathML --stringparam sts $(word 2, $^) sts2rnc-sts.xsl $<

$(CD3.OM.rnc-arity):	om3-%-arity.rnc: $(CD.dir)/%.cd3 $(CD.dir)/%.sts sts2rnc-arity.xsl
	xsltproc -o $@ --stringparam format OpenMath --stringparam sts $(word 2, $^) sts2rnc-arity.xsl $<

$(CD3.MathML.rnc-arity): mathml3-%-arity.rnc: $(CD.dir)/%.cd3 $(CD.dir)/%.sts sts2rnc-arity.xsl
	xsltproc -o $@ --stringparam format MathML --stringparam sts $(word 2, $^) sts2rnc-arity.xsl $<

$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@

echo:	
	echo $(CD3)
#	echo $(CD.OM.rnc-arity)
