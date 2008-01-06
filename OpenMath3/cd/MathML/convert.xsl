<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="mcd">
    <mcd><xsl:apply-templates/></mcd>
  </xsl:template>


  <xsl:template match="MMLdefinition">
    <xsl:variable name="name" select="name"/>
    <xsl:for-each select="rendering">
      <rendering name="{$name}">
	<xsl:copy-of select="*|text()"/>
      </rendering>
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
  
