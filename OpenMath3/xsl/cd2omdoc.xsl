<!-- An XSL style sheet for creating OMDoc from OpenMath Content Dictionaries
     Initial version 2000-05-18 by Michael Kohlhase 
     send bug-reports, patches, suggestions to kohlhase@mathweb.org
     Copyright (c) 2000 - 2002 Michael Kohlhase, 

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
  version="1.0"
  xmlns:func="http://exslt.org/functions" 
  xmlns="http://omdoc.org/ns"
  xmlns:omdoc="http://omdoc.org/ns"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns:dc="http://purl.org/dc/elements/1.1/" 
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:saxon="http://icl.com/saxon"
  extension-element-prefixes="func saxon"
  exclude-result-prefixes="omdoc func saxon xsl m om">

<xsl:output method="xml"
  version="1.0"
  indent="yes"
  cdata-section-elements="use"/>

<!-- for debugging -->
<xsl:template match="*">
  <xsl:message>warning: template for element <xsl:value-of select="local-name()"/> undefined in line <xsl:value-of select="saxon:line-number()"/></xsl:message>
</xsl:template>


<xsl:variable name="stsname" select="concat(/cd:CD/cd:CDName,'.sts')"/>
<xsl:variable name="stsfile" select="translate($stsname,'&#x9;&#x20;','')"/>
<xsl:variable name="here" select="/"/>
<xsl:variable name="sts" select="document($stsfile,$here)/cd:CDSignatures"/>

<!-- the default behavior is that everything (for instance OMOBJects)
     are copied verbatim. This is overridden later by the other rules
  -->
<xsl:template match="*" mode="copy">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates mode="copy"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="/">
  <xsl:variable name="cdname" select="normalize-space(cd:CD/cd:CDName)"/>
  <xsl:comment>
    <xsl:text> This OMDoc file  is automatically generated from the OpenMath Content 
     Dictionary "</xsl:text> 
    <xsl:value-of select="$cdname"/>
    <xsl:text>.ocd",  version </xsl:text>
    <xsl:value-of select="normalize-space(cd:CD/cd:CDVersion)"/> 
    <xsl:text>&#xA;     available at </xsl:text>
    <xsl:value-of select="normalize-space(cd:CD/cd:CDURL)"/>
    <xsl:text>,&#xA;     DO NOT EDIT!&#xA;</xsl:text>
    </xsl:comment>
    <xsl:apply-templates/>
</xsl:template>


<xsl:template match="cd:CD">
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:variable name="cdname" select="normalize-space(cd:CDName)"/>
  <omdoc>
    <xsl:copy-of select="omdoc:id($cdname,'omdoc')"/>
    <xsl:text>&#xA;</xsl:text>
    <metadata>
      <xsl:text>&#xA;</xsl:text>
      <xsl:if test="cd:Title">
	<dc:title><xsl:apply-templates select="cd:Title"/></dc:title>
	<xsl:text>&#xA;</xsl:text>
      </xsl:if>
      <dc:creator role="trl"><xsl:text>cd2omdoc</xsl:text></dc:creator>
      <xsl:text>&#xA;</xsl:text>
      <dc:creator role="aut"><xsl:text>The OpenMath Society</xsl:text></dc:creator>
      <xsl:text>&#xA;</xsl:text>
      <dc:description><xsl:apply-templates select="cd:Description" mode="dc"/></dc:description>
      <xsl:text>&#xA;</xsl:text>
      <dc:rights><xsl:value-of select="cd:CDComment"/></dc:rights>
      <xsl:text>&#xA;</xsl:text>
    </metadata>
    <xsl:text>&#xA;</xsl:text>
    <theory cdurl="{normalize-space(cd:CDURL)}"
	    cdbase="{normalize-space(cd:CDBase)}"
	    cdreviewdate="{normalize-space(cd:CDReviewDate)}" 
	    cdversion="{normalize-space(cd:CDVersion)}" 
	    cdrevision="{normalize-space(cd:CDRevision)}" 
	    cdstatus="{normalize-space(cd:CDStatus)}"> 
      <xsl:copy-of select="omdoc:id($cdname,'')"/>
      <xsl:apply-templates select="cd:CDDefinition"/>
    </theory>
  </omdoc>
</xsl:template>


<xsl:template match="cd:Name|cd:Role|cd:Title"/>

<xsl:template match="cd:CDDefinition">
  <xsl:variable name="id" select="normalize-space(cd:Name)"/>
  <xsl:text>&#xA;</xsl:text>
  <tgroup cd:type="CDDefinition">
    <xsl:text>&#xA;</xsl:text>
    <symbol name="{$id}">
      <xsl:text>&#xA;</xsl:text>
      <metadata>
	<xsl:text>&#xA;</xsl:text>
	<dc:description><xsl:apply-templates select="cd:Description" mode="dc"/></dc:description>
	<xsl:text>&#xA;</xsl:text>
      </metadata>
      <xsl:text>&#xA;</xsl:text>
      <xsl:if test="$sts/Signature[@name=$id]/om:OMOBJ">
	<type system="sts">
	  <xsl:copy-of select="$sts/Signature[@name=$id]/om:OMOBJ"/>
	</type>
      </xsl:if>
    </symbol>
    <xsl:text>&#xA;</xsl:text>
    <xsl:apply-templates select="child::node()[not(self::cd:Description) and not(self::cd:Name)]"/>
  </tgroup>
</xsl:template>

