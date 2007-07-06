<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:h="http://www.w3.org/1999/xhtml">

<xsl:template match="node()">
<xsl:copy>
<xsl:copy-of select="@*"/>
<xsl:apply-templates/>
</xsl:copy>
</xsl:template>

<xsl:template match="h:br"><br class="br"/></xsl:template>

</xsl:stylesheet>
