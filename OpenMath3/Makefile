RNC 	= $(shell ls *.rnc)
RNCXML 	= $(RNC:%.rnc=%rnc.xml)
RNCSIG 	= $(RNC:%.rnc=%.rng)
RNCXSD  = openmath3.xsd	
SPECINCL= $(RNC) $(RNCXML) $(RNCSIG) $(RNCXSD)

MOCDs = nums1,complex1,fns1,calculus1,arith1,set1,list1,integer1,minmax1,multiset1,\
	alg1,logic1,rounding1,quant1,relations1,limit1,veccalc1,transc1,s-data1,s-dist1,\
	linalg1,linalg2,setname1

HTML	= omstd30html.xml omstd30html-d.xml #primerom30html.xml

html:	$(HTML)

$(RNCXML): %rnc.xml: %.rnc 
		perl rnc2dbk $(firstword $<) > $@

$(RNCSIG): %.rng: %.rnc 
		java -jar trang.jar $(firstword $<) $@

$(RNCXSD): %.xsd: %.rnc
		java -jar trang.jar $(firstword $<) $@

omstd30html.xml: omstd30.xml omstd30.xsl $(SPECINCL)
	xsltproc -o $@ omstd30.xsl omstd30.xml

omstd30html-d.xml: omstd30.xml omstd30.xsl $(SPECINCL)
	xsltproc -o $@ --stringparam showdiffs true omstd30.xsl omstd30.xml

omstd30.tex: omstd30.xml omstd30tex.xsl $(SPECINCL)
	xsltproc -o $@ omstd30.xsl omstd30.xml

omstd30-d.tex: omstd30.xml omstd30tex.xsl $(SPECINCL)
	xsltproc -o $@ --stringparam showdiffs true omstd30.xsl omstd30.xml

primerom30html.xml: primerom30.xml primer.xsl
	xsltproc -o $@ primer.xsl primerom30.xml

clean: 	
	rm -f *~ *.log *.dvi *.aux *.out

distclean:	clean
		rm -f $(HTML) omstd30.tex
