

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>




<xsl:template match="om:OMS[@cd='fns1' and @name='identity']" >
  <mrow>
  <mi>Id</mi>
  <mo><!-- AF --></mo>
  <mo>(</mo>
  <xsl:apply-templates select="following-sibling::*[1]"/>
  <mo>)</mo>
  </mrow>
</xsl:template>


<xsl:template match="om:OMS[@cd='fns1' and @name='inverse']" >
<msup>
<xsl:apply-templates select="following-sibling::*">
<xsl:with-param name="p" select="5"/>
</xsl:apply-templates>
<mn>-1</mn>
</msup>
</xsl:template>

<xsl:template match="om:OMS[@cd='fns1' and @name='left_compose']" >
  <xsl:param name="p"/>
  <xsl:call-template name="binary">
    <xsl:with-param name="mo"><mo>o</mo></xsl:with-param>
    <xsl:with-param name="p" select="$p"/>
    <xsl:with-param name="this-p" select="2"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="om:OMS[@cd='fns1' and @name='lambda']" mode="ombind">
 <mrow>
  <mo>&#x3BB;</mo>
  <xsl:apply-templates select="following-sibling::OMBVAR[1]"/>
  <mo>.</mo>
  <xsl:apply-templates select="following-sibling::*[2]"/>
 </mrow>
</xsl:template>


</xsl:stylesheet>



