<?xml version="1.0"?>
<mcd>
  Statistics
  <signature name="mean">(random_variable) -&gt; scalar</signature>
<signature name="mean">(scalar+) -&gt; scalar</signature>

  
  <signature name="sdev">(scalar,scalar+) -&gt; scalar</signature>
<signature name="sdev">(discrete_random_variable) -&gt; scalar</signature>
<signature name="sdev">(continuous_random_variable) -&gt; scalar</signature>

  
  <signature name="variance">(scalar,scalar+) -&gt; scalar</signature>
<signature name="variance">(descrete_random_variable) -&gt; scalar</signature>
<signature name="variance">(continuous_random_variable) -&gt; scalar</signature>

      
      <signature name="median">(scalar+) -&gt; scalar</signature>

	  
      <signature name="mode">(scalar+) -&gt; scalar</signature>

      
      <signature name="moment">(degree,momentabout?,scalar+) -&gt; scalar</signature>
<signature name="moment">(degree,momentabout?,discrete_random_variable) -&gt; scalar</signature>
<signature name="moment">(degree,momentabout?,continuous_random_variable) -&gt; scalar</signature>

      
      <signature name="momentabout">(function) -&gt; method</signature>
<signature name="momentabout">(scalar) -&gt; point</signature>

    </mcd>
