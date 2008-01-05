<?xml version="1.0" encoding="utf-8"?>
      <MMLdefinition id="cds_limit" cdrole="application">
	<name>limit</name>
        <description>
          <p>The limit element represents the operation of taking a limit of a
          sequence. The limit point is expressed by specifying a lowlimit and a bvar, or
	  by specifying a condition on one or more bound variables.</p>
	</description>
	<discussion>
	  <p>The <el>limit</el> element represents the operation of taking a limit of a
	  sequence. The limit point is expressed by specifying a <el>lowlimit</el> and a
	  <el>bvar</el>, or by specifying a <el>condition</el> on one or more bound
	  variables.</p>

	  <p>The <el>limit</el> function accepts zero or more <el>bvar</el> schemata, and
	  optional <el>condition</el> and <el>lowlimit</el> schemata. A <el>condition</el>
	  may be used to place constraints on the <el>bvar</el>. The <el>bvar</el> schema
	  denotes the variable with respect to which the limit is being taken. The
	  <el>lowlimit</el> schema denotes the limit point. When used with <el>limit</el>,
	  the <el>bvar</el> and <el>lowlimit</el> schemata are expected to contain a
	  single child schema; otherwise an error is generated.</p>
	</discussion>
        <classification>function</classification>
	<rendering>
	  <graphic role="display" source="image/f4092.gif" alt="\lim_{x \to 0} \sin x"/>
	  <graphic role="display" source="image/f4093.gif" alt="\lim_{x \searrow a} \sin x"/>
	</rendering>
	<signature> (bvar+, lowlimit, uplimit, algebraic) -> real </signature>
        <signature> (bvar+, condition , algebraic) -> real </signature>
        <MMLexample><![CDATA[
<apply>
  <limit/>
  <bvar><ci> x </ci></bvar>
  <lowlimit><cn> 0 </cn></lowlimit>
  <apply><sin/><ci> x </ci></apply>
</apply>
]]></MMLexample>
        <!-- fixed to HERE JSD -->
        <MMLexample><![CDATA[
<apply><limit/>
  ]]><![CDATA[<bvar><ci>x</ci></bvar>
  <condition>
    <apply><tendsto/><ci>x</ci><cn>0</cn></apply>]]><![CDATA[
  </condition>
  <apply><sin/><ci>x</ci></apply>
</apply>
]]></MMLexample>
		<MMLexample><![CDATA[
		<apply>
		  <limit/>
		  <bvar><ci> x </ci></bvar>
		  <condition>
		    <apply>
		      <tendsto type="above"/>
		      <ci> x </ci>
		      <ci> a </ci>
		    </apply>
		  </condition>
		  <apply><sin/>
		     <ci> x </ci>
		  </apply>
		</apply>
		]]></MMLexample>
      </MMLdefinition>
      
	  <MMLdefinition id="cds_tendsto" cdrole="application">
        <name>tendsto</name>
        <description>
          <p>The tendsto element is used to express the relation that a quantity is
          tending to a specified value.</p>
	</description>
	<discussion>
	  <p>The <el>tendsto</el> element is used to express the relation that a quantity
	  is tending to a specified value. While this is used primarily as part of the
	  statement of a mathematical limit, it exists as a construct on its own to allow
	  one to capture mathematical statements such as "As x tends to y," and to provide
	  a building block to construct more general kinds of limits that are not
	  explicitly covered by the recommendation.</p>

	  <p>The <el>tendsto</el> element takes the attributes <att>type</att> to set the
	  direction from which the limiting value is approached. It occurs as a container
	  so that it can more easily be used in the construction of a limit expression.
	  Predefined values: <attval>above</attval>, <attval>below</attval>,
	  <attval>two-sided</attval>. The default value is <attval>two-sided</attval>.</p>
	  <issue role="open" id="type_on_tendsto">
	    <head>keep <att>type</att> attribute on <el>tendsto</el>?</head>
	    <p>It seems very awkward to keep this, it would probably be better to have an
	    <el>tendsto_xxx</el> symbol where xxx is the <att>type</att>value. (this would
	    be closer to what OpenMath does now).</p>
	  </issue>
	</discussion>
        <classification>function</classification>
        <MMLattribute>
          <attname>type</attname>
          <attvalue>above | below | all | MathMLType </attvalue>
          <attdefault>all</attdefault>
        </MMLattribute>
	<rendering>
	  <graphic role="display" source="image/f4094.gif" alt="x^{2} \searrow a^{2}"/>
	  <graphic role="display" source="image/f4095.gif" alt="(x, y) \rightarrow (f(x, y), g(x, y))"/>
	</rendering>
	<signature> (algebraic,algebraic) -> tendsto </signature>
        <signature> [ type=direction ](algebraic,algebraic) -> tendsto(direction) </signature>
        <MMLexample>
		<![CDATA[
<apply><tendsto type="above"/>
  <apply><power/><ci> x </ci><cn> 2 </cn></apply>
  <apply><power/><ci> a </ci><cn> 2 </cn></apply>
</apply>
]]></MMLexample>
        <MMLexample>
		<description><p>To express (<var>x</var>, <var>y</var>)
<graphic role = "inline" source = "image/f4009.gif" alt = "\rightarrow"/>(<var>f</var>(<var>x</var>, <var>y</var>), 
<var>g</var>(<var>x</var>,<var>y</var>)), one might use vectors, as in:</p></description>
		<![CDATA[<apply><tendsto/>
  <vector><ci> x </ci><ci> y </ci></vector>
  <vector>
    <apply><ci type="function">f</ci><ci> x </ci><ci> y </ci></apply>
    <apply><ci type="function">g</ci><ci> x </ci><ci> y </ci></apply>
  </vector>
</apply>]]></MMLexample>
	  </MMLdefinition>
