<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:saxon="http://saxon.sf.net/"
		xmlns="http://www.w3.org/1998/Math/MathML"
		xmlns:om="http://www.openmath.org/OpenMath"
		xmlns:m="http://www.w3.org/1998/Math/MathML"
		xmlns:h="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="saxon om xs m h"
		>

<xsl:output encoding="US-ASCII" omit-xml-declaration="yes" indent="no"/>



<xsl:template match="h:html">
\documentclass[12pt,a4paper]{article}
\topmargin0pt
\headheight0pt
\headsep0pt
\voffset-1cm

\textheight0.6\textheight
\paperheight0.6\paperheight


\usepackage{amssymb,amsmath}
\setcounter{MaxMatrixCols}{25}
\usepackage{color,graphics,array}
\extrarowheight4pt
\usepackage{pmml}
\begin{document}
<xsl:apply-templates select="h:body/h:div"/>
\end{document}
</xsl:template>

<xsl:template match="h:body/h:div">


<xsl:apply-templates/>

\clearpage
</xsl:template>

<xsl:template match="h:h3">

[\verb|<xsl:value-of select="."/>|]


</xsl:template>

<xsl:template match="h:p">
  <xsl:text>&#10;&#10;</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>&#10;&#10;</xsl:text>
</xsl:template>

<xsl:template match="h:hr">

\hrule

</xsl:template>

<xsl:template match="h:img">

\includegraphics{<!--../w3c/WWW/<xsl:text/>
<xsl:value-of select="substring-after(@src,'w3c/WWW/')"/>--><xsl:value-of select="@src"/>
<xsl:text>}

</xsl:text>
</xsl:template>


<xsl:template match="h:img[contains(@src,'/Characters/')]"/>
<xsl:template match="h:img[contains(@src,'TortureTests/Size')]"/>
<xsl:template match="h:img[contains(@src,'TortureTests/Complexity')]"/>
<xsl:template match="h:img[ends-with(@src,'/multinewline3.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/int2.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/int5.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/abs1.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/mid1.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/mid2.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/linebreakString1.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/linebreakRow1.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/linebreakNum1.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/linebreakFrac.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/noChildPresentation.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/mrootE2.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/arccos3.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/clipboard1.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/mactionSmixed3.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/mactionSmixed4.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/mfracZComp1.png')]"/>
<xsl:template match="h:img[ends-with(@src,'/rec-mcolumn6.png')]"/>


<xsl:template match="m:math">
\[\let\par\empty 
<xsl:apply-templates/>
\]
</xsl:template>

