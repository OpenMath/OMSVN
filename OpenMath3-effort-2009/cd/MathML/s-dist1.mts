<?xml version="1.0" encoding="utf-8"?>
<!-- $Id: statistics.mcd,v 1.9 2007/08/23 19:34:40 mkohlhas2 Exp $ -->

<mcd id="statistics">
  <title>Statistics</title>

  <MMLdefinition id="cds_mean" cdrole="application" arity="nary">
    <name>mean</name>
    <description>
      <p>The mean value of a set of data, or of a random variable.  See CRC Standard
      Mathematical Tables and Formulae, editor: Dan Zwillinger, CRC Press Inc., 1996,
      section 7.7.1</p>
    </description>
    <discussion>
      <p><el>mean</el> is the operator element representing a <emph>mean</emph> or
      average.</p>
    </discussion>
    <classification>nary function</classification>
    <rendering>
      <head>Default Rendering</head>
      <p>
	<graphic role="inline" source="image/f4101.gif" alt="\bar{X}"/> or
      <graphic role="inline" source="image/f4102.gif" alt="\langle X \rangle"/></p>
    </rendering>
    <signature>(random_variable) -> scalar</signature>
    <signature>(scalar+) -> scalar</signature>
    <MMLexample><![CDATA[<apply><mean/><ci type="discrete_random_variable"> X </ci></apply>]]></MMLexample>
    <MMLexample><![CDATA[<apply><mean/><cn>3</cn><cn>4</cn><cn>3</cn><cn>7</cn><cn>4</cn></apply>]]></MMLexample>
    <MMLexample><![CDATA[<apply><mean/><ci> X </ci></apply>]]></MMLexample>
  </MMLdefinition>
  
  <MMLdefinition id="cds_sdev" cdrole="application" arity="nary">
    <name>sdev</name>
    <description>
      <p> This element represents a function denoting the sample standard deviation of its
      arguments. The arguments are either all data, or a discrete random variable, or a
      continuous random variable.</p>

      <p>For numeric data at least two values are required and this is the square root of
      (the sum of the squares of the deviations from the mean of the arguments, divided by
      the number of arguments less one).  For a "discrete_random_variable", this is the
      square root of the second moment about the mean.  This further generalizes to
      identifiers of type continuous_random_variable.</p>

      <p>See CRC Standard Mathematical Tables and Formulae, editor: Dan Zwillinger, CRC
      Press Inc., 1996, (7.7.11) section 7.7.1.</p>
    </description>
    <discussion>
      <p><el>sdev</el> is the operator element representing the statistical
      <emph>standard deviation</emph> operator.</p>
    </discussion>
    <classification>nary function</classification>
    <rendering>
      <graphic role="display" source="image/f4103.gif" alt="\sigma(X)"/>
    </rendering>
    <signature>(scalar,scalar+) -> scalar</signature>
    <signature>(discrete_random_variable) -> scalar</signature>
    <signature>(continuous_random_variable) -> scalar</signature>
    <MMLexample><![CDATA[<apply><sdev/><cn>3</cn><cn>4</cn><cn>2</cn><cn>2</cn></apply>]]></MMLexample>
    <MMLexample>
      <description><p><el>sdev</el> is an <emph>n-ary operator</emph>.</p></description>
    <![CDATA[<apply><sdev/><ci type="discrete_random_variable"> X </ci></apply>]]></MMLexample>
  </MMLdefinition>
  
  <MMLdefinition id="cds_variance" cdrole="application" arity="nary">
        <name>variance</name>
        <description>
          <p>This symbol represents a function denoting the variance of its 
		arguments, that is, the square of the standard deviation.
		The arguments are either all data in which case there are two or
		more of them, or an identifier of type
		discrete_random_variable, or continuous_random_variable.
		See CRC Standard Mathematical Tables and Formulae, 
		editor: Dan Zwillinger, CRC Press Inc., 1996, [7.1.2] and [7.7].</p>
        </description>
	<discussion>
	  <p><el>variance</el> is the operator element representing the
	  statistical <emph>variance</emph> operator.</p>
	</discussion>
	<classification>nary function</classification>
	<rendering>
	  <graphic role="display" source="image/f4104.gif" alt="\sigma(X)^2"/>
	</rendering>
        <signature>(scalar,scalar+) -> scalar</signature>
        <signature>(descrete_random_variable) -> scalar</signature>
        <signature>(continuous_random_variable) -> scalar</signature>
        <MMLexample><![CDATA[<apply><variance/><cn>3</cn><cn>4</cn><cn>2</cn><cn>2</cn></apply>]]></MMLexample>
        <MMLexample>
	  <description><p><el>variance</el> is an <emph>n-ary operator</emph>.</p></description>
	  <![CDATA[<apply><variance/><ci type="discrete_random_variable"> X </ci></apply>]]></MMLexample>
      </MMLdefinition>
      
      <MMLdefinition id="cds_median" cdrole="application" arity="nary">
        <name>median</name>
        <description>
          <p>This symbol represents an n-ary function denoting the median of its
          arguments.  That is, if the data were placed in ascending order then it denotes
          the middle one (in the case of an odd amount of data) or the average of the
          middle two (in the case of an even amount of data).  See CRC Standard
          Mathematical Tables and Formulae, editor: Dan Zwillinger, CRC Press Inc., 1996,
          section 7.7.1</p>
	</description>
	<discussion>
	  <p><el>median</el> is the operator element representing the statistical 
	  <emph>median</emph> operator.</p>
	</discussion>
	<classification>nary function</classification>
	<rendering>
	  <graphic role="display" source="image/f4105.gif" alt="\mathrm{median}(X)"/>
	</rendering>
        <signature>(scalar+) -> scalar</signature>
        <MMLexample><![CDATA[<apply><median/><cn>3</cn><cn>4</cn><cn>2</cn><cn>2</cn></apply>]]></MMLexample>
	<MMLexample>
	  <description><p><el>median</el> is an <emph>n-ary operator</emph>.</p>
		</description>
		<![CDATA[
		<apply>
		  <median/>
		  <ci> X </ci>
		</apply>
		]]></MMLexample>
      </MMLdefinition>
	  
      <MMLdefinition id="cds_mode" cdrole="application" arity="nary">
        <name>mode</name>
        <description>
          <p>This represents the mode of  n data values. The mode is the data value that 
			occurs with the greatest frequency.
			See CRC Standard Mathematical Tables and Formulae, editor: Dan Zwillinger, 
			CRC Press Inc., 1996, section 7.7.1</p>
        </description>
	<discussion>
	  <p><el>mode</el> is the operator element representing the statistical
	  <emph>mode</emph> operator.</p>
	</discussion>
        <classification>nary function</classification>
	<rendering>
	  <graphic role="display" source="image/f4106.gif" alt="\mathrm{mode}(X)"/>
	</rendering>
        <signature>(scalar+) -> scalar</signature>
        <MMLexample><![CDATA[<apply><mode/><cn>3</cn><cn>4</cn><cn>2</cn><cn>2</cn></apply>]]></MMLexample>
	<MMLexample>
	  <description><p><el>mode</el> is an <emph>n-ary operator</emph>.</p></description>
	  <![CDATA[<apply>
  <mode/>
  <ci> X </ci>
</apply>]]></MMLexample>
      </MMLdefinition>
      
      <MMLdefinition id="cds_moment" cdrole="application" arity="nary">
	<name>moment</name>
        <description>
          <p>This symbol is used to denote the i'th moment of a set of data, or a random
          variable.  Unless otherwise specified, the moment is about the origin.  For
          example, the i'th moment of X about the origin is given by moment( i , 0 , x ).
	  </p>

	  <p>The first argument indicates which moment about that point is being
	  specified.  For the i'th moment the first argument should be i.  The second
	  argument specifies the point about which the moment is computed.  It is either
	  an actual point ( e.g. 0 ), or a function which can be used on the data to
	  compute that point.  To indicate a central moment, specify the element "mean".
	  The third argument is either a discrete or continuous random variable, or the
	  start of a sequence of data.  If there is a sequence of data then the i'th
	  moment is (1/n) (x_1^i + x_2^i + ... + x_n^i).
	  </p>

	  <p>See CRC Standard Mathematical Tables and Formulae, editor: Dan Zwillinger,
	  CRC Press Inc., 1996, section 7.7.1</p>
        </description>
	<discussion>
	  <p>The <el>moment</el> element represents the statistical <emph>moment</emph>
	  operator. Use the qualifier <el>degree</el> for the <var>n</var> in <quote>
	  <var>n</var>-th moment</quote>. Use the qualifier <el>momentabout</el> for the
	  <var>p</var> in <quote>moment about <var>p</var></quote>.</p>

	  <p>The <el>moment</el> function accepts the <el>degree</el> and
	  <el>momentabout</el> schema. If present, the <el>degree</el> schema denotes the
	  order of the moment. Otherwise, the moment is assumed to be the first order
	  moment. When used with <el>moment</el>, the <el>degree</el> schema is expected
	  to contain a single child schema; otherwise an error is generated. If present,
	  the <el>momentabout</el> schema denotes the point about which the moment is
	  taken. Otherwise, the moment is assumed to be the moment about zero.</p>
	</discussion>
        <classification>function</classification>
	<rendering>
	  <graphic role="display" source="image/f4107.gif" alt="\langle X^3 \rangle"/>
	</rendering>
        <signature>(degree,momentabout?,scalar+) -> scalar</signature>
        <signature>(degree,momentabout?,discrete_random_variable) -> scalar</signature>
        <signature>(degree,momentabout?,continuous_random_variable) -> scalar</signature>
        <MMLexample>
          <description>
            <p> The third moment about the point p of a discrete random variable</p>
	    <p><el>moment</el> is an <emph>operator taking qualifiers</emph> (see <specref
	    ref="contm_qualifiers"/>). The third moment of the distribution <var>X</var> about
	    the point <var>p</var> is written:</p>
          </description><![CDATA[<apply> <moment/>
  <degree><cn>3</cn></degree>
  <momentabout><ci>p</ci></momentabout>
  <ci>X</ci>
</apply>]]></MMLexample>
        <MMLexample>
          <description>
            <p>The 3rd central moment of a set of data. </p>
          </description><![CDATA[<apply><moment/>
  <degree><cn>3</cn></degree>
  <momentabout><mean/></momentabout>
  <cn>6</cn><cn>4</cn><cn>2</cn><cn>2</cn><cn>5</cn>
</apply>]]></MMLexample>

        <MMLexample>
          <description>
            <p>The 3rd central moment of a discrete random variable. </p>
          </description><![CDATA[<apply><moment/>
  <degree><cn>3</cn></degree>
  <momentabout><mean/></momentabout>
  <ci type="discrete_random_variable"> X </ci>
</apply>]]></MMLexample>

        <MMLexample>
          <description>
            <p>The 3rd  moment about the origin of a set of data.</p>
          </description><![CDATA[<apply><moment/>
  <degree><cn>3</cn></degree>
  <momentabout><cn>0</cn></momentabout>
  <cn>6</cn><cn>4</cn><cn>2</cn><cn>2</cn>
</apply>]]></MMLexample>
      </MMLdefinition>
      
      <MMLdefinition id="cds_momentabout" cdrole="application" arity="1">
        <name>momentabout</name>
        <description>
          <p>This qualifier element is used to identify the point about which a moment is
          to be computed.  It may be an explicit point, or it may identify a method by
          which the point is to be computed from the given data.  For example the moment
          may be computed about the mean by specifying the element used for the mean.</p>
        </description>

	<discussion>
	  <p>The <el>momentabout</el> element is a <emph>qualifier</emph> element used
	  with the <el>moment</el> element to represent statistical moments.  Use the
	  qualifier <el>momentabout</el> for the <var>p</var> in <quote>moment about
	  <var>p</var></quote>.</p>
	</discussion>
        <classification>constructor</classification>
	<rendering>
	  <graphic role="display" source="image/f4107.gif" alt="\langle X^3 \rangle"/>
	</rendering>
        <signature>(function) -> method</signature>
        <signature>(scalar) -> point</signature>
        <MMLexample>
          <description>
            <p>The third moment of the distribution
<var>X</var> about the point <var>p</var> of a discrete random variable is written:</p>
          </description><![CDATA[<apply><moment/>
  <degree> <cn> 3 </cn> </degree>
  <momentabout> <ci> p </ci> </momentabout>
  <ci> X </ci>
</apply>]]></MMLexample>
        <MMLexample>
          <description>
            <p>
The 3rd central moment of a set of data. </p>
          </description><![CDATA[<apply><moment/>
  <degree><cn> 3 </cn></degree>
  <momentabout><mean/></momentabout>
  <cn>6</cn><cn>4</cn><cn>2</cn><cn>2</cn><cn>5</cn>
</apply>]]></MMLexample>
      </MMLdefinition>
    </mcd>
