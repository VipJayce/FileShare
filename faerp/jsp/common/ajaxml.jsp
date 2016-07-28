<%@ page contentType="application/xml; charset=UTF-8" %>

<?xml version="1.0" encoding="UTF-8"?>
<%
String xmlstr = (String)request.getAttribute("ajaxml");
if(xmlstr==null)
	out.println("<Nothing/>");
else
	out.println(xmlstr);
%>