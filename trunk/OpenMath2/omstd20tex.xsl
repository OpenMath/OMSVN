<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="verb.xsl"/>

<xsl:param name="changelog">no</xsl:param>
<xsl:param name="showdiffs" select="false()"/>
<xsl:output method="text" encoding="iso-8859-1"/>


<xsl:key name="new"  match="*[@revisionflag='added']" use="ancestor-or-self::section[1]/@id"/>
<xsl:key name="ids" match="*[@id]" use="@id"/>

<xsl:template match="*">
\xxxxxx\textcolor£redß[[[<xsl:value-of select="name()"/>]]]}
</xsl:template>

<xsl:template match="book">
\documentclass[11pt,twoside,chapter,a4paper,keylogo]{openmath}
\setcounter{secnumdepth}{4}
\usepackage[latin1]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{soul,longtable}
\usepackage{ae,amsfonts,amssymb,url,graphics,color,
%hyperref
}
\definecolor{green}{rgb}{0,0.3,0}
\let\cellsep&amp;

\catcode`\&amp;=12
\catcode`\_=12
\catcode`\^=12
\catcode`\#=12
\catcode`\$=12
\catcode`\£=1
\catcode`\ß=2

\begin{document}
\catcode`\%=12
\catcode`\{=12
\catcode`\}=12

\raggedbottom

\title£<xsl:value-of select="title"/>ß

\version£<xsl:apply-templates select="bookinfo/releaseinfo"/>ß
\author£<xsl:apply-templates select="bookinfo/author"/>ß

<xsl:for-each select="bookinfo/editor">
\editor£<xsl:value-of select="."/>ß
</xsl:for-each>


\date£<xsl:value-of select="bookinfo/date"/>ß

\begin£abstractß
<xsl:apply-templates select="bookinfo/abstract/*"/>
\end£abstractß

\maketitle

<xsl:if test="$showdiffs">
\subsection*£Change-marked edition notesß
This edition contains colour coded change markings
relative to the OpenMath 1.0 document\ldots
\begin£itemizeß
\color£greenß
\item New text is marked in green.
\color£redß
\item Deleted text is marked in red.
\end£itemizeß

\subsubsection*£Sections with new textß
\begin£itemizeß
<xsl:for-each select="//section">
<xsl:if test="key('new',@id)">
\item
\ref£<xsl:value-of select="@id"/>ß <xsl:value-of select="title[1]"/>\\
</xsl:if>
</xsl:for-each>
\end£itemizeß
</xsl:if>

<xsl:apply-templates/>
\catcode`\{=1
\catcode`\}=2
\end£documentß

</xsl:template>

<xsl:template match="bookinfo"/>
<xsl:template match="title"/>



<xsl:template match="formalpara">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<xsl:text>£</xsl:text>
<xsl:apply-templates select="@revisionflag"/>
<xsl:text>\paragraph£</xsl:text>
<xsl:value-of select="title"/>
<xsl:text>ß</xsl:text>
£<xsl:apply-templates select="@revisionflag|node()[not(title)]"/>ß
<xsl:text>ß</xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="para">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
£<xsl:apply-templates select="@revisionflag|node()"/>ß
</xsl:if>
</xsl:template>


<xsl:template match="@revisionflag[.='deleted']">
<xsl:if test="$showdiffs">
<xsl:text>\color[rgb]£1,0.7,0.7ß</xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="@revisionflag[.='added']">
<xsl:if test="$showdiffs">
<xsl:text>\color£greenß</xsl:text>
</xsl:if>
</xsl:template>



<xsl:template match="emphasis">
<xsl:text>\emph£</xsl:text>
<xsl:apply-templates/>
<xsl:text>ß</xsl:text>
</xsl:template>

<xsl:template match="acronym">
<xsl:text>\textsc£</xsl:text>
<xsl:value-of select="."/>
<xsl:text>ß</xsl:text>
</xsl:template>

<xsl:template match="chapter">

\chapter£<xsl:apply-templates select="title/node()"
           />ß\label£<xsl:value-of select="@id"/>ß
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="chapter" mode="number">
<xsl:number/>
</xsl:template>

