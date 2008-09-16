<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="om m cd">

<!-- Modes and templates used for rendering CDs to XHTML.  Rolled out of 
     cd2html.xsl for easier reuse. -->

<xsl:import href="om2cmml.xsl"/>
<xsl:import href="cmml2om.xsl"/>
<xsl:output method="xml" encoding="UTF-8"/>

<!-- for debugging -->
<xsl:template match="cd:*" priority="-1">
  <xsl:message>cd2html warning: template for CD element <xsl:value-of select="local-name()"/> undefined</xsl:message>
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
