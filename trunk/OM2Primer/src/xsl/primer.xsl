<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
  <!--
<xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets/xhtml/docbook.xsl"/>
-->
<xsl:import href="omstd20.xsl"/>
<xsl:param name="html.stylesheet.type">text/css</xsl:param>
<xsl:param name="html.stylesheet" select="primer.css"/>
<xsl:param name="changelog">no</xsl:param>
<xsl:param name="section.autolabel" select="1"/>
 
<xsl:param name="shade.verbatim" select="1"/>
</xsl:stylesheet>

