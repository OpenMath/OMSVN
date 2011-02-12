<?xml version="1.0"?>
<mcd>

      <signature name="and"> (boolean*) -&gt; boolean </signature>


      <signature name="or"> (boolean*) -&gt; boolean </signature>
<signature name="or"> [type="boolean"](symbolic*) -&gt; boolean </signature>

      
      <signature name="xor"> (boolean*) -&gt; boolean </signature>
<signature name="xor"> [type="boolean"](symbolic*) -&gt; symbolic </signature>


      <signature name="not"> (boolean) -&gt; boolean </signature>
<signature name="not"> [type="boolean"](algebraic)  -&gt; boolean </signature>


      <signature name="implies"> (boolean,boolean) -&gt; boolean </signature>


      <signature name="equivalent">(boolean,boolean+) -&gt; boolean </signature>
<signature name="equivalent"> (domainofapp,function) -&gt; boolean </signature>
<signature name="equivalent"> (bvar+,domainofapp,boolean) -&gt; boolean </signature>

      
	  <signature name="true">boolean</signature>


      <signature name="false">boolean</signature>

      
</mcd>
