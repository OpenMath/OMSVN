<xsl:stylesheet 
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>


<xsl:template match="CDDefMPs">
  <html>
  <head>
    <title><xsl:value-of select="@cd"/></title>
<link rel = "stylesheet"
         href = "../omcd.css"
         type = "text/css" ></link>    
  </head>
  <body>
    <h1>OpenMath Defining Mathematical Properties</h1>
    <hr/>
    <p>
	<dl>	
      	<dt><span class="dt">Type System:</span></dt>
      	<dd><a href="../cd/{@type}.html"><xsl:value-of select="@type"/></a> </dd>
      	<br/>
      	<dt><span class="dt">Content Dictionary:</span></dt>
      	<dd><a href="../cd/{@cd}.html"><xsl:value-of select="@cd"/></a> </dd>
      	<br/>
      	<dt><span class="dt">CD Signature File:</span></dt>
      	<dd><a href="../../ecc/{@cd}.cc"><xsl:value-of select="@cd"/>.cc</a></dd>
      	<br/>
	<dt><span class="dt">Canonical URL:</span></dt>
	<dd><a href="{normalize-space(./CDMPURL)}">
  	<xsl:value-of select="normalize-space(./CDMPURL)"/>
  	</a></dd>
        <dt><span class="dt">Date:</span></dt>
	<dd><xsl:value-of select="CDMPDate"/></dd>
  	<dt><span class="dt">Version:</span></dt>
	<dd><xsl:value-of select="CDMPVersion"/></dd>
  	<dt><span class="dt">Review Date:</span></dt>
	<dd><xsl:value-of select="CDMPReviewDate"/></dd>
  	<dt><span class="dt">Status:</span></dt>
	<dd><xsl:value-of select="CDMPStatus"/></dd>
    	</dl>
    </p>
    <hr/>
    <xsl:apply-templates/>
  </body>
  </html>
</xsl:template>

<xsl:template match="CDMPComment">
  <pre>
  <xsl:apply-templates/>
  </pre>
</xsl:template>


<xsl:template match="CDMPURL|CDMPName|CDMPDate|CDMPReviewDate|CDMPStatus|CDMPVersion">
</xsl:template>


<xsl:import href="verb.xsl"/>

<xsl:template match="DefMP">
  <hr/>
  <h2> <a name="{@name}"><xsl:value-of select="@name"/> </a></h2>

  <br/><dl><dt><span class="dt">Defining Mathematical Property:</span></dt>
  <dd>	 
  <xsl:apply-templates/>
  </dd>
  </dl>		
  <p>
     <a href="../cd/{../@cd}.html#{@name}">Content Dictionary Entry.</a> 
  </p>

  <table width="100%">
    <tr><td align="right"><font size="-1">
    <xsl:variable name="n"
        select="normalize-space(following-sibling::DefMP[1]/@name)"/>
      <xsl:choose>
        <xsl:when test="''=$n">
          <xsl:variable name="n"
              select="normalize-space(../DefMP[1]/@name)"/>
          [First: <a href="#{$n}"><xsl:value-of select="$n"/></a>]
        </xsl:when>
        <xsl:otherwise>
          [Next:
          <a href="#{$n}"><xsl:value-of select="$n"/></a>]
        </xsl:otherwise>
      </xsl:choose>
    <xsl:variable name="p"
       select="normalize-space(preceding-sibling::DefMP[1]/@name)"/>
      <xsl:choose>
        <xsl:when test="''=$p">
          <xsl:variable name="p"
              select="normalize-space(../DefMP[last()]/@name)"/>
          [Last: <a href="#{$p}"><xsl:value-of select="$p"/></a>]
        </xsl:when>
        <xsl:otherwise>
          [Previous:
          <a href="#{$p}"><xsl:value-of select="$p"/></a>]
        </xsl:otherwise>
      </xsl:choose>
      [<a href="#top">Top</a>]</font>
    </td>
    </tr>
  </table>

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

<xsl:template mode="term" match="OMBVAR">
<xsl:for-each  select="./*[position()>=1]">
  <xsl:apply-templates mode="term" select="."/>
  <xsl:if test="position()&lt;last()">
    <xsl:text>, </xsl:text>
  </xsl:if>
</xsl:for-each>
</xsl:template>

<xsl:template mode="term" match="OMATTR[OMATP/OMS/@name='typecoerce']">
<xsl:apply-templates mode="term" select="*[2]"/>
<xsl:text>:> </xsl:text>  
<xsl:apply-templates mode="term" select="OMATP/*[2]"/>
</xsl:template>

<xsl:template mode="term" match="OMATTR[OMATP/OMS/@name='type']">
<xsl:apply-templates mode="term" select="*[2]"/>
<xsl:text>: </xsl:text>  
<xsl:apply-templates mode="term" select="OMATP/*[2]"/>
</xsl:template>


<xsl:template mode="term" match="OMATTR">
ONLY type attributions supported today
</xsl:template>




<xsl:template mode="term" match="OME">
  <b>Error</b>(<xsl:apply-templates mode="term" select="./*[position()=1]"/>,
<xsl:apply-templates mode="term" select="./*[position()>1]"/>)
</xsl:template>

<!--   term mode -->




</xsl:stylesheet>

