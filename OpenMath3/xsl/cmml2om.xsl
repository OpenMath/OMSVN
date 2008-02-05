<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.openmath.org/OpenMath"
		xmlns:m="http://www.w3.org/1998/Math/MathML"
 
>

  <xsl:template match="*" mode="cmml2om">
    <xsl:message>cmml2om: <xsl:value-of select="name()"/></xsl:message>
  </xsl:template>

  <xsl:template match="m:apply" mode="cmml2om">
    <OMA>
      <xsl:apply-templates mode="cmml2om"/>
    </OMA>
  </xsl:template>

  <xsl:template match="m:math" mode="cmml2om">
    <OMOBJ>
      <xsl:apply-templates mode="cmml2om"/>
    </OMOBJ>
  </xsl:template>



  <xsl:template match="m:csymbol" mode="cmml2om">
    <OMS cd="{@cd}" name="{.}"/>
  </xsl:template>

  <xsl:template match="m:ci" mode="cmml2om">
    <OMV name="{.}"/>
  </xsl:template>



  <xsl:template match="m:cn" mode="cmml2om">
    <OMI>
      <xsl:value-of select="."/>
    </OMI>
  </xsl:template>

  <xsl:template match="m:bind" mode="cmml2om">
    <OMBIND>
	<xsl:apply-templates select="*[1]" mode="cmml2om"/>
      <OMBVAR>
	<xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
      </OMBVAR>
      <xsl:apply-templates select="*[last()]" mode="cmml2om"/>
    </OMBIND>
  </xsl:template>



   <xsl:template match="m:lcm" mode="cmml2om">
      <OMS cd="arith1" name="lcm"/>
   </xsl:template>
   <xsl:template match="m:big_lcm" mode="cmml2om">
      <OMS cd="arith1" name="big_lcm"/>
   </xsl:template>
   <xsl:template match="m:gcd" mode="cmml2om">
      <OMS cd="arith1" name="gcd"/>
   </xsl:template>
   <xsl:template match="m:big_gcd" mode="cmml2om">
      <OMS cd="arith1" name="big_gcd"/>
   </xsl:template>
   <xsl:template match="m:plus" mode="cmml2om">
      <OMS cd="arith1" name="plus"/>
   </xsl:template>
   <xsl:template match="m:unary_minus" mode="cmml2om">
      <OMS cd="arith1" name="unary_minus"/>
   </xsl:template>
   <xsl:template match="m:minus" mode="cmml2om">
      <OMS cd="arith1" name="minus"/>
   </xsl:template>
   <xsl:template match="m:times" mode="cmml2om">
      <OMS cd="arith1" name="times"/>
   </xsl:template>
   <xsl:template match="m:divide" mode="cmml2om">
      <OMS cd="arith1" name="divide"/>
   </xsl:template>
   <xsl:template match="m:power" mode="cmml2om">
      <OMS cd="arith1" name="power"/>
   </xsl:template>
   <xsl:template match="m:abs" mode="cmml2om">
      <OMS cd="arith1" name="abs"/>
   </xsl:template>
   <xsl:template match="m:root" mode="cmml2om">
      <OMS cd="arith1" name="root"/>
   </xsl:template>
   <xsl:template match="m:apply[*[1][self::m:root]][not(m:degree)]" mode="cmml2om">
     <OMA>
       <OMS cd="arith1" name="root"/>
       <xsl:apply-templates select="*[2]" mode="cmml2om"/>
       <OMI>2</OMI>
     </OMA>
   </xsl:template>
   <xsl:template match="m:apply[*[1][self::m:root]][m:degree]" mode="cmml2om">
     <OMA>
       <OMS cd="arith1" name="root"/>
       <xsl:apply-templates select="*[position()!=1 and not(self::degree)],m:degree/*" mode="cmml2om"/>
     </OMA>
   </xsl:template>
   <xsl:template match="m:sum" mode="cmml2om">
      <OMS cd="arith1" name="sum"/>
   </xsl:template>
   <xsl:template match="m:product" mode="cmml2om">
      <OMS cd="arith1" name="product"/>
   </xsl:template>
   <xsl:template match="m:diff" mode="cmml2om">
      <OMS cd="calculus1" name="diff"/>
   </xsl:template>
   <xsl:template match="m:nthdiff" mode="cmml2om">
      <OMS cd="calculus1" name="nthdiff"/>
   </xsl:template>
   <xsl:template match="m:partialdiff" mode="cmml2om">
      <OMS cd="calculus1" name="partialdiff"/>
   </xsl:template>

