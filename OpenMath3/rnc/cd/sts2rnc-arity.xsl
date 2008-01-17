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
  <xsl:param name="sts"/>
  <xsl:variable name="here" select="/"/>

<xsl:variable name="symbol">
  <xsl:choose>
    <xsl:when test="$format='OpenMath'"><xsl:text>om:OMS</xsl:text></xsl:when>
    <xsl:when test="$format='MathML'"><xsl:text>m:csymbol</xsl:text></xsl:when>
  </xsl:choose>
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
    <xsl:text>#     This file contains the arity checking rules for the symbols&#xA;</xsl:text>
    <xsl:text>#     generated from the STS types for the content dictionary </xsl:text> 
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
    <xsl:message>hey</xsl:message>
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
    <xsl:value-of select="$symbol"/>
    <xsl:text>{attribute cd {"</xsl:text>
    <xsl:value-of select="$cd"/>
    <xsl:text>"}, attribute name {"</xsl:text>
    <xsl:value-of select="$name"/>
    <xsl:text>"}}&#xA;</xsl:text>
    <!-- extend the relevant classes with it -->
    <xsl:variable name="sig" select="exsl:node-set(document($sts,$here))//omcds:Signature[normalize-space(@name)=$name]/om:OMOBJ"/>
    <xsl:variable name="role" select="normalize-space(omcd:Role)"/>
    <xsl:variable name="token" select="normalize-space(omcd:Pragmatic/omcd:Token)"/>
    <xsl:message>token: <xsl:value-of select="$token"/></xsl:message>
    <xsl:variable name="elt" select="concat($name,'_',$cd,'_elt')"/>
    <xsl:choose>
      <xsl:when test="$role='constant'">
	<xsl:value-of select="concat('cd.constants |= ',$elt)"/>
      </xsl:when>
      <xsl:when test="$role='binder'">
	<xsl:value-of select="concat('cd.binders |= ',$elt)"/>
      </xsl:when>
      <xsl:when test="$role='application'">
	<xsl:choose> 
	  <xsl:when test="$sig/om:OMA[om:OMS[1 and @cd='sts' and @name='mapsto'] and 
		                      om:OMA[2 and om:OMS[1 and @cd='sts' and @name='nassoc']]]">
	    <xsl:value-of select="concat('cd.nary |= ',$elt)"/>
	  </xsl:when>
	  <xsl:when test="$sig/om:OMA[om:OMS[1 and @cd='sts' and @name='mapsto'] and count(*)=3]">
	    <xsl:value-of select="concat('cd.unary |= ',$elt)"/>
	  </xsl:when>
	  <xsl:when test="$sig/om:OMA[om:OMS[1 and @cd='sts' and @name='mapsto'] and count(*)=4]">
	    <xsl:value-of select="concat('cd.binary |= ',$elt)"/>
	  </xsl:when>
	  <xsl:when test="$sig/om:OMA[om:OMS[1 and @cd='sts' and @name='mapsto'] and count(*)=5]">
	    <xsl:value-of select="concat('cd.ternary |= ',$elt)"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:message>unrecognized arity</xsl:message>
	    <xsl:text>unrecognized arity</xsl:text>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:when test="$role='semantic-attribution' or $role='semantic-attribution'">
	<xsl:value-of select="concat('cd.key |= ',$elt)"/>
      </xsl:when>
      <xsl:when test="$role='error'">
	<xsl:value-of select="concat('cd.errors |= ',$elt)"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:message>role <xsl:value-of select="$role"/> unsupported!</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
