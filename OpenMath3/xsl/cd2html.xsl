<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="om m cd">

<!-- Modes and templates used by this XSLT. -->
<xsl:import href="cd2html-util.xsl"/>
<!-- Render OpenMath to Presentation MathML -->
<xsl:import href="om2pmml.xsl"/>
<!-- Render XML source of math object -->
<xsl:import href="verb.xsl"/>

<!-- This file only implements templates for the CD root element and for
     mathematical objects.  Anything else is imported -->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:strip-space elements="cd:Name"/>

<xsl:template match="cd:CD">
  <xsl:variable name="cd" select="normalize-space(./cd:CDName)"/>
  <xsl:text>&#10;</xsl:text>
  <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="../../xsl/pmathml.xsl"</xsl:processing-instruction>
  <xsl:text>&#10;</xsl:text>
  <html>
  <head>

   <!-- this JavaScript is now located in ../lib/js.  You have to put a copy into 
   the same directory as the XHTML output of this XSLT. -->
    <script type="text/javascript" src="divfold.js"/>
     <title><xsl:value-of select="$cd"/>
   </title>    
   <!-- this stylesheet is now located in ../lib/css.  You have to put a copy into 
   the same directory as the XHTML output of this XSLT. -->
	<link rel = "stylesheet"
         href = "omcd.css"
         type = "text/css" ></link>

  </head>
  <body>
  <a name="top"/>
  <h1>OpenMath Content Dictionary: <xsl:value-of select="$cd"/></h1>



<dl>
<xsl:apply-templates select="cd:CDURL"/>
<xsl:apply-templates select="cd:CDBase"/>

<xsl:call-template name="field">
    <xsl:with-param name="key">CD File</xsl:with-param>
    <xsl:with-param name="value" select="concat($cd, '.ocd')"/>
    <xsl:with-param name="normalize-space" select="false()" tunnel="yes"/>
    <xsl:with-param name="link" select="true()" tunnel="yes"/>
</xsl:call-template>

<xsl:call-template name="field">
    <xsl:with-param name="key">CD as XML Encoded OpenMath</xsl:with-param>
    <xsl:with-param name="value" select="concat($cd, '.omcd')"/>
    <xsl:with-param name="normalize-space" select="false()" tunnel="yes"/>
    <xsl:with-param name="link" select="true()" tunnel="yes"/>
</xsl:call-template>

<xsl:call-template name="field">
    <xsl:with-param name="key">Defines</xsl:with-param>
    <xsl:with-param name="value"><xsl:for-each select="cd:CDDefinition/cd:Name">
   <xsl:sort select="."/>
   <xsl:if test="position()>1">, </xsl:if>
    <xsl:variable name="n" select="normalize-space(.)"/>
    <a href="#{$n}"><xsl:value-of select="$n"/></a>
  </xsl:for-each>
    </xsl:with-param>
</xsl:call-template>

<xsl:apply-templates select="cd:CDDate"/>
<xsl:apply-templates select="cd:CDVersion"/>
<xsl:apply-templates select="cd:CDReviewDate"/>
<xsl:apply-templates select="cd:CDStatus"/>

  <xsl:if test="normalize-space(cd:CDUses) ne ''">
<xsl:call-template name="field">
    <xsl:with-param name="key">Uses CD</xsl:with-param>
    <xsl:with-param name="value">
  <xsl:for-each select="cd:CDUses/cd:CDName">
    <xsl:variable name="p">
<xsl:if test="not(document(concat(.,'.ocd'),.))">../../../cd/</xsl:if>
    </xsl:variable>
    <xsl:variable name="n" select="normalize-space(.)"/>
    <a href="{$p}{$n}.xhtml"><xsl:value-of select="$n"/></a>
    <xsl:if test="position() &lt; last()">, </xsl:if>
  </xsl:for-each>
    </xsl:with-param>
</xsl:call-template>
  </xsl:if>
</dl>
  <hr/>
  <!-- we have already dealt with these -->
  <xsl:apply-templates select="* except (cd:CDName|cd:CDURL|cd:CDBase|cd:CDDate|cd:CDVersion|cd:CDRevision|cd:CDReviewDate|cd:CDStatus|cd:CDUses)"/>
  </body>
  </html>
</xsl:template>

<xsl:template match="cd:CDVersion">
    <xsl:call-template name="cd-version-and-revision"/>
</xsl:template>

