<?xml version="1.0"?>
<mcd>
  <signature name="determinant">(matrix)-&gt; scalar</signature>

      
      <signature name="transpose">(vector)-&gt;vector(type=row)</signature>
<signature name="transpose">(matrix)-&gt;matrix</signature>
<signature name="transpose">(vector[type=row])-&gt;vector</signature>

      <signature name="selector">(matrix,scalar,scalar)-&gt;scalar</signature>
<signature name="selector">(matrix,scalar)-&gt;matrixrow</signature>
<signature name="selector">(matrix)-&gt;scalar* </signature>
<signature name="selector">((vector|list|matrixrow),scalar )-&gt;scalar</signature>
<signature name="selector">(vector|list|matrixrow)-&gt;scalar*</signature>

      
      <signature name="vectorproduct">(vector,vector)-&gt;vector</signature>

      
	  <signature name="scalarproduct">(vector,vector) -&gt; scalar</signature>

	  
      <signature name="outerproduct">(vector,vector) -&gt; matrix</signature>

    </mcd>
