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

    <xsl:param name="speclevel" select="1"/>

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
	  <code><xsl:value-of select="ocd:Name"/></code>
	  <xsl:if test="$elem">
	    <xsl:text> (</xsl:text>
	    <code><xsl:value-of select="concat('&lt;',$pragmatic,$attr,'&gt;')"/></code>
	    <xsl:text>)</xsl:text>
	  </xsl:if>
	</head>
	<p><b>Description:</b><xsl:apply-templates select="ocd:Description"/></p>
	<xsl:variable name="examples" select="ocd:MMLexample[@speclevel &lt;= $speclevel]"/>
	<xsl:if test="$examples">
	  <xsl:message><xsl:value-of select="count($examples)"/>examples</xsl:message>
	  <p>Examples: <xsl:apply-templates select="$examples" mode="speccopy"/></p>
	</xsl:if>
	<xsl:choose>
	  <xsl:when test="contains($elem/@type,'token')">
	    <p><b>Usage in pragmatic Content MathML:</b>This symbol can be represented as the (empty) <intref ref="contm_token">token element</intref> 
	    <el><xsl:value-of select="$pragmatic"/></el> 
	    <xsl:if test="$attr!=''"> with attributes <code><xsl:value-of select="$attr"/></code></xsl:if>
	     in pragmatic Content MathML.</p>
	  </xsl:when>
	  <xsl:when test="$elem/@type='container'">
	    <p>This constructor symbol allows <intref ref="contm_container">container markup</intref> with with the element
	    <el><xsl:value-of select="$pragmatic"/></el> 
	    <xsl:if test="$attr!=''"> with attributes <code><xsl:value-of select="$attr"/></code></xsl:if> 
	     in pragmatic Content MathML.</p>
	  </xsl:when>
	</xsl:choose> 
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
