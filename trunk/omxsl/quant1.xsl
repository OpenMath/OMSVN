<!DOCTYPE xsl:stylesheet [
<!ENTITY % om2pmml.ent SYSTEM "om2pmml.ent" >
%om2pmml.ent;
]>

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>


<xsl:template match="om:OMS[@cd='quant1' and @name='forall']" mode="ombind">
 <mrow>
  <mo>&forall;</mo>
  <xsl:apply-templates select="following-sibling::om:OMBVAR[1]"/>
  <mo>.</mo>
  <xsl:apply-templates select="following-sibling::*[2]"/>
 </mrow>
</xsl:template>

<xsl:template match="om:OMS[@cd='quant1' and @name='exists']" mode="ombind">
 <mrow>
  <mo>&exists;</mo>
  <xsl:apply-templates select="following-sibling::om:OMBVAR[1]"/>
  <mo>.</mo>
  <xsl:apply-templates select="following-sibling::*[2]"/>
 </mrow>
</xsl:template>


</xsl:stylesheet>



