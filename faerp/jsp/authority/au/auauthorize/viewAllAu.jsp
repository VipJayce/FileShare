<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%@ page import="gap.authority.org.aupartyrelationtype.bs.IAuPartyRelationTypeBS" %>
<%@page import="gap.authority.org.aupartyrelationtype.util.IConstants"%>
<%@page import="gap.authority.org.aupartyrelationtype.vo.AuPartyRelationTypeVo"%>
<%@ page import="venus.frames.mainframe.util.Helper" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ include file="/jsp/include/global.jsp" %>
<%
	String vCode = request.getParameter("vCode");
	String partyId = request.getParameter("partyId");
	String partyTypeId = request.getParameter("partyTypeId");
	String visitorType = GlobalConstants.getVisiTypeByPartyType(partyTypeId);
	//关系类型
	java.util.Map relationTypeMap = new HashMap();
	IAuPartyRelationTypeBS bs = (IAuPartyRelationTypeBS)Helper.getBean(IConstants.BS_KEY);
	AuPartyRelationTypeVo searchVo = new AuPartyRelationTypeVo();
	searchVo.setKeyword("4");
	List al = bs.simpleQuery(1,Short.MAX_VALUE,null,searchVo);
	for(int i=0;i<al.size();i++){
	    AuPartyRelationTypeVo reTypeVo = (AuPartyRelationTypeVo)al.get(i);
	    if(!GlobalConstants.getRelaType_proxy().equals(reTypeVo.getId())){//非代理关系
	        relationTypeMap.put(reTypeVo.getId(),reTypeVo.getName());
	    }
	}
%>
<base target="_self">
<title><fmt:message key='gap.authority.View_permissions' bundle='${applicationAuResources}' /></title>
<script language="javascript">
	function goBack_onClick(typeId) {//返回
	    if(window.dialogArguments){
           parent.window.close();
       }else{
          form.action="<venus:base/>/AuPartyAction.do?cmd=detailList&pageFlag=<%=visitorType%>&id=<%=partyId%>";
          form.submit();
        }	    
	}	
</script>
<link href="<venus:base/>/css/tabs.css.jsp" rel="stylesheet" type="text/css">
<script language="javascript">
	var tabs  =  new Array(
		new Array ("<fmt:message key='gap.authority.Functional_competence' bundle='${applicationAuResources}' />","<venus:base/>/AuAuthorizeAction.do?cmd=viewFuncAu&vCode=<%=vCode%>"),	
		new Array ("<fmt:message key='gap.authority.Agency_data_rights' bundle='${applicationAuResources}' />","<venus:base/>/jsp/authority/tree/deeptree4Au.jsp?inputType=checkbox&nodeRelationType=noRelation&rootXmlSource="
				+"<venus:base/>/jsp/authority/au/auauthorize/viewOrg.jsp?parent_code%3D<%=GlobalConstants.getRelaType_comp()%>%26vCode%3D<%=vCode%>%26data_limit%3D1"),
		<%java.util.Iterator it = relationTypeMap.entrySet().iterator();
		while (it.hasNext()) {
		    java.util.Map.Entry entry = (java.util.Map.Entry) it.next();
		%>
		new Array ("<%= String.valueOf(entry.getValue())%><fmt:message key='gap.authority.Data_rights' bundle='${applicationAuResources}' />","<venus:base/>/jsp/authority/tree/deeptree4Au.jsp?inputType=checkbox&nodeRelationType=noRelation&rootXmlSource="
                +"<venus:base/>/jsp/authority/au/auauthorize/viewOrg.jsp?parent_code%3D<%= String.valueOf(entry.getKey())%>%26vCode%3D<%=vCode%>%26data_limit%3D1"),
        <%}%>
        new Array ("<fmt:message key='gap.authority.The_role_of_data_rights' bundle='${applicationAuResources}' />","<venus:base/>/jsp/authority/tree/deeptree4Au.jsp?inputType=checkbox&nodeRelationType=noRelation&rootXmlSource="
                +"<venus:base/>/jsp/authority/au/auauthorize/viewOrg.jsp?parent_code%3D<%=GlobalConstants.getRelaType_role()%>%26vCode%3D<%=vCode%>%26data_limit%3D1"),
        new Array ("<fmt:message key='gap.authority.Agency_data_rights0' bundle='${applicationAuResources}' />","<venus:base/>/jsp/authority/tree/deeptree4Au.jsp?inputType=checkbox&nodeRelationType=noRelation&rootXmlSource="
                +"<venus:base/>/jsp/authority/au/auauthorize/viewOrg.jsp?parent_code%3D<%=GlobalConstants.getRelaType_proxy()%>%26vCode%3D<%=vCode%>%26data_limit%3D1"),
		new Array ("<fmt:message key='gap.authority.Historical_data_permissions' bundle='${applicationAuResources}' />","<venus:base/>/HistoryLogAction.do?cmd=simpleQueryForView&vCode=<%=vCode%>&rType=<%=GlobalConstants.getResType_orga()%>"),				
		new Array ("<fmt:message key='gap.authority.Functional_data_permissions' bundle='${applicationAuResources}' />","<venus:base/>/jsp/authority/au/auauthorize/viewFuncOrgFrame.jsp?cmd=viewFuncOrgAu&vCode=<%=vCode%>&rootCode=<%=GlobalConstants.getRelaType_comp()%>"),		
		<%it = relationTypeMap.entrySet().iterator();
        while (it.hasNext()) {
            java.util.Map.Entry entry = (java.util.Map.Entry) it.next();
        %>
        new Array ("<%= String.valueOf(entry.getValue())%><fmt:message key='gap.authority.Functional_data_permissions' bundle='${applicationAuResources}' />","<venus:base/>/jsp/authority/au/auauthorize/viewFuncOrgFrame.jsp?cmd=viewFuncOrgAu&vCode=<%=vCode%>&rootCode=<%=String.valueOf(entry.getKey())%>"),
        <%}%>
		new Array ("<fmt:message key='gap.authority.Field_level_data_permissions' bundle='${applicationAuResources}' />","<venus:base/>/AuAuthorizeAction.do?cmd=viewDataAu&vCode=<%=vCode%>&rType=<%=GlobalConstants.getResType_fild()%>"),
		new Array ("<fmt:message key='gap.authority.Record_level_data_permissions' bundle='${applicationAuResources}' />","<venus:base/>/AuAuthorizeAction.do?cmd=viewDataAu&vCode=<%=vCode%>&rType=<%=GlobalConstants.getResType_recd()%>")
	); 
</script>
<script src="<venus:base/>/js/au/tabs.js"></script>
</head>
<body onload="writeTabs(430);">
<form name="form" method="post">
<table class="table_noframe" width="100%" align="center">
	<tr>
		<td valign="middle">			
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Return' bundle='${applicationAuResources}' />"  onClick="goBack_onClick();">
		</td>
		
	</tr>
</table>
<div id="auDivParent1" align="center"> 
<table class="table_div_control" style="width:96%">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.View_authorization' bundle='${applicationAuResources}' />
		</td>
		<td>
		</td>		
	</tr>
</table>
</div>
<div id="auDivChild1" align="center"> 
<table class="table_div_content" style="width:96%">
	<tr>
		<td>
			<table width="100%">
			  <tr>
				<td>
				<div id="tabsDiv"></div>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
</div>	
</form>
</body>
</html>

