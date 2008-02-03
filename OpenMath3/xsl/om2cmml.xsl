<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:om="http://www.openmath.org/OpenMath"
		xmlns="http://www.w3.org/1998/Math/MathML"
 
>

  <xsl:template match="*" mode="om2cmml">
    <xsl:message>om2cmml: <xsl:value-of select="name()"/></xsl:message>
  </xsl:template>

  <xsl:template match="om:OMA" mode="om2cmml">
    <apply>
      <xsl:apply-templates mode="om2cmml"/>
    </apply>
  </xsl:template>

  <xsl:template match="om:OMOBJ" mode="om2cmml">
    <math>
      <xsl:apply-templates mode="om2cmml"/>
    </math>
  </xsl:template>



  <xsl:template match="om:OMS" mode="om2cmml">
    <csymbol cd="{@cd}">
      <xsl:value-of select="@name"/>
    </csymbol>
  </xsl:template>

  <xsl:template match="om:OMV" mode="om2cmml">
    <ci>
      <xsl:value-of select="@name"/>
    </ci>
  </xsl:template>



  <xsl:template match="om:OMI" mode="om2cmml">
    <cn>
      <xsl:value-of select="."/>
    </cn>
  </xsl:template>

  <xsl:template match="om:OMBIND" mode="om2cmml">
    <bind>
      <xsl:apply-templates mode="om2cmml"/>
    </bind>
  </xsl:template>


  <xsl:template match="om:OMBVAR" mode="om2cmml">
    <xsl:for-each select="*">
    <bvar>
      <xsl:apply-templates mode="om2cmml" select="."/>
    </bvar>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>