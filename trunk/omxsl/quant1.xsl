

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>


<xsl:template match="om:OMS[@cd='quant1' and @name='forall']" mode="ombind">
 <mrow>
  <mo>&#x2200;</mo>
  <xsl:apply-templates select="following-sibling::om:OMBVAR[1]"/>
  <mo>.</mo>
  <xsl:apply-templates select="following-sibling::*[2]"/>
 </mrow>
</xsl:template>

<xsl:template match="om:OMS[@cd='quant1' and @name='exists']" mode="ombind">
 <mrow>
  <mo>&#x2203;</mo>
  <xsl:apply-templates select="following-sibling::om:OMBVAR[1]"/>
  <mo>.</mo>
  <xsl:apply-templates select="following-sibling::*[2]"/>
 </mrow>
</xsl:template>


</xsl:stylesheet>



