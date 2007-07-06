#!/bin/sh

jade -t rtf -d mathmlx.dsl xml.dcl mathmlx.dtd $*

./rtffix `basename $1 .mml`.rtf
