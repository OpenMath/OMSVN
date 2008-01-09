<?xml version="1.0" encoding="utf-8"?>

<!-- an XSLT stylesheet for tranfsorming arity information in MathML3 Content 
     Dictionaries to RelaxNG grammar rules 
     Copyright (c) 2007 Michael Kohlhase licensed under the Gnu LGPL -->

<xsl:stylesheet  version="1.0"
		 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:set="http://exslt.org/sets" 
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:func="http://exslt.org/functions" 
  xmlns:exsl="http://exslt.org/common" 
  xmlns:omcd="http://www.openmath.org/OpenMathCDS"
  xmlns:om="http://www.openmath.org/OpenMath"
  extension-element-prefixes="func set exsl">

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:text>#     This is the Mathematical Markup Language (MathML) 3.0, an XML&#xA;</xsl:text>
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
    <xsl:text>#&#xA;</xsl:text>
    <xsl:text>#     This file contains the arity checking rules for the symbols&#xA;</xsl:text>
    <xsl:text>#     from the STS types for the content dictionary </xsl:text> 
    <xsl:value-of select="/omcd:CDSignatures/@cd"/><xsl:text>&#xA;</xsl:text>
    <xsl:text>#     It is provided "as is" without expressed or implied warranty.&#xA;</xsl:text>
    <xsl:text>#&#xA;</xsl:text>
    <xsl:text>#     Revision:   $Id$&#xA;</xsl:text>
    <xsl:text>&#xA;namespace om = "http://www.openmath.org/OpenMath"</xsl:text>
    <xsl:text>&#xA;namespace m  ="http://www.w3.org/1998/Math/MathML"&#xA;</xsl:text>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="omcd:CDSignatures">
    <!-- define abbreviations for the elements -->
    <xsl:variable name="cd" select="@cd"/>
    <xsl:for-each select="set:distinct(descendant::omcd:Signature/@name)"> 
     <xsl:value-of select="concat(.,'_',$cd,'_elt')"/>
      <xsl:text> = </xsl:text>
	<xsl:text>element om:OMS {&#xA;</xsl:text>
	<xsl:text>        attribute cd {"</xsl:text>
      	<xsl:value-of select="$cd"/>
	<xsl:text>"},&#xA;</xsl:text>
	<xsl:text>        attribute name {"</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>"}}&#xA;</xsl:text>
	<xsl:text> |    </xsl:text>
	<xsl:text>element m:csymbol {&#xA;</xsl:text>
	<xsl:text>        attribute cd {"</xsl:text>
      	<xsl:value-of select="$cd"/>
	<xsl:text>"},&#xA;</xsl:text>
	<xsl:text>        attribute name {"</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>"}}&#xA;</xsl:text>
    </xsl:for-each>

    <xsl:apply-templates select="omcd:Signature">
      <xsl:with-param name="cd" select="$cd"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="omcd:Signature">
    <xsl:param name="cd"/>
    <xsl:apply-templates select="om:OMOBJ/*[1]" mode="rnc">
      <xsl:with-param name="elt" select="concat(@name,'_',$cd,'_elt')"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="om:OMS" mode="rnc">
    <xsl:param name="elt"/>
    <xsl:value-of select="concat(@name,'_',@cd,'_type',' |= ',$elt,'&#xA;')"/>
  </xsl:template>

  <xsl:template match="om:OMV" mode="rnc">
    <xsl:param name="elt"/>
    <xsl:value-of select="concat(@name,'_type',' |= ',$elt,'&#xA;')"/>
  </xsl:template>

  <xsl:template match="om:OMA[om:OMS[1 and @name='mapsto' and @cd='sts']]" mode="rnc">
    <xsl:param name="elt"/>
    <xsl:apply-templates select="*[position()=last()]" mode="type"/>
    <xsl:text> |= element om:OMA {</xsl:text>
    <xsl:value-of select="$elt"/>
    <xsl:text>,</xsl:text>
    <xsl:for-each select="*[position() &gt; 1 and position()!=last()]">
      <xsl:apply-templates select="." mode="type"/>
      <xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
    </xsl:for-each>
    <xsl:text>}&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="om:OMA[om:OMS[1 and @name='bind' and @cd='sts']]" mode="rnc">
    <xsl:param name="elt"/>
    <xsl:apply-templates select="*[position()=last()]" mode="type"/>
    <xsl:text> |= element om:OMBIND {</xsl:text>
    <xsl:value-of select="$elt"/>
    <xsl:text>, OMBVAR,</xsl:text>
    <xsl:apply-templates select="*[2]" mode="type"/>
    <xsl:text>}&#xA;</xsl:text>
  </xsl:template>

  <!-- printing types --> 

  <xsl:template match="om:OMA[om:OMS[1 and @name='mapsto' and @cd='sts']]" mode="type">
    <xsl:text>function_type</xsl:text>
  </xsl:template>

  <xsl:template match="om:OMS" mode="type">
    <xsl:value-of select="concat(@name,'_',@cd,'_type')"/>
  </xsl:template>

  <xsl:template match="om:OMV" mode="type">
    <xsl:value-of select="concat(@name,'_type')"/>
  </xsl:template>

  <xsl:template match="om:OMA[om:OMS[1 and @cd='sts' and (@name='nassoc' or @name='nary')]]" mode="type">
    <xsl:apply-templates select="*[2]" mode="type"/>
    <xsl:text>*</xsl:text>
  </xsl:template>

  <xsl:template match="om:OMA[om:OMS[1 and @cd='sts' and @name='structure']]" mode="type">
    <xsl:apply-templates select="*[2]" mode="type"/>
  </xsl:template>

  <!-- warnings for unimplemented cases -->
  <xsl:template match="om:*" mode="rnc">
    <xsl:message> sts2rnc.xsl: rnc rule generation for <xsl:value-of select="local-name()"/> not implemented!</xsl:message>
  </xsl:template>

  <xsl:template match="om:*" mode="type">
    <xsl:message> sts2rnc.xsl: type printing for <xsl:value-of select="local-name()"/> not implemented!</xsl:message>
  </xsl:template>
</xsl:stylesheet>
