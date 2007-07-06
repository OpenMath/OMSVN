<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
xmlns="http://www.w3.org/1999/xhtml">

<xsl:param name="changelog">no</xsl:param>
<xsl:output method="xml"/>

<xsl:template match="*">
<font color="red">[[[<xsl:value-of select="name()"/>]]]</font>
</xsl:template>

<xsl:template match="book">
<xsl:processing-instruction name="xml-stylesheet">
 type="text/xsl"
 href="pmathmlsvg.xsl"
</xsl:processing-instruction>
<html xmlns:m="http://www.w3.org/1998/Math/MathML">
<head>
<title><xsl:value-of select="title"/></title>
<object id="mmlFactory" 
        classid="clsid:32F66A20-7614-11D4-BD11-00104BD3F987">
</object>
<xsl:processing-instruction name="import">
 namespace="m" implementation="#mmlFactory"
</xsl:processing-instruction>
<style>
.figure {
border-width:1px;
border-color: black;
}
.footnote{
font-size: 75%;
font-style: italic;
}
.meta{
font-size: 75%;
}
.literal {
font-size: 75%;
background-color: #55FFCC;
border-color: black;
border-style: solid;
border-width: 2px;
padding: 1em;
}
</style>
</head>
<body>
<h1><xsl:apply-templates select="title/node()"/></h1>

<div class="meta">
Version: <xsl:value-of select="bookinfo/releaseinfo"/><br/>
Date: <xsl:value-of select="bookinfo/date"/><br/>
&#169; <xsl:value-of select="bookinfo/copyright/year"/>
 <xsl:text> </xsl:text>
<xsl:value-of select="bookinfo/copyright/holder"/>
</div>

<h2><xsl:value-of select="bookinfo/Author"/></h2>

<div class="author">
 <xsl:apply-templates select="bookinfo/author"/>
</div>

<div class="editor">
  Editors<br/>
 <xsl:apply-templates select="bookinfo/editor"/>
</div>
<h3>Abstract</h3>
<div>
<xsl:apply-templates select="bookinfo/abstract/*"/>
</div>
<xsl:apply-templates/>
</body>

</html>
</xsl:template>

<xsl:template match="bookinfo"/>
<xsl:template match="title"/>

<xsl:template match="author">
<span><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="editor">
<span><xsl:apply-templates/></span>
<xsl:choose>
<xsl:when test="following-sibling::editor and not(following-sibling::editor[2])"> and </xsl:when>
<xsl:when test="following-sibling::editor">, </xsl:when>
</xsl:choose>
</xsl:template>

<xsl:template match="firstname|othername|surname">
<span> <xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="para">
<p>
<xsl:apply-templates/>
</p>
</xsl:template>


<xsl:template match="emphasis">
<i>
<xsl:apply-templates/>
</i>
</xsl:template>

<xsl:template match="acronym">
<span>
<xsl:value-of select="."/>
</span>
</xsl:template>

<xsl:template match="chapter">
<h2 name="{@id}" id="{@id}">
  Chapter&#160;<xsl:apply-templates mode="number" select="."/>
  <br/>
  <xsl:apply-templates select="title/node()"/>
</h2>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="chapter" mode="number">
<xsl:number/>
</xsl:template>

<xsl:template match="appendix">
<h2 name="{@id}" id="{@id}">
  Appendix&#160;<xsl:apply-templates mode="number" select="."/>
  <br/>
  <xsl:apply-templates select="title/node()"/>
</h2>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="appendix" mode="number">
<xsl:number format="A"/>
</xsl:template>


<xsl:template match="section">
<xsl:element name="h{count(ancestor::section)+3}">
  <xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
  <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
  <xsl:apply-templates mode="number" select="."/>&#160;<xsl:apply-templates select="title/node()"/>
</xsl:element>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="section" mode="number">
<xsl:apply-templates mode="number" select="ancestor::chapter|ancestor::appendix"/>
<xsl:text>.</xsl:text>
<xsl:number level="multiple"  from="chapter|appendix"/>
</xsl:template>


<xsl:template match="ulink">
<a href="{@url}"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="quote">
<span>"<xsl:apply-templates/>"</span>
</xsl:template>


<xsl:template match="phrase">
<span><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="phrase[@role='sl']">
<span><i><xsl:apply-templates/></i></span>
</xsl:template>

<xsl:template match="phrase[@role='tt']">
<code><xsl:apply-templates/></code>
</xsl:template>

<xsl:template match="itemizedlist">
<ul>
<xsl:apply-templates/>
</ul>
</xsl:template>


<xsl:template match="orderedlist">
<ol>
<xsl:apply-templates/>
</ol>
</xsl:template>


<xsl:template match="variablelist">
<dl>
<xsl:apply-templates/>
</dl>
</xsl:template>

<xsl:template match="listitem">
<li>
<xsl:apply-templates/>
</li>
</xsl:template>

<xsl:template match="varlistentry">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="varlistentry/listitem">
<dd>
<xsl:apply-templates/>
</dd>
</xsl:template>

<xsl:template match="varlistentry/term">
<dt>
<xsl:apply-templates/>
</dt>
</xsl:template>

<xsl:template match="varname">
<b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="filename">
<b><xsl:apply-templates/></b>
</xsl:template>



<xsl:template match="systemitem">
<span><xsl:apply-templates/></span>
</xsl:template>


<xsl:template match="blockquote">
<blockquote><xsl:apply-templates/></blockquote>
</xsl:template>


<xsl:template match="figure">
<div class="figure">
<a name="{@id}" id="{@id}"/>
<xsl:apply-templates/>
<div>
  Figure <xsl:apply-templates mode="number" select="."/>&#160;<xsl:apply-templates select="title/node()"/>
