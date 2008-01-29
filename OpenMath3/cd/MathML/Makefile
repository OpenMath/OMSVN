PREFIX = ../..
XSLDIR = $(PREFIX)/xsl

CDS.ocd = $(shell ls *.ocd)
CDS.mtn = $(CDS.ocd:%.ocd=%.mtn)
CDS.mts = $(CDS.ocd:%.ocd=%.mts)
CDS.html = $(CDS.ocd:%.ocd=%.html)


all: cds-overview.xml $(CDS.html)

$(CDS.html): %.html: %.ocd $(XSLDIR)/cd2html.xsl
	xsltproc -o $@ $(word 2, $^) $<

$(CDS.mtn): %.mtn: %.mcd convert.xsl
	xsltproc -o $@ convert.xsl $<

cds-overview.xml: cds.xml $(CDS.ocd) cds2overview.xsl
	xsltproc -o $@ cds2overview.xsl $<

install: cds-overview.xml
	cp cds-overview.xml $(HOME)/vc/cvs/Math/Group/spec/xml

echo:
	echo $(CDS.mts)
