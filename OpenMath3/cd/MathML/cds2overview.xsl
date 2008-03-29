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
      <xsl:apply-templates select="mathml-cds"/>
    </div2>
  </xsl:template>

  <xsl:template match="mathml-cds">
    <ednote>
      <name>MiKo</name>
      <edtext>
	The list is generated from the MathML3 Content Dictionaries at 
	<loc href="{@baseuri}/"><xsl:value-of select="@baseuri"/>/</loc>. 
	These are the result of merging material from the MathML2 and 
	OpenMath2 content dictionaries, they are under review. We have 
	already done some work on the <code>arith1</code> CD to show how 
	the extracted material will look in the MathML3 specification. The 
	presentation of the other CDs will improve with the content dictionary 
	editorial process.  
      </edtext>
    </ednote>
    <xsl:apply-templates>
      <xsl:with-param name="speclevel" select="@speclevel"/>
      <xsl:with-param name="prune" select="@prune"/>
      <xsl:with-param name="baseuri" select="@baseuri"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="cd">
    <xsl:param name="speclevel"/>
    <xsl:param name="baseuri"/>
    <xsl:param name="prune"/>
    <xsl:variable name="file" select="."/>
    <xsl:message>reading <xsl:value-of select="$file"/></xsl:message>
    <xsl:apply-templates select="exsl:node-set(document($file,$here))//ocd:CD">
      <xsl:with-param name="speclevel" select="$speclevel"/>
      <xsl:with-param name="prune" select="$prune"/>
      <xsl:with-param name="baseuri" select="$baseuri"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="ocd:CD">
    <xsl:param name="speclevel"/>
    <xsl:param name="baseuri"/>
    <xsl:param name="prune"/>
    <xsl:variable name="cdname" select="normalize-space(ocd:CDName)"/>
    <div3 id="contm.{$cdname}">
      <head><xsl:value-of select="$cdname"/></head>
      <p><xsl:apply-templates select="ocd:Description"/></p>
      <xsl:apply-templates select="ocd:discussion/*" mode="speccopy"/>
      <p>For a full semantic description of the content dictionary see <loc href="{$baseuri}/{$cdname}.xhtml"><xsl:value-of select="concat($baseuri,'/',$cdname,'.xhtml')"/></loc>.</p>
      <xsl:apply-templates select="ocd:CDDefinition">
	<xsl:with-param name="speclevel" select="$speclevel"/>
	<xsl:with-param name="prune" select="$prune"/>
	<xsl:with-param name="cdname" select="$cdname"/>
	<xsl:with-param name="baseuri" select="$baseuri"/>
      </xsl:apply-templates>
    </div3>
  </xsl:template>

  <xsl:template match="ocd:CDDefinition">
    <xsl:param name="speclevel"/>
    <xsl:param name="baseuri"/>
    <xsl:param name="prune"/>
    <xsl:param name="cdname"/>
    <xsl:variable name="def" select="."/>
    <xsl:variable name="elem" select="ocd:Pragmatic/ocd:Element"/>
    <xsl:variable name="name" select="normalize-space(ocd:Name)"/>
    <xsl:variable name="pragmatic">
      <xsl:choose>
	<xsl:when test="ocd:Pragmatic/@specref">
	  <xsl:value-of select="ocd:Pragmatic/@specref"/>
	</xsl:when>
	<xsl:when test="$elem"><xsl:value-of select="$elem"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="$name"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="attr">
      <xsl:for-each select="ocd:Pragmatic/ocd:Attribute/ocd:Prescribed">
	<xsl:value-of select="concat(' ',normalize-space(../ocd:Name),'=',.)"/>
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
	  <code><xsl:value-of select="$name"/></code>
	  <xsl:if test="$elem">
	    <xsl:text> (</xsl:text>
	    <code>
	      <xsl:value-of select="concat('&lt;',$pragmatic,$attr)"/>
	      <xsl:if test="contains($elem/@type,'opel')"><xsl:text>/</xsl:text></xsl:if>
	      <xsl:text>&gt;</xsl:text>
	    </code>
	    <xsl:text>)</xsl:text>
	  </xsl:if>
	</head>
	<p><emph>Description:</emph><xsl:apply-templates select="ocd:Description"/></p>
	<xsl:apply-templates select="ocd:MMLexample[@speclevel &lt;= $speclevel]" mode="speccopy"/>
	<p>For a full semantic definition and more examples see <loc href="{$baseuri}/{$cdname}.xhtml#{$name}"><xsl:value-of select="concat($baseuri,'/',$cdname,'.xhtml#',$name)"/></loc>.</p>
	<xsl:choose>
	  <xsl:when test="contains($elem/@type,'opel')">
	    <p><emph>Usage in pragmatic Content MathML:</emph> This symbol can be represented as the (empty) <intref ref="contm_opel">operator element</intref> 
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
    <p><!-- we do not want internal paragraph structure -->
      <emph>Example:</emph>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="ocd:description/ocd:p/text()|ocd:description/ocd:p/*" mode="speccopy"/>
      <xsl:apply-templates select="m:math" mode="speccopy"/>
    </p>
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
