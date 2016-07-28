<%@ page contentType="application/xml; charset=UTF-8"%>
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="gap.common.authority.service.IOrganization"%>
<%@ page import="gap.common.util.IBeanConstants"%>
<%@ page import="gap.common.tree.OrgModel4Ref"%>

<%
try {
    IOrganization orgAdaptor = (IOrganization) Helper.getBean(IBeanConstants.BEAN_ID_ORGANIZATION);
    out.write(OrgModel4Ref.makeXML(orgAdaptor,request.getContextPath(),request.getParameter("partyid")));
} catch(Exception e) {
    e.printStackTrace();
}
%>