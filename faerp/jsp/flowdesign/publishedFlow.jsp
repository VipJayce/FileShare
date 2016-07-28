<%@ page contentType="application/xml; charset=UTF-8" %>
<%@ page import="com.alexander.flowdesign.util.IConstants" %>

<%
String xmlStr=(String)request.getAttribute(IConstants.RETURN_PUBLISHED_FLOW_VALUE);
out.println(xmlStr);
%>