</div>
</div>
</xsl:template>


<xsl:template match="figure" mode="number">
<xsl:number level="multiple" count="chapter"/>.<xsl:number level="any"  from="chapter"/>
</xsl:template>



<xsl:template match="xref">
<a href="#{@linkend}">
<xsl:variable name="n" select="id(@linkend)"/>
<xsl:choose>
<xsl:when test="$n/ancestor::appendix">Appendix</xsl:when>
<xsl:otherwise>
<xsl:value-of select="translate(substring(name($n),1,1),'acfs','ACFS')"/>
<xsl:value-of select="substring(name($n),2)"/>
</xsl:otherwise>
</xsl:choose>
<xsl:text>&#160;</xsl:text>
<xsl:apply-templates mode="number" select="$n"/>
</a>
</xsl:template>

<xsl:template match="programlisting|literallayout">
<div class="literal">
<pre>
<xsl:apply-templates/>
</pre>
</div>
</xsl:template>

<xsl:template match="sidebar">
<xsl:if test="$changelog='yes'">
changelog entry here
</xsl:if>
</xsl:template>


<xsl:template match="informaltable">
<table>
<xsl:apply-templates select="tgroup/*"/>
</table>
</xsl:template>


<xsl:template match="tbody|thead">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="row">
<tr><xsl:apply-templates/></tr>
</xsl:template>


<xsl:template match="entry">
<td><xsl:apply-templates/></td>
</xsl:template>

<xsl:template match="thead/row/entry" priority="2">
<th><xsl:apply-templates/></th>
</xsl:template>

<xsl:key name="cite" match="citation" use="."/>

<xsl:template match="graphic">
<embed  src="{@fileref}.svg" type="image/svg+xml" 
       height="{@depth}"
       width="{@width}"
/>
</xsl:template>

<xsl:template match="footnote">
<sup><a href="#{@id}">*<xsl:number level="any"/></a></sup>
</xsl:template>

<xsl:template match="para[footnote]">
<p><xsl:apply-templates/></p>
<xsl:for-each select="footnote">
<p class="footnote"><a name="{@id}"/><sup>*<xsl:number level="any"/></sup> <xsl:apply-templates select="para/node()"/></p>
</xsl:for-each>
</xsl:template>
<!-- toc -->

<xsl:template match="toc">
<h2>Contents</h2>
<xsl:for-each select="/book/chapter|/book/bibliography|/book/appendix">
<a href="#{@id}">
<xsl:apply-templates select="."
mode="number"/>&#160;<xsl:apply-templates select="title/node()"/>
</a><br/>
<xsl:apply-templates select="section" mode="toc"/>
</xsl:for-each>
</xsl:template>


<xsl:template match="section" mode="toc">
&#160;&#160;&#160;&#160;<xsl:for-each select="ancestor::section">&#160;&#160;&#160;&#160;</xsl:for-each>
<a href="#{@id}"><xsl:apply-templates select="." mode="number"/>&#160;<xsl:apply-templates select="title/node()"/>
</a><br/>
<xsl:apply-templates select="section" mode="toc"/>
</xsl:template>


<xsl:template match="lot">
<h2><xsl:apply-templates select="title/node()"/></h2>
<xsl:for-each select="//figure">
<a href="#{@id}">
<xsl:apply-templates select="."
mode="number"/>&#160;<xsl:apply-templates select="title/node()"/>
</a><br/>
</xsl:for-each>
</xsl:template>

<!-- bibliography -->
<xsl:template match="bibliography">
<h2 name="bibliography" id="bibliography">
  Appendix&#160;<xsl:apply-templates mode="number" select="."/>
  <br/>Bibliography</h2>
<xsl:for-each select="biblioentry[key('cite',@id)]">
<xsl:sort select="(author[1]/surname|author[1]/othername|key)[1]"/>
<p><a name="{@id}" id="{@id}"/><b>[<xsl:value-of select="position()"/>]</b>
<xsl:text>&#160;&#160;</xsl:text>
<xsl:for-each select="author">
 <xsl:choose>
   <xsl:when test="position() = last() and last() &gt; 1"> and </xsl:when>
   <xsl:when test="position() &lt; last() and position() &gt; 1">, </xsl:when>
 </xsl:choose>
 <xsl:value-of select="."/>
</xsl:for-each>
  <xsl:text> </xsl:text>
 <i><xsl:apply-templates select="title/node()"/></i>
</p>
</xsl:for-each>
</xsl:template>

<xsl:template match="bibliography" mode="number">
<xsl:number format="A" value="1+count(preceding-sibling::appendix)"/>
</xsl:template>

<xsl:variable name="bib" select="/book/bibliography/biblioentry[key('cite',@id)]"/>
<xsl:template match="citation">
<xsl:variable name="x" select="."/>
<a href="#{.}">[<xsl:for-each select="$bib">
<xsl:sort select="(author[1]/surname|author[1]/othername|key)[1]"/>
<xsl:if test="@id=$x"><xsl:value-of select="position()"/></xsl:if>
</xsl:for-each>]</a>
</xsl:template>

<!-- MathML -->
<xsl:template match="math">
<xsl:apply-templates mode="math" select="."/>
<xsl:if test="following-sibling::node()[1] and 
following-sibling::node()[1][starts-with(.,' ') or starts-with(.,'&#10;')]">&#160;</xsl:if>
</xsl:template>

<xsl:template mode="math" match="*">
<xsl:element name="m:{local-name(.)}" namespace="http://www.w3.org/1998/Math/MathML">
<xsl:copy-of select="@*"/>
<xsl:apply-templates mode="math"/>
</xsl:element>
</xsl:template>


</xsl:stylesheet>
