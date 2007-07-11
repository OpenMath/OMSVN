RNC 	= $(shell ls *.rnc)
RNCXML 	= $(RNC:%.rnc=%rnc.xml)
RNCSIG 	= $(RNC:%.rnc=%.rng)
RNCXSD  = openmath3.xsd	
SPECINCL= $(RNC) $(RNCXML) $(RNCSIG) $(RNCXSD)

HTML	= omstd30html.xml omstd30html-d.xml #primerom30html.xml

html:	$(HTML)

$(RNCXML): %rnc.xml: %.rnc 
		perl rnc3dbk $(firstword $<) > $@

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
