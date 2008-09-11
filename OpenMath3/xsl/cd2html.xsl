<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="om m cd">

<xsl:import href="verb.xsl"/>
<xsl:import href="om2pmml.xsl"/>
<xsl:import href="om2cmml.xsl"/>
<xsl:import href="cmml2om.xsl"/>
<xsl:output method="xml" encoding="UTF-8"/>

<xsl:strip-space elements="cd:Name"/>

<!-- for debugging -->
<xsl:template match="cd:*" priority="-1">
  <xsl:message>cd2html warning: template for CD element <xsl:value-of select="local-name()"/> undefined</xsl:message>
</xsl:template>

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
<xsl:call-template name="field">
    <xsl:with-param name="key">Canonical URL</xsl:with-param>
    <xsl:with-param name="value"><a href="{normalize-space(./cd:CDURL)}">
<xsl:value-of select="normalize-space(./cd:CDURL)"/></a>
    </xsl:with-param>
</xsl:call-template>

<xsl:if test="cd:CDBase">
	<xsl:call-template name="field">
	    <xsl:with-param name="key">CD Base</xsl:with-param>
	    <xsl:with-param name="value" select="normalize-space(./cd:CDBase)"/>
	    <xsl:with-param name="link" select="true()"/>
	</xsl:call-template>
</xsl:if>

<xsl:call-template name="field">
    <xsl:with-param name="key">CD File</xsl:with-param>
    <xsl:with-param name="value" select="concat($cd, '.ocd')"/>
    <xsl:with-param name="link" select="true()"/>
</xsl:call-template>

<xsl:call-template name="field">
    <xsl:with-param name="key">CD as XML Encoded OpenMath</xsl:with-param>
    <xsl:with-param name="value" select="concat($cd, '.omcd')"/>
    <xsl:with-param name="link" select="true()"/>
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

<xsl:call-template name="field">
    <xsl:with-param name="key">Date</xsl:with-param>
    <xsl:with-param name="value" select="cd:CDDate"/>
</xsl:call-template>

<xsl:call-template name="field">
    <xsl:with-param name="key">Version</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="cd:CDVersion"/>
    <xsl:if test="0 ne number(cd:CDRevision)">
    (Revision <xsl:value-of select="normalize-space(cd:CDRevision)"/>)
    </xsl:if>
    </xsl:with-param>
</xsl:call-template>

<xsl:call-template name="field">
    <xsl:with-param name="key">Review Date</xsl:with-param>
    <xsl:with-param name="value" select="cd:CDReviewDate"/>
</xsl:call-template>

<xsl:call-template name="field">
    <xsl:with-param name="key">Status</xsl:with-param>
    <xsl:with-param name="value" select="cd:CDStatus"/>
</xsl:call-template>

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
  <xsl:apply-templates/>
  </body>
  </html>
</xsl:template>

<xsl:template match="cd:CDComment">
  <pre><xsl:apply-templates/></pre>
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:Description|cd:CDDefinition/cd:description|cd:CDDefinition/cd:discussion|cd:CDDefinition/cd:Title">
	<xsl:call-template name="field">
	    <xsl:with-param name="key" select="local-name()"/>
	    <xsl:with-param name="value">
	        <xsl:call-template name="grab-para">
	            <xsl:with-param name="string" select="."/>
	        </xsl:call-template>
	    </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="cd:Description|cd:description">
  <xsl:call-template name="grab-para"><xsl:with-param name="string" select="."/></xsl:call-template>
</xsl:template>

<!-- we have already dealt with these -->
<xsl:template match="cd:CDURL|cd:CDBase|cd:CDName|cd:CDDate|cd:CDReviewDate|cd:CDStatus|
                    cd:CDVersion|cd:CDRevision|cd:CDUses"/>

<xsl:template match="cd:CDDefinition">
  <div class="cddefinition">
  <xsl:apply-templates select="cd:Name"/>
  <dl>
    <xsl:apply-templates select="* except cd:Name"/>
    <xsl:call-template name="field">
        <xsl:with-param name="key" select="'Signatures'"/>
        <xsl:with-param name="value">
      <xsl:element name="a">
    <xsl:attribute name="href">../sts/<xsl:value-of 
    select="normalize-space(/cd:CD/cd:CDName)"/>.xhtml#<xsl:value-of
    select="normalize-space(cd:Name)"/></xsl:attribute>
    sts
      </xsl:element>
        </xsl:with-param>
    </xsl:call-template>
  </dl>
  </div>

 <div>
	<xsl:variable name="n" select="normalize-space(following-sibling::cd:CDDefinition[1]/cd:Name)"/>
	<xsl:choose>
	  <xsl:when test="''=$n">
	    <xsl:variable name="n2" select="normalize-space(../cd:CDDefinition[1]/cd:Name)"/>
	    [First: <a href="#{$n2}"><xsl:value-of select="$n2"/></a>]
	  </xsl:when>
	  <xsl:otherwise>[Next: <a href="#{$n}"><xsl:value-of select="$n"/></a>]</xsl:otherwise>
	</xsl:choose>
	   [This: <a href="#{normalize-space(cd:Name)}"><xsl:value-of select="normalize-space(cd:Name)"/></a>]
	<xsl:variable name="p" select="normalize-space(preceding-sibling::cd:CDDefinition[1]/cd:Name)"/>
	<xsl:choose>
	  <xsl:when test="''=$p">
	    <xsl:variable name="p2" select="normalize-space(../cd:CDDefinition[last()]/cd:Name)"/>
	    [Last: <a href="#{$p2}"><xsl:value-of select="$p2"/></a>]
	  </xsl:when>
	  <xsl:otherwise>[Previous: <a href="#{$p}"><xsl:value-of select="$p"/></a>]</xsl:otherwise>
	</xsl:choose>
      [<a href="#top">Top</a>]
 </div>

