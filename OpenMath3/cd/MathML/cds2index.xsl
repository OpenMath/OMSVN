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

  <xsl:output method="html" indent="yes"/>
  <xsl:variable name="here" select="/"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>The OpenMath/MathML 3 Content Dictionaries</title>
      </head>
      <body>
	<h1>The OpenMath/MathML3 Content Dictionaries</h1>
	<p>This directory contains the development versions of a set of Content Dictionaries, which 	declare and describe the set of symbols for MathML 3 (see the current w<a 	href="http://www.w3.org/TR/MathML3/chapter4.html#contm.operators">working draft</a>).</p>
	<p>This CD set is under joint development of the
	<a href="http://www.w3.org/Math/">W3C Math Working Group</a> and the 
	<a href="http://www.openmath.org/society/">OpenMath Society</a></p>
	<p>The CDs below are linked in their presentation. We also link 
	<ul>
	  <li>the XML source (<tt>*.ocd</tt>),</li>
	  <li>the OpenMath and MathML2 type information (<tt>*.sts</tt> and <tt>*.mts</tt>),</li>
	  <li>notation definitions (<tt>*.ntn</tt>).</li>
	</ul>
	</p>
	<p>General Discussions take place on the mailing list <tt>om3@openmath.org</tt>, you
	can self-subscribe at  
	<a href="http://openmath.org/mailman/listinfo/om3">
	  <tt>http://openmath.org/mailman/listinfo/om3</tt></a>.
	Please send your comments to the mailing list.</p>
	<p>Specific discussions about issues will take place at 
	<a href="https://trac.kwarc.info/OM3"><tt>https://trac.kwarc.info/OM3</tt></a>, again, you can 	self-subscribe.
	</p>
	<xsl:apply-templates select="mathml-cds"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="mathml-cds">
    <ul><xsl:apply-templates/></ul>
  </xsl:template>

  <xsl:template match="cd">
    <xsl:variable name="file" select="."/>
    <xsl:message>reading <xsl:value-of select="$file"/></xsl:message>
    <xsl:apply-templates select="exsl:node-set(document($file,$here))//ocd:CD"/>
  </xsl:template>

  <xsl:template match="ocd:CD">
    <xsl:variable name="cdname" select="normalize-space(ocd:CDName)"/>
    <li>
	<a href="{$cdname}.xhtml"><xsl:value-of select="$cdname"/></a>:
	<xsl:apply-templates select="ocd:Description"/><br/>
	Other Information:   
	CD source (<a href="{$cdname}.ocd"><tt><xsl:value-of select="$cdname"/>.ocd</tt></a>)
	OM types (<a href="{$cdname}.sts"><tt><xsl:value-of select="$cdname"/>.sts</tt></a>)
	MathML types (<a href="{$cdname}.mts"><tt><xsl:value-of select="$cdname"/>.mts</tt></a>)
	Notations (<a href="{$cdname}.ntn"><tt><xsl:value-of select="$cdname"/>.ntn</tt></a>)
    </li>
  </xsl:template>

</xsl:stylesheet>
