<%@ page contentType="application/xml; charset=UTF-8"%>
<%@ page import="gap.wf.adaptor.organization.OrgAdaptor"%>
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="com.alexander.workflow.extend.util.OrgModel4Ref"%>

<%
try {
	OrgAdaptor orgAdaptor = (OrgAdaptor) Helper.getBean("organization.adaptor");
	out.write(OrgModel4Ref.makeXML(orgAdaptor,request.getContextPath(),request.getParameter("partyid")));
} catch(Exception e) {
	e.printStackTrace();
}
%>