<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="verb.xsl"/>
<xsl:param name="changelog">no</xsl:param>
<xsl:param name="showdiffs" select="false()"/>
<xsl:output method="xml" encoding="iso-8859-1"/>

<xsl:key name="new"  match="*[@revisionflag='added']" use="ancestor-or-self::section[1]/@id"/>
<xsl:key name="ids" match="*[@id]" use="@id"/>

<xsl:template match="*">
<font color="red">[[[<xsl:value-of select="name()"/>]]]</font>
</xsl:template>

<xsl:template match="book">
<xsl:processing-instruction name="xml-stylesheet"
> type="text/xsl" href="pmathml.xsl"</xsl:processing-instruction>
<html  xml:space="preserve" xmlns:m="http://www.w3.org/1998/Math/MathML">
<head>
<title><xsl:value-of select="title"/></title>
<!--
<object id="mmlFactory" 
        classid="clsid:32F66A20-7614-11D4-BD11-00104BD3F987"/>
<xsl:processing-instruction name="import">
 namespace="m" implementation="#mmlFactory"
</xsl:processing-instruction>
-->
<style>
p {text-align:justify;	   
  }
code {font-size: 125%;
      font-family: monospace; 
     }
.figure {
border-width:1px;
border-color: black;
}
.footnote{
font-size: 75%;
font-style: italic;
}
.delliteral {
font-size: 75%;
background-color: #cfcfcf;
border-color: black;
border-style: solid;
border-width: 1px;
padding: 1em;
color: red;
text-decoration: line-through;
}
.newliteral {
font-size: 75%;
background-color: #cfcfcf;
border-color: black;
border-style: solid;
border-width: 1px;
padding: 1em;
color: green;
}
.literal {
font-size: 75%;
background-color: #cfcfcf;
border-color: black;
border-style: solid;
border-width: 1px;
padding: 1em;
}
.del {
color: red;
text-decoration: line-through;
}
.new {
color: green;
}
.chg {
color: blue;
}
.changetoc {
border-style: solid;
border-color: black;
border-width: 1px;
margin: 2em 2em 2em 2em;
background-color: yellow;
}

.lowerroman {
list-style-type: lower-roman;
}
</style>
</head>
<body>
<h1><xsl:apply-templates select="title/node()"/></h1>
<div>
Version: <xsl:apply-templates select="bookinfo/releaseinfo"/>
</div>

<div>
<xsl:apply-templates select="bookinfo/author"/>
</div>

<div>Editors<br/>
<xsl:apply-templates select="bookinfo/editor"/>
</div>

<div>
<xsl:value-of select="bookinfo/date"/>
</div>

<div>
<h3>Abstract</h3>
<xsl:apply-templates select="bookinfo/abstract/*"/>
</div>

<xsl:if test="$showdiffs">
<div class="changetoc">
<h3>Change-marked edition notes</h3>
<p>
This edition contains colour coded change markings
relative to the OpenMath 1.0 document...</p>
<ul>
<li class="new">New text is marked with css class "new" (green).</li>
<li class="del">Deleted text is marked with css class "del" (red).</li>
</ul>

<p>Sections with new text</p>
<ul>
<xsl:for-each select="//*[self::section or self::appendix]">
<xsl:if test="key('new',@id)">
<a href="#{@id}" class="new">
<xsl:apply-templates mode="number" select="."/>&#160;<xsl:value-of select="title[1]"/>
</a><br/>
</xsl:if>
</xsl:for-each>
</ul>
</div>
</xsl:if>

<xsl:apply-templates/>
</body>

</html>
</xsl:template>

<xsl:template match="bookinfo"/>
<xsl:template match="title"/>



<xsl:template match="formalpara">
<p>
<b>
<xsl:value-of select="title"/>
</b>
<xsl:apply-templates select="@revisionflag|node()[not(title)]"/>
</p>
</xsl:template>

<xsl:template match="para">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<p>
<xsl:apply-templates select="@revisionflag|node()"/>
</p>
</xsl:if>
</xsl:template>


