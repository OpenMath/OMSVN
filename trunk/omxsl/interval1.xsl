
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>




<xsl:template match="om:OMS[@cd='interval1' and @name='integer_interval']" >
   <mo>[</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   <mo>,</mo>
   <xsl:apply-templates select="following-sibling::*[2]"/>
   <mo>]</mo>
</xsl:template>



<xsl:template match="om:OMS[@cd='interval1' and @name='interval']" >
   <mo>(</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   <mo>,</mo>
   <xsl:apply-templates select="following-sibling::*[2]"/>
   <mo>)</mo>
</xsl:template>



<xsl:template match="om:OMS[@cd='interval1' and @name='interval_oo']" >
   <mo>(</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   <mo>,</mo>
   <xsl:apply-templates select="following-sibling::*[2]"/>
   <mo>)</mo>
</xsl:template>


<xsl:template match="om:OMS[@cd='interval1' and @name='interval_cc']" >
   <mo>[</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   <mo>,</mo>
   <xsl:apply-templates select="following-sibling::*[2]"/>
   <mo>]</mo>
</xsl:template>



<xsl:template match="om:OMS[@cd='interval1' and @name='interval_oc']" >
   <mo>(</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   <mo>,</mo>
   <xsl:apply-templates select="following-sibling::*[2]"/>
   <mo>]</mo>
</xsl:template>



<xsl:template match="om:OMS[@cd='interval1' and @name='interval_co']" >
   <mo>[</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   <mo>,</mo>
   <xsl:apply-templates select="following-sibling::*[2]"/>
   <mo>)</mo>
</xsl:template>

</xsl:stylesheet>



