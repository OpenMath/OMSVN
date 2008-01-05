<?xml version="1.0"?>
<mcd>
  <signature name="vector">(real*) -&gt; vector(type=real)</signature>
<signature name="vector">[type=vectortype]((anything)*) -&gt; vector(type=vectortype)</signature>
<signature name="vector"> (domainofapp,function) -&gt; vector </signature>
<signature name="vector"> (bvar+,domainofapp,anything) -&gt; vector </signature>

	  <signature name="matrix">(matrixrow*) -&gt; matrix</signature>
<signature name="matrix">[type=matrixtype](matrixrow*) -&gt; 
matrix(type=matrixtype)</signature>
<signature name="matrix"> (domainofapp,function) -&gt; matrix </signature>
<signature name="matrix"> (bvar,bvar,domainofapp,anything) -&gt; matrix </signature>


      <signature name="matrixrow">(ringelement+) -&gt; matrixrow</signature>

      

</mcd>
