PREFIX = ../..
XSLDIR = $(PREFIX)/xsl

CDS.ocd = $(shell ls *.ocd)
#CDS.mcd = $(CDS.ocd:%.ocd=%.mcd)
CDS.mts = $(CDS.ocd:%.ocd=%.mts)

all = $(CDS.mts)

#$(CDS.mcd): %.mcd: %.ocd $(XSLDIR)/ocd2mcd.xsl $(XSLDIR)/om2mml.xsl
#	xsltproc -o $@ $(XSLDIR)/ocd2mcd.xsl $(firstword $<)

$(CDS.mts): %.mts: %.mcd convert.xsl
	xsltproc -o $@ convert.xsl $(firstword $<)