<xsl:template match="m:mrow">
<xsl:text>{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="m:mrow[m:mo=$stretchy]">
<xsl:text>{\left.</xsl:text>
<xsl:apply-templates/>
<xsl:text>\right.}</xsl:text>
</xsl:template>


<xsl:template match="m:none">
<xsl:text>\empty </xsl:text>
</xsl:template>

<xsl:template match="m:glyph[@src]" priority="2">
  <xsl:text>\includeraphics{</xsl:text>
  <xsl:value-of select="@src"/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="m:glyph[@alt]" priority="1">
  <xsl:text>\mathrm{</xsl:text>
  <xsl:value-of select="replace(@alt,' ','~')"/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="m:mfenced">
<xsl:text>{\left</xsl:text>
<xsl:choose>
  <xsl:when test="not(@open)">(</xsl:when>
  <xsl:when test="normalize-space(@open)=''">.</xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="replace(@open,'[{}]','\\$0')"/>
  </xsl:otherwise>
</xsl:choose>
<xsl:variable name="s" select="for $s in string-to-codepoints((@separators,',')[1]) return codepoints-to-string($s)"/>
<xsl:for-each select="*">
  <xsl:apply-templates select="."/>
    <xsl:variable name="p" select="position()"/>
  <xsl:if test="position()!=last()">
    <xsl:if test="($s[$p],$s[last()])[1]=$stretchy">\middle </xsl:if>
    <xsl:value-of select="replace(($s[$p],$s[last()])[1],'[{}]','\\$0')"/>
  </xsl:if>
</xsl:for-each>
<xsl:text>\right</xsl:text>
<xsl:choose>
  <xsl:when test="not(@close)">)</xsl:when>
  <xsl:when test="normalize-space(@close)=''">.</xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="replace(@close,'[{}]','\\$0')"/>
  </xsl:otherwise>
</xsl:choose>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:variable name="stretchy" select="'(',')','{','}','|'"/>

<xsl:template match="m:msqrt">
<xsl:text>\sqrt{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="m:mphantom">
<xsl:text>\phantom{</xsl:text>
<xsl:apply-templates/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="m:mspace[@width]">
<xsl:text>{\hspace{</xsl:text>
 <xsl:value-of select="replace(@width,'px','pt')"/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="m:maction">
<xsl:apply-templates select="*[1]"/>
</xsl:template>


<xsl:template match="m:menclose">
<xsl:message>
<menclose>
<xsl:copy-of select="@*"/>
</menclose>
</xsl:message>
<xsl:apply-templates/>
</xsl:template>


<xsl:template match="m:menclose[@notation]">
  <xsl:variable name="s" select="tokenize((@notation,'longdiv')[1],'\s+')"/>
  <xsl:text>{\menclosebox{</xsl:text>
  <xsl:if test="$s='radical'">\sqrt</xsl:if>
  <xsl:text>{</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}}{</xsl:text>
<xsl:for-each select="$s">
  <xsl:choose>
    <xsl:when test=".='longdiv'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m  
   3 \hheight
   3 \hheight
   0 \height
   c
   \width \height
   l
   S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='actuarial'">
      <xsl:text>\hbox{\pdfliteral{q 0 \height m  
   \width \height
   l
   \width 0
   l
   S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='left'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m 0 \height l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='right'">
      <xsl:text>\hbox{\pdfliteral{q \width \depth m \width \height l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='top'">
      <xsl:text>\hbox{\pdfliteral{q 0 \height m \width \height l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='bottom'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m \width\depth l S Q}}</xsl:text>
    </xsl:when>

    <xsl:when test=".='box'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m 0 \height l </xsl:text>
      <xsl:text>\width \height l </xsl:text>
      <xsl:text>\width \depth l </xsl:text>
      <xsl:text>0 \depth l s Q}}</xsl:text>
    </xsl:when>



    <xsl:when test=".='updiagonalstrike'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m \width\height l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='downdiagonalstrike'">
      <xsl:text>\hbox{\pdfliteral{q 0 \height m \width\depth l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='horizontalstrike'">
      <xsl:text>\hbox{\pdfliteral{q 0 \hheight m \width\hheight l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='verticalstrike'">
      <xsl:text>\pdfliteral{q \hwidth \height m \hwidth\depth l S Q}</xsl:text>
    </xsl:when>
    <xsl:when test=".=('circle','roundedbox')">
      <xsl:text>\pdfliteral{q
     0  \hheight m
     0 \height
     0 \height
     \hwidth \height
     c 
     \width \height
     \width \height
     \width \hheight
     c
     \width \depth
     \width \depth
     \hwidth \space \depth
     c
     0 \depth  
     0 \depth  
     0 \hheight
     c
s Q}</xsl:text>
    </xsl:when>
    <xsl:when test=".='madruwb'">
\dimen0\wd0
\advance\dimen0-2pt
\dimen2\wd0
\advance\dimen2 1pt
\pdfliteral{
q \stripPT\dimen0 \space 0 m \stripPT\dimen2 \space -2 \hwidth -2   2 0 c
         \hwidth -3 \stripPT\dimen2 \space -3 \width 0 c
\stripPT\dimen0 \space \height l 
    h f
     Q}
    </xsl:when>
    <xsl:otherwise>
      <xsl:message select="'menclose: ',."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:for-each>
  <xsl:text>}}</xsl:text>
</xsl:template>


<xsl:template match="m:mpadded">
<xsl:message>
<mpadded>
<xsl:copy-of select="@*"/>
</mpadded>
</xsl:message>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="m:merror">
{{\color{red}{\fbox{$<xsl:apply-templates/>$}}}}
</xsl:template>


<xsl:template match="m:mtext">
<xsl:text>{\mathrm{</xsl:text>
  <xsl:variable name="t"><xsl:apply-templates/></xsl:variable>
  <xsl:value-of select="replace(replace(replace($t,' ','~'),'&lt;','\\lt '),'&gt;','\\gt ')"/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="m:mroot">
<xsl:text>\sqrt[{</xsl:text>
<xsl:apply-templates select="*[2]"/>
<xsl:text>}]{</xsl:text>
<xsl:apply-templates select="*[1]"/>
<xsl:text>}</xsl:text>
</xsl:template>


<xsl:template match="m:mfrac">
<xsl:text>{\frac{</xsl:text>
<xsl:apply-templates select="*[1]"/>
<xsl:text>}{</xsl:text>
<xsl:apply-templates select="*[2]"/>
<xsl:text>}}</xsl:text>
</xsl:template>


<xsl:template match="m:mfenced/m:mo[not(@*) and normalize-space(.)=$stretchy]" priority="2">
  <xsl:text>\middle</xsl:text>
  <xsl:value-of select="replace(.,'[{}]','\\$0')"/>
</xsl:template>
<xsl:template match="m:mrow/m:mo[not(@*) and normalize-space(.)=$stretchy]" priority="2">
  <xsl:text>\middle</xsl:text>
  <xsl:value-of select="replace(.,'[{}]','\\$0')"/>
</xsl:template>

<xsl:template match="m:mo[not(@*) and string-length(normalize-space(.))=1]">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="m:mo">
  <xsl:text>{\mo{</xsl:text>
  <xsl:apply-templates select="@*"/>
  <xsl:apply-templates/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="m:mo[string-length(normalize-space(.)) gt 1]">
  <xsl:text>{\mo{\mathrm{</xsl:text>
  <xsl:apply-templates select="@*"/>
  <xsl:apply-templates/>
  <xsl:text>}}}</xsl:text>
</xsl:template>

<xsl:template match="m:mo[.='{']">\{</xsl:template>
<xsl:template match="m:mo[.='}']">\}</xsl:template>
<xsl:template match="m:mo[.='^']">\hat{}</xsl:template>
<xsl:template match="m:mo[.='_']">\_ </xsl:template>
<xsl:template match="m:mo[.='\']">\backslash </xsl:template>
<xsl:template match="m:mo[.='&amp;']">\ampersand </xsl:template>
<xsl:template match="m:mo[.='&lt;']">\lt </xsl:template>
<xsl:template match="m:mo[.='&gt;']">\gt </xsl:template>



<!--
  <xsl:value-of select="for $n in string-to-codepoints(.)
 return concat('\mo{',$n,'}')"/>
-->

<xsl:template match="m:mi[not(@*) and string-length(normalize-space(.))=1]">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="m:mi">
  <xsl:text>{\mi</xsl:text>
  <xsl:value-of select="replace(@mathvariant,'-','')"/>
  <xsl:if test="not(@mathvariant) and string-length(.)&gt;1">normal</xsl:if>
  <xsl:text>{</xsl:text>
  <xsl:apply-templates select="@* except @mathvariant"/>
  <xsl:apply-templates/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="m:mn">
  <xsl:text>{\mn{</xsl:text>
  <xsl:apply-templates select="@*"/>
  <xsl:apply-templates/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="*">
<xsl:message select="'tex: ',name()"/>
</xsl:template>


<xsl:template match="m:msup">
<xsl:text>{{</xsl:text>
<xsl:apply-templates select="*[1]"/>
<xsl:text>}\sp{</xsl:text>
<xsl:apply-templates select="*[2]"/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="m:msub">
<xsl:text>{{</xsl:text>
<xsl:apply-templates select="*[1]"/>
<xsl:text>}\sb{</xsl:text>
<xsl:apply-templates select="*[2]"/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="m:msubsup">
  <xsl:text>{</xsl:text>
  <xsl:text>{</xsl:text>
  <xsl:apply-templates select="*[1]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>\sb{</xsl:text>
  <xsl:apply-templates select="*[2]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>\sp{</xsl:text>
  <xsl:apply-templates select="*[3]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="m:mmultiscripts">
  <xsl:text>\setbox0\hbox{$</xsl:text>
  <xsl:apply-templates select="*[1]"/>
  <xsl:text>$}</xsl:text>
  <xsl:for-each select="m:mprescripts/following-sibling::*[position() mod 2=1]">
   <xsl:text>\vphantom{pre\copy0}</xsl:text>
   <xsl:text>\sb{</xsl:text>
   <xsl:apply-templates select="."/>
   <xsl:text>}\sp{</xsl:text>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   <xsl:text>}</xsl:text>
  </xsl:for-each>
  <xsl:text>{\copy0}</xsl:text>
  <xsl:for-each select="*[position()!=1][not(self::m:mprescripts)][not(preceding-sibling::m:mprescripts)][position() mod 2=1]">
   <xsl:text>\vphantom{post\copy0}</xsl:text>
   <xsl:text>\sb{</xsl:text>
   <xsl:apply-templates select="."/>
   <xsl:text>}\sp{</xsl:text>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   <xsl:text>}</xsl:text>
  </xsl:for-each>
</xsl:template>

<xsl:template match="m:mtable">
<xsl:text>{\begin{matrix}&#10;</xsl:text>
<xsl:apply-templates select="m:mtr|m:mlabeledtr">
  <xsl:with-param name="cols" select="max(*/count(m:mtd/(@colspan/number(.),1)[1]))"/>
</xsl:apply-templates>
<xsl:text>&#10;\end{matrix}}</xsl:text>
</xsl:template>

<xsl:template match="m:mtr">
  <xsl:if test="../@side='left' and ../m:mlabeledtr">
    <xsl:text>{\relax}\endcell </xsl:text>
  </xsl:if>
  <xsl:apply-templates select="m:mtd"/>
  <xsl:if test="not(../@side='left') and ../m:mlabeledtr">
    <xsl:text>\endcell {\empty} </xsl:text>
  </xsl:if>
  <xsl:if test="position()!=last()">\\&#10;</xsl:if>
</xsl:template>

<xsl:template match="m:mlabeledtr">
  <xsl:param name="cols"/>
  <xsl:if test="../@side='left'">
    <xsl:apply-templates select="m:mtd[1]"/>
  </xsl:if>
  <xsl:apply-templates select="m:mtd[position()!=1]"/>
  <xsl:for-each select="-2 to ($cols - count(m:mtd/(@colspan/number(.),1)[1]))">
   <xsl:text>  \endcell </xsl:text>
  </xsl:for-each>
  <xsl:if test="not(../@side='left')">
    <xsl:apply-templates select="m:mtd[1]"/>
  </xsl:if>
  <xsl:if test="position()!=last()">\\&#10;</xsl:if>
</xsl:template>


<xsl:template match="m:mtd">
  <xsl:apply-templates/>
  <xsl:if test="position()!=last()"> \endcell </xsl:if>
</xsl:template>


<xsl:template match="m:ms">
  <xsl:text>\mathrm{</xsl:text>
  <xsl:apply-templates select="@*"/>
  <xsl:text>"</xsl:text>
  <xsl:variable name="t"><xsl:apply-templates/></xsl:variable>
  <xsl:value-of select="replace($t,' ','~')"/>
  <xsl:text>"</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="m:mover">
  <xsl:text>{</xsl:text>
  <xsl:text>\mathop{</xsl:text>
  <xsl:apply-templates select="*[1]"/>
  <xsl:text>}\limits</xsl:text>
  <xsl:text>\sp{</xsl:text>
  <xsl:apply-templates select="*[2]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template match="m:mover[*[2]='&#175;']" priority="2">
  <xsl:text>{</xsl:text>
  <xsl:text>\overline{</xsl:text>
  <xsl:apply-templates select="*[1]"/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="m:munder">
  <xsl:text>{</xsl:text>
  <xsl:text>\mathop{</xsl:text>
  <xsl:apply-templates select="*[1]"/>
  <xsl:text>}\limits</xsl:text>
  <xsl:text>\sb{</xsl:text>
  <xsl:apply-templates select="*[2]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template match="m:munderover">
  <xsl:text>{</xsl:text>
  <xsl:text>\mathop{</xsl:text>
  <xsl:apply-templates select="*[1]"/>
  <xsl:text>}\limits</xsl:text>
  <xsl:text>\sb{</xsl:text>
  <xsl:apply-templates select="*[2]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>\sp{</xsl:text>
  <xsl:apply-templates select="*[3]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template match="m:mstyle">
<xsl:text>{</xsl:text>
<xsl:apply-templates select="@*"/>
<xsl:apply-templates/>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template match="@*">
<xsl:message select="'attribute: ',../name(),name(),string(.)"/>
</xsl:template>
<xsl:template match="@mathbackground" priority="2"/>
<xsl:template match="@background" priority="2"/>

<xsl:template match="*[@mathbackground|@background]" priority="100">
  <xsl:text>{</xsl:text>
  <xsl:for-each select="(@mathbackground,@background)[1]">
  <xsl:call-template name="color">
    <xsl:with-param name="cmd" select="'\colorbox'"/>
  </xsl:call-template>
  </xsl:for-each>
  <xsl:text>{$</xsl:text>
  <xsl:next-match/>
  <xsl:text>$}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="@color[../@mathcolor]" priority="20"/>
<xsl:template match="@mathcolor|@color" name="color" priority="2">
  <xsl:param name="cmd" select="'\color'"/>
  <xsl:value-of select="$cmd"/>
  <xsl:choose>
    <xsl:when test="starts-with(.,'#') and string-length(.)=4">
      <xsl:text>[xRGB]{</xsl:text>
      <xsl:value-of select="upper-case(replace(.,'#(.)(.)(.)','$1$1,$2$2,$3$3}'))"/>
    </xsl:when>
    <xsl:when test="starts-with(.,'#') and string-length(.)=7">
      <xsl:text>[xRGB]{</xsl:text>
      <xsl:value-of select="upper-case(replace(.,'#(..)(..)(..)','$1,$2,$3}'))"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="lower-case(.)"/>
      <xsl:text>}</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="m:mstyle/@displaysize[.='true']">
  \dislaystyle
</xsl:template>


<xsl:template match="m:mcolumn">
 <xsl:text>&#10;\begin{array}{@{}*{25}{c@{}c@{}}}&#10;</xsl:text>
<xsl:variable name="mc">
<mc>
 <xsl:apply-templates select="*" mode="mc"/>
</mc>
</xsl:variable>
<xsl:variable name="c" select="max($mc/m:mc/m:row/count(m:cell))"/>
<xsl:message select="'mcolumn: ',$c,$mc"/>
<xsl:for-each select="$mc/m:mc/(m:row|m:mline)">
 <xsl:if test="self::m:mline">\hline&#10;</xsl:if>
 <xsl:if test="self::m:row">
<xsl:for-each select="1 to $c - count(m:cell)">
<xsl:text> \endcell </xsl:text>
</xsl:for-each>
<xsl:for-each select="m:cell">
 <xsl:value-of select="."/>
 <xsl:if test="position()!=last()"> \endcell </xsl:if>
</xsl:for-each>
<xsl:if test="position()!=last()">\\&#10;</xsl:if>
 </xsl:if>
</xsl:for-each>
 <xsl:text>&#10;\end{array}&#10;</xsl:text>
</xsl:template>

<xsl:template match="*" mode="mc">
  <row>
    <xsl:apply-templates mode="mc2"/>
  </row>
</xsl:template>


<xsl:template match="m:mline" mode="mc">
 <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="*" mode="mc2">
    <cell><xsl:apply-templates select="."/></cell>
</xsl:template>

<xsl:template match="m:mstyle" mode="mc2">
    <xsl:apply-templates select="*" mode="mc2"/>
</xsl:template>

<xsl:template match="m:mrow" mode="mc2">
    <xsl:apply-templates select="*" mode="mc2"/>
</xsl:template>

<xsl:template match="m:mn|m:mi|m:mo|m:mtext" mode="mc">
 <row>
    <xsl:apply-templates select="." mode="mc2"/>
 </row>
</xsl:template>

<xsl:template match="m:mn" mode="mc2">
  <xsl:for-each select="string-to-codepoints(replace(normalize-space(.),'[&#824;]',''))">
  <cell><xsl:value-of select="codepoints-to-string(.)"/>  </cell>
  </xsl:for-each>
</xsl:template>

<xsl:template match="m:mtext" mode="mc2">
  <xsl:for-each select="string-to-codepoints(normalize-space(.))">
  <cell><xsl:value-of select="codepoints-to-string(.)"/></cell>
  </xsl:for-each>
</xsl:template>

<xsl:template match="m:mi" mode="mc2">
  <xsl:for-each select="string-to-codepoints(normalize-space(.))">
  <cell>
   <xsl:value-of select="codepoints-to-string(.)"/>
  </cell>
  </xsl:for-each>
</xsl:template>

<xsl:template match="m:mspace[@spacing]" mode="mc2">
  <xsl:for-each select="string-to-codepoints(normalize-space(@spacing))">
  <cell></cell>
  </xsl:for-each>
</xsl:template>


<xsl:template match="m:mo" mode="mc2">
  <xsl:for-each select="string-to-codepoints(normalize-space(.))">
  <cell><xsl:value-of select="codepoints-to-string(.)"/></cell>
  </xsl:for-each>
</xsl:template>

<xsl:template match="m:mglyph[@src]">
  <xsl:text>{\includegraphics{</xsl:text>
  <xsl:value-of select="@src"/>
  <xsl:text>}}</xsl:text>
</xsl:template>
<xsl:template match="m:mglyph">
  <xsl:text>{\mathrm{[</xsl:text>
  <xsl:value-of select="@alt"/>
  <xsl:text>]}}</xsl:text>
</xsl:template>

</xsl:stylesheet>