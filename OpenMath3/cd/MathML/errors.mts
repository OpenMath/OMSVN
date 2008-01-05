<?xml version="1.0" encoding="utf-8"?>
<!-- $Id: errors.mcd,v 1.5 2007/08/23 19:34:40 mkohlhas2 Exp $ -->
<mcd id="errors" 
     revision-date="2006-12-14"
     review-date="2007-01-14"
     version="0.1"
     status="experimental"
     cdbase="http://w3.org/Math/cds">

<title>General MathML Errors</title>

<MMLdefinition id="cds_unhandled_symbol" cdrole="error">
  <title>Unhandled Symbol</title>
  <name>unhandled_symbol</name>
  <description>
    <p>This symbol represents the error which is raised when an application reads a symbol
    which is present in the mentioned content dictionary, but which it has not
    implemented.</p>

    <p>When receiving such a symbol, the application should act as if it had received the
    MathML error object constructed from <code>unhandled_symbol</code> and the unhandled symbol as in
    the example below.</p>
  </description>
  <classification>Error Specifier</classification>
  <rendering><p>This symbols is not rendered</p></rendering>
  <MMLexample>
    <description><p>The application does not implement the Complex numbers:</p></description>
<![CDATA[<error>
    <csymbol cd="error" name="unhandled_symbol"/>
    <csymbol cd="setname1" name="C"/>
  </error>]]>
</MMLexample>
</MMLdefinition>

<MMLdefinition id="unexpected_symbol" cdrole="error">
  <title>Unexpected Symbol</title>
  <name>unexpected_symbol</name>
  <description>
    <p>This symbol represents the error which is raised when an application reads a symbol
    which is not present in the mentioned content dictionary.</p>

    <p>When receiving such a symbol, the application should act as if it had received the
    MathML error object constructed from unexpected_symbol and the unexpected symbol as
    in the example below.</p>
  </description>
  <classification>Error Specifier</classification>
  <rendering><p>This symbols is not rendered</p></rendering>

  <MMLexample>
    <description><p>The application received a mistyped symbol</p></description>
<![CDATA[<error>
    <csymbol cd="error" name="unexpected_symbol"/>
    <csymbol cd="arith1" name="plurse"/>
  </error>]]>
</MMLexample>
</MMLdefinition>

<MMLdefinition id="unsupported_CD" cdrole="error">
  <title>Unsupported Content Dictionary</title>
  <name>unsupported_CD</name>
  <description>
    <p>This symbol represents the error which is raised when an application reads a symbol
    where the mentioned content dictionary is not present.</p>

    <p>When receiving such a symbol, the application should act as if it had received the
    MathML error object constructed from <code>unsupported_CD</code> and the symbol from
    the unsupported Content Dictionary as in the example below.</p>
  </description>
  <classification>Error Specifier</classification>
  <rendering><p>This symbols is not rendered</p></rendering>
  <MMLexample>
    <description><p>The application does not know about the CD <code>specfun</code></p></description>
<![CDATA[<error>
    <csymbol cd="error" name="unsupported_CD"/>
    <csymbol cd="specfun" name="BesselJ"/>
  </error>]]>
  </MMLexample>
</MMLdefinition>
</mcd>
