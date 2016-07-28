<%@ page contentType="application/xml; charset=UTF-8"%>
<%@ page import="gap.wf.adaptor.organization.OrgAdaptor"%>
<%@ page import="venus.frames.mainframe.util.Helper"%>

<%
try{
	OrgAdaptor orgAdaptor = (OrgAdaptor) Helper.getBean("organization.adaptor");
	out.write(orgAdaptor.makeXML(request.getParameter("partyid")));
} catch(Exception e) {
	e.printStackTrace();
}
%>