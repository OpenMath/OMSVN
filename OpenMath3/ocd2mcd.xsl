<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:ocd="http://www.openmath.org/OpenMathCD"
  xmlns:mcd="http://www.w3.org/ns/mathml-cd"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <xsl:comment>This MathML CD is automatically generated from an OpenMath CD. Edit at your own risk.</xsl:comment>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ocd:CD">
    <mcd:mcd version="3.0">
      <xsl:attribute name="xml:id"><xsl:value-of select="ocd:CDName"/></xsl:attribute>
      <xsl:attribute name="review-date"><xsl:value-of select="ocd:CDReviewdate"/></xsl:attribute>
      <xsl:attribute name="revision-date"><xsl:value-of select="ocd:CDRevisiondate"/></xsl:attribute>
      <xsl:attribute name="cdbase"><xsl:value-of select="ocd:CDBase"/></xsl:attribute>
      <xsl:attribute name="status"><xsl:value-of select="ocd:CDStatus"/></xsl:attribute>
      <xsl:attribute name="date"><xsl:value-of select="ocd:CDDate"/></xsl:attribute>
      <xsl:apply-templates select="ocd:Description"/>
      <xsl:apply-templates select="ocd:CDDefinition"/>
    </mcd:mcd>
  </xsl:template>

  <xsl:template match="ocd:CDDefinition">
    <mcd:MMLDefinition>
      <xsl:attribute name="xml:id"><xsl:value-of select="ocd:CDName"/></xsl:attribute>
      <xsl:attribute name="cdrole"><xsl:value-of select="ocd:Role"/></xsl:attribute>
      
</xsl:stylesheet>
