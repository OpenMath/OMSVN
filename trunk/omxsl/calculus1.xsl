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


<xsl:template match="om:OMS[@cd='calculus1' and @name='diff']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, put the bound variable in the
subscript, and just typeset the body of the lambda expression,
zap the lambda.
-->
   <xsl:when test="following-sibling::*[1]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">
    <mfrac>
     <mi>d</mi>
    <mrow>
     <mi>d</mi>
     <xsl:apply-templates select="following-sibling::om:OMBIND/om:OMBVAR"/>
    </mrow>
    </mfrac>
    <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
     <mo>)</mo>
    </mrow>
   </xsl:when>
   <xsl:otherwise>
   <mo>D</mo>
   <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::*[1]"/>
     <mo>)</mo>
   </mrow>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<xsl:template match="om:OMS[@cd='calculus1' and @name='int']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, put the bound variable in the
subscript, and just typeset the body of the lambda expression,
zap the lambda.
-->
   <xsl:when test="following-sibling::*[1]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">
    <mo>&int;</mo>
    <mrow>
     <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
    </mrow>
    <mrow>
     <mi>d</mi>
     <xsl:apply-templates select="following-sibling::om:OMBIND/om:OMBVAR"/>
    </mrow>
   </xsl:when>
   <xsl:otherwise>
   <mo>&int;</mo>
   <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::*[1]"/>
     <mo>)</mo>
   </mrow>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>





<xsl:template
  match="om:OMS[@cd='calculus1' and @name='defint']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, put the bound variable in the
subscript, and just typeset the body of the lambda expression,
zap the lambda.
-->
   <xsl:when test="following-sibling::*[2]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">

   <xsl:choose>
<!--
If there is an explicit interval put limits top and bottom
else put range of summation at bottom
-->
   <xsl:when test="following-sibling::*[1]/self::om:OMA/*[1][self::om:OMS[@name='interval']]">
   <munderover>
     <mo>&int;</mo>
   <xsl:apply-templates select="following-sibling::om:OMA/*[2]"/>
   <xsl:apply-templates select="following-sibling::om:OMA/*[3]"/>
   </munderover>
   </xsl:when>
   <xsl:otherwise>
   <msub>
   <mo>&int;</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   </msub>
   </xsl:otherwise>
   </xsl:choose>
   <mrow>
   <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
   </mrow>
   <mrow>
     <mi>d</mi>
     <xsl:apply-templates select="following-sibling::om:OMBIND/om:OMBVAR"/>
   </mrow>
   </xsl:when>

<!--
 No lambda
-->
   <xsl:otherwise>
   <xsl:choose>
<!--
If there is an explicit interval put limits top and bottom
else put range of summation at bottom
-->
   <xsl:when test="following-sibling::*[1]/self::om:OMA/*[1][self::om:OMS[@name='interval']]">
   <munderover>
   <mo>&int;</mo>
   <xsl:apply-templates select="following-sibling::om:OMA/*[2]"/>
   <xsl:apply-templates select="following-sibling::om:OMA/*[3]"/>
   </munderover>
   </xsl:when>
   <xsl:otherwise>
   <msub>
   <mo>&int;</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   </msub>
   </xsl:otherwise>
   </xsl:choose>
   <xsl:apply-templates select="following-sibling::*[2]"/>
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>




<xsl:template match="om:OMS[@cd='calculus1' and @name='partialdiff']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, use d^2/dx/dy otherwise use D_1,2
-->
   <xsl:when test="following-sibling::*[2]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">
    <mfrac>
     <msup>
       <mi>&PartialD;</mi>
       <mn><xsl:value-of select="count(following-sibling::*[1]/om:OMI)"/></mn>
     </msup>
    <mrow>
      <xsl:apply-templates mode="dx" 
                           select="following-sibling::*[1]/om:OMI[1]"/>
    </mrow>
    </mfrac>
    <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
     <mo>)</mo>
    </mrow>
   </xsl:when>
   <xsl:otherwise>
   <mo>&PartialD;</mo>
   <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::*[1]"/>
     <mo>)</mo>
   </mrow>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template mode="dx" match="om:OMI">
  <xsl:param name="n" select="1"/>
  <xsl:variable name="v" select="../following-sibling::om:OMBIND/om:OMBVAR"/>
  <xsl:choose>
    <xsl:when 
       test="following-sibling::om:OMI[1][number(.) = number(current())]">
     <xsl:apply-templates mode="dx" 
                           select="following-sibling::om:OMI[1]">
       <xsl:with-param name="n" select="$n+1"/>
     </xsl:apply-templates>
   </xsl:when>
   <xsl:otherwise>
     <mrow>
     <mi>&PartialD;</mi>
     <xsl:choose>
       <xsl:when test="$n=1">
         <xsl:apply-templates select="$v/*[position()=current()]"/>
       </xsl:when>
       <xsl:otherwise>
         <msup>
           <xsl:apply-templates select="$v/*[position()=current()]"/>
           <xsl:value-of select="$n"/>
         </msup>
       </xsl:otherwise>
     </xsl:choose>
     </mrow>
     <xsl:apply-templates mode="dx" 
                           select="following-sibling::om:OMI[1]"/>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>



