
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
>
<xsl:output method="text"/>

<xsl:variable name="attribution"
   select="document(concat('sts/',normalize-space(CD/CDName),'.sts'))/CDSignatures/Signature[OMOBJ/OMS[@name='attribution'
   and @cd='sts']]"/>

<xsl:template match="/">

<xsl:variable name="a"
  select="CD/CDDefinition[not(normalize-space(Name)=$attribution/@name)]"/>
<xsl:if test="$a">
cd.attlist.OMS |= 
  attribute cd {string "<xsl:value-of select="normalize-space(CD/CDName)"/>" },
  attribute name {<xsl:text/>
<xsl:for-each select="$a">
  <xsl:text>&#10;    string "</xsl:text>
  <xsl:value-of select="normalize-space(Name)"/>" <xsl:text/>
  <xsl:if test="position() &lt; last()">|</xsl:if>
</xsl:for-each>}
</xsl:if>

<xsl:variable name="b"
  select="CD/CDDefinition[normalize-space(Name)=$attribution/@name]"/>
<xsl:if test="$b">
cd.attlist.OMS.attrib |= 
  attribute cd {string "<xsl:value-of select="normalize-space(CD/CDName)"/>" },
  attribute name {<xsl:text/>
<xsl:for-each select="$b">
  <xsl:text>&#10;    string "</xsl:text>
  <xsl:value-of select="normalize-space(Name)"/>" <xsl:text/>
  <xsl:if test="position() &lt; last()">|</xsl:if>
</xsl:for-each>}
</xsl:if>

</xsl:template>
</xsl:stylesheet>