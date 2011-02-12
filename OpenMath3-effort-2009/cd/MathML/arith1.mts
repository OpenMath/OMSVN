<?xml version="1.0"?>
<mcd>
<signature name="divide"> (algebraic, algebraic) -&gt; algebraic </signature>
<signature name="divide"> (complex, complex) -&gt; complex </signature>
<signature name="divide"> (real, real) -&gt; real </signature>
<signature name="divide"> (rational, rational) -&gt; rational </signature>
<signature name="divide"> (integer, integer) -&gt; rational </signature>


      <signature name="minus">(real,real) -&gt; real</signature>
<signature name="minus">(algebraic,algebraic) -&gt; algebraic</signature>
<signature name="minus">[type=MathMLtype](MathMLtype,MathMLtype) -&gt; MathMLtype </signature>


      <signature name="unary_minus">(real) -&gt; real</signature>
<signature name="unary_minus">(algebraic) -&gt; algebraic</signature>
<signature name="unary_minus">[type=MathMLtype](MathMLtype) -&gt; MathMLtype </signature>


      <signature name="plus">[type=MathMLtype](anything*) -&gt; MathMLtype </signature>
<signature name="plus">(set*) -&gt; set</signature>
<signature name="plus">(multiset*) -&gt; multiset</signature>
<signature name="plus">(algebraic*) -&gt; algebraic</signature>
<signature name="plus">(real*) -&gt; real</signature>
<signature name="plus">(complex*) -&gt; complex</signature>
<signature name="plus">(integer*) -&gt; integer</signature>
<signature name="plus"> (domainofapp,function) -&gt; algebraic </signature>
<signature name="plus"> (bvar+,domainofapp,algebraic) -&gt; algebraic </signature>


      <signature name="power"> (algebraic, algebraic) -&gt; algebraic </signature>
<signature name="power"> (complex, complex) -&gt; complex </signature>
<signature name="power"> (real, real) -&gt; complex </signature>
<signature name="power"> (rational, integer) -&gt; rational </signature>
<signature name="power"> (integer, integer) -&gt; rational </signature>
<signature name="power">[type=MathMLtype](anything,anything) -&gt; MathMLtype </signature>


      <signature name="times"> (algebraic*) -&gt; algebraic </signature>
<signature name="times"> (complex*) -&gt; complex </signature>
<signature name="times"> (real*) -&gt; real </signature>
<signature name="times"> (rational*) -&gt; rational </signature>
<signature name="times"> (integer*) -&gt; integer </signature>
<signature name="times"> (domainofapp,function) -&gt; algebraic </signature>
<signature name="times"> (bvar+,domainofapp,anything) -&gt; algebraic </signature>


      <signature name="root"> (algebraic) -&gt; root(degree(2),algebraic) </signature>
<signature name="root"> (anything) -&gt; root(degree(2),anything) </signature>
<signature name="root"> (degree,anything) -&gt; root </signature>


      <signature name="gcd"> [type=MathMLtype](MathMLtype*) -&gt;MathMLtype </signature>
<signature name="gcd">(integer*) -&gt; integer </signature>
<signature name="gcd"> (domainofapp,function) -&gt; algebraic </signature>
<signature name="gcd"> (bvar+,domainofapp,algebraic) -&gt; algebraic </signature>


      <signature name="abs">(algebraic) -&gt; algebraic</signature>
<signature name="abs">(real) -&gt; real</signature>
<signature name="abs">(complex) -&gt; real</signature>


      <signature name="lcm"> [type=MathMLtype](MathMLtype*) -&gt; MathMLtype </signature>
<signature name="lcm">(integer*) -&gt; integer</signature>
<signature name="lcm">(algebraic*) -&gt; algebraic</signature>
<signature name="lcm"> (domainofapp,function) -&gt; algebraic </signature>
<signature name="lcm"> (bvar+,domainofapp,anything) -&gt; algebraic </signature>


  <signature name="sum"> (function ) -&gt; function </signature>
<signature name="sum"> (bvar,algebraic ) -&gt; algebraic </signature>
<signature name="sum"> (domainofapp,function) -&gt; function </signature>
<signature name="sum"> (bvar+,domainofapp,algebraic) -&gt; algebraic </signature>

      
      <signature name="product"> (function) -&gt; function </signature>
<signature name="product"> (bvar,algebraic) -&gt; algebraic </signature>
<signature name="product"> (domainofapp,function) -&gt; function </signature>
<signature name="product"> (bvar+,domainofapp,algebraic) -&gt; algebraic </signature>


</mcd>
