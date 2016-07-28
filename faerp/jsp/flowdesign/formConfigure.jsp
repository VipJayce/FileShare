<%@ page contentType="application/xml; charset=UTF-8" %>

<%
String xmlStr=(String)request.getAttribute("formConfigure");

String signal = "xml version=\"1.0\"";
String signaln = "encoding=\"gb2312\""; 
int pos = xmlStr.indexOf(signal);
int posn = xmlStr.indexOf(signaln);

if(pos!=-1 && posn==-1){
	xmlStr = xmlStr.replaceFirst(signal,signal + " " + signaln);
}
else if(pos==-1){
	xmlStr = "<?xml version=\"1.0\" encoding=\"gb2312\" ?>"
		+ "<AlexanderExtendService>" 
		+ xmlStr 
		+ "</AlexanderExtendService>";
}

out.println(xmlStr);
%>