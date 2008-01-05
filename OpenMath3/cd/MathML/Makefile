#PREFIX = ../..
#XSLDIR = $(PREFIX)/xsl

CDS.ocd = $(shell ls *.ocd)
#CDS.mcd = $(CDS.ocd:%.ocd=%.mcd)
CDS.mts = $(CDS.ocd:%.ocd=%.mts)

all: $(CDS.mts)

$(CDS.mts): %.mts: %.mcd convert.xsl
	xsltproc -o $@ convert.xsl $(firstword $<)

echo:
	echo $(CDS.mts)
