<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>


<xsl:template match="CDSignatures">
  <html>
  <head>
    <title><xsl:value-of select="@cd"/></title>
<link rel = "stylesheet"
         href = "../omcd.css"
         type = "text/css" ></link>    
  </head>
  <body>
    <h1>OpenMath Signatures</h1>
    <hr/>
    <p>
	<dl>	
      	<dt><span class="dt">Type System:</span></dt>
      	<dd><a href="../cd/{@type}.html"><xsl:value-of select="@type"/></a> </dd>
      	<dt><span class="dt">Content Dictionary:</span></dt>
      	<dd><a href="../cd/{@cd}.html"><xsl:value-of select="@cd"/></a> </dd>
      	<dt><span class="dt">CD Signature File:</span></dt>
      	<dd><a href="../../ecc/{@cd}.cc"><xsl:value-of select="@cd"/>.cc</a></dd>
      	<dt><span class="dt">CD Signature as XML Encoded OpenMath: </span></dt>
      	<dd><a href="../../omecc/{@cd}.omecc"><xsl:value-of select="@cd"/>.omecc</a></dd>
    	</dl>
    </p>
    <hr/>
    <xsl:apply-templates/>
  </body>
  </html>
</xsl:template>

<xsl:template match="CDSComment">
  <pre>
  <b>
  <xsl:apply-templates/>
  </b>
  </pre>
</xsl:template>

<xsl:import href="verb.xsl"/>

<xsl:template match="Signature">
  <hr/>
  <h2><a name="{@name}"><xsl:value-of select="@name"/></a></h2>

  <br/><dl><dt><span class="dt">Signature:</span></dt>
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
        select="normalize-space(following-sibling::Signature[1]/@name)"/>
      <xsl:choose>
        <xsl:when test="''=$n">
          <xsl:variable name="n"
              select="normalize-space(../Signature[1]/@name)"/>
          [First: <a href="#{$n}"><xsl:value-of select="$n"/></a>]
        </xsl:when>
        <xsl:otherwise>
          [Next:
          <a href="#{$n}"><xsl:value-of select="$n"/></a>]
        </xsl:otherwise>
      </xsl:choose>
    <xsl:variable name="p"
       select="normalize-space(preceding-sibling::Signature[1]/@name)"/>
      <xsl:choose>
        <xsl:when test="''=$p">
          <xsl:variable name="p"
              select="normalize-space(../Signature[last()]/@name)"/>
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




</xsl:stylesheet>

