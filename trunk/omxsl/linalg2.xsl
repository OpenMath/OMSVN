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

<xsl:template match="om:OMS[@cd='linalg2'  and @name='matrix']" >
  <mfenced><mtable>
   <xsl:apply-templates select="following-sibling::*"/>
  </mtable></mfenced>
</xsl:template>

<xsl:template match="om:OMS[@cd='linalg2'  and @name='matrixrow']" >
  <mtr>
   <xsl:for-each select="following-sibling::*">
   <mtd><xsl:apply-templates select="."/></mtd>
   </xsl:for-each>
  </mtr>
</xsl:template>

<xsl:template match="om:OMS[@cd='linalg2'  and @name='vector']" >
   <mfenced>
   <xsl:for-each select="following-sibling::*">
   <mrow><xsl:apply-templates select="."/></mrow>
   </xsl:for-each>
  </mfenced>>
</xsl:template>



</xsl:stylesheet>

