<?xml version="1.0" encoding="utf-8"?>
<mcd>
      <MMLdefinition id="cds_list" cdrole="application" arity="nary" container="yes">
        <name>list</name>
        <description>
          <p>The list element is the container element that constructs a list of elements.
          They may be explicitly listed, or defined by expressions or functions evaluated
          over a domain of application.  The domain of application may be given
          explicitly, or provided by means of one of the shortcut notations.</p>
        </description>
        <classification>constructor</classification>
        <MMLattribute>
          <attname>order</attname>
          <attvalue> lexicographic | numeric </attvalue>
          <attdefault>none</attdefault>
        </MMLattribute>
        <signature> (anything*) -> list </signature>
        <signature>[order=ordering](anything*) -> list </signature>
        <signature>(domainofapp,function) -> list </signature>
        <signature>(bvar+,domainofapp,anything) -> list </signature>
        <signature>[order=ordering](domainofapp,function) -> list(ordering) </signature>
        <signature>[order=ordering](bvar*,domainofapp,anything) -> list(ordering) </signature>
        <MMLexample><![CDATA[<list>
  <ci> a </ci>
  <ci> b </ci>
  <ci> c </ci>
</list>
]]></MMLexample>
        <MMLexample><![CDATA[<list order="numeric">
  <bvar><ci> x </ci></bvar>
  <condition>
    <apply><lt/>
      <ci> x </ci>
      <cn> 5 </cn>
    </apply>
  </condition>
</list>
]]></MMLexample>
      </MMLdefinition>

</mcd>