</xsl:template>


<xsl:template match="cd:CDDefinition/cd:Name">
  <h2><a name="{normalize-space(.)}">Symbol Definition: <xsl:apply-templates/></a></h2>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:Role">
	<xsl:call-template name="field">
	    <xsl:with-param name="key" select="'Role'"/>
	    <xsl:with-param name="value">
	        <xsl:apply-templates/>
	    </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:Pragmatic">
	<xsl:call-template name="field">
	    <xsl:with-param name="key" select="'Pragmatic MathML'"/>
	    <xsl:with-param name="value">
	        <xsl:apply-templates/>
	    </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="cd:Pragmatic/cd:Element">
  <p>&lt;<xsl:value-of select="normalize-space(.)"/>/&gt;</p>
</xsl:template>

<xsl:template match="cd:Pragmatic/cd:Element[@type='container']" priority="2">
  <p>&lt;<xsl:value-of select="normalize-space(.)"/>
  <xsl:text>&gt;&#160;&lt;/</xsl:text>
  <xsl:value-of select="normalize-space(.)"/>&gt;</p>
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:MMLexample">
	<xsl:call-template name="field">
	    <xsl:with-param name="key" select="'Example'"/>
	    <xsl:with-param name="value">
            <xsl:apply-templates/>
	    </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="cd:Token">
  <code>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="."/>
    <xsl:apply-templates select="following-sibling::cd:Attribute"/>
    <xsl:text>/&gt;</xsl:text>
  </code>
</xsl:template>

<!-- FIXME what's this? It's not in rnc/cd.rnc. -->
<!-- 
<xsl:template match="cd:Container">
  <code>
    <xsl:value-of select="concat('&lt;',.)"/>
    <xsl:apply-templates  select="following-sibling::cd:Attribute"/>
    <xsl:value-of select="concat('&gt; ... &lt;/',.,'&gt;')"/>
  </code>
</xsl:template>
-->
 
<xsl:template match="cd:Attribute">
  <p>
  <xsl:value-of select="concat(' ',normalize-space(cd:Name))"/>
  <xsl:choose>
    <xsl:when test="cd:Prescribed">
      <xsl:value-of select="concat('=&quot;',normalize-space(cd:Prescribed),'&quot;')"/>
    </xsl:when>
    <xsl:when test="cd:Model">
      <xsl:value-of select="concat(' : ',normalize-space(cd:Model))"/>
    </xsl:when>
  </xsl:choose>
  </p>
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:property">
	<xsl:call-template name="field">
	    <xsl:with-param name="key" select="'Property'"/>
	    <xsl:with-param name="value">
	        <xsl:apply-templates/>
	    </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="cd:property/cd:CMP"><xsl:apply-templates/></xsl:template>
<xsl:template match="cd:property/cd:FMP"><xsl:apply-templates/></xsl:template>

<!-- eliminate them as soon as properties are universally used -->
<xsl:template match="cd:CDDefinition/cd:CMP">
	<xsl:call-template name="field">
	    <xsl:with-param name="key" select="'Commented Mathematical property (CMP)'"/>
	    <xsl:with-param name="value">
	        <xsl:apply-templates/>
	    </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:FMP">
	<xsl:call-template name="field">
	    <xsl:with-param name="key" select="'Formal Mathematical property (FMP)'"/>
	    <xsl:with-param name="value">
	        <xsl:apply-templates/>
	    </xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:Example">
	<xsl:call-template name="field">
	    <xsl:with-param name="key" select="'Example'"/>
	    <xsl:with-param name="value">
            <xsl:apply-templates/>
	    </xsl:with-param>
	</xsl:call-template>
</xsl:template>

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

<xsl:template match="m:math">
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

<!--   term mode -->

<xsl:template mode="term" match="om:OMOBJ|om:OMBVAR|m:bvar">
  <xsl:apply-templates mode="term"/>
</xsl:template>


<xsl:template mode="term" match="om:OMSTR">
<tt> "<xsl:apply-templates mode="term"/>" </tt>
</xsl:template>

