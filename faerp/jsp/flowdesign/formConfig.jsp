<%@ page contentType="application/xml; charset=UTF-8" %>

<?xml version="1.0" encoding="UTF-8"?>

<xml>
<%
String xref = request.getParameter("xref");
String xmlstr = request.getParameter("xmlstr");

if(xmlstr!=null){
	session.setAttribute(xref,xmlstr);
}

Object getxml = session.getAttribute(xref==null?"":xref);
if(getxml==null){
	out.println("<Nothing/>");
}
else{
	out.println((String)getxml);
}
%>
</xml>

<!--sampleXML desc="收集表单元素">
  <input name="huqitest1" type="text" />
  <input name="huqitest2" type="textarea" />
  <input name="huqitest3" type="select-one" />
  <input name="huqitest4" type="text" />
  <input name="huqitest5" type="textarea" desc="中文提示"/>
</sampleXML-->