<!--
	some syntax sanity checks (cd2html-util.xsl doesn't do them, it allows
	e.g. an example to occur everywhere, as that is needed for SWiM's document splitting)
-->
<xsl:template match="cd:CD/cd:Description|cd:CD/cd:discussion">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:CDDefinition/cd:Description|cd:CDDefinition/cd:description|cd:CDDefinition/cd:discussion|cd:CDDefinition/cd:Title">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:MMLexample/cd:description">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:Pragmatic/cd:description">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:property/cd:description">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:Description|cd:description|cd:discussion|cd:Title"/>

<xsl:template match="cd:CDDefinition/cd:Pragmatic">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:Pragmatic"/>

<xsl:template match="cd:CDDefinition/cd:MMLexample|cd:CDDefinition/cd:Example">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:MMLexample|cd:Example"/>

<xsl:template match="cd:property/cd:CMP|cd:property/cd:FMP">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:CDDefinition/cd:CMP|cd:CDDefinition/cd:FMP">
    <!-- abolish this template as soon as properties are universally used -->
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:CMP|cd:FMP"/>

<!-- enforce them to be children of /cd:CD?
<xsl:template match="cd:CDURL|cd:CDBase|cd:CDName|cd:CDDate|cd:CDReviewDate|cd:CDStatus|
                     cd:CDVersion|cd:CDRevision|cd:CDUses"/>
-->    

<!-- Math Objects -->
<xsl:template match="om:OMOBJ">
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'xml')"/>
        <xsl:with-param name="label">XML (OpenMath)</xsl:with-param>
    </xsl:call-template>
  <pre id="{generate-id()}xml" style="display:none">
    <xsl:apply-templates mode="verb" select="."/>
  </pre>
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'cmml')"/>
        <xsl:with-param name="label">Content MathML</xsl:with-param>
    </xsl:call-template>
  <pre id="{generate-id()}cmml" style="display:none; margin-top: 0.5em">
    <xsl:variable name="c">
      <xsl:apply-templates  mode="om2cmml" select="."/>
    </xsl:variable>
    <xsl:apply-templates mode="verb" select="$c"/>
  </pre>
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'pref')"/>
        <xsl:with-param name="label">Prefix form</xsl:with-param>
    </xsl:call-template>
  <div id="{generate-id()}pref" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="term" select="."/>
  </div>
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'mml')"/>
        <xsl:with-param name="label">Presentation MathML</xsl:with-param>
	<xsl:with-param name="active" select="true()"/>
    </xsl:call-template>
  <div id="{generate-id()}mml" style="display:block; margin-top: 0.5em">
    <m:math   xmlns:m="http://www.w3.org/1998/Math/MathML" display="block">
      <xsl:apply-templates/>
    </m:math>
  </div>
</xsl:template>

<xsl:template match="m:math[not(parent::cd:p)]">
  <xsl:variable name="o">
    <xsl:apply-templates mode="cmml2om" select="."/>
  </xsl:variable>
    <xsl:variable name="c">
      <xsl:apply-templates  mode="om2cmml" select="$o"/>
    </xsl:variable>
    <xsl:variable name="strict" select="deep-equal($c/m:math,.)"/>
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'xml')"/>
        <xsl:with-param name="label">XML (<xsl:if test="$strict">Strict </xsl:if>MathML)</xsl:with-param>
    </xsl:call-template>
  <pre id="{generate-id()}xml" style="display:none">
    <xsl:apply-templates mode="verb" select="."/>
  </pre>
<xsl:if test="not($strict)">
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'strict')"/>
        <xsl:with-param name="label">Strict Content MathML</xsl:with-param>
    </xsl:call-template>
  <pre id="{generate-id()}strict" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="verb" select="$c"/>
  </pre>  
</xsl:if>
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'cmml')"/>
        <xsl:with-param name="label">OpenMath</xsl:with-param>
    </xsl:call-template>
  <pre id="{generate-id()}cmml" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="verb" select="$o"/>
  </pre>
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'pref')"/>
        <xsl:with-param name="label">Prefix form</xsl:with-param>
    </xsl:call-template>
  <div id="{generate-id()}pref" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="term" select="$o"/>
  </div>
    <xsl:call-template name="formula-button">
        <xsl:with-param name="id" select="concat(generate-id(), 'mml')"/>
        <xsl:with-param name="label">Presentation MathML</xsl:with-param>
	<xsl:with-param name="active" select="true()"/>
    </xsl:call-template>
  <div id="{generate-id()}mml" style="display:block; margin-top: 0.5em">
    <m:math   xmlns:m="http://www.w3.org/1998/Math/MathML" display="block">
      <xsl:apply-templates select="$o/*/*"/>
    </m:math>
  </div>
</xsl:template>

<!-- override "field" subtemplates from cd2html-util.xsl -->
<xsl:template name="field-value">
    <xsl:param name="value" tunnel="yes"/>
    <xsl:param name="normalize-space" select="true()" tunnel="yes"/>
    <xsl:call-template name="field-value-impl">
        <xsl:with-param name="value" select="if (not(*) and $normalize-space)
            then normalize-space($value)
            else $value" tunnel="yes"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