<xsl:template match="appendix">
<xsl:if test="not(preceding-sibling::appendix)">

\appendix

</xsl:if>
<xsl:text>£</xsl:text>
<xsl:apply-templates select="@revisionflag"/>
\chapter£<xsl:apply-templates select="title/node()"
           />ß\label£<xsl:value-of select="@id"/>ß
<xsl:apply-templates/>
<xsl:text>ß</xsl:text>
</xsl:template>

<xsl:template match="appendix" mode="number">
<xsl:number format="A"/>
</xsl:template>


<xsl:template match="section">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
  <xsl:if test="parent::appendix">\clearpage</xsl:if>
  <xsl:text>£</xsl:text>
  <xsl:apply-templates select="@revisionflag"/>
\<xsl:for-each select="ancestor::section">sub</xsl:for-each>
  <xsl:text/>section<xsl:if test="@revisionflag='deleted'">*</xsl:if>£<xsl:apply-templates select="title/node()"
           />ß<xsl:if test="@id">\label£<xsl:value-of select="@id"/>ß</xsl:if>
<xsl:apply-templates/>
  <xsl:text>ß</xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="section" mode="number">
<xsl:apply-templates mode="number" select="ancestor::chapter|ancestor::appendix"/>
<xsl:text>.</xsl:text>
<xsl:number level="multiple"  from="chapter|appendix"/>
</xsl:template>


<xsl:template match="ulink">
<xsl:text/>\href£<xsl:value-of select="@url"/>ß£<xsl:apply-templates/>ß<xsl:text/>
</xsl:template>

<xsl:template match="quote">
<xsl:text/>``<xsl:apply-templates/>''<xsl:text/>
</xsl:template>


<xsl:template match="phrase">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<xsl:text/>£<xsl:apply-templates select="@*|node()"/>ß<xsl:text/>
</xsl:if>
</xsl:template>

<xsl:template match="para/text()">
<xsl:value-of select="translate(.,'&#10;',' ')"/>
</xsl:template>

<xsl:template match="phrase[@role='sl']">
<xsl:text/>\textsl£<xsl:apply-templates/>ß<xsl:text/>
</xsl:template>

<xsl:template match="phrase[@role='tt']">
<xsl:text/>\texttt£<xsl:apply-templates/>ß<xsl:text/>
</xsl:template>

<xsl:template match="itemizedlist">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
\begin£itemizeß
<xsl:apply-templates/>
\end£itemizeß
</xsl:if>
</xsl:template>


<xsl:template match="orderedlist">
\begin£enumerateß
<xsl:choose>
<xsl:when test="@numeration='lowerroman'">
\def\theenumi£\roman£enumißß
\def\labelenumi£(\theenumi)ß
</xsl:when>
</xsl:choose>
<xsl:apply-templates/>
\end£enumerateß
</xsl:template>


<xsl:template match="variablelist">
\begin£descriptionß
<xsl:apply-templates/>
\end£descriptionß
</xsl:template>

<xsl:template match="listitem">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
\item
<xsl:apply-templates select="@*|*"/>
</xsl:if>
</xsl:template>

<xsl:template match="varlistentry">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="varlistentry/listitem">
<xsl:apply-templates select="../@*|node()"/>
</xsl:template>

<xsl:template match="varlistentry/term">
\item[<xsl:apply-templates select="../@*|node()"/>]
</xsl:template>

<xsl:template match="varname">
<xsl:text/>\textbf£<xsl:apply-templates/>ß<xsl:text/>
</xsl:template>

<xsl:template match="filename">
<xsl:text/>\textbf£<xsl:apply-templates/>ß<xsl:text/>
</xsl:template>



<xsl:template match="systemitem">
<xsl:text/>\texttt£<xsl:apply-templates/>ß<xsl:text/>
</xsl:template>


<xsl:template match="blockquote">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
\begin£quotationß
<xsl:apply-templates/>
\end£quotationß
</xsl:if>
</xsl:template>


<xsl:template match="figure">
\begin£figureß

<xsl:apply-templates/>

