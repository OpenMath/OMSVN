<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">



<xsl:import href="@stylesheet.uri"/>

<xsl:variable name="toc.section.depth">3</xsl:variable>
<xsl:param name="htmlhelp.encoding" select="'windows-1250'"/>
<xsl:param name="default.encoding" select="'windows-1250'"/>
<xsl:param name="saxon.character.representation" select="'native'"/>


<xsl:param name="html.stylesheet.type">text/css</xsl:param>
<xsl:param name="html.stylesheet" select="'primer.css'"/>
<xsl:param name="changelog">no</xsl:param>
<xsl:param name="section.autolabel" select="1"/>
 
<xsl:param name="shade.verbatim" select="1"/>


</xsl:stylesheet>

