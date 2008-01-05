<?xml version="1.0" encoding="utf-8"?>
<mcd>

      <MMLdefinition id="cds_forall"  cdrole="binder">
	<title>Universal Quantification</title>
        <name>forall</name>
        <description>
          <p>The forall operator is the logical "For all" quantifier.  The bound
          variables, if any, appear first and are tagged using the bvar element.  Next
          comes an optional condition on the bound variables.  The last argument is the
          boolean expression that is asserted to be true for all values of the bound
          variables that meet the specified conditions (if any).</p>
        </description>
	<discussion>
	  <p>The <code>forall</code> element represents the universal quantifier of logic. It
	  is usually used in conjunction with one or more bound variables, an optional
	  <code>condition</code> element, and an assertion. It may also be used with a domain
	  of application and function as described in <specref ref="contm_qualifiers"/> in
	  which case the assertion corresponds to applying the function to an element of
	  the specified domain., which should take the form of an <code>apply</code>
	  element.</p>

	  <p>The universal quantifier <code>forall</code> is used in conjunction with one or
	  more <code>bvar</code> schemata to represent simple logical assertions. There are
	  two main main ways of using the logical quantifier operators. The first usage is
	  for representing a simple, quantified assertion.  For example, the statement
	  <quote>there exists <var>x</var> &lt; 9</quote> would be represented as:

<eg role = "mathml"><![CDATA[<bind>
  <exists/>
  <bvar><ci> x </ci></bvar>
  <apply><lt/><ci>x</ci><cn>9</cn></apply>
</bind>]]></eg>

The second usage is for representing implications. Hypotheses are given by a
<code>condition</code> element following the bound variables. For example the statement
<quote>for all <var>x</var> &lt; 9, <var>x</var> &lt; 10</quote> would be represented as:

<eg role = "mathml"><![CDATA[<bind>
  <forall/>
  <bvar><ci>x</ci></bvar>
  <condition><apply><lt/><ci>x</ci><cn>9</cn></apply></condition>
  <apply><lt/><ci>x</ci><cn>10</cn></apply>
</bind>]]></eg>

Note that in both these usages one or more <code>bvar</code> qualifiers are mandatory.</p>
		</discussion>
        <classification>function</classification>
        <MMLattribute>
          <attname>type</attname>
          <attvalue>MathMLType</attvalue>
          <attdefault>boolean</attdefault>
        </MMLattribute>
	<rendering><ul>
	  <li><p><graphic role="inline" source="image/f4044.gif" alt="\forall x: x-x=0"/></p></li>
	  <li><p><graphic role="inline" source="image/f4045.gif" alt="\forall p \in \mathbb{Q}, q \in \mathbb{Q}, p &lt; q: p &lt; q^2"/></p></li>
	  <li><p><graphic role="inline" source="image/f4046.gif" alt="\forall n>0, n \in \mathbb{Z}: \exists x \in \mathbb{Z}, y \in \mathbb{Z}, z \in  \mathbb{Z}: x^n+y^n=z^n"/></p></li></ul>
	  <note><p>The second and third examples in this section are correct MathML expressions of False mathematical statements.</p></note>
	</rendering>
	<optype>quantifier</optype>
	<signature> (domainofapp,function) -> boolean </signature>
        <signature> (bvar+,domainofapp?,boolean) -> boolean </signature>
        <MMLexample>
		<description><p>The example encodes a simple identity.</p>
		</description>
		<![CDATA[<apply>
		  <forall/>
		  <bvar><ci> x </ci></bvar>
		  <apply><eq/>
		    <apply>
		      <minus/><ci> x </ci><ci> x </ci>
		    </apply>
		    <cn>0</cn>
		  </apply>
		</apply>]]></MMLexample>
		<MMLexample>
		<description><p>The example is more involved, and makes use of an optional <code>condition</code> element.</p>
		</description>
		<![CDATA[
		<apply>
		  <forall/>
		  <bvar><ci> p </ci></bvar>
		  <bvar><ci> q </ci></bvar>
		  <condition>
		    <apply><and/>
		      <apply><in/><ci> p </ci><rationals/></apply>
		      <apply><in/><ci> q </ci><rationals/></apply>
		      <apply><lt/><ci> p </ci><ci> q </ci></apply>
		    </apply>
		  </condition>
		  <apply><lt/>
		      <ci> p </ci>
		      <apply>
		          <power/>
		        <ci> q </ci>
		        <cn> 2 </cn>
		      </apply>
		  </apply>
		</apply>
		]]></MMLexample>
		<MMLexample>
		<description><p>The example uses both the <code>forall</code> and
