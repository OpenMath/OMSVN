
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
>
<xsl:output method="text"/>

<xsl:template match="/">

cd.attlist.OMS |= 
  attribute cd {string "<xsl:value-of select="normalize-space(CD/CDName)"/>" },
  attribute name {<xsl:text/>
<xsl:for-each select="CD/CDDefinition">
  <xsl:text>&#10;    string "</xsl:text>
  <xsl:value-of select="normalize-space(Name)"/>" <xsl:text/>
  <xsl:if test="position() &lt; last()">|</xsl:if>
</xsl:for-each>}
</xsl:template>
</xsl:stylesheet>