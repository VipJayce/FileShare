<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%
String partyType = request.getParameter("partyType");
//规则中和团体关系有关的关系类型
java.util.Map relationTypeMap = new java.util.HashMap();
if(org.apache.commons.lang.StringUtils.isNotEmpty(partyType)){
	gap.authority.org.auconnectrule.vo.AuConnectRuleVo obj = new gap.authority.org.auconnectrule.vo.AuConnectRuleVo();
	//obj.setParent_partytype_id(partyType);
	obj.setChild_partytype_id(partyType);
	java.util.List list = ((gap.authority.org.auconnectrule.bs.IAuConnectRuleBS)venus.frames.mainframe.util.Helper.getBean(gap.authority.org.auconnectrule.util.IConstants.BS_KEY)).queryByType(obj);
	for(int i=0;i<list.size();i++){
	    gap.authority.org.auconnectrule.vo.AuConnectRuleVo ruleVo = (gap.authority.org.auconnectrule.vo.AuConnectRuleVo)list.get(i);
	    if(!relationTypeMap.containsKey(ruleVo.getRelation_type_id()))
	        relationTypeMap.put(ruleVo.getRelation_type_id(),ruleVo.getRelation_type());
	}
}
String src = "deeptree.jsp?inputType="+request.getParameter("inputType")+"&submitType="+(request.getParameter("submitType")==null?"submitAll":request.getParameter("submitType"));
src+=("&nodeRelationType="+(request.getParameter("nodeRelationType")==null?"hasRelation":request.getParameter("nodeRelationType")));
src+=("&rootXmlSource="+gap.authority.util.StringHelperTools.encodeUrl(request.getParameter("rootXmlSource"))+"%26parent_code%3D");
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Organization' bundle='${applicationAuResources}' /></title>
<script>
function changeRT(v){
var locationUrl = "<%=src%>";
document.myTree.location.href=locationUrl+v;
}
</script>
</head>
<body topmargin=0 leftmargin=0 >
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Reference_page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<table class="table_noFrame">
	<tr>
		<td>&nbsp;&nbsp;
			<input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Determine' bundle='${applicationAuResources}' />" onClick="javascript:myTree.returnValueName();">
			<input name="button_cancel" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />"  onclick="javascript:window.close();" >
		</td>
	</tr>
</table>
<table class="table_noFrame">
  <tr> 
     <td width="100%"> 
        <select style="width:100%" onchange="changeRT(this.value)">
        <%java.util.Iterator it = relationTypeMap.entrySet().iterator();
        String firstParentCode = null;
        while (it.hasNext()) {
            java.util.Map.Entry entry = (java.util.Map.Entry) it.next();
            if(null==firstParentCode)
                firstParentCode = String.valueOf(entry.getKey());
        %>
            <option value="<%= String.valueOf(entry.getKey())%>"><%= String.valueOf(entry.getValue())%></option>
        <%} %>
        </select>
    </td>
  </tr>
  <tr> 
     <td width="100%" valign="top"> 
		<!--树开始-->    
		<iframe name="myTree" width="100%" height="450" src="<%=src+firstParentCode %>">
		</iframe>
		<!--树结束-->
    </td>
  </tr>
</table>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