<xsl:template match="cd:Example">
  <xsl:variable name="id" select="normalize-space(../cd:Name)"/>
  <example type="for" for="{$id}" cd:type='Example'>
    <xsl:copy-of select="omdoc:nid($id,'ex')"/>
    <CMP><xsl:apply-templates mode="copy" select="text()"/></CMP>
    <xsl:apply-templates select="om:OMOBJ" mode="copy"/>
  </example>
</xsl:template>

<xsl:template match="cd:MMLexample">
  <xsl:variable name="id" select="normalize-space(../cd:Name)"/>
  <example cd:type="MMLexample" type="for" for="{$id}">
    <xsl:copy-of select="omdoc:nid($id,'ex')"/>
    <xsl:apply-templates/>
  </example>
</xsl:template>

<!-- we assume that every CMP that is followed by an FMP mean the same thing -->
<xsl:template match="cd:CDDefinition/cd:CMP">
  <xsl:variable name="id" select="normalize-space(../cd:Name)"/>
  <xsl:variable name="num"><xsl:number value="position()" format="1"/></xsl:variable>
  <assertion type="lemma">
    <xsl:copy-of select="omdoc:nid($id,'prop')"/>
    <CMP><xsl:copy-of select="*[node()]"/></CMP>
    <xsl:if test="following-sibling::cd:FMP">
      <xsl:copy-of select="following-sibling::cd:FMP[1]"/>
      <FMP><xsl:copy-of select="following-sibling::cd:FMP[1]/*[node()]"/></FMP>
    </xsl:if>
  </assertion>
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:FMP">
  <xsl:variable name="id" select="normalize-space(../cd:Name)"/>
  <xsl:variable name="num">
    <xsl:number value="position()" format="1"/>
  </xsl:variable>
  <xsl:if test="not(preceding-sibling::cd:CMP)">
    <xsl:message>fmp</xsl:message>
    <assertion>
      <xsl:copy-of select="omdoc:nid($id,'prop')"/>
      <CMP><xsl:apply-templates mode="copy"/></CMP>
    </assertion>
  </xsl:if>
</xsl:template>

<xsl:template match="cd:Description">
  <omtext cd:type="{local-name()}">
    <xsl:text>&#xA;</xsl:text>
    <CMP><xsl:apply-templates mode="copy"/></CMP>
    <xsl:text>&#xA;</xsl:text>
  </omtext>
</xsl:template>

<xsl:template match="cd:description|cd:discussion">
  <omtext cd:type="{local-name()}">
    <xsl:text>&#xA;</xsl:text>
    <CMP><xsl:apply-templates/></CMP>
    <xsl:text>&#xA;</xsl:text>
  </omtext>
</xsl:template>

<xsl:template match="cd:description/cd:p|cd:discussion/cd:p">
    <p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="cd:Description|cd:description|cd:discussion" mode="dc">
    <xsl:apply-templates mode="copy"/>
</xsl:template>

<xsl:template match="cd:CMP">
  <CMP><xsl:apply-templates mode="copy"/></CMP>
</xsl:template>

<xsl:template match="cd:FMP">
  <FMP><xsl:apply-templates mode="copy"/></FMP>
</xsl:template>
  
<xsl:template match="cd:property">
  <assertion cd:type="{local-name()}">
    <xsl:apply-templates/>
  </assertion>
</xsl:template>

<xsl:template match="cd:property/m:math">
  <FMP><xsl:apply-templates select="." mode="copy"/></FMP>
</xsl:template>

<xsl:template match="m:math">
  <xsl:apply-templates select="." mode="copy"/>
</xsl:template>

<xsl:template match="cd:property/cd:description|cd:MMLexample/cd:description">
  <CMP><xsl:apply-templates/></CMP>
</xsl:template>

<xsl:template match="cd:el|cd:var|cd:code|cd:quote">
  <phrase type="{local-name()}"><xsl:apply-templates/></phrase>
</xsl:template>

<xsl:template match="Signature"><xsl:apply-templates/></xsl:template>

<!-- this function makes an xml:id attribute, it first looks whether an xml:id attribute is already 
     present, if it is it takes that. If there is not, it constructs one from the arguments -->
<func:function name="omdoc:nidaux">
  <xsl:param name="id"/>
  <xsl:param name="type"/>
  <xsl:variable name="num"><xsl:number value="position()" format="1"/></xsl:variable>
  <func:result select="concat(omdoc:idaux($id,$type),'-',$num)"/>
</func:function>

<func:function name="omdoc:idaux">
  <xsl:param name="id"/>
  <xsl:param name="type"/>
  <xsl:choose>
    <xsl:when test="@id!=''"><func:result select="@id"/></xsl:when>
    <xsl:when test="$id!='' and $type!=''"><func:result select="concat($id,'-',$type)"/></xsl:when>
    <xsl:when test="$id!=''"><func:result select="$id"/></xsl:when>
  </xsl:choose>
</func:function>


<func:function name="omdoc:nid">
  <xsl:param name="id"/>
  <xsl:param name="type"/>
  <xsl:variable name="num"><xsl:number value="position()" format="1"/></xsl:variable>
  <xsl:attribute name="xml:id"><xsl:value-of select="omdoc:nidaux($id,$type)"/></xsl:attribute>
</func:function>

<func:function name="omdoc:id">
  <xsl:param name="id"/>
  <xsl:param name="type"/>
  <xsl:variable name="num"><xsl:number value="position()" format="1"/></xsl:variable>
  <xsl:attribute name="xml:id"><xsl:value-of select="omdoc:idaux($id,$type)"/></xsl:attribute>
</func:function>

</xsl:stylesheet>
