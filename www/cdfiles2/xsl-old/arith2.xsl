
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>




<xsl:template match="om:OMS[@cd='arith2' and @name='inverse']" >
<msup>
<xsl:apply-templates select="following-sibling::*">
<xsl:with-param name="p" select="5"/>
</xsl:apply-templates>
<mn>-1</mn>
</msup>
</xsl:template>

<!-- times added to arith1 -->
<!-- arg works by default -->

</xsl:stylesheet>



