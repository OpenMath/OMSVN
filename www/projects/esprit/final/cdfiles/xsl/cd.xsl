<xsl:stylesheet 
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:strip-space elements="Name"/>

<xsl:template match="CD">
  <xsl:variable name="cd" select="normalize-space(./CDName)"/>
  <html>
  <head>
  <title><xsl:value-of select="$cd"/>
   </title>    
	<link rel = "stylesheet"
         href = "../omcd.css"
         type = "text/css" ></link>

  </head>
  <body>
  <a name="top"/>
  <h1>OpenMath Content Dictionary: <xsl:value-of select="$cd"/></h1>



<dl>
<dt><span class="dt">Canonical URL:</span></dt>
<dd><a href="{normalize-space(./CDURL)}">
  <xsl:value-of select="normalize-space(./CDURL)"/>
  </a></dd>

<dt><span class="dt">CD File:</span></dt> 
<dd><a href="../../cd/{$cd}.ocd">
    <xsl:value-of select="$cd"/>.ocd
  </a></dd>

<dt><span class="dt">CD as XML Encoded OpenMath:</span></dt>  
<dd><a href="../../omcd/{$cd}.omcd">
    <xsl:value-of select="$cd"/>.omcd
  </a>
  </dd>

<dt><span class="dt">Defines:</span></dt>
<dd><xsl:for-each select="CDDefinition/Name">
   <xsl:sort select="."/>
   <xsl:if test="position()>1">, </xsl:if>
    <xsl:variable name="n" select="normalize-space(.)"/>
    <a href="#{$n}"><xsl:value-of select="$n"/></a>
  </xsl:for-each>
  </dd>

  <dt><span class="dt">Date:</span></dt><dd> <xsl:value-of select="CDDate"/></dd>
  <dt><span class="dt">Version:</span></dt><dd><xsl:value-of select="CDVersion"/> 
  <xsl:if test="0 != number(CDRevision)">
  (Revision <xsl:value-of select="normalize-space(CDRevision)"/>)
  </xsl:if> </dd>
  <dt><span class="dt">Review Date:</span></dt><dd> <xsl:value-of select="CDReviewDate"/></dd>
  <dt><span class="dt">Status:</span></dt><dd><xsl:value-of select="CDStatus"/></dd>
  <xsl:if test="not(normalize-space(CDUses)='')">
  <dt><span class="dt">Uses CD:</span></dt><dd>
  <xsl:for-each select="CDUses/CDName">
    <xsl:variable name="n" select="normalize-space(.)"/>
    <a href="{$n}.html"><xsl:value-of select="$n"/></a>
    <xsl:if test="position() &lt; last()">, </xsl:if>
  </xsl:for-each></dd>
  </xsl:if></dl>
  <hr/>
  <xsl:apply-templates/>
  </body>
  </html>
</xsl:template>

<xsl:template match="CDComment">
<pre>
<xsl:apply-templates/>
</pre>
</xsl:template>



<xsl:template match="Description">
  <xsl:call-template name="grab-para">
    <xsl:with-param name="string" select="."/>
  </xsl:call-template>
</xsl:template>



<xsl:template match="CDURL|CDName|CDDate|CDReviewDate|CDStatus|
                    CDVersion|CDRevision|CDUses">
</xsl:template>



<xsl:template match="CDDefinition">
<hr/>
<xsl:apply-templates/>
<dl>
<dt><span class="dt">Signatures:</span></dt>
<dd>
      <xsl:element name="a">
      <xsl:attribute name="href">../sts/<xsl:value-of 
             select="normalize-space(/CD/CDName)"/>.html#<xsl:value-of
             select="normalize-space(Name)"/></xsl:attribute>
      sts
      </xsl:element>
<!-- not many ecc files so far -->
<!--   <xsl:variable name="nm" select="normalize-space(/CD/CDName)"/>
   <xsl:if test="$nm='logic1' or 
                 $nm='logic2' or 
                 $nm='quant1' or
	         $nm='setoid' or 
                 $nm='relation1' or 
                 $nm='relation0'">       
   <xsl:element name="a">
      <xsl:attribute name="href">../ecc/<xsl:value-of 
             select="$nm"/>.html#<xsl:value-of
             select="normalize-space(Name)"/></xsl:attribute>
      ,ecc
      </xsl:element>
</xsl:if> -->
</dd>
</dl>
<p/>
<hr/>

