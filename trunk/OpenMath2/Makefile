RNC 	= $(shell ls *.rnc)
RNCXML 	= $(RNC:%.rnc=%rnc.xml)
RNCSIG 	= $(RNC:%.rnc=%.rng)
RNCXSD  = openmath2.xsd	
HTML	= omstd20html.xml omstd20html-d.xml primerom20html.xml
html:	$(HTML)

$(RNCXML): %rnc.xml: %.rnc 
		perl rnc2dbk $(firstword $<) > $@

$(RNCSIG): %.rng: %.rnc 
		java -jar trang.jar $(firstword $<) $@

$(RNCXSD): %.xsd: %.rnc
		java -jar trang.jar $(firstword $<) $@

omstd20html.xml: omstd20.xml omstd20.xsl
	xsltproc -o $@ omstd20.xsl omstd20.xml

omstd20html-d.xml: omstd20.xml omstd20.xsl
	xsltproc -o $@ --stringparam showdiffs true omstd20.xsl omstd20.xml

omstd20.tex: omstd20.xml omstd20tex.xsl
	xsltproc -o $@ omstd20.xsl omstd20.xml

omstd20-d.tex: omstd20.xml omstd20tex.xsl
	xsltproc -o $@ --stringparam showdiffs true omstd20.xsl omstd20.xml

primerom20html.xml: primerom20.xml primer.xsl
	xsltproc -o $@ primer.xsl primerom20.xml

clean: 	
	rm -f *~ *.log *.dvi *.aux *.out

distclean:	clean
		rm -f $(HTML) omstd20.tex
