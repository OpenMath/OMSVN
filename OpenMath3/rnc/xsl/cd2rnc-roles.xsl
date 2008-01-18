<?xml version="1.0" encoding="utf-8"?>

<!-- an XSLT stylesheet for tranfsorming STS type  information in  Content 
     Dictionaries to RelaxNG grammar rules 
     Copyright (c) 2008 Michael Kohlhase licensed under the Gnu LGPL
    Revision:   $Id: sts2rnc-sts.xsl 529 2008-01-15 10:07:01Z kohlhase $
    $HeadURL: https://svn.openmath.org/OpenMath3/rnc/cd/sts2rnc-sts.xsl $
 -->

<xsl:stylesheet  version="1.0"
		 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:set="http://exslt.org/sets" 
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:func="http://exslt.org/functions" 
  xmlns:exsl="http://exslt.org/common" 
  xmlns:omcds="http://www.openmath.org/OpenMathCDS"
  xmlns:omcd="http://www.openmath.org/OpenMathCD"
  xmlns:om="http://www.openmath.org/OpenMath"
  extension-element-prefixes="func set exsl">

  <xsl:output method="text"/>
  <xsl:param name="format" select="'OpenMath'"/>

<xsl:variable name="symbol">
</xsl:variable>

  <xsl:template match="/">
<!--     <xsl:text>#     This is the Mathematical Markup Language (MathML) 3.0, an XML&#xA;</xsl:text>
    <xsl:text>#     application for describing mathematical notation and capturing&#xA;</xsl:text>
    <xsl:text>#     both its structure and content.&#xA;</xsl:text>
    <xsl:text>#&#xA;</xsl:text>
    <xsl:text>#     Copyright 1998-2007 World Wide Web Consortium&#xA;</xsl:text>
    <xsl:text>#        (Massachusetts Institute of Technology, Institut National de&#xA;</xsl:text>
    <xsl:text>#         Recherche en Informatique et en Automatique, Keio University).&#xA;</xsl:text>
    <xsl:text>#         All Rights Reserved.&#xA;</xsl:text>
    <xsl:text>#&#xA;</xsl:text>
    <xsl:text>#     Permission to use, copy, modify and distribute the RelaxNG schema for MathML3&#xA;</xsl:text>
    <xsl:text>#     and its accompanying documentation for any purpose and without fee is&#xA;</xsl:text>
    <xsl:text>#     hereby granted in perpetuity, provided that the above copyright notice&#xA;</xsl:text>
    <xsl:text>#     and this paragraph appear in all copies.  The copyright holders make&#xA;</xsl:text>
    <xsl:text>#     no representation about the suitability of the Schema for any purpose.&#xA;</xsl:text>
    <xsl:text>#&#xA;</xsl:text> -->
    <xsl:text>#     This file contains the role checking rules for the symbols&#xA;</xsl:text>
    <xsl:text>#     from the the content dictionary </xsl:text> 
    <xsl:value-of select="/omcds:CDSignatures/@cd"/><xsl:text>&#xA;</xsl:text>
    <xsl:text>#     It is provided "as is" without expressed or implied warranty.&#xA;</xsl:text>
    <xsl:text>#&#xA;</xsl:text>
    <xsl:text>#     Revision:   $Id: sts2rnc-sts.xsl 529 2008-01-15 10:07:01Z kohlhase $&#xA;</xsl:text>
    <xsl:text>#    $HeadURL: https://svn.openmath.org/OpenMath3/rnc/cd/sts2rnc-sts.xsl $ &#xA;&#xA;</xsl:text>
    <xsl:choose>
      <xsl:when test="$format='OpenMath'">
	<xsl:text>&#xA;namespace om = "http://www.openmath.org/OpenMath"&#xA;&#xA;</xsl:text>
      </xsl:when>
      <xsl:when test="$format='MathML'">
	<xsl:text>&#xA;namespace m  ="http://www.w3.org/1998/Math/MathML"&#xA;</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="omcd:CD">
    <xsl:apply-templates select="omcd:CDDefinition">
      <xsl:with-param name="cd" select="normalize-space(omcd:CDName)"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="omcd:CDDefinition">
    <!-- make the element definition -->
    <xsl:param name="cd"/>
    <xsl:variable name="name" select="normalize-space(omcd:Name)"/>
    <xsl:value-of select="concat($name,'_',$cd,'_elt')"/>
    <xsl:text> = element </xsl:text>
    <xsl:choose>
      <xsl:when test="$format='OpenMath'">
	<xsl:text>om:OMS {common.attributes,cdbase,</xsl:text>
      </xsl:when>
      <xsl:when test="$format='MathML'">
	<xsl:text>m:csymbol {MathML.Common.attrib,</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="concat('attribute cd {&quot;',$cd,'&quot;},')"/>
    <xsl:value-of select="concat('attribute name {&quot;',$name,'&quot;}')"/>
    <xsl:text>}&#xA;</xsl:text>
    <xsl:variable name="role">
      <xsl:choose>
	<xsl:when test="omcd:Role"><xsl:value-of select="normalize-space(omcd:Role)"/></xsl:when>
	<xsl:otherwise><xsl:text>norole</xsl:text></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="elt" select="concat($name,'_',$cd,'_elt')"/>
    <xsl:value-of select="concat('cd.',$role,' |= ',$elt)"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>


</xsl:stylesheet>
