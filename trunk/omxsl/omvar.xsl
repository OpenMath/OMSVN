

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>




<xsl:template match="om:OMV[@name='theta']"  >
   <mi>&#x3B8;</mi>
</xsl:template>

<xsl:template match="om:OMV[@name='lambda']"  >
   <mi>&#x3BB;</mi>
</xsl:template>

<xsl:template match="om:OMV[@name='pi']"  >
   <mi>&#x3C0;</mi>
</xsl:template>

</xsl:stylesheet>



