#!/bin/sh

sed -e "s/-\\([0-9]* {\\\\field{\\\\\\*\\\\fldinst  EQ\\)/\\1/g" $1 >$1.tmp
mv $1.tmp $1