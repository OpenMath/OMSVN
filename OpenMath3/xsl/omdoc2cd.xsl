<!-- An XSL style sheet for creating OpenMath Content Dictionaries from OMDoc
     Initial version 20000718 by Michael Kohlhase 
     send bug-reports, patches, suggestions to kohlhase@mathweb.org

     Copyright (c) 2001 - 2002 Michael Kohlhase, 

     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
     version 2.1 of the License, or (at your option) any later version.

     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     Lesser General Public License for more details.

     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.openmath.org"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:omdoc="http://www.mathweb.org/omdoc"
  version="1.0">
 
<xsl:strip-space elements = "*"/> 

<xsl:output method="xml"
            version="1.0"
            indent="yes"
            standalone="yes"/>

<!-- the default behavior is that everything (for instance OMOBJects)
     are copied verbatim. This is overridden later by the other rules
  -->

<xsl:template match="*"><xsl:copy-of select="."/></xsl:template>

<xsl:template match="/">
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:comment>
    This Content Dictionary file is automatically generated from the OpenMath Document
    "<xsl:value-of select="omdoc:omdoc/omdoc:metadata/dc:title"/>", do not edit!
    It may contain more than one Content Dictionary declaration.
  </xsl:comment>
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:omdoc"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:metadata"></xsl:template>