<xsl:template match="emphasis">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<i>
<xsl:apply-templates select="@revisionflag|node()"/>
</i>
</xsl:if>
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
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
 <div>
  <xsl:apply-templates select="@revisionflag"/>
<h2 name="{@id}" id="{@id}">
  Appendix&#160;<xsl:apply-templates mode="number" select="."/>
  <br/>
  <xsl:apply-templates select="title/node()"/>
</h2>
<xsl:apply-templates/>
</div>
</xsl:if>
</xsl:template>

<xsl:template match="appendix" mode="number">
<xsl:number format="A"/>
</xsl:template>


<xsl:template match="section">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
 <div>
  <xsl:apply-templates select="@revisionflag"/>
<xsl:element name="h{count(ancestor::section)+3}">
  <xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
  <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
  <xsl:apply-templates mode="number" select="."/>&#160;<xsl:apply-templates select="title/node()"/>
</xsl:element>
<xsl:apply-templates/>
 </div>
</xsl:if>
</xsl:template>

<xsl:template match="section" mode="number">
<xsl:if test="not(@revisionflag='deleted')">
<xsl:apply-templates mode="number" select="ancestor::chapter|ancestor::appendix"/>
<xsl:text>.</xsl:text>
<xsl:number count="section[not(@revisionflag='deleted')]" level="multiple" format="1.1" from="chapter|appendix"/>
</xsl:if>
</xsl:template>


<xsl:template match="ulink">
<a href="{@url}"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="quote">
<span>"<xsl:apply-templates/>"</span>
</xsl:template>


<xsl:template match="phrase">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<span><xsl:apply-templates select="@*|node()"/></span>
</xsl:if>
</xsl:template>

<xsl:template match="@role">
<xsl:attribute name="class"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>


<xsl:template match="phrase[@role='sl']">
<span><i><xsl:apply-templates/></i></span>
</xsl:template>

<xsl:template match="phrase[@role='tt']">
<code><xsl:apply-templates/></code>
</xsl:template>

<xsl:template match="itemizedlist">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<ul>
<xsl:apply-templates select="@revisionflag"/>
<xsl:apply-templates/>
</ul>
</xsl:if>
</xsl:template>


<xsl:template match="orderedlist">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<ol>
<xsl:apply-templates select="@revisionflag"/>
<xsl:apply-templates select="@numeration"/>
<xsl:apply-templates/>
</ol>
</xsl:if>
</xsl:template>

<xsl:template match="@numeration">
<xsl:attribute name="class"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template match="variablelist">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<dl>
<xsl:apply-templates select="@revisionflag"/>
<xsl:apply-templates/>
</dl>
</xsl:if>
</xsl:template>

<xsl:template match="listitem">
<li>
<xsl:apply-templates select="@*|*"/>
</li>
</xsl:template>

<xsl:template match="varlistentry">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="varlistentry/listitem">
<dd>
<xsl:apply-templates select="../@*|node()"/>
</dd>
</xsl:template>

<xsl:template match="varlistentry/term">
<dt>
<xsl:apply-templates select="../@*|node()"/>
</dt>
</xsl:template>

<xsl:template match="varname">
<b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="filename">
<b><xsl:apply-templates/></b>
</xsl:template>



<xsl:template match="systemitem">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<small><code><xsl:apply-templates select="@revisionflag|node()"/></code></small>
</xsl:if>
</xsl:template>


<xsl:template match="blockquote">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<blockquote><xsl:apply-templates select="@revisionflag|node()"/></blockquote>
</xsl:if>
</xsl:template>


<xsl:template match="figure">
<xsl:if test="$showdiffs or  not(ancestor-or-self::*/@revisionflag='deleted')">
<div class="figure">
<xsl:apply-templates select="(ancestor-or-self::*/@revisionflag)[last()]"/>
<a name="{@id}" id="{@id}"/>
<xsl:apply-templates/>
<div>
  Figure <xsl:apply-templates mode="number" select="."/>&#160;<xsl:apply-templates select="title/node()"/>
</div>
</div>
</xsl:if>
</xsl:template>


