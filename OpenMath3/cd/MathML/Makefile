#PREFIX = ../..
#XSLDIR = $(PREFIX)/xsl

CDS.ocd = $(shell ls *.ocd)
CDS.mtn = $(CDS.ocd:%.ocd=%.mtn)
CDS.mts = $(CDS.ocd:%.ocd=%.mts)

all: $(CDS.mtn)

$(CDS.mtn): %.mtn: %.mcd convert.xsl
	xsltproc -o $@ convert.xsl $(firstword $<)

echo:
	echo $(CDS.mts)
