#!/bin/sh

###############################################################################
#
# Verify and Set Required Environment Variables 
#   
if [ "$ANT_HOME" = "" ] ; then
  ANT_HOME=.
fi

if [ "$JAVA_HOME" = "" ] ; then
  echo You must set JAVA_HOME to point at your Java Development Kit installation
  exit 1
fi


###############################################################################
#
# Set Up The Runtime Classpath
#

JAVA_CLASSPATH=${JAVA_HOME}/lib/tools.jar

for I in ${ANT_HOME}/lib/*.jar
do
 JAVA_CLASSPATH=${JAVA_CLASSPATH}:"$I"
done


###############################################################################
#
# Execute The Requested Build 
#

$JAVA_HOME/bin/java $ANT_OPTS -classpath $JAVA_CLASSPATH org.apache.tools.ant.Main -Dant.home=$ANT_HOME $*