<!-- to be done...
   <xsl:template match="m:*[self::m:apply or self::m:bind][*[1][self::m:partialdiff]]" mode="cmml2om">
     <OMA>
       <OMS cd="calculus1" name="partialdif"/>
      <OMA>
        <OMS cd="list1" name="list"/>
       <xsl:apply-templates select="*[2]" mode="cmml2om"/>
     </OMA>
   </xsl:template>
-->

   <xsl:template match="m:int" mode="cmml2om">
      <OMS cd="calculus1" name="int"/>
   </xsl:template>
   <xsl:template match="m:defint" mode="cmml2om">
      <OMS cd="calculus1" name="defint"/>
   </xsl:template>
   <xsl:template match="m:complex_cartesian" mode="cmml2om">
      <OMS cd="complex1" name="complex_cartesian"/>
   </xsl:template>
   <xsl:template match="m:real" mode="cmml2om">
      <OMS cd="complex1" name="real"/>
   </xsl:template>
   <xsl:template match="m:imaginaryi" mode="cmml2om">
      <OMS cd="complex1" name="imaginaryi"/>
   </xsl:template>
   <xsl:template match="m:complex_polar" mode="cmml2om">
      <OMS cd="complex1" name="complex_polar"/>
   </xsl:template>
   <xsl:template match="m:argument" mode="cmml2om">
      <OMS cd="complex1" name="argument"/>
   </xsl:template>
   <xsl:template match="m:conjugate" mode="cmml2om">
      <OMS cd="complex1" name="conjugate"/>
   </xsl:template>
   <xsl:template match="m:unhandled_symbol" mode="cmml2om">
      <OMS cd="error1" name="unhandled_symbol"/>
   </xsl:template>
   <xsl:template match="m:unexpected_symbol" mode="cmml2om">
      <OMS cd="error1" name="unexpected_symbol"/>
   </xsl:template>
   <xsl:template match="m:unsupported_CD" mode="cmml2om">
      <OMS cd="error1" name="unsupported_CD"/>
   </xsl:template>
   <xsl:template match="m:domain" mode="cmml2om">
      <OMS cd="fns1" name="domain"/>
   </xsl:template>
   <xsl:template match="m:range" mode="cmml2om">
      <OMS cd="fns1" name="range"/>
   </xsl:template>
   <xsl:template match="m:image" mode="cmml2om">
      <OMS cd="fns1" name="image"/>
   </xsl:template>
   <xsl:template match="m:identity" mode="cmml2om">
      <OMS cd="fns1" name="identity"/>
   </xsl:template>
   <xsl:template match="m:left_inverse" mode="cmml2om">
      <OMS cd="fns1" name="left_inverse"/>
   </xsl:template>
   <xsl:template match="m:right_inverse" mode="cmml2om">
      <OMS cd="fns1" name="right_inverse"/>
   </xsl:template>
   <xsl:template match="m:inverse" mode="cmml2om">
      <OMS cd="fns1" name="inverse"/>
   </xsl:template>
   <xsl:template match="m:left_compose" mode="cmml2om">
      <OMS cd="fns1" name="left_compose"/>
   </xsl:template>
   <xsl:template match="m:lambda" mode="cmml2om">
      <OMS cd="fns1" name="lambda"/>
   </xsl:template>
   <xsl:template match="m:factorof" mode="cmml2om">
      <OMS cd="integer1" name="factorof"/>
   </xsl:template>
   <xsl:template match="m:factorial" mode="cmml2om">
      <OMS cd="integer1" name="factorial"/>
   </xsl:template>
   <xsl:template match="m:quotient" mode="cmml2om">
      <OMS cd="integer1" name="quotient"/>
   </xsl:template>
   <xsl:template match="m:rem" mode="cmml2om">
      <OMS cd="integer1" name="remainder"/>
   </xsl:template>
   <xsl:template match="m:integer_interval" mode="cmml2om">
      <OMS cd="interval1" name="integer_interval"/>
   </xsl:template>
   <xsl:template match="m:interval" mode="cmml2om">
      <OMS cd="interval1" name="interval"/>
   </xsl:template>
   <xsl:template match="m:interval_oo" mode="cmml2om">
      <OMS cd="interval1" name="interval_oo"/>
   </xsl:template>
   <xsl:template match="m:interval_cc" mode="cmml2om">
      <OMS cd="interval1" name="interval_cc"/>
   </xsl:template>
   <xsl:template match="m:interval_oc" mode="cmml2om">
      <OMS cd="interval1" name="interval_oc"/>
   </xsl:template>
   <xsl:template match="m:interval_co" mode="cmml2om">
      <OMS cd="interval1" name="interval_co"/>
   </xsl:template>
   <xsl:template match="m:limit" mode="cmml2om">
      <OMS cd="limit1" name="limit"/>
   </xsl:template>
   <xsl:template match="m:both_sides" mode="cmml2om">
      <OMS cd="limit1" name="both_sides"/>
   </xsl:template>
   <xsl:template match="m:above" mode="cmml2om">
      <OMS cd="limit1" name="above"/>
   </xsl:template>
   <xsl:template match="m:below" mode="cmml2om">
      <OMS cd="limit1" name="below"/>
   </xsl:template>
   <xsl:template match="m:null" mode="cmml2om">
      <OMS cd="limit1" name="null"/>
   </xsl:template>
   <xsl:template match="m:vectorproduct" mode="cmml2om">
      <OMS cd="linalg1" name="vectorproduct"/>
   </xsl:template>
   <xsl:template match="m:scalarproduct" mode="cmml2om">
      <OMS cd="linalg1" name="scalarproduct"/>
   </xsl:template>
   <xsl:template match="m:outerproduct" mode="cmml2om">
      <OMS cd="linalg1" name="outerproduct"/>
   </xsl:template>
   <xsl:template match="m:transpose" mode="cmml2om">
      <OMS cd="linalg1" name="transpose"/>
   </xsl:template>
   <xsl:template match="m:determinant" mode="cmml2om">
      <OMS cd="linalg1" name="determinant"/>
   </xsl:template>
   <xsl:template match="m:vector_selector" mode="cmml2om">
      <OMS cd="linalg1" name="vector_selector"/>
   </xsl:template>
   <xsl:template match="m:matrix_selector" mode="cmml2om">
      <OMS cd="linalg1" name="matrix_selector"/>
   </xsl:template>
   <xsl:template match="m:vector" mode="cmml2om">
      <OMS cd="linalg2" name="vector"/>
   </xsl:template>
   <xsl:template match="m:matrixrow" mode="cmml2om">
      <OMS cd="linalg2" name="matrixrow"/>
   </xsl:template>
   <xsl:template match="m:matrix" mode="cmml2om">
      <OMS cd="linalg2" name="matrix"/>
   </xsl:template>
   <xsl:template match="m:map" mode="cmml2om">
      <OMS cd="list1" name="map"/>
   </xsl:template>
   <xsl:template match="m:suchthat" mode="cmml2om">
      <OMS cd="list1" name="suchthat"/>
   </xsl:template>
   <xsl:template match="m:list" mode="cmml2om">
      <OMS cd="list1" name="list"/>
   </xsl:template>
   <xsl:template match="m:equivalent" mode="cmml2om">
      <OMS cd="logic1" name="equivalent"/>
   </xsl:template>
   <xsl:template match="m:not" mode="cmml2om">
      <OMS cd="logic1" name="not"/>
   </xsl:template>
   <xsl:template match="m:and" mode="cmml2om">
      <OMS cd="logic1" name="and"/>
   </xsl:template>
   <xsl:template match="m:xor" mode="cmml2om">
      <OMS cd="logic1" name="xor"/>
   </xsl:template>
   <xsl:template match="m:or" mode="cmml2om">
      <OMS cd="logic1" name="or"/>
   </xsl:template>
   <xsl:template match="m:implies" mode="cmml2om">
      <OMS cd="logic1" name="implies"/>
   </xsl:template>
   <xsl:template match="m:true" mode="cmml2om">
      <OMS cd="logic1" name="true"/>
   </xsl:template>
   <xsl:template match="m:false" mode="cmml2om">
      <OMS cd="logic1" name="false"/>
   </xsl:template>
   <xsl:template match="m:type" mode="cmml2om">
      <OMS cd="mathmltypes" name="type"/>
   </xsl:template>
   <xsl:template match="m:integer_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="integer_type"/>
   </xsl:template>
   <xsl:template match="m:real_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="real_type"/>
   </xsl:template>
   <xsl:template match="m:rational_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="rational_type"/>
   </xsl:template>
   <xsl:template match="m:complex_cartesian_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="complex_cartesian_type"/>
   </xsl:template>
   <xsl:template match="m:complex_polar_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="complex_polar_type"/>
   </xsl:template>
   <xsl:template match="m:constant_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="constant_type"/>
   </xsl:template>
   <xsl:template match="m:vector_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="vector_type"/>
   </xsl:template>
   <xsl:template match="m:list_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="list_type"/>
   </xsl:template>
   <xsl:template match="m:set_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="set_type"/>
   </xsl:template>
   <xsl:template match="m:matrix_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="matrix_type"/>
   </xsl:template>
   <xsl:template match="m:fn_type" mode="cmml2om">
      <OMS cd="mathmltypes" name="fn_type"/>
   </xsl:template>
   <xsl:template match="m:min" mode="cmml2om">
      <OMS cd="minmax1" name="min"/>
   </xsl:template>
   <xsl:template match="m:max" mode="cmml2om">
      <OMS cd="minmax1" name="max"/>
   </xsl:template>
   <xsl:template match="m:size[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="size"/>
   </xsl:template>
   <xsl:template match="m:cartesian_product[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="cartesian_product"/>
   </xsl:template>
   <xsl:template match="m:emptyset[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="emptyset"/>
   </xsl:template>
   <xsl:template match="m:multiset" mode="cmml2om">
      <OMS cd="multiset1" name="multiset"/>
   </xsl:template>
   <xsl:template match="m:intersect[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="intersect"/>
   </xsl:template>
   <xsl:template match="m:union[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="union"/>
   </xsl:template>
   <xsl:template match="m:setdiff[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="setdiff"/>
   </xsl:template>
   <xsl:template match="m:subset[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="subset"/>
   </xsl:template>
   <xsl:template match="m:in[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="in"/>
   </xsl:template>
   <xsl:template match="m:notin[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="notin"/>
   </xsl:template>
   <xsl:template match="m:prsubset[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="prsubset"/>
   </xsl:template>
   <xsl:template match="m:notsubset[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="notsubset"/>
   </xsl:template>
   <xsl:template match="m:notprsubset[@type='multiset']" mode="cmml2om">
      <OMS cd="multiset1" name="notprsubset"/>
   </xsl:template>
   <xsl:template match="m:based_integer" mode="cmml2om">
      <OMS cd="nums1" name="based_integer"/>
   </xsl:template>
   <xsl:template match="m:rational" mode="cmml2om">
      <OMS cd="nums1" name="rational"/>
   </xsl:template>
   <xsl:template match="m:infinity" mode="cmml2om">
      <OMS cd="nums1" name="infinity"/>
   </xsl:template>
   <xsl:template match="m:e" mode="cmml2om">
      <OMS cd="nums1" name="e"/>
   </xsl:template>
   <xsl:template match="m:i" mode="cmml2om">
      <OMS cd="nums1" name="i"/>
   </xsl:template>
   <xsl:template match="m:pi" mode="cmml2om">
      <OMS cd="nums1" name="pi"/>
   </xsl:template>
   <xsl:template match="m:gamma" mode="cmml2om">
      <OMS cd="nums1" name="gamma"/>
   </xsl:template>
   <xsl:template match="m:NaN" mode="cmml2om">
      <OMS cd="nums1" name="NaN"/>
   </xsl:template>
   <xsl:template match="m:omtype" mode="cmml2om">
      <OMS cd="omtypes" name="omtype"/>
   </xsl:template>
   <xsl:template match="m:symtype" mode="cmml2om">
      <OMS cd="omtypes" name="symtype"/>
   </xsl:template>
   <xsl:template match="m:integer" mode="cmml2om">
      <OMS cd="omtypes" name="integer"/>
   </xsl:template>
   <xsl:template match="m:float" mode="cmml2om">
      <OMS cd="omtypes" name="float"/>
   </xsl:template>
   <xsl:template match="m:string" mode="cmml2om">
      <OMS cd="omtypes" name="string"/>
   </xsl:template>
   <xsl:template match="m:bytearray" mode="cmml2om">
      <OMS cd="omtypes" name="bytearray"/>
   </xsl:template>
   <xsl:template match="m:piecewise" mode="cmml2om">
      <OMS cd="piece1" name="piecewise"/>
   </xsl:template>
   <xsl:template match="m:piece" mode="cmml2om">
      <OMS cd="piece1" name="piece"/>
   </xsl:template>
   <xsl:template match="m:otherwise" mode="cmml2om">
      <OMS cd="piece1" name="otherwise"/>
   </xsl:template>
   <xsl:template match="m:forall" mode="cmml2om">
      <OMS cd="quant1" name="forall"/>
   </xsl:template>
   <xsl:template match="m:exists" mode="cmml2om">
      <OMS cd="quant1" name="exists"/>
   </xsl:template>
   <xsl:template match="m:eq" mode="cmml2om">
      <OMS cd="relation1" name="eq"/>
   </xsl:template>
   <xsl:template match="m:lt" mode="cmml2om">
      <OMS cd="relation1" name="lt"/>
   </xsl:template>
   <xsl:template match="m:gt" mode="cmml2om">
      <OMS cd="relation1" name="gt"/>
   </xsl:template>
   <xsl:template match="m:neq" mode="cmml2om">
      <OMS cd="relation1" name="neq"/>
   </xsl:template>
   <xsl:template match="m:leq" mode="cmml2om">
      <OMS cd="relation1" name="leq"/>
   </xsl:template>
   <xsl:template match="m:geq" mode="cmml2om">
      <OMS cd="relation1" name="geq"/>
   </xsl:template>
   <xsl:template match="m:approx" mode="cmml2om">
      <OMS cd="relation1" name="approx"/>
   </xsl:template>
   <xsl:template match="m:ceiling" mode="cmml2om">
      <OMS cd="rounding1" name="ceiling"/>
   </xsl:template>
   <xsl:template match="m:floor" mode="cmml2om">
      <OMS cd="rounding1" name="floor"/>
   </xsl:template>
   <xsl:template match="m:trunc" mode="cmml2om">
      <OMS cd="rounding1" name="trunc"/>
   </xsl:template>
   <xsl:template match="m:round" mode="cmml2om">
      <OMS cd="rounding1" name="round"/>
   </xsl:template>
   <xsl:template match="m:mean" mode="cmml2om">
      <OMS cd="s_data1" name="mean"/>
   </xsl:template>
   <xsl:template match="m:sdev" mode="cmml2om">
      <OMS cd="s_data1" name="sdev"/>
   </xsl:template>
   <xsl:template match="m:variance" mode="cmml2om">
      <OMS cd="s_data1" name="variance"/>
   </xsl:template>
   <xsl:template match="m:mode" mode="cmml2om">
      <OMS cd="s_data1" name="mode"/>
   </xsl:template>
   <xsl:template match="m:median" mode="cmml2om">
      <OMS cd="s_data1" name="median"/>
   </xsl:template>
   <xsl:template match="m:moment" mode="cmml2om">
      <OMS cd="s_data1" name="moment"/>
   </xsl:template>
   <xsl:template match="m:mean" mode="cmml2om">
      <OMS cd="s_dist1" name="mean"/>
   </xsl:template>
   <xsl:template match="m:sdev" mode="cmml2om">
      <OMS cd="s_dist1" name="sdev"/>
   </xsl:template>
   <xsl:template match="m:variance" mode="cmml2om">
      <OMS cd="s_dist1" name="variance"/>
   </xsl:template>
   <xsl:template match="m:moment" mode="cmml2om">
      <OMS cd="s_dist1" name="moment"/>
   </xsl:template>
   <xsl:template match="m:cartesian_product" mode="cmml2om">
      <OMS cd="set1" name="cartesian_product"/>
   </xsl:template>
   <xsl:template match="m:emptyset" mode="cmml2om">
      <OMS cd="set1" name="emptyset"/>
   </xsl:template>
   <xsl:template match="m:map" mode="cmml2om">
      <OMS cd="set1" name="map"/>
   </xsl:template>
   <xsl:template match="m:size" mode="cmml2om">
      <OMS cd="set1" name="size"/>
   </xsl:template>
   <xsl:template match="m:suchthat" mode="cmml2om">
      <OMS cd="set1" name="suchthat"/>
   </xsl:template>
   <xsl:template match="m:set" mode="cmml2om">
      <OMS cd="set1" name="set"/>
   </xsl:template>
   <xsl:template match="m:intersect" mode="cmml2om">
      <OMS cd="set1" name="intersect"/>
   </xsl:template>
   <xsl:template match="m:union" mode="cmml2om">
      <OMS cd="set1" name="union"/>
   </xsl:template>
   <xsl:template match="m:setdiff" mode="cmml2om">
      <OMS cd="set1" name="setdiff"/>
   </xsl:template>
   <xsl:template match="m:subset" mode="cmml2om">
      <OMS cd="set1" name="subset"/>
   </xsl:template>
   <xsl:template match="m:in" mode="cmml2om">
      <OMS cd="set1" name="in"/>
   </xsl:template>
   <xsl:template match="m:notin" mode="cmml2om">
      <OMS cd="set1" name="notin"/>
   </xsl:template>
   <xsl:template match="m:prsubset" mode="cmml2om">
      <OMS cd="set1" name="prsubset"/>
   </xsl:template>
   <xsl:template match="m:notsubset" mode="cmml2om">
      <OMS cd="set1" name="notsubset"/>
   </xsl:template>
   <xsl:template match="m:notprsubset" mode="cmml2om">
      <OMS cd="set1" name="notprsubset"/>
   </xsl:template>
   <xsl:template match="m:P" mode="cmml2om">
      <OMS cd="setname1" name="P"/>
   </xsl:template>
   <xsl:template match="m:N" mode="cmml2om">
      <OMS cd="setname1" name="N"/>
   </xsl:template>
   <xsl:template match="m:Z" mode="cmml2om">
      <OMS cd="setname1" name="Z"/>
   </xsl:template>
   <xsl:template match="m:Q" mode="cmml2om">
      <OMS cd="setname1" name="Q"/>
   </xsl:template>
   <xsl:template match="m:R" mode="cmml2om">
      <OMS cd="setname1" name="R"/>
   </xsl:template>
   <xsl:template match="m:C" mode="cmml2om">
      <OMS cd="setname1" name="C"/>
   </xsl:template>
   <xsl:template match="m:type" mode="cmml2om">
      <OMS cd="sts" name="type"/>
   </xsl:template>
   <xsl:template match="m:mapsto" mode="cmml2om">
      <OMS cd="sts" name="mapsto"/>
   </xsl:template>
   <xsl:template match="m:nary" mode="cmml2om">
      <OMS cd="sts" name="nary"/>
   </xsl:template>
   <xsl:template match="m:nassoc" mode="cmml2om">
      <OMS cd="sts" name="nassoc"/>
   </xsl:template>
   <xsl:template match="m:error" mode="cmml2om">
      <OMS cd="sts" name="error"/>
   </xsl:template>
   <xsl:template match="m:structure" mode="cmml2om">
      <OMS cd="sts" name="structure"/>
   </xsl:template>
   <xsl:template match="m:binder" mode="cmml2om">
      <OMS cd="sts" name="binder"/>
   </xsl:template>
   <xsl:template match="m:attribution" mode="cmml2om">
      <OMS cd="sts" name="attribution"/>
   </xsl:template>
   <xsl:template match="m:Object" mode="cmml2om">
      <OMS cd="sts" name="Object"/>
   </xsl:template>
   <xsl:template match="m:NumericalValue" mode="cmml2om">
      <OMS cd="sts" name="NumericalValue"/>
   </xsl:template>
   <xsl:template match="m:SetNumericalValue" mode="cmml2om">
      <OMS cd="sts" name="SetNumericalValue"/>
   </xsl:template>
   <xsl:template match="m:log" mode="cmml2om">
      <OMS cd="transc1" name="log"/>
   </xsl:template>
   <xsl:template match="m:ln" mode="cmml2om">
      <OMS cd="transc1" name="ln"/>
   </xsl:template>
   <xsl:template match="m:exp" mode="cmml2om">
      <OMS cd="transc1" name="exp"/>
   </xsl:template>
   <xsl:template match="m:sin" mode="cmml2om">
      <OMS cd="transc1" name="sin"/>
   </xsl:template>
   <xsl:template match="m:cos" mode="cmml2om">
      <OMS cd="transc1" name="cos"/>
   </xsl:template>
   <xsl:template match="m:tan" mode="cmml2om">
      <OMS cd="transc1" name="tan"/>
   </xsl:template>
   <xsl:template match="m:sec" mode="cmml2om">
      <OMS cd="transc1" name="sec"/>
   </xsl:template>
   <xsl:template match="m:csc" mode="cmml2om">
      <OMS cd="transc1" name="csc"/>
   </xsl:template>
   <xsl:template match="m:cot" mode="cmml2om">
      <OMS cd="transc1" name="cot"/>
   </xsl:template>
   <xsl:template match="m:sinh" mode="cmml2om">
      <OMS cd="transc1" name="sinh"/>
   </xsl:template>
   <xsl:template match="m:cosh" mode="cmml2om">
      <OMS cd="transc1" name="cosh"/>
   </xsl:template>
   <xsl:template match="m:tanh" mode="cmml2om">
      <OMS cd="transc1" name="tanh"/>
   </xsl:template>
   <xsl:template match="m:sech" mode="cmml2om">
      <OMS cd="transc1" name="sech"/>
   </xsl:template>
   <xsl:template match="m:csch" mode="cmml2om">
      <OMS cd="transc1" name="csch"/>
   </xsl:template>
   <xsl:template match="m:coth" mode="cmml2om">
      <OMS cd="transc1" name="coth"/>
   </xsl:template>
   <xsl:template match="m:arcsin" mode="cmml2om">
      <OMS cd="transc1" name="arcsin"/>
   </xsl:template>
   <xsl:template match="m:arccos" mode="cmml2om">
      <OMS cd="transc1" name="arccos"/>
   </xsl:template>
   <xsl:template match="m:arctan" mode="cmml2om">
      <OMS cd="transc1" name="arctan"/>
   </xsl:template>
   <xsl:template match="m:arcsec" mode="cmml2om">
      <OMS cd="transc1" name="arcsec"/>
   </xsl:template>
   <xsl:template match="m:arccsc" mode="cmml2om">
      <OMS cd="transc1" name="arccsc"/>
   </xsl:template>
   <xsl:template match="m:arccot" mode="cmml2om">
      <OMS cd="transc1" name="arccot"/>
   </xsl:template>
   <xsl:template match="m:arcsinh" mode="cmml2om">
      <OMS cd="transc1" name="arcsinh"/>
   </xsl:template>
   <xsl:template match="m:arccosh" mode="cmml2om">
      <OMS cd="transc1" name="arccosh"/>
   </xsl:template>
   <xsl:template match="m:arctanh" mode="cmml2om">
      <OMS cd="transc1" name="arctanh"/>
   </xsl:template>
   <xsl:template match="m:arcsech" mode="cmml2om">
      <OMS cd="transc1" name="arcsech"/>
   </xsl:template>
   <xsl:template match="m:arccsch" mode="cmml2om">
      <OMS cd="transc1" name="arccsch"/>
   </xsl:template>
   <xsl:template match="m:arccoth" mode="cmml2om">
      <OMS cd="transc1" name="arccoth"/>
   </xsl:template>
   <xsl:template match="m:divergence" mode="cmml2om">
      <OMS cd="veccalc1" name="divergence"/>
   </xsl:template>
   <xsl:template match="m:grad" mode="cmml2om">
      <OMS cd="veccalc1" name="grad"/>
   </xsl:template>
   <xsl:template match="m:curl" mode="cmml2om">
      <OMS cd="veccalc1" name="curl"/>
   </xsl:template>
   <xsl:template match="m:Laplacian" mode="cmml2om">
      <OMS cd="veccalc1" name="Laplacian"/>
   </xsl:template>


   <xsl:template match="m:notanumber" mode="cmml2om">
      <OMF dec="NaN"/>
   </xsl:template>




</xsl:stylesheet>