<xsl:template mode="term" match="om:OMA|m:apply">
<xsl:apply-templates mode="term" select="./*[position()=1]"/>
(<xsl:for-each  select="./*[position()>1]">
  <xsl:apply-templates mode="term" select="."/>
  <xsl:if test="position()&lt;last()">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:for-each>)
</xsl:template>

<xsl:template mode="term" match="om:OMBIND|m:bind">
<xsl:apply-templates mode="term" select="./*[position()=1]"/>
[<xsl:apply-templates mode="term" select="./*[position()=2]"/>] .
(<xsl:apply-templates mode="term" select="./*[position()>2]"/>)
</xsl:template>


<xsl:template mode="term" match="om:OMV|m:ci">
  <xsl:text> </xsl:text>
  <i><xsl:value-of select="@name"/></i>
</xsl:template>


<xsl:template mode="term" match="om:OMF">
<xsl:text> </xsl:text>
  <xsl:value-of select="@*"/><xsl:text> </xsl:text>
</xsl:template>


<xsl:template mode="term" match="om:OMS|m:csymbol">
    <xsl:variable name="p">
    <!--  <xsl:if test="not(document(concat(@cd,'.ocd'),.))">../../../cd/</xsl:if>-->
    </xsl:variable>
    <a href="{$p}{@cd}.xhtml#{@name}"><xsl:value-of select="@name"/></a>
</xsl:template>

<xsl:template mode="term" match="om:OMATP">
<xsl:apply-templates mode="term" />
</xsl:template>


<xsl:template mode="term" match="om:OMATTR">
  <b>Attrib</b>([<xsl:apply-templates mode="term" select="./*[position()=1]"/>],
<xsl:apply-templates mode="term" select="./*[position()>1]"/>)
</xsl:template>

<xsl:template mode="term" match="om:OME">
  <b>Error</b>(<xsl:apply-templates mode="term" select="./*[position()=1]"/>,
<xsl:apply-templates mode="term" select="./*[position()>1]"/>)
</xsl:template>

<!-- end term mode -->


<!-- Formats a chunk of plain text into a series of paragraphs.  Any empty line in the 
     original text is interpreted as a paragraph separator. -->
<xsl:template name="grab-para">
  <xsl:param name="string"/>
  <xsl:choose>
    <xsl:when test="contains($string, '&#10;&#10;')">
      <p><xsl:value-of select="substring-before($string,'&#10;&#10;')"/></p>
      <xsl:call-template name="grab-para">
	<xsl:with-param name="string" select="substring-after($string,'&#10;&#10;')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise><p><xsl:value-of select="$string"/></p></xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- Creates one item of an HTML <dl/> list, i.e. a <dt/><dd/> pair -->
<xsl:template name="field">
    <xsl:param name="key"/>
    <xsl:param name="value"/>
    <xsl:param name="link" select="false()"/>
    <dt class="dt"><xsl:value-of select="$key"/>:</dt>
    <dd><xsl:choose>
        <xsl:when test="$link"><a href="{$value}"><xsl:value-of select="$value"/></a></xsl:when>
        <xsl:otherwise><xsl:copy-of select="$value"/></xsl:otherwise>
        </xsl:choose></dd>
</xsl:template>

<!-- Creates a button for showing/hiding a rendered formula contained in a <div/> with the given id -->
<xsl:template name="formula-button">
    <xsl:param name="id"/>
    <xsl:param name="label"/>
    <xsl:param name="active" select="false()"/>
<div><button id="{$id}a" class="omcd_formula omcd_{if ($active) then 'active' else 'inactive'}" onclick="omcd_divfold('{$id}')"><xsl:value-of select="$label"/></button></div>
</xsl:template>


<xsl:template name="ns">
<xsl:variable name="a" select="../namespace::*"/>
<xsl:variable name="b" select="namespace::*"/>
<xsl:for-each select="$b[not(name()='xml')]">
<xsl:variable name="n" select="name()"/>
<xsl:variable name="v" select="."/>
<xsl:if test="not($n) or starts-with(name(..),concat($n,':'))">
<xsl:if test="not($a[name()=$n and . = $v])">
<xsl:text/> xmlns<xsl:if test="$n">:</xsl:if><xsl:value-of
  select="$n"/>="<xsl:value-of select="$v"/>"<xsl:text/>
</xsl:if>
</xsl:if>
</xsl:for-each>
<!--
 This should work (and does with saxon, but not with xalan) so instead do the above.

  <xsl:for-each select="namespace::*[not(name()='xml')]">
  <xsl:if test="not(../../namespace::*[name()=name(current()) and (. = current())])">
  <xsl:text/> xmlns<xsl:if test="name()">:</xsl:if><xsl:value-of
  select="name()"/>="<xsl:value-of select="."/>"<xsl:text/>
  </xsl:if>
  </xsl:for-each>
-->
</xsl:template>

</xsl:stylesheet>
