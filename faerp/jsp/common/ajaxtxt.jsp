<%@ page contentType="text/html; charset=UTF-8" %><%
String txtstr = (String)request.getAttribute("ajaxtxt");
if(txtstr==null)
	out.println("");
else
	out.println(txtstr);
%>