<code>exists</code> quantifiers.</p>
		</description>
		<![CDATA[
		<apply>
		  <forall/>
		  <bvar><ci> n </ci></bvar>
		  <condition>
		    <apply><and/>
		      <apply><gt/><ci> n </ci><cn> 0 </cn></apply>
		      <apply><in/><ci> n </ci><integers/></apply>
		    </apply>
		  </condition>
		  <apply>
		    <exists/>
		    <bvar><ci> x </ci></bvar>
		    <bvar><ci> y </ci></bvar>
		    <bvar><ci> z </ci></bvar>
		    <condition>
		      <apply><and/>
		        <apply><in/><ci> x </ci><integers/></apply>
		        <apply><in/><ci> y </ci><integers/></apply>
		        <apply><in/><ci> z </ci><integers/></apply>
		      </apply>
		    </condition>
		    <apply>
		      <eq/>
		      <apply>
		        <plus/>
		        <apply><power/><ci> x </ci><ci> n </ci></apply>
		        <apply><power/><ci> y </ci><ci> n </ci></apply>
		      </apply>
		      <apply><power/><ci> z </ci><ci> n </ci></apply>
		    </apply>
		  </apply>
		</apply>
		]]></MMLexample>
        <MMLexample><![CDATA[<apply>
		  <forall/>
		  <bvar><ci> x </ci></bvar>
		  <condition><apply><lt/><ci> x </ci><cn> 0
		  </cn></apply></condition>
		  <ci> x </ci>
</apply>
]]></MMLexample>
      </MMLdefinition>

      <MMLdefinition id="cds_exists" cdrole="binder">
	<title>Existential Quantification</title>
        <name>exists</name>
        <description>
          <p>This is the MathML operator that is used to assert existence, as in "There
          exists an x such that x is real and x is positive."</p>
          <p>- The first argument indicates the bound variable,</p>
          <p>- The second optional argument places conditions on that
bound variable. </p>
          <p>- The last argument is the expression
that is asserted to be true.</p>
        </description>
	<discussion>
	  <p>The <code>exists</code> element represents the existential quantifier of
	  logic. Typically, it is used in conjunction with one or more bound variables, an
	  optional <code>condition</code> element, and an assertion, which may take the form
	  of either an <code>apply</code> or <code>reln</code> element.The <code>exists</code> element
	  may also be used with a general domain of application and function as described
	  in <specref ref="contm_qualifiers"/>.  For such uses the assertion is obtained
	  by applying the function to an element of the specified domain.</p>
	  <p>The universal quantifier <code>forall</code> is used in conjunction with one or
	  more <code>bvar</code> schemata to represent simple logical assertions. There are
	  two main main ways of using the logical quantifier operators. The first usage is
	  for representing a simple, quantified assertion.  For example, the statement
	  <quote>there exists <var>x</var> &lt; 9</quote> would be represented as:

<eg role = "mathml"><![CDATA[<bind>
  <exists/>
  <bvar><ci> x </ci></bvar>
  <apply><lt/><ci>x</ci><cn>9</cn></apply>
</bind>]]></eg>

The second usage is for representing implications. Hypotheses are given by a
<code>condition</code> element following the bound variables. For example the statement
<quote>for all <var>x</var> &lt; 9, <var>x</var> &lt; 10</quote> would be represented as:

<eg role = "mathml"><![CDATA[<bind>
  <forall/>
  <bvar><ci>x</ci></bvar>
  <condition><apply><lt/><ci>x</ci><cn>9</cn></apply></condition>
  <apply><lt/><ci>x</ci><cn>10</cn></apply>
</bind>]]></eg>

Note that in both these usages one or more <code>bvar</code> qualifiers are mandatory.</p>
	</discussion>
        <classification>function</classification>
        <MMLattribute>
          <attname>type</attname>
          <attvalue>MathMLType</attvalue>
          <attdefault>boolean</attdefault>
        </MMLattribute>
	<rendering>
	  <graphic  source="image/f4047.gif" alt="\exists x: f(x)=0"/>
	</rendering>
	<optype>quantifier</optype>
        <signature> (bvar+,boolean) -> boolean </signature>
        <signature> (bvar+,domainofapp,anything) -> boolean </signature>
        <MMLexample>
		<description><p>The following example encodes the sense of the expression <quote>there exists an <var>x</var> such that <var>f</var>(<var>x</var>) = 0</quote>.</p>
		</description>
		<![CDATA[
		<apply><exists/>
		  <bvar><ci>x</ci></bvar>
		  <apply><eq/>
		    <apply><ci>f</ci>
		      <ci>x</ci>
		    </apply>
		    <cn>0</cn>
		  </apply>
		</apply>
]]></MMLexample>

       <MMLexample><![CDATA[
<apply>
  <exists/>
  <bvar><ci> x </ci></bvar>
  <domainofapplication>
    <ci type="set">C</ci>
  </domainofapplication>
  <apply>
    <eq/>
    <apply>
      <power/><ci>x</ci><cn>2</cn>
    </apply>
    <cn>4</cn>
  </apply>
</apply>
]]></MMLexample>
      </MMLdefinition>

</mcd>
