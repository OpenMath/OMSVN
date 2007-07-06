<?xml version="1.0" encoding="utf-8"?>


<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dc="http://purl.org/DC"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:omdoc="http://www.mathweb.org/omdoc"
  version="1.0">
<xsl:output method="html" indent="yes"/>

<xsl:param name="slideNum"/>


	<xsl:template match="/">
		<xsl:message>slideNum=<xsl:value-of select="$slideNum"/></xsl:message>
		<!--<xsl:choose>
			 <xsl:when test="$slideNum = 0">
				<xsl:call-template name="list" select="/presentation/slide[0]/.."/>
				</xsl:when>
			<xsl:otherwise> -->
				<xsl:apply-templates select="/presentation/slide[position()=$slideNum]"/>
			<!-- </xsl:otherwise>
			</xsl:choose>-->
		</xsl:template> 
	

	<xsl:template match="slide">
		<xsl:message>Title=<xsl:value-of select="title"/></xsl:message>
			<HTML>
			<HEAD>
			<TITLE><xsl:value-of select="title"/></TITLE>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
			<STYLE type="text/css">
			<xsl:comment> @import url(../css/default.css);</xsl:comment>
			</STYLE></HEAD>
			
			<BODY BGCOLOR="white" text="#000000" link="#666666" vlink="#666666" alink="#00FF00" background="../images/LogoEnFondFlou.jpeg">
			<DIV id="Content" style="position:absolute; left:0px; top:0px; width:100%; height=700px; z-index:1; visibility: visible; overflow: visible"> 
				<TABLE width="95%" border="0" cellpadding="3" align="center" height="600px">
					<TR> 
						<TD colspan="3" valign="top" align="left"> <!-- #BeginEditable "SlidesContent" --> 
							
							<h1 class="levelOne"><xsl:value-of select="title"/></h1>
							
							<xsl:apply-templates select="." mode="li-container">
								<xsl:with-param name="depth" select="'0'"/>
								</xsl:apply-templates>
							<!-- #EndEditable --></TD>
					</TR>
					<TR valign="bottom" align="center"> 
						<TD height="40" align="left"><!-- #BeginEditable "ForwardsBackwards" --> 
							<script src="../countPages.js" type="text/javascript" language="Javascript"></script>
							<A href="previous" onClick="return gotoPrevious();">&lt;-</A> <A href="next" onClick="return gotoNext();">-&gt;</A>
							<!-- #EndEditable --></TD>
						<TD height="40" class="footer"> 
							<p><a href="index.htm" class="invisible">
                            <xsl:value-of select="/presentation/title"/></a></p>
							</TD>
						<TD height="40" align="right" class="footer"><br/>
							<xsl:apply-templates select="//footer"/>
							</TD>
					</TR>
				</TABLE>
			</DIV>
			</BODY>
			<!-- #EndTemplate --></HTML>	
			</xsl:template>
	
	<xsl:template match="footer">
		<xsl:copy-of select="*"/>
		</xsl:template>
	
	
	<xsl:template match="*" mode="li-container">
		<xsl:param name="depth"/>
		<xsl:choose>
			<xsl:when test="li">
				<ul>
					<xsl:for-each select="li">
						<li>
							<xsl:attribute name="class">
								<xsl:value-of select="'level_'"/><xsl:value-of select="$depth"/>
								</xsl:attribute>
							<xsl:copy-of select="t/node()"/>
							<xsl:apply-templates select="." mode="li-container">
								<xsl:with-param name="depth" select="$depth+1"/>
								</xsl:apply-templates>
							<xsl:text/>
							</li>
						</xsl:for-each>
				</ul>
				</xsl:when>
			<xsl:when test="comment">
				<br/>
				<span class="comment"><xsl:copy-of select="*"/></span>
				</xsl:when>
			<xsl:otherwise>
				<!-- <xsl:copy-of select="*"/> -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	
	<xsl:template name="list" match="/presentation">
		<xsl:message>Name is <xsl:value-of select="name()"/></xsl:message>
		<html>
			<head><title><xsl:value-of select="title"/></title>
			</head>
		<body bgcolor="white">
			<h1><xsl:value-of select="title"/></h1>
			<ul>
				<xsl:for-each select="slide">
					<li>
						<a><xsl:attribute name="href">
							<xsl:choose>
								<xsl:when test="position() &lt; 10">
									<xsl:text>0</xsl:text>
									<xsl:value-of select="position()"/>
									</xsl:when>
								<xsl:otherwise>
									<xsl:text></xsl:text>
									<xsl:value-of select="position()"/>
									</xsl:otherwise>
								</xsl:choose>
							<xsl:text>.htm</xsl:text>
							</xsl:attribute>
						<xsl:value-of select="title"/>
						</a>
						</li>
					</xsl:for-each>
				</ul>
			</body></html>
		</xsl:template>
	
	</xsl:stylesheet>
