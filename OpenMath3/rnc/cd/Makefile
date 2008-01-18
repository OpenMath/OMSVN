CD.dir = ../../cd/MathML
XSL.dir = ../xsl
CD = $(shell cd $(CD.dir);ls *.ocd)
CDs = $(shell ls $(CD.dir)/*.ocd)
CD.OM.rnc-roles = $(CD:%.ocd=om3-%-roles.rnc)
CD.OM.rnc-arity = $(CD:%.ocd=om3-%-arity.rnc)
CD.OM.rnc-sts = $(CD:%.ocd=om3-%-sts.rnc)
CD.MathML.rnc-roles = $(CD:%.ocd=mathml3-%-roles.rnc)
CD.MathML.rnc-pragmatic = $(CD:%.ocd=mathml3-%-pragmatic.rnc)
CD.MathML.rnc-arity = $(CD:%.ocd=mathml3-%-arity.rnc)
CD.MathML.rnc-sts = $(CD:%.ocd=mathml3-%-sts.rnc)

RNC = $(CD.OM.rnc-roles) $(CD.MathML.rnc-roles)\
      $(CD.MathML.rnc-pragmatic)\
      $(CD.OM.rnc-arity) $(CD.MathML.rnc-arity)\
      $(CD.OM.rnc-sts) $(CD.MathML.rnc-sts) 

RNG = $(RNC:%.rnc=%.rng) 

INCL.MathML = mathml3-roles.rnc mathml3-pragmatic.rnc mathml3-arity.rnc mathml3-sts.rnc
INCL.OM = om3-roles.rnc om3-arity.rnc om3-sts.rnc
INCL = $(INCL.MathML) $(INCL.OM)

all: $(INCL) $(RNC) #rng

rng: $(RNG)

mathml3-roles.rnc: $(CDs)
	rm -f $@
	@for d in $(CD.MathML.rnc-roles); do  (echo "include \"$$d\"" >> $@) done
mathml3-pragmatic.rnc: $(CDs)
	rm -f $@
	@for d in $(CD.MathML.rnc-pragmatic); do  (echo "include \"$$d\"" >> $@) done
mathml3-arity.rnc: $(CDs)
	rm -f $@
	@for d in $(CD.MathML.rnc-arity); do  (echo "include \"$$d\"" >> $@) done
mathml3-sts.rnc: $(CDs)
	rm -f $@
	@for d in $(CD.MathML.rnc-sts); do  (echo "include \"$$d\"" >> $@) done
om3-roles.rnc: $(CDs)
	rm -f $@
	@for d in $(CD.MathML.rnc-roles); do  (echo "include \"$$d\"" >> $@) done
om3-arity.rnc: $(CDs)
	rm -f $@
	@for d in $(CD.MathML.rnc-ariy); do  (echo "include \"$$d\"" >> $@) done
om3-sts.rnc: $(CDs)
	rm -f $@
	@for d in $(CD.MathML.rnc-sts); do  (echo "include \"$$d\"" >> $@) done

$(CD.OM.rnc-sts):	om3-%-sts.rnc:	$(CD.dir)/%.ocd $(CD.dir)/%.sts $(XSL.dir)/sts2rnc-sts.xsl
	xsltproc -o $@ --stringparam format OpenMath --stringparam sts $(word 2, $^) $(word 3,$^) $<

$(CD.MathML.rnc-sts): mathml3-%-sts.rnc: $(CD.dir)/%.ocd $(CD.dir)/%.sts $(XSL.dir)/sts2rnc-sts.xsl
	xsltproc -o $@ --stringparam format MathML --stringparam sts $(word 2, $^) $(word 3,$^) $<

$(CD.OM.rnc-arity):	om3-%-arity.rnc: $(CD.dir)/%.ocd $(CD.dir)/%.sts $(XSL.dir)/sts2rnc-arity.xsl
	xsltproc -o $@ --stringparam format OpenMath --stringparam sts $(word 2, $^) $(word 3,$^) $<

$(CD.MathML.rnc-arity): mathml3-%-arity.rnc: $(CD.dir)/%.ocd $(CD.dir)/%.sts $(XSL.dir)/sts2rnc-arity.xsl
	xsltproc -o $@ --stringparam format MathML --stringparam sts $(word 2, $^) $(word 3,$^) $<

$(CD.MathML.rnc-pragmatic): mathml3-%-pragmatic.rnc: $(CD.dir)/%.ocd $(XSL.dir)/cd2rnc-pragmatic.xsl
	xsltproc -o $@ $(word 2,$^) $<

$(CD.OM.rnc-roles): om3-%-roles.rnc: $(CD.dir)/%.ocd $(XSL.dir)/cd2rnc-roles.xsl
	xsltproc -o $@ --stringparam format OpenMath $(word 2,$^) $<

$(CD.MathML.rnc-roles): mathml3-%-roles.rnc: $(CD.dir)/%.ocd $(XSL.dir)/cd2rnc-roles.xsl
	xsltproc -o $@ --stringparam format MathML $(word 2,$^) $<

$(RNG): %.rng: %.rnc
	trang -I rnc -O rng $< $@

echo:	
	echo $(CDs)
#	echo $(CD.OM.rnc-arity)
