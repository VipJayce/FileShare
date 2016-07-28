<%@ page contentType="application/xml; charset=UTF-8"%>
<%@ page import="gap.msg.util.OrgAdaptor"%>
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%
try{
	OrgAdaptor orgAdaptor = (OrgAdaptor) Helper.getBean("message.organization.adaptor");
	out.write(orgAdaptor.makeXML(request.getParameter("partyid")));
} catch(Exception e) {
	e.printStackTrace();
}
%>