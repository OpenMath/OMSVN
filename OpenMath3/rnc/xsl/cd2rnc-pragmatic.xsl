<?xml version="1.0" encoding="utf-8"?>

<!-- an XSLT stylesheet for tranfsorming STS type  information in  Content 
     Dictionaries to RelaxNG grammar rules 
     Copyright (c) 2008 Michael Kohlhase licensed under the Gnu LGPL
    Revision:   $Id: sts2rnc-sts.xsl 529 2008-01-15 10:07:01Z kohlhase $
    $HeadURL: https://svn.openmath.org/OpenMath3/rnc/cd/sts2rnc-sts.xsl $
 -->

<xsl:stylesheet  version="1.0"
		 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:omcd="http://www.openmath.org/OpenMathCD">

  <xsl:output method="text"/>

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
    <xsl:text>#     This file contains the token element definitions for the symbols&#xA;</xsl:text>
    <xsl:text>#     generated from the content dictionary </xsl:text> 
    <xsl:value-of select="/omcd:CD/omcd:CDName"/><xsl:text>&#xA;</xsl:text>
    <xsl:text>#     It is provided "as is" without expressed or implied warranty.&#xA;</xsl:text>
    <xsl:text>#&#xA;</xsl:text>
    <xsl:text>#     Revision:   $Id: sts2rnc-sts.xsl 529 2008-01-15 10:07:01Z kohlhase $&#xA;</xsl:text>
    <xsl:text>#    $HeadURL: https://svn.openmath.org/OpenMath3/rnc/cd/sts2rnc-sts.xsl $ &#xA;&#xA;</xsl:text>
    <xsl:text>&#xA;namespace m  ="http://www.w3.org/1998/Math/MathML"&#xA;</xsl:text>
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
    <xsl:variable name="token" select="normalize-space(omcd:Pragmatic/omcd:Token)"/>
    <xsl:if test="$token!=''">
      <xsl:value-of select="concat($name,'_',$cd,'_elt',' |= element m:',$token,' {MathML.Common.attrib}&#xA;')"/>
    </xsl:if>
    <xsl:variable name="role" select="normalize-space(omcd:Role)"/>
    <xsl:variable name="elt" select="concat($name,'_',$cd,'_elt')"/>
    <xsl:value-of select="concat('token.',$role,' |= ',$elt,'&#xA;')"/>
  </xsl:template>


</xsl:stylesheet>
