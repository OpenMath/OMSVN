PREFIX = ../..
XSLDIR = $(PREFIX)/xsl

CDS.ocd = $(shell ls *.ocd)
CDS.mtn = $(CDS.ocd:%.ocd=%.mtn)
CDS.mts = $(CDS.ocd:%.ocd=%.mts)
CDS.xhtml = $(CDS.ocd:%.ocd=%.xhtml)
CDS.omdoc = $(CDS.ocd:%.ocd=%.omdoc)
CDS.ocd.back = $(CDS.ocd:%.ocd=%.ocd.back)


all: cds-overview.xml $(CDS.xhtml) index.html

$(CDS.xhtml): %.xhtml: %.ocd $(XSLDIR)/cd2html.xsl
	saxon -o $@ $(word 2, $^) $<

$(CDS.omdoc): %.omdoc: %.ocd $(XSLDIR)/cd2omdoc.xsl
	xsltproc -o $@ $(word 2, $^) $<

$(CDS.ocd.back): %.ocd.back: %.omdoc $(XSLDIR)/omdoc2cd.xsl
	xsltproc -o $@ $(word 2, $^) $<

index.html: cds.xml cds2index.xsl $(CDS.ocd) 
	xsltproc -o $@ $(word 2, $^) $<

# cds-overview.xml: cds.xml cds2overview.xsl $(CDS.ocd) 
# 	xsltproc -o $@ $(word 2, $^) $<

# install: cds-overview.xml
# 	cp cds-overview.xml $(HOME)/vc/cvs/Math/Group/spec/xml

echo:
	echo $(CDS.mts)
