<xsl:stylesheet 
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:x="http://xml.apache.org/xalan"
   xmlns:xx="http://icl.com/saxon"
>

<xsl:output method="html" indent="yes"/>

<xsl:variable name="extra" select="document('extra.xml',.)"/>
<xsl:variable name="contrib" select="document('../contrib/log.xml',.)"/>

<xsl:key name="oms" match="CDDefinition" use="concat(../@name,':',@name)"/>
<xsl:template match="/">
<html>
<head>
<title>Index</title>
</head>
<body>




<h1>OpenMath Symbols</h1>

<a href="../../cd/index.html">CD Home</a>
<hr/>

<xsl:variable name="all">
<xsl:for-each select="$contrib/log/cd[not(@name=following-sibling::cd/@name)]">
<CD path="contrib" name="{@name}">
<xsl:for-each select="document(concat('cd/',@name,'.ocd'),.)/CD/CDDefinition">
<CDDefinition name="{normalize-space(Name)}">
<xsl:copy-of select="Description"/>
</CDDefinition>
</xsl:for-each>
</CD>
</xsl:for-each>
<xsl:for-each select="$extra/page/cdgroups/cdgroup">
<xsl:for-each select="document(concat('../cdgroups/',@name,'.cdg'),.)/CDGroup/CDGroupMember/CDName">
<CD path=".." name="{.}">
(<xsl:for-each select="document(concat('../cd/',.,'.ocd'),.)/CD/CDDefinition">
<CDDefinition name="{normalize-space(Name)}">
<xsl:copy-of select="Description"/>
</CDDefinition>
</xsl:for-each>
</CD>
</xsl:for-each>
</xsl:for-each>
</xsl:variable>



<table border="1">
<tr>
<th>Symbol</th>
<th>CD</th>
<th>Description</th>
</tr>
<xsl:for-each select="x:nodeset($all)/CD/CDDefinition">
<xsl:sort select="@name"/>
<xsl:if test="generate-id(.)=generate-id(key('oms',concat(../@name,':',@name)))">
<tr>
<td><a href="../{../@path}/cd/{../@name}.html#{@name}"><xsl:value-of select="@name"/></a></td>
<td><xsl:value-of select="../@name"/></td>
<td><pre><xsl:copy-of select="Description/node()"/></pre></td>
</tr>
</xsl:if>
</xsl:for-each>
</table>
</body>
</html>
</xsl:template>





</xsl:stylesheet>

