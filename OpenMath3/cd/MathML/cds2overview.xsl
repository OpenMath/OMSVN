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
	  <loc href="http://svn.openmath.org/OpenMath3/cd/MathML/">http://svn.openmath.org/OpenMath3/cd/MathML/</loc>. 
	  These are the result of merging material from the MathML2 and 
	  OpenMath2 content dictionaries, they are under review. We have 
	  already done some work on the <code>arith1</code> CD to show how 
	  the extracted material will look in the MathML3 specification. The 
	  presentation of the other CDs will improve with the content dictionary 
	  editorial process.  
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
      <xsl:apply-templates select="ocd:discussion/*" mode="speccopy"/>
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
    <xsl:variable name="elem" select="ocd:Pragmatic/ocd:Element"/>
    <xsl:variable name="pragmatic">
      <xsl:choose>
	<xsl:when test="ocd:Pragmatic/@specref">
	  <xsl:value-of select="ocd:Pragmatic/@specref"/>
	</xsl:when>
	<xsl:when test="$elem"><xsl:value-of select="$elem"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="ocd:Name"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="attr">
      <xsl:for-each select="ocd:Pragmatic/ocd:Attribute/ocd:Prescribed">
	<xsl:value-of select="concat(' type=&quot;',.,'&quot;')"/>
      </xsl:for-each>
    </xsl:variable>      
    <xsl:if test="not($pragmatic) or not(contains($prune,$pragmatic))"> 
      <xsl:variable name="divid">
	<xsl:value-of select="concat('contm.',$pragmatic)"/>
	<xsl:if test="ocd:Pragmatic/ocd:Attribute/ocd:Prescribed">
	  <xsl:value-of select="concat('.',translate(ocd:Pragmatic/ocd:Attribute/ocd:Prescribed,'&quot;',''))"/>
	</xsl:if>
      </xsl:variable>
      <div4 id="{$divid}">
	<head>
	  <code>&lt;csymbol cd=&quot;<xsl:value-of select="$cdname"/>&quot;&gt;<xsl:value-of select="ocd:Name"/>&lt;/csymbol&gt;</code>
	  <xsl:if test="$elem">
	    <xsl:text> (</xsl:text>
	    <xsl:choose>
	      <xsl:when test="contains($elem/@type,'token')"><xsl:text>Token</xsl:text></xsl:when>
	      <xsl:when test="$elem/@type='container'"><xsl:text>Container</xsl:text></xsl:when>
	    </xsl:choose> 
	    <xsl:text> element </xsl:text>
	    <code><xsl:value-of select="concat('&lt;',$pragmatic,$attr,'&gt;')"/></code>
	    <xsl:text>)</xsl:text>
	  </xsl:if>
	</head>
	<p><xsl:apply-templates select="ocd:Description"/></p>
	<xsl:apply-templates select="ocd:Pragmatic/ocd:description" mode="speccopy"/>
	<xsl:for-each select="$copy">
	  <xsl:variable name="id" select="./text()"/>
        <xsl:apply-templates select="$def//*[@id=$id]" mode="speccopy"/>
      </xsl:for-each>
    </div4>
  </xsl:if>
  </xsl:template>

  <xsl:template match="ocd:pseq" mode="speccopy">
    <p>The pragmatic Content MathML expression
    <eg role="pragmatic-mathml"><xsl:apply-templates mode="tostring" select="*[1]"/></eg>
    is equivalent to the strict Content MathML expression
    <eg role="pragmatic-mathml"><xsl:apply-templates mode="tostring" select="*[2]"/></eg>
    </p>
  </xsl:template>
    

  <!-- copying CD elements for the MathML3 spec -->

  <xsl:template match="ocd:MMLexample" mode="speccopy">
    <xsl:apply-templates mode="speccopy"/>
  </xsl:template>

  <xsl:template match="ocd:description" mode="speccopy">
    <xsl:apply-templates mode="speccopy"/>
  </xsl:template>

  <xsl:template match="ocd:*" mode="speccopy">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="speccopy"/>
    </xsl:element>
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

  <xsl:template match="m:*[not(*|text())]" mode="tostring">
    <xsl:value-of select="concat('&lt;',name())"/>
    <xsl:for-each select="@*">
      <xsl:value-of select="concat(' ',name(),'=&quot;',.,'&quot;')"/>
    </xsl:for-each>
    <xsl:value-of select="'/&gt;'"/>
  </xsl:template>

  <xsl:template match="text()" mode="tostring">
    <xsl:value-of select="."/>
  </xsl:template>

</xsl:stylesheet>
