<?xml version="1.0"?>
<mcd>
  <signature name="eq">(real,real+) -&gt; boolean</signature>
<signature name="eq">(boolean, boolean+) -&gt; boolean</signature>
<signature name="eq">(set,set+) -&gt; set</signature>
<signature name="eq">(multiset,multiset+) -&gt; multiset</signature>
<signature name="eq"> (domainofapp,function) -&gt; boolean </signature>
<signature name="eq"> (bvar+,domainofapp,anything) -&gt; boolean </signature>

      
  <signature name="neq"> (real,real) -&gt; boolean </signature>
<signature name="neq">(boolean,boolean) -&gt; boolean</signature>
<signature name="neq">(set,set) -&gt; set</signature>
<signature name="neq">(multiset,multiset) -&gt; multiset</signature>

      
	  <signature name="gt">(real,real+) -&gt; boolean </signature>
<signature name="gt"> (domainofapp,function) -&gt; boolean </signature>
<signature name="gt"> (bvar+,domainofapp,algebraic) -&gt; boolean </signature>

      
      <signature name="lt">(real,real+) -&gt; boolean </signature>
<signature name="lt"> ( domainofapp , function ) -&gt; boolean </signature>
<signature name="lt"> ( bvar+ , domainofapp , algebraic) -&gt; boolean </signature>

     
	 <signature name="geq">(real,real+) -&gt; boolean </signature>
<signature name="geq"> ( domainofapp , function ) -&gt; boolean </signature>
<signature name="geq"> ( bvar+ , domainofapp , algebraic ) -&gt; boolean </signature>

      
      <signature name="leq">(real,real+) -&gt; boolean </signature>
<signature name="leq"> ( domainofapp , function ) -&gt; boolean </signature>
<signature name="leq"> ( bvar+ , domainofapp , arithmetic ) -&gt; boolean </signature>

      	  <signature name="approx">(real,real+) -&gt; boolean </signature>
<signature name="approx"> (domainofapp,function) -&gt; boolean </signature>
<signature name="approx"> (bvar+,domainofapp,boolean) -&gt; boolean </signature>

      
</mcd>