<table width="100%">
<tr>
<td align="right"><font size="-1">
<xsl:variable name="n"
              select="normalize-space(following-sibling::CDDefinition[1]/Name)"/>
  <xsl:choose>
    <xsl:when test="''=$n">
      <xsl:variable name="n"
              select="normalize-space(../CDDefinition[1]/Name)"/>
      [First: <a href="#{$n}"><xsl:value-of select="$n"/></a>]
    </xsl:when>
    <xsl:otherwise>
      [Next: <a href="#{$n}"><xsl:value-of select="$n"/></a>]
    </xsl:otherwise>
  </xsl:choose>
<xsl:variable name="p"
              select="normalize-space(preceding-sibling::CDDefinition[1]/Name)"/>
  <xsl:choose>
    <xsl:when test="''=$p">
      <xsl:variable name="p"
              select="normalize-space(../CDDefinition[last()]/Name)"/>
      [Last: <a href="#{$p}"><xsl:value-of select="$p"/></a>]
    </xsl:when>
    <xsl:otherwise>
      [Previous: <a href="#{$p}"><xsl:value-of select="$p"/></a>]
    </xsl:otherwise>
  </xsl:choose>
[<a href="#top">Top</a>]</font></td>
</tr>
</table>
</xsl:template>


<xsl:template match="CDDefinition/Name">
<h2><a name="{normalize-space(.)}"><xsl:apply-templates/></a></h2>
</xsl:template>


<xsl:template match="CDDefinition/CMP">
<dl>
<dt><span class="dt">Commented Mathematical property (CMP):</span></dt>
<dd>
<xsl:apply-templates/>
</dd></dl>
</xsl:template>


<xsl:template match="CDDefinition/FMP">
<dl>
<dt><span class="dt">Formal Mathematical property (FMP):</span></dt>
<dd><xsl:apply-templates/>
</dd></dl>
</xsl:template>


<xsl:template match="CDDefinition/Example">
<dl>
<dt><span class="dt">Example:</span></dt>
<dd><xsl:apply-templates/>
</dd></dl>
</xsl:template>

<xsl:template match="OMOBJ">
<pre>
<xsl:apply-templates mode="verb" select="."/>
</pre>
<p>
<xsl:apply-templates mode="term" select="."/>
</p>
</xsl:template>


<!-- verb mode -->
<xsl:import href="verb.xsl"/>


<!--   term mode -->

<xsl:template mode="term" match="OMOBJ|OMBVAR">
<xsl:apply-templates mode="term"/>
</xsl:template>


<xsl:template mode="term" match="OMSTR">
<tt> "<xsl:apply-templates mode="term"/>" </tt>
</xsl:template>

<xsl:template mode="term" match="OMA">
<xsl:apply-templates mode="term" select="./*[position()=1]"/>
(<xsl:for-each  select="./*[position()>1]">
  <xsl:apply-templates mode="term" select="."/>
  <xsl:if test="position()&lt;last()">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:for-each>)
</xsl:template>

<xsl:template mode="term" match="OMBIND">
<xsl:apply-templates mode="term" select="./*[position()=1]"/>
[<xsl:apply-templates mode="term" select="./*[position()=2]"/>] .
(<xsl:apply-templates mode="term" select="./*[position()>2]"/>)
</xsl:template>


<xsl:template mode="term" match="OMV">
  <xsl:text> </xsl:text>
  <i><xsl:value-of select="@name"/></i>
</xsl:template>


<xsl:template mode="term" match="OMF">
<xsl:text> </xsl:text>
  <xsl:value-of select="@*"/><xsl:text> </xsl:text>
</xsl:template>




<xsl:template mode="term" match="OMS">
<a href="{@cd}.html#{@name}"><xsl:value-of select="@name"/></a>
</xsl:template>

<xsl:template mode="term" match="OMATP">
<xsl:apply-templates mode="term" />
</xsl:template>


<xsl:template mode="term" match="OMATTR">
  <b>Attrib</b>([<xsl:apply-templates mode="term" select="./*[position()=1]"/>],
<xsl:apply-templates mode="term" select="./*[position()>1]"/>)
</xsl:template>

<xsl:template mode="term" match="OME">
  <b>Error</b>(<xsl:apply-templates mode="term" select="./*[position()=1]"/>,
<xsl:apply-templates mode="term" select="./*[position()>1]"/>)
</xsl:template>

<!--   term mode -->


<xsl:template name="grab-para">
  <xsl:param name="string"/>
  <xsl:choose>
  <xsl:when test="contains($string, '&#10;&#10;')">
  <p>
  <xsl:value-of select="substring-before($string,'&#10;&#10;')"/>
  </p>
  <xsl:call-template name="grab-para">
    <xsl:with-param name="string" select="substring-after($string,'&#10;&#10;')"/>
  </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
  <p>
  <xsl:value-of select="$string"/>
  </p>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
