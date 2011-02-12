<?xml version="1.0"?>
<mcd>
  <signature name="set"> (anything*) -&gt; list </signature>
<signature name="set">[order=ordering](anything*) -&gt; list </signature>
<signature name="set">(domainofapp,function) -&gt; list </signature>
<signature name="set">(bvar+,domainofapp,anything) -&gt; list </signature>
<signature name="set">[order=ordering](domainofapp,function) -&gt; list(ordering) </signature>
<signature name="set">[order=ordering](bvar*,domainofapp,anything) -&gt; list(ordering) </signature>


  <signature name="union"> (set*) -&gt; set </signature>
<signature name="union"> (multiset*) -&gt; multiset </signature>
<signature name="union"> (domainofapp, set_valued_function) -&gt; set </signature>
<signature name="union"> (bvar+,domainofapp,set_valued_expression) -&gt; set</signature>
<signature name="union"> (domainofapp, multiset_valued_function) -&gt; multiset </signature>
<signature name="union"> (bvar+,domainofapp,multiset_valued_expression) -&gt; multiset</signature>

      
	  <signature name="intersect"> (set*) -&gt; set </signature>
<signature name="intersect"> (multiset*) -&gt; multiset </signature>
<signature name="intersect"> (domainofapp, set_valued_function) -&gt; set </signature>
<signature name="intersect"> (bvar+,domainofapp,set_valued_expression) -&gt; set</signature>
<signature name="intersect"> (domainofapp, multiset_valued_function) -&gt; multiset </signature>
<signature name="intersect"> (bvar+,domainofapp,multiset_valued_expression) -&gt; multiset</signature>

      
	  <signature name="in"> (anything,set) -&gt; boolean </signature>
<signature name="in"> (anything,multiset) -&gt; boolean </signature>

      
	  <signature name="notin"> (anything,set) -&gt; boolean </signature>
<signature name="notin"> (anything,multiset) -&gt; boolean </signature>

      
	  <signature name="subset"> (set*) -&gt; boolean </signature>
<signature name="subset"> (multiset*) -&gt; boolean </signature>
<signature name="subset"> (domainofapp,function) -&gt; boolean </signature>
<signature name="subset"> (bvar+,domainofapp,algebraic) -&gt; boolean </signature>

      
	  <signature name="prsubset"> (set*) -&gt; boolean </signature>
<signature name="prsubset"> (multiset*) -&gt; boolean </signature>
<signature name="prsubset"> (domainofapp,function) -&gt; boolean </signature>
<signature name="prsubset"> (bvar+,domainofapp,boolean) -&gt; boolean </signature>

      
	  <signature name="notsubset"> (set, set) -&gt; boolean </signature>
<signature name="notsubset"> (multiset,multiset) -&gt; boolean </signature>

      
	  <signature name="notprsubset"> (set,set) -&gt; boolean </signature>
<signature name="notprsubset"> (multiset,multiset) -&gt; boolean </signature>

     
      <signature name="setdiff"> (set,set) -&gt; set </signature>
<signature name="setdiff"> (multiset,multiset) -&gt; multiset </signature>

      
	  <signature name="card"> (set) -&gt; scalar </signature>
<signature name="card"> (multiset) -&gt; scalar </signature>

      
	  <signature name="cartesianproduct"> (set*) -&gt; set </signature>
<signature name="cartesianproduct"> (multiset*) -&gt; multiset </signature>


	  <signature name="emptyset">set</signature>



      
</mcd>
