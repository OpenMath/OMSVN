<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:exsl="http://exslt.org/common" 
  xmlns:str="http://exslt.org/strings"
  xmlns:ocd="http://www.openmath.org/OpenMathCD"
  extension-element-prefixes="exsl str"
  exclude-result-prefixes="m ocd">

  <xsl:preserve-space elements="m:*"/>

  <xsl:output method="xml" indent="yes" 
    omit-xml-declaration="yes"
    cdata-section-elements="eg"/>
  <xsl:variable name="here" select="/"/>

  <xsl:template match="/">
    <div2 id="contm_operators">
      <head>The MathML3 Content Dictionaries and Operators</head>
      
      <p>We will now give an overview over the MathML3 symbols: they are grouped into content
      dictionaries that broadly reflect the area of mathematics from which they come.</p>
      <ednote>
        <name>MiKo</name>
        <edtext>
	  The list is generated from the MathML3 Content Dictionaries at 
	  <loc href="http://svn.openmath.org/OpenMath3/cd/MathML/">http://svn.openmath.org/OpenMath3/cd/MathML/</loc>. These are the result of merging material from the MathML2 and OpenMath2 content dictionaries, they are under review. The presentation here will improve with the content dictionary editorial process.  
        </edtext>
      </ednote>
      <xsl:apply-templates select="mathml-cds/cd"/>
    </div2>
  </xsl:template>

  <xsl:template match="cd">
    <xsl:variable name="file" select="."/>
    <xsl:message>reading <xsl:value-of select="$file"/></xsl:message>
    <xsl:apply-templates select="exsl:node-set(document($file,$here))//ocd:CD">
      <xsl:with-param name="copy" select="str:tokenize(@copy)"/>
      <xsl:with-param name="prune" select="@prune"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="ocd:CD">
    <xsl:param name="copy"/>
    <xsl:param name="prune"/>
    <div3 id="contm.{ocd:CDName}">
      <head>The MathML Content Dictionary <xsl:value-of select="ocd:CDName"/></head>
      <p><xsl:apply-templates select="ocd:Description"/></p>
      <xsl:apply-templates select="ocd:CDDefinition">
        <xsl:with-param name="prune" select="$prune"/>
        <xsl:with-param name="copy" select="$copy"/>
        <xsl:with-param name="cdname" select="ocd:CDName"/>
      </xsl:apply-templates>
    </div3>
  </xsl:template>

  <xsl:template match="ocd:CDDefinition">
    <xsl:param name="copy"/>
    <xsl:param name="prune"/>
    <xsl:param name="cdname"/>
    <xsl:variable name="def" select="."/>
    <xsl:variable name="token" select="ocd:Pragmatic/ocd:Token"/>
    <xsl:if test="not($token) or not(contains($prune,$token))"> 
      <div4 id="contm.{$token}">
	<head>
	  <code>&lt;csymbol cd=&quot;<xsl:value-of select="$cdname"/>&quot;&gt;<xsl:value-of select="ocd:Name"/>&lt;/csymbol&gt;</code>
	  <xsl:if test="$token">(<el><xsl:value-of select="$token"/></el>)</xsl:if>
	</head>
	<p><xsl:apply-templates select="ocd:Description"/></p>
	<xsl:for-each select="$copy">
	  <xsl:variable name="id" select="./text()"/>
        <xsl:apply-templates select="$def//*[@id=$id]" mode="speccopy"/>
      </xsl:for-each>
    </div4>
  </xsl:if>
  </xsl:template>

  <!-- copying CD elements for the MathML3 spec -->

  <xsl:template match="ocd:MMLexample" mode="speccopy">
    <xsl:apply-templates mode="speccopy"/>
  </xsl:template>

  <xsl:template match="ocd:description" mode="speccopy">
    <p><xsl:apply-templates mode="speccopy"/></p>
  </xsl:template>

  <xsl:template match="m:math" mode="speccopy">
    <eg role="mathml"><xsl:apply-templates mode="tostring"/></eg>
  </xsl:template>

  <!-- converting MathML elements to strings -->
  
  <xsl:template match="m:*" mode="tostring">
    <xsl:value-of select="concat('&lt;',name())"/>
    <xsl:for-each select="@*">
      <xsl:value-of select="concat(' ',name(),'=&quot;',.,'&quot;')"/>
    </xsl:for-each>
    <xsl:value-of select="'&gt;'"/>
    <xsl:apply-templates select="*|text()" mode="tostring"/>
    <xsl:value-of select="concat('&lt;/',name(),'&gt;')"/>

  </xsl:template>

  <xsl:template match="text()" mode="tostring">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