<xsl:template match="omdoc:theory">
  <xsl:text>&#xA;&#xA;</xsl:text>
  <CD>
   <CDName>
    <xsl:choose>
     <xsl:when test="@cd"><xsl:value-of select="@cd"/></xsl:when>
     <xsl:otherwise><xsl:value-of select="@xml:id"/></xsl:otherwise>
    </xsl:choose>
   </CDName>
   <CDURL><xsl:text>Not Specified</xsl:text></CDURL>
   <CDReviewDate><xsl:text>Not Specified</xsl:text></CDReviewDate>
   <CDStatus><xsl:text>Experimental</xsl:text></CDStatus>
   <CDDate><xsl:value-of select="../omdoc:metadata/dc:date"/></CDDate>
   <CDVersion><xsl:text>Not Specified</xsl:text></CDVersion>
   <CDUses>
    <xsl:for-each select="imports">
     <xsl:value-of select="@from"/>
     <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
    </xsl:for-each>
   </CDUses>
   <Description>
    <xsl:choose>
     <xsl:when test="omdoc:metadata/dc:title">
      <xsl:value-of select="omdoc:metadata/dc:title"/>
     </xsl:when>
     <xsl:when test="omdoc:commonname[@xml:lang='en']">
      <xsl:value-of select="omdoc:commonname[@xml:lang='en']"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:text>The Content Dictionary for the OMDoc theory </xsl:text>
      <xsl:value-of select="@xml:id"/>
     </xsl:otherwise>
    </xsl:choose>
    <xsl:text>.&#xA;</xsl:text>
    <xsl:if test="omdoc:CMP">
     <xsl:text>&#xA;</xsl:text>
     <xsl:apply-templates select="CMP"/>
     <xsl:text>&#xA;</xsl:text>
    </xsl:if>
    <xsl:if test="omdoc:imports">
     <xsl:text>This CD imports symbols from other CDs. From&#xA;</xsl:text>
     <xsl:for-each select="omdoc:imports">
      <xsl:text> - the CD </xsl:text>
      <xsl:value-of select="@from"/>
      <xsl:text> all symbols </xsl:text>
      <xsl:choose>
       <xsl:when test="omdoc:morphism">
        <xsl:text>under the renaming given by the following recursive equations:&#xA;</xsl:text>
        <xsl:apply-templates select="omdoc:morphism"/>
       </xsl:when>
       <xsl:otherwise>
        <xsl:text>literally.&#xA;</xsl:text>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:for-each>
     <xsl:text>&#xA;</xsl:text>
    </xsl:if>
    <xsl:if test="omdoc:inclusion">
     <xsl:text>For this construction to make sense it is necessary that&#xA; 
     following conditions hold (which we assume for the purposes of this CD:&#xA;
    </xsl:text>
    <xsl:for-each select="omdoc:inclusion">
     <xsl:variable name="Inclusion" select="@for"/>
     <xsl:apply-templates select="id($Inclusion)"/>
    </xsl:for-each>
    <xsl:text>&#xA;</xsl:text>
   </xsl:if>
  </Description>
  <xsl:text>&#xA;</xsl:text>
  <xsl:apply-templates/>
 </CD>
</xsl:template>

<xsl:template match="omdoc:theory/omdoc:CMP"></xsl:template>

<xsl:template match="omdoc:imports"></xsl:template>

<xsl:template match="omdoc:requation">
 <xsl:apply-templates select="omdoc:pattern"/>
 <xsl:text> goes to </xsl:text>
 <xsl:apply-templates select="value"/>
 <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:pattern|omdoc:value"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:symbol">
 <xsl:variable name="Id"><xsl:value-of select="@name"/></xsl:variable>
 <xsl:text>&#xA;</xsl:text>
 <CDDefinition>
  <Name><xsl:value-of select="@name"/></Name>
  <xsl:if test="../omdoc:definition[@for = $Id]/omdoc:CMP">
   <CMP><xsl:apply-templates select="../omdoc:definition[@for = $Id]/omdoc:CMP"/></CMP>
  </xsl:if>
  <xsl:if test="../omdoc:definition[@for = $Id]/omdoc:FMP">
   <FMP><xsl:apply-templates select="../omdoc:definition[@for = $Id]/omdoc:FMP"/></FMP>
  </xsl:if>
 </CDDefinition>
 <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:assertion|omdoc:axiom|omdoc:commonname|omdoc:omtext|omdoc:definition|omdoc:proof|omdoc:exercise|omdoc:example|omdoc:omlet|omdoc:alternative|omdoc:proofobject"/>

<!-- the CMP and FMP elements are treated literally -->

<xsl:template match="omdoc:CMP|omdoc:FMP"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:adt">
 <xsl:variable name="AdtName">
  <xsl:choose>
   <xsl:when test="omdoc:commoname[@xml:lang='en']">
    <xsl:value-of select="omdoc:commoname[@xml:lang='en']"/>
   </xsl:when>
   <xsl:otherwise><xsl:value-of select="@xml:id"/></xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <CDComment>
   <xsl:text>The next symbols form the abstract data type </xsl:text> 
   <xsl:value-of select="$AdtName"/>
   <xsl:text>&#xA;This means that they should be considered together.&#xA;</xsl:text>
   <xsl:choose>
     <xsl:when test="self::node()[@type='loose']">
       <xsl:value-of select="$AdtName"/>
       <xsl:text> is a so-called loose abstract data type,&#xA;</xsl:text>
       <xsl:text>this means that the sorts contain all constructor terms, but&#xA;</xsl:text>
       <xsl:text> - may contain other elements, and&#xA;</xsl:text>
       <xsl:text> - there may be non-trivial equalities between elements.&#xA;</xsl:text>
     </xsl:when>
     <xsl:when test="self::node()[@type='generated']">
       <xsl:value-of select="$AdtName"/>
       <xsl:text> is a so-called generated abstract data type,&#xA;</xsl:text>
       <xsl:text>this means that the sorts are generated by the constants, i.e.&#xA;</xsl:text>
       <xsl:text> - they contain no other elements, than the constructor terms, but&#xA;</xsl:text>
       <xsl:text> - there may be non-trivial equalities between elements.&#xA;</xsl:text>
     </xsl:when>
     <xsl:when test="self::node()[@type='free']">
       <xsl:value-of select="$AdtName"/>
       <xsl:text> is a so-called freely generated abstract data type,&#xA;</xsl:text>
       <xsl:text>this means that the sorts are generated by the constants, i.e.&#xA;</xsl:text>
       <xsl:text> - they contain no other elements, than the constructor terms, and&#xA;</xsl:text>
       <xsl:text> - there are no non-trivial equalities between elements.&#xA;</xsl:text>
     </xsl:when>
   </xsl:choose>
 </CDComment>
  <xsl:apply-templates select="omdoc:CMP[@xml:lang='en']"/>
  <xsl:apply-templates/>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <CDComment>
  <xsl:text>END of the abstract data type </xsl:text>
  <xsl:value-of select="$AdtName"/>
 </CDComment>
</xsl:template>

<xsl:template match="omdoc:sortdef">
 <xsl:variable name="SortName">
  <xsl:choose>
    <xsl:when test="omdoc:metadata/dc:subject[@xml:lang='en']">
      <xsl:value-of select="omdoc:metadata/dc:subject[@xml:lang='en']"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="@name"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <CDComment>
  <xsl:text>The following definitions specify the sort (= set) </xsl:text>
  <xsl:value-of select="$SortName"/>
 </CDComment>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <CDDefinition>
  <Name><xsl:value-of select="@name"/></Name>
  <Description>
   <xsl:text>The set </xsl:text><xsl:value-of select="$SortName"/>
   <xsl:if test="omdoc:insort">
    <xsl:text> is a superset of the union of </xsl:text>
    <xsl:for-each select="omdoc:insort"><xsl:value-of select="@for"/></xsl:for-each>
    <xsl:text>&#xA;and</xsl:text>
   </xsl:if>
   <xsl:if test="omdoc:constructor">
    <xsl:text> contains all terms that can be built up from the symbols&#xA;</xsl:text>
    <xsl:for-each select="omdoc:constructor">
     <xsl:value-of select="@name"/>
     <xsl:if test="omdoc:argument">
      <xsl:text> (applied to objects of sort </xsl:text>
      <xsl:for-each select="omdoc:argument">
       <xsl:value-of select="@sort"/>
      </xsl:for-each>
      <xsl:text>)&#xA;</xsl:text>
     </xsl:if>
    </xsl:for-each>
   </xsl:if>
   <xsl:text>&#xA;</xsl:text>
  </Description>
 </CDDefinition>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <xsl:apply-templates/>
 <CDComment>
  <xsl:text>END of the sort </xsl:text><xsl:value-of select="$SortName"/><xsl:text>.&#xA;</xsl:text>
 </CDComment>
 <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:insort"/>

<xsl:template match="omdoc:constructor">
 <xsl:variable name="ConstructorName">
  <xsl:choose>
    <xsl:when test="omdoc:metadata/dc:subject[@xml:lang='en']">
      <xsl:value-of select="omdoc:metdata/dc:subject[@xml:lang='en']"/>
   </xsl:when>
   <xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:variable name="SortName">
  <xsl:choose>
    <xsl:when test="../omdoc:metadata/dc:subject[@xml:lang='en']">
      <xsl:value-of select="omdoc:metadata/dc:subject[@xml:lang='en']"/>
   </xsl:when>
   <xsl:otherwise><xsl:value-of select="../@name"/></xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <CDDefinition>
  <Name><xsl:value-of select="@name"/></Name>
  <Description>
   <xsl:text>This symbol is a constructor of the set </xsl:text>
   <xsl:value-of select="$SortName"/>
   <xsl:if test="omdoc:argument">
    <xsl:text>, it takes arguments of the sorts </xsl:text>
    <xsl:for-each select="omdoc:argument">
     <xsl:value-of select="@sort"/>
     <xsl:text>, </xsl:text>
    </xsl:for-each>
   </xsl:if>
  </Description>
 </CDDefinition>
 <xsl:text>&#xA;</xsl:text>
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:argument"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:selector">
 <xsl:variable name="ConstructorName">
  <xsl:choose>
    <xsl:when test="../../omdoc:metadata/dc:subject[@xml:lang='en']">
      <xsl:value-of select="../../omdoc:metadata/dc:subject[@xml:lang='en']"/>
   </xsl:when>
   <xsl:otherwise><xsl:value-of select="../../@name"/></xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:variable name="ArgumentNumber">
  <xsl:text>9999</xsl:text>
  <!-- use something like 	<xsl:number value="position()" format="1"/> -->
 </xsl:variable>
 <xsl:variable name="ArgumentSort"><xsl:value-of select="../@sort"/></xsl:variable>
 <xsl:variable name="SelectorName">
  <xsl:choose>
    <xsl:when test="omdoc:metadata/dc:subject[@xml:lang='en']">
      <xsl:value-of select="omdoc:metadata/dc:subject[@xml:lang='en']"/>
   </xsl:when>
   <xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
  </xsl:choose>
  </xsl:variable>
  <CDDefinition>
   <Name><xsl:value-of select="@name"/></Name>
   <Description>
    <xsl:text>This symbol is a </xsl:text>
    <xsl:value-of select="@type"/>
    <xsl:text> inverse of the </xsl:text>
    <xsl:value-of select="$ArgumentNumber"/>
    <xsl:text>-th argument&#xA;</xsl:text>
    <xsl:text>of the constructor </xsl:text>
    <xsl:value-of select="$ConstructorName"/>
    <xsl:text> on the argument sort </xsl:text>
    <xsl:value-of select="$ArgumentSort"/>
    <xsl:text>.&#xA;</xsl:text>
   </Description>
   <xsl:text>&#xA;</xsl:text>
  </CDDefinition>
  <xsl:text>&#xA;</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:inclusion"></xsl:template>

<xsl:template match="omdoc:axiom-inclusion|omdoc:theory-inclusion">
 <xsl:variable name="FromCD">
  <xsl:value-of select="@from"/>
 </xsl:variable>
 <xsl:variable name="ToCD">
  <xsl:value-of select="@to"/>
 </xsl:variable>
  <!-- ###todo: something fancier to get the actual cd name -->
  <xsl:text>&#xA; - The meanings of symbols from the CD </xsl:text>
  <xsl:value-of select="$FromCD"/>
  <xsl:text> must be presrveed&#xA;   (all FMP/CMP continue to hold) in the CD </xsl:text>
  <xsl:value-of select="$ToCD"/>
  <xsl:choose>
   <xsl:when test="omdoc:morphism">
    <xsl:text>,&#xA;   under the renaming given by the following recursive equations:&#xA;</xsl:text>
    <xsl:apply-templates select="omdoc:morphism"/>
   </xsl:when>
   <xsl:otherwise><xsl:text>.&#xA;</xsl:text></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:code|omdoc:private|omdoc:presentation"/>

</xsl:stylesheet>

