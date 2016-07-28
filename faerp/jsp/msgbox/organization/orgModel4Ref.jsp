<%@ page contentType="application/xml; charset=UTF-8"%>
<%@ page import="gap.msg.util.OrgAdaptor"%>
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="gap.msg.logic.org.OrgModel4Ref"%>
<%
try {
	OrgAdaptor orgAdaptor = (OrgAdaptor) Helper.getBean("message.organization.adaptor");
	out.write(OrgModel4Ref.makeXML(orgAdaptor,request.getContextPath(),request.getParameter("partyid")));
} catch(Exception e) {
	e.printStackTrace();
}
%>