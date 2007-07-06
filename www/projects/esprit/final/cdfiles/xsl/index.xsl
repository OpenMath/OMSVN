<xsl:stylesheet 
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>


<xsl:template match="/">
<html>
<head>
<title>Index</title>
</head>
<body BGCOLOR="#FFFFFF">
<font size="-1">
  <xsl:apply-templates select="/cds/CD/CDDefinition/Name">
  <xsl:sort select="."/>
<!--   <xsl:sort select=".."/> -->
  </xsl:apply-templates>
</font>
</body>
</html>
</xsl:template>


<xsl:template match="Name">
  <xsl:variable name="c" select="normalize-space(../../CDName)"/>
  <xsl:variable name="n" select="normalize-space(.)"/>
  <br/>
  <a href="{$c}.html#{$n}" target="cdframe">
  <xsl:value-of select="$n"/>(<xsl:value-of select="$c"/>)
  </a>
</xsl:template>



<xsl:template match="text()">
</xsl:template>



</xsl:stylesheet>

