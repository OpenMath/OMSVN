~!/bin/sh

jade -t tex -d mathmlx.dsl xml.dcl mathmlx.dtd $*
