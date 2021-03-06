<?xml version="1.0" encoding="utf-8"?>
<!-- $Id: mathmlkeys.mcd,v 1.1 2007/09/15 07:40:44 mkohlhas2 Exp $ -->
<mcd id="mathmlkeys"  revision-date="2007-09-24"
     review-date="2007-09-17" version="0.1" status="experimental"
     cdbase="http://w3.org/Math/cds">

  <title>MathML Keys for Attributions</title>
  <description>
    <p>This content dictionary provides some keys for specifying the relations in
    <el>semantics</el> elements.</p>
  </description>

  <MMLdefinition id="cds_mathmlkeys_equiv" cdrole="attribution">
    <title>Semantically Equivalent</title>
    <name>equiv</name>
    <description>
      <p>This key specifies that the corresponding value is equivalent
      to the annotated element in some unspecified way.</p> 
    </description>
    <discussion>
      <p>This key is used as the default relation for <el>annotation</el> and
      <el>annotation-xml</el> elements that do not specify keys. It is mainly intended for
      MathML2 legacy documents</p>
    </discussion>
  </MMLdefinition>
  
  <MMLdefinition id="cds_mathmlkeys_contentequiv" cdrole="attribution">
    <title>Content Equivalent</title>
    <name>contentequiv</name>
    <description>
      <p>This key specifies that the corresponding value is the content MathML equivalent
      of the annotated element.</p> 
    </description>
  </MMLdefinition>

  <MMLdefinition id="cds_mathmlkeys_contentequiv-strict" cdrole="attribution">
    <title>Strice Content Equivalent</title>
    <name>contentequiv-strice</name>
    <description>
      <p>This key specifies that the corresponding value is the equivalent in strict
      content MathML of the annotated element.</p>
    </description>
  </MMLdefinition>
</mcd>
