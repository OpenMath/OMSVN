<?xml version="1.0" encoding="utf-8"?>

<!-- an XSLT stylesheet for tranfsorming arity information in MathML3 Content 
     Dictionaries to RelaxNG grammar rules 
     Copyright (c) 2007 Michael Kohlhase licensed under the Gnu LGPL -->

<xsl:stylesheet  version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:func="http://exslt.org/functions" 
  extension-element-prefixes="func">

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
    <xsl:text>#     from the content dictionary </xsl:text> 
    <xsl:value-of select="/mcd/@xml:id"/><xsl:text>&#xA;</xsl:text>
    <xsl:text>#     It is provided "as is" without expressed or implied warranty.&#xA;</xsl:text>
    <xsl:text>#&#xA;</xsl:text>
    <xsl:text>#     Revision:   $Id$&#xA;</xsl:text>
    <xsl:value-of select="m:extend-class(//MMLdefinition[@cdrole='constant'],'cd.token.class')"/>
    <xsl:value-of select="m:extend-class(//MMLdefinition[@cdrole='application' and @arity='1'],'cd.token.unary.class')"/>
    <xsl:value-of select="m:extend-class(//MMLdefinition[@cdrole='application' and @arity='2'],'cd.token.binary.class')"/>
    <xsl:value-of select="m:extend-class(//MMLdefinition[@cdrole='application' and @arity='nary'],'cd.token.nary.class')"/>
    <xsl:value-of select="m:extend-class(//MMLdefinition[@cdrole='binder'],'cd.binder.class')"/>
    <xsl:value-of select="m:extend-class(//MMLdefinition[@cdrole='key'],'cd.key.class')"/>
    <xsl:value-of select="m:extend-class(//MMLdefinition[@cdrole='error'],'cd.error.class')"/>
    <!--     <xsl:value-of select="m:extend-class(//MMLdefinition[@container],'cd.container.class')"/> -->

    <!-- warnings -->
    <xsl:for-each select="//MMLdefinition[not(@cdrole='key' or 
                                              @cdrole='error' or 
                                              @cdrole='binder' or 
                                              @cdrole='application' or 
                                              @cdrole='constant')]">
      <xsl:value-of select="concat('&#xA;# role ',@cdrole,' for symbol ',name,' not recognized!')"/>
      <xsl:message>
        <xsl:value-of select="concat('&#xA;# role ',@cdrole,' for symbol ',name,' not recognized!')"/>
      </xsl:message>
    </xsl:for-each>
    <xsl:for-each select="//MMLdefinition[not(@cdrole)]">
      <xsl:value-of select="concat('# no role for symbol ',name,' specified!')"/>
      <xsl:message><xsl:value-of select="concat('# no role for symbol ',name,' specified!')"/></xsl:message>
    </xsl:for-each>
    
    <!-- token element definitions -->
    <xsl:text>&#xA;&#xA;</xsl:text>
    <xsl:text># the element definitions for the token elements</xsl:text>
    <xsl:for-each select="//MMLdefinition">
      <xsl:value-of select="concat('&#xA;',name,'.content = Token.type')"/>
      <xsl:for-each select="MMLattribute">
        <xsl:value-of select="concat(', attribute ',attname,' {MathMLtype}?')"/>
      </xsl:for-each>
      <xsl:choose>
        <xsl:when test="@container and @arity='1'"><xsl:text>,ContExp?</xsl:text></xsl:when>
        <xsl:when test="@container and @arity='2'"><xsl:text>,(ContExp,ContExp)?</xsl:text></xsl:when>
        <xsl:when test="@container and @arity='nary'"><xsl:text>,ContExp*</xsl:text></xsl:when>
      </xsl:choose>
      <xsl:value-of select="concat('&#xA;',name,'.token = element ',name,' {',name,'.content}')"/>
    </xsl:for-each>
  </xsl:template>

  <func:function name="m:extend-class">
    <xsl:param name="tokens"/>
    <xsl:param name="class"/>
    <xsl:if test="count($tokens)&gt;0">
      <func:result>
        <xsl:value-of select="concat('&#xA;',$class,' |= ')"/>
        <xsl:for-each select="$tokens">
          <xsl:value-of select="concat(name,'.token')"/>
          <xsl:if test="position()!=last()"><xsl:text> | </xsl:text></xsl:if>
        </xsl:for-each>
      </func:result>
    </xsl:if>
  </func:function>

</xsl:stylesheet>
