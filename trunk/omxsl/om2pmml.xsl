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
<xsl:output method="xml" indent="yes"/>

<xsl:include href="arith1.xsl"/>
<xsl:include href="arith2.xsl"/>
<!-- default OK
 <xsl:include href="transc11.xsl"/>
 <xsl:include href="minmax.xsl"/>
-->
<xsl:include href="alg1.xsl"/>
<xsl:include href="integer1.xsl"/>
<xsl:include href="interval1.xsl"/>
<xsl:include href="nums1.xsl"/>
<xsl:include href="relation1.xsl"/>
<xsl:include href="calculus1.xsl"/>
<xsl:include href="fns1.xsl"/>
<xsl:include href="quant1.xsl"/>
<xsl:include href="logic1.xsl"/>
<xsl:include href="bigfloat.xsl"/>
<xsl:include href="list1.xsl"/>
<xsl:include href="linalg2.xsl"/>
<xsl:include href="set1.xsl"/>
<xsl:include href="setname1.xsl"/>
<xsl:include href="combinat1.xsl"/>
<!-- -->
<xsl:include href="omvar.xsl"/>
<!-- -->
<!-- -->
<xsl:include href="verbxml.xsl"/>
<!-- -->
<xsl:include href="fns2.xsl"/>



<xsl:template match="om:OMOBJ">
  <math display="block">
    <xsl:apply-templates/>
  </math>
</xsl:template>

<xsl:template match="om:OMATP"/>


<xsl:template match="om:OMA">
  <xsl:param name="p" select="0"/>
  <mrow>
    <xsl:apply-templates select="*[1]">
      <xsl:with-param name="p" select="$p"/>
    </xsl:apply-templates>
  </mrow>
</xsl:template>

<xsl:template match="om:OMBIND">
  <xsl:param name="p" select="0"/>
  <mrow>
    <xsl:apply-templates mode="ombind" select="*[1]">
      <xsl:with-param name="p" select="$p"/>
    </xsl:apply-templates>
  </mrow>
</xsl:template>

<xsl:template match="om:OMBVAR">
  <mrow>
    <xsl:for-each select="*">
      <xsl:apply-templates select="."/>
      <xsl:if test="not(position()=last())"><mo>,</mo></xsl:if>
    </xsl:for-each>
  </mrow>
</xsl:template>


<xsl:template match="om:OMV">
  <mi>
    <xsl:value-of select="@name"/>
  </mi>
</xsl:template>

<xsl:template match="om:OMSTR">
  <mtext>
    <xsl:value-of select="."/>
  </mtext>
</xsl:template>


<xsl:template match="om:OMI">
  <mn>
    <xsl:value-of select="."/>
  </mn>
</xsl:template>

<xsl:template match="om:OMF">
  <mn>
    <xsl:value-of select="@dec"/>
  </mn>
</xsl:template>


<xsl:template match="om:OMS">
<xsl:message>[<xsl:value-of select="@cd"/>:<xsl:value-of select="@name"/>]</xsl:message>
  <mrow>
  <mi><xsl:value-of select="@name"/></mi>
  <xsl:if test="parent::om:OMA and not(preceding-sibling::*)">
  <mo>&ApplyFunction;</mo>
  <mrow>
  <mo>(</mo>
  <xsl:for-each select="following-sibling::*">
   <xsl:apply-templates select="."/>
   <xsl:if test="position() &lt; last()"><mo>,</mo></xsl:if>
  </xsl:for-each>
  <mo>)</mo>
  </mrow>
  </xsl:if>
  </mrow>
</xsl:template>



<xsl:template name="infix" >
  <xsl:param name="mo"/>
  <xsl:param name="p" select="0"/>
  <xsl:param name="this-p" select="0"/>
  <xsl:choose>
  <xsl:when test="parent::om:OMA and not(preceding-sibling::*)">
  <mrow>
  <xsl:if test="$this-p &lt; $p"><mo>(</mo></xsl:if>
  <xsl:for-each select="following-sibling::*">
   <xsl:if test="position() &gt; 1">
    <xsl:copy-of select="$mo"/>
   </xsl:if>   
   <xsl:apply-templates select=".">
     <xsl:with-param name="p" select="$this-p"/>
   </xsl:apply-templates>
  </xsl:for-each>
  <xsl:if test="$this-p &lt; $p"><mo>)</mo></xsl:if>
  </mrow>
  </xsl:when>
  <xsl:otherwise>
    <xsl:copy-of select="$mo"/>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="binary" >
  <xsl:param name="mo"/>
  <xsl:param name="p" select="0"/>
  <xsl:param name="this-p" select="0"/>
  <xsl:choose>
  <xsl:when test="parent::om:OMA and not(preceding-sibling::*)">
  <mrow>
  <xsl:if test="$this-p &lt; $p"><mo>(</mo></xsl:if>
   <xsl:apply-templates select="following-sibling::*[1]">
     <xsl:with-param name="p" select="$this-p"/>
   </xsl:apply-templates>
   <xsl:copy-of select="$mo"/>
   <xsl:apply-templates select="following-sibling::*[2]">
     <xsl:with-param name="p" select="$this-p"/>
   </xsl:apply-templates>
  </mrow>
  </xsl:when>
  <xsl:otherwise>
    <xsl:copy-of select="$mo"/>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
