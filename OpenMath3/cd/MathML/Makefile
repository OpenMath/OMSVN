PREFIX = ../..
XSLDIR = $(PREFIX)/xsl

CDS.ocd = $(shell ls *.ocd)
CDS.mtn = $(CDS.ocd:%.ocd=%.mtn)
CDS.mts = $(CDS.ocd:%.ocd=%.mts)
CDS.html = $(CDS.ocd:%.ocd=%.html)
CDS.omdoc = $(CDS.ocd:%.ocd=%.omdoc)


all: cds-overview.xml $(CDS.html)

$(CDS.html): %.html: %.ocd $(XSLDIR)/cd2html.xsl
	xsltproc -o $@ $(word 2, $^) $<

$(CDS.omdoc): %.omdoc: %.ocd $(XSLDIR)/cd2omdoc.xsl
	xsltproc -o $@ $(word 2, $^) $<

cds-overview.xml: cds.xml cds2overview.xsl $(CDS.ocd) 
	xsltproc -o $@ $(word 2, $^) $<

install: cds-overview.xml
	cp cds-overview.xml $(HOME)/vc/cvs/Math/Group/spec/xml

echo:
	echo $(CDS.mts)
