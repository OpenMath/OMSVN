PREFIX = ../..
XSLDIR = $(PREFIX)/xsl

CDS.ocd = $(shell ls *.ocd)
CDS.mcd = $(CDS.ocd:%.ocd=%.mcd)

all = mcd

mcd: $(CDS.mcd)

$(CDS.mcd): %.mcd: %.ocd $(XSLDIR)/ocd2mcd.xsl $(XSLDIR)/om2mml.xsl
	xsltproc -o $@ $(XSLDIR)/ocd2mcd.xsl $(firstword $<)
