<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="xml" indent="yes"/>

<xsl:template match="text()|*">
  <xsl:copy>
    <xsl:copy-of select="@*[local-name()!='revisionflag']"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<!-- do the deletes -->
<xsl:template match="*[@revisionflag='deleted']"/>
<xsl:template match="phrase[@revisionflag='added' or @revisionflag='changed']"> 
<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
