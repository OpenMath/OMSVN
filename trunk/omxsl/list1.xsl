



<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>

<xsl:template match="om:OMS[@cd='list1' and @name='list']" >
<mfenced>
<xsl:apply-templates select="following-sibling::*"/>
</mfenced>
</xsl:template>

<xsl:template match="om:OMS[@cd='list1' and @name='list'][following-sibling::*/*/*]" priority="2">
<mtable>
<xsl:for-each select="following-sibling::*">
<mtr><mtd columnalign="left"><xsl:apply-templates select="."/></mtd></mtr>
</xsl:for-each>
</mtable>
</xsl:template>


</xsl:stylesheet>







