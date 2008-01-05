<?xml version="1.0" encoding="utf-8"?>
<!-- $Id: basic-content-elements.mcd,v 1.9 2007/08/23 19:34:40 mkohlhas2 Exp $ -->
<mcd id="basic_content_elements" 
     revision-date="2006-12-14"
     review-date="2007-01-14"
     version="0.1"
     status="experimental"
     cdbase="http://w3.org/Math/cds">

  <title>Basic Content Elements</title>
  <description><p>The basic content Elements</p></description>
  
      <MMLdefinition id="cds_piecewise"  cdrole="application" arity="nary" container="yes">
	<title>Piecewise declaration</title>
        <name>piecewise</name>
        <description>
          <p>The piecewise, piece, and otherwise elements are used to support 'piecewise'
          declarations of the form H(x) = 0 if x less than 0, H(x) = 1 otherwise.  The
          piece and otherwise elements describe evaluation rules.  If no rule applies or
          if more than one rule applies but they give different answers then the
          expression is undefined.</p>
        </description>
	<discussion>
	  <p>The <el>piecewise</el>, <el>piece</el>, and <el>otherwise</el> elements are
	  used to support <quote>piecewise</quote> declarations of the form <quote>
	  <var>H</var>(<var>x</var>) = 0 if <var>x</var> less than 0,
	  <var>H</var>(<var>x</var>) = 1 otherwise</quote>.</p>

	  <p> The declaration is constructed using the <el>piecewise</el> element.  This
	  contains zero or more <el>piece</el> elements, and optionally one
	  <el>otherwise</el> element. Each <el>piece</el> element contains exactly two
	  children. The first child defines the value taken by the <el>piecewise</el>
	  expression when the condition specified in the associated second child of the
	  <el>piece</el> is true.  The degenerate case of no <el>piece</el> elements and
	  no <el>otherwise</el> element is treated as undefined for all values of the
	  domain.</p>

	  <p> <el>otherwise</el> allows the specification of a value to be taken by the
	  <el>piecewise</el> function when none of the conditions (second child elements
	  of the <el>piece</el> elements) is true, i.e. a default value.</p>

	  <p>It should be noted that no <quote>order of execution</quote> is implied by
	  the ordering of the <el>piece</el> child elements within <el>piecewise</el>. It
	  is the responsibility of the author to ensure that the subsets of the function
	  domain defined by the second children of the <el>piece</el> elements are
	  disjoint, or that, where they overlap, the values of the corresponding first
	  children of the <el>piece</el> elements coincide. If this is not the case, the
	  meaning of the expression is undefined.</p>

	  <p>The <el>piecewise</el> elements are <emph>constructors</emph>.</p>

	<p>The <el>piecewise</el>, <el>piece</el>, <el>otherwise</el> elements are used to
	support <quote>piecewise</quote> declarations of the form <quote>
	<var>H</var>(<var>x</var>) = 0 if <var>x</var> less than 0,
	<var>H</var>(<var>x</var>) = x otherwise</quote>.

<eg role = "mathml"><![CDATA[<piecewise>
  <piece>
      <cn>0</cn>
      <apply><lt/><ci>x</ci><cn>0</cn></apply>
  </piece>
  <otherwise><ci>x</ci></otherwise>
</piecewise>]]></eg></p>

	</discussion>
        <classification>constructor</classification>
<rendering>
<graphic role="display" source="image/new-piecewise.gif" alt="|x| = 
 \left\{\begin{array}{ll}-x&amp; \mbox{if } x &lt; 0\\0&amp; \mbox{if } x = 0
\\ x&amp; \mbox{if } x > 0\end{array}\right."/>
</rendering>
        <signature>(piece*, otherwise?) -> algebraic</signature>
        <signature>(piece*, otherwise?) -> anything</signature>
        <property>
          <description>
            <p>ForAll( x, x in domain(f), the evaluation rules collectively produce at most one 
value in codomain(f) )</p></description></property>
        <MMLexample><![CDATA[<piecewise>
  <piece><cn> 0</cn><apply><lt/><ci> x</ci> <cn> 0</cn></apply></piece>
  <otherwise><ci>x</ci></otherwise>
</piecewise>]]></MMLexample>
        <MMLexample>
          <description>
	    <p>The value of the abs function evaluated at x can be written as:</p>
	  </description>
<![CDATA[<piecewise>
  <piece>
    <apply><minus/><ci>x</ci></apply>
    <apply><lt/><ci> x</ci><cn> 0</cn></apply>
  </piece>
  <piece>
    <cn>0</cn>
    <apply><eq/><ci>x</ci><cn>0</cn></apply>
  </piece>
  <piece>
    <ci>x</ci>
    <apply><gt/><ci>x</ci><cn>0</cn></apply>
  </piece>
</piecewise>]]></MMLexample>
      </MMLdefinition>

      <MMLdefinition id="cds_piece"  cdrole="application" arity="2">
	<title>Pieces</title>
        <name>piece</name>
        <description>
          <p>The piece element is used to construct the conditionally defined values as
          part of a piecewise object.</p>
        </description>
        <classification>constructor</classification>
	<rendering/>
        <signature>(algebraic, boolean) -> piece</signature>
        <signature>(anything, boolean) -> piece</signature>
        <MMLexample><![CDATA[<piecewise>
  <piece><cn>0</cn><apply><lt/><ci> x</ci> <cn> 0</cn></apply></piece>
  <otherwise><ci>x</ci></otherwise>
</piecewise>]]></MMLexample>
      </MMLdefinition>

      <MMLdefinition id="cds_otherwise"  cdrole="application" arity="1">
	<title>Leftover Pieces</title>
        <name>otherwise</name>
        <description>
          <p>The otherwise element is used to describe the value of a piecewise construct
          when none of the conditions of the associated pieces are satisfied.</p>
        </description>
        <classification>constructor</classification>
	<rendering/>
        <signature>(algebraic) -> otherwise</signature>
        <signature>(anything) -> otherwise</signature>
        <MMLexample><![CDATA[<piecewise>
  <piece><cn> 0</cn><apply><lt/><ci> x</ci> <cn> 0</cn></apply></piece>
  <otherwise><ci>x</ci></otherwise>
</piecewise>]]></MMLexample>
      </MMLdefinition>
    </mcd>