\caption£<xsl:apply-templates select="title/node()"
        />ß\label£<xsl:value-of select="@id"/>ß
\end£figureß
</xsl:template>


<xsl:template match="figure" mode="number">
<xsl:number level="multiple" count="chapter"/>.<xsl:number level="any"  from="chapter"/>
</xsl:template>



<xsl:template match="xref">
<a href="#£@linkendß">
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
<xsl:text>£</xsl:text>
<xsl:apply-templates select="@revisionflag"/>
<xsl:if test="@role='small'">£\footnotesize</xsl:if>
\begin£verbatimß<xsl:apply-templates/>\end{verbatim}<xsl:if test="@role='small'">\par\vspace£-10ptßß</xsl:if>
<xsl:text>&#10;</xsl:text>
<xsl:text>ß</xsl:text>
</xsl:template>

<xsl:template match="sidebar">
<xsl:if test="$changelog='yes'">
changelog entry here
</xsl:if>
</xsl:template>


<xsl:template match="informaltable">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
£<xsl:apply-templates select="@revisionflag"/>
<xsl:if test="@role='small'">\footnotesize</xsl:if>
\begin£tabularß£lllllllllllllß
<xsl:apply-templates select="tgroup/*"/>
\end£tabularß<xsl:text>ß&#10;</xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="id('fig_bin-enc')/informaltable">
\footnotesize
\begin£longtableß£llp£5cmßlp£5cmß|lß
<xsl:apply-templates select="tgroup/*"/>
\end£longtableß<xsl:text>&#10;</xsl:text>
</xsl:template>


<xsl:template match="tbody|thead">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="row">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<xsl:apply-templates/>
<xsl:if test="parent::head or position() &lt; last()">\\
</xsl:if>
</xsl:if>
</xsl:template>


<xsl:template match="entry">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<xsl:apply-templates select="@revisionflag|../@revisionflag"/>
<xsl:if test="../parent::thead">\bfseries </xsl:if>
<xsl:apply-templates/>
<xsl:if test="position() &lt; last()"> \cellsep </xsl:if>
</xsl:if>
</xsl:template>


<xsl:key name="cite" match="citation" use="."/>

<xsl:template match="graphic">
<xsl:text/>\includegraphics£<xsl:value-of select="@fileref"/>ß<xsl:text/>
</xsl:template>

<xsl:template match="footnote">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')">
<xsl:text/>\footnote£<xsl:apply-templates select="para/node()"/>ß<xsl:text/>
</xsl:if>
</xsl:template>


<!-- toc -->

<xsl:template match="toc">
\catcode`\{=1
\catcode`\}=2
\tableofcontents
\catcode`\{=12
\catcode`\}=12
</xsl:template>

<xsl:template match="lot">
\catcode`\{=1
\catcode`\}=2
\listoffigures
\catcode`\{=12
\catcode`\}=12
</xsl:template>




<!-- bibliography -->
<xsl:template match="bibliography">
\begin£thebibliographyß£99ß
<xsl:for-each select="biblioentry[key('cite',@id)]">
<xsl:sort select="(author[1]/surname|author[1]/othername|bibliomisc[@role='key'])[1]"/>
<xsl:text>£</xsl:text>
<xsl:apply-templates select="@revisionflag"/>
\bibitem£<xsl:value-of select="@id"/>ß
<xsl:for-each select="author">
 <xsl:choose>
   <xsl:when test="position() = last() and last() &gt; 1"> and </xsl:when>
   <xsl:when test="position() &lt; last() and position() &gt; 1">, </xsl:when>
 </xsl:choose>
 <xsl:value-of select="."/>
</xsl:for-each>
  <xsl:text> </xsl:text>
 <i><xsl:apply-templates select="title/node()"/></i>
<xsl:text>&#10;</xsl:text>
<xsl:text>ß</xsl:text>
</xsl:for-each>
\end£thebibliographyß
</xsl:template>


<xsl:template match="bibliography" mode="number">
<xsl:number format="A" value="1+count(preceding-sibling::appendix)"/>
</xsl:template>

<xsl:variable name="bib" select="/book/bibliography/biblioentry[key('cite',@id)]"/>

<xsl:template match="citation">
<xsl:text/>\cite£<xsl:value-of select="."/>ß<xsl:text/>
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
<xsl:if test="$showdiffs or not(@revisionflag='deleted')"
>\protect\(<xsl:apply-templates/>\protect\)</xsl:if></xsl:template>
<xsl:template match="math[@display='block']">
<xsl:if test="$showdiffs or not(@revisionflag='deleted')"
>\protect\[<xsl:apply-templates/>\protect\]</xsl:if></xsl:template>


<xsl:template match="mfenced">
<xsl:text>(</xsl:text>
<xsl:apply-templates/>
<xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="mi|mn|mo">
<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="mi[@mathvariant='bold']">
<xsl:text/>\mathbf£<xsl:value-of select="."/>ß<xsl:text/>
</xsl:template>

<xsl:template match="mi[@mathvariant='monospace']">
<xsl:text/>\mathtt£<xsl:value-of select="."/>ß<xsl:text/>
</xsl:template>

<xsl:template match="mo[.='&#8594;']">\longrightarrow </xsl:template>
<xsl:template match="mo[.='&#8594;']" mode="number">\longrightarrow </xsl:template>
<xsl:template match="mi[.='&#937;']">\Omega </xsl:template>
<xsl:template match="mo[.='&#955;']">\lambda </xsl:template>
<xsl:template match="mi[.='&#955;']">\lambda </xsl:template>
<xsl:template match="mi[.='&#945;']">\alpha </xsl:template>
<xsl:template match="mo[.='&#945;']">\alpha </xsl:template>
<xsl:template match="mi[.='&#960;']">\pi </xsl:template>
<xsl:template match="mi[.='&#8230;']">\ldots </xsl:template>

<xsl:template match="phrase[.='&#8230;']">\ldots </xsl:template>
<xsl:template match="phrase[.='&#8211;']">\textendash </xsl:template>
<xsl:template match="text()[contains(.,'&#8211;')]">
 <xsl:value-of select="substring-before(.,'&#8211;')"/>
 <xsl:text>\textendash </xsl:text>
 <xsl:value-of select="substring-after(.,'&#8211;')"/>
</xsl:template>


<xsl:template match="mo[.='&#8805;']">\geq </xsl:template>

<xsl:template match="msub">
<xsl:apply-templates select="*[1]"/>
<xsl:text>\sb£</xsl:text>
<xsl:apply-templates select="*[2]"/>
<xsl:text>ß</xsl:text>
</xsl:template>

<xsl:template match="msup">
<xsl:apply-templates select="*[1]"/>
<xsl:text>\sp£</xsl:text>
<xsl:apply-templates select="*[2]"/>
<xsl:text>ß</xsl:text>
</xsl:template>

<xsl:template match="mfrac">
<xsl:text>\frac£</xsl:text>
<xsl:apply-templates select="*[1]"/>
<xsl:text>ß£</xsl:text>
<xsl:apply-templates select="*[2]"/>
<xsl:text>ß</xsl:text>
</xsl:template>


<xsl:template match="mrow">
<xsl:text>£</xsl:text>
<xsl:apply-templates />
<xsl:text>ß</xsl:text>
</xsl:template>

<xsl:template match="mtext">
<xsl:text>\mbox£</xsl:text>
<xsl:apply-templates />
<xsl:text>ß</xsl:text>
</xsl:template>

<xsl:template match="mspace">
<xsl:text>\hspace£</xsl:text>
<xsl:value-of select="@width"/>
<xsl:text>ß</xsl:text>
</xsl:template>


<xsl:template match="token|comment|string">
  <xsl:value-of select="."/>
</xsl:template>


<xsl:template match="rng:grammar" xmlns:rng="http://relaxng.org/ns/structure/1.0">
<xsl:apply-templates mode="verb" select="."/>
</xsl:template>


<xsl:template match="xsd:schema" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<xsl:apply-templates mode="verb" select="."/>
</xsl:template>


</xsl:stylesheet>