<xsl:template match="figure" mode="number">
<xsl:if test="not(ancestor-or-self::*/@revisionflag='deleted')">
<xsl:number level="multiple" count="chapter"/>.<xsl:number
count="figure[not(ancestor-or-self::*/@revisionflag='deleted')]" level="any"  from="chapter"/>
</xsl:if>
</xsl:template>


<xsl:template match="para" mode="number"/>

<xsl:template match="*" mode="number">
<xsl:message>no number for <xsl:value-of select="name()"
/>: <xsl:value-of select="@id"/>
</xsl:message>
</xsl:template>

<xsl:template match="xref">
<a href="#{@linkend}">
<xsl:variable name="n" select="key('ids',@linkend)"/>
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
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<xsl:variable name="c">
<xsl:choose>
  <xsl:when test="$showdiffs and @revisionflag='added'">
    <xsl:value-of select="'newliteral'"/>
  </xsl:when>
  <xsl:when test="$showdiffs and @revisionflag='deleted'">
    <xsl:value-of select="'delliteral'"/>
  </xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="'literal'"/>
  </xsl:otherwise>
</xsl:choose>
</xsl:variable>
<div class="{$c}">
<pre>
<xsl:apply-templates/>
</pre>
</div>
</xsl:if>
</xsl:template>

<xsl:template match="sidebar">
<xsl:if test="$changelog='yes'">
changelog entry here
</xsl:if>
</xsl:template>


<xsl:template match="informaltable">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<table>
<xsl:apply-templates select="@revisionflag|tgroup/*"/>
</table>
</xsl:if>
</xsl:template>


<xsl:template match="tbody|thead">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="row">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<tr><xsl:apply-templates select="@revisionflag|node()"/></tr>
</xsl:if>
</xsl:template>

<xsl:template match="@revisionflag[.='added']">
<xsl:if test="$showdiffs">
 <xsl:attribute name="class">new</xsl:attribute>
</xsl:if>
</xsl:template>

<xsl:template match="@revisionflag[.='deleted']">
<xsl:if test="$showdiffs">
 <xsl:attribute name="class">del</xsl:attribute>
</xsl:if>
<xsl:if test="not($showdiffs)">
<xsl:message>!!!<xsl:value-of select="name(..)"/>
</xsl:message>
</xsl:if>
</xsl:template>

<xsl:template match="@revisionflag[.='changed']">
 <xsl:attribute name="class">chg</xsl:attribute>
</xsl:template>



<xsl:template match="entry">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<td><xsl:apply-templates select="@revisionflag|node()"/></td>
</xsl:if>
</xsl:template>


<xsl:template match="thead/row/entry" priority="2">
<th><xsl:apply-templates/></th>
</xsl:template>

<xsl:key name="cite" match="citation" use="."/>

<xsl:template match="graphic">
<xsl:choose>
<xsl:when test="system-property('xsl:vendor')='Microsoft'">
<embed  src="{@fileref}.svg" type="image/svg+xml" 
       height="{@depth}"
       width="{@width}"
/>
</xsl:when>
<xsl:otherwise>
<img src="{@fileref}.png" alt="{@fileref}.png"/>
</xsl:otherwise>
</xsl:choose>
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
<xsl:for-each
select="/book/chapter|/book/bibliography|/book/appendix">
<xsl:if test="not(@id)">
<xsl:message>
No id on <xsl:value-of select="title"/>
</xsl:message>
</xsl:if>
<a href="#{@id}">
<xsl:apply-templates select="."
mode="number"/>&#160;<xsl:apply-templates select="title/node()"/>
</a><br/>
<xsl:apply-templates select="section" mode="toc"/>
</xsl:for-each>
</xsl:template>


<xsl:template match="section" mode="toc">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
&#160;&#160;&#160;&#160;<xsl:for-each select="ancestor::section">&#160;&#160;&#160;&#160;</xsl:for-each>
<a href="#{@id}">
<xsl:apply-templates select="@revisionflag"/>
<xsl:apply-templates select="." mode="number"/>&#160;<xsl:apply-templates select="title/node()"/>
</a><br/>
<xsl:apply-templates select="section" mode="toc"/>
</xsl:if>
</xsl:template>


<xsl:template match="lot">
<h2><xsl:apply-templates select="title/node()"/></h2>
<xsl:for-each select="//figure[$showdiffs or not(ancestor-or-self::*/@revisionflag='deleted')]">
<a href="#{@id}">
<xsl:apply-templates select="../@revisionflag"/>
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
<xsl:sort select="(author[1]/surname|author[1]/othername|bibliomisc[@role='key'])[1]"/>
<p>
<xsl:apply-templates select="@revisionflag"/>
<a name="{@id}" id="{@id}"/><b>[<xsl:value-of select="position()"/>]</b>
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
<xsl:if test="pubdate">
  <xsl:text>, </xsl:text>
 <xsl:if test="pubdate[@role]">
   <xsl:apply-templates select="pubdate[@role]/node()"/>
   <xsl:text> </xsl:text>
 </xsl:if>
 <xsl:apply-templates select="pubdate[not(@role)]/node()"/>
</xsl:if>
<xsl:text>.</xsl:text>
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
<xsl:sort select="(author[1]/surname|author[1]/othername|bibliomisc[@role='key'])[1]"/>
<xsl:if test="@id=$x"><xsl:value-of select="position()"/></xsl:if>
</xsl:for-each>]</a>
</xsl:template>

<xsl:template match="releaseinfo|firstname|surname|othername">
 <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="editor|author">
<xsl:for-each select="*">
  <xsl:apply-templates select="."/>
 <xsl:if test="position() &lt; last()">&#160;</xsl:if>
</xsl:for-each>
 <xsl:if test="position() &lt; last()">,&#160;</xsl:if>
</xsl:template>


<!-- MathML -->
<xsl:template match="math">
<xsl:apply-templates mode="math" select="."/>
<xsl:if test="not(@display='block') and following-sibling::node()[1] and 
following-sibling::node()[1][starts-with(.,' ') or starts-with(.,'&#10;')]">&#160;</xsl:if>
</xsl:template>

<xsl:template mode="math" match="*">
<xsl:element name="m:{local-name(.)}" namespace="http://www.w3.org/1998/Math/MathML">
<xsl:copy-of select="@*"/>
<xsl:apply-templates mode="math"/>
</xsl:element>
</xsl:template>

<xsl:template match="comment">
<span style="color:brown;"><xsl:value-of select="."/></span></xsl:template>

<xsl:template match="token">
  <xsl:value-of select="."/>
</xsl:template>
<xsl:template match="string">
  <xsl:value-of select="."/>
</xsl:template>


<xsl:template match="token[not(preceding-sibling::*[1]='element' 
or preceding-sibling::*[1]='attribute')]" priority="2">
<a href="#rnc{.}"><xsl:value-of select="."/></a>
</xsl:template>

<xsl:template match="token[.='element' or .='attribute'
or .='default' or .='namespace' or .='pattern' or .='text' 
or .='include']"
priority="4">
  <span style="font-weight:bold;"><xsl:value-of select="."/></span>
</xsl:template>

<xsl:template
match="token[starts-with(normalize-space(following-sibling::node()[1]),'=')]"
priority="3">
<a name="rnc{preceding-sibling::*[1][.='namespace']}{.}" style="color:blue;"><xsl:value-of select="."/></a>
</xsl:template>


<xsl:template
match="token[contains(.,':')]" priority="5">
<a href="#rncnamespace{substring-before(.,':')}"><xsl:value-of
select="substring-before(.,':')"/>:</a>
<xsl:value-of select="substring-after(.,':')"/>
</xsl:template>

<xsl:template match="token[starts-with(.,'xsd:')]" priority="6">
  <span style="font-weight:bold;"><xsl:value-of select="."/></span>
</xsl:template>



<xsl:template match="rng:grammar" xmlns:rng="http://relaxng.org/ns/structure/1.0">
<xsl:apply-templates mode="verb" select="."/>
</xsl:template>


<xsl:template match="xsd:schema" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<xsl:apply-templates mode="verb" select="."/>
</xsl:template>

<xsl:template match="cd:CD" xmlns:cd="http://www.openmath.org/OpenMathCD">
<xsl:apply-templates mode="verb" select="."/>
</xsl:template>



</xsl:stylesheet>

