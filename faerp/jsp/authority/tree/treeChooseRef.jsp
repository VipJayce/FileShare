<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="gap.authority.org.aupartyrelationtype.bs.IAuPartyRelationTypeBS" %>
<%@page import="gap.authority.org.aupartyrelationtype.util.IConstants"%>
<%@page import="gap.authority.org.aupartyrelationtype.vo.AuPartyRelationTypeVo"%>
<%@ page import="venus.frames.mainframe.util.Helper" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%@ page import="java.util.List" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Organization' bundle='${applicationAuResources}' /></title>
</head>
<%
String basePath=request.getParameter("basePath");
String submit_all=request.getParameter("submit_all");
String return_type=request.getParameter("return_type");
String tree_level=request.getParameter("tree_level");
String data_limit=request.getParameter("data_limit");
String hierarchy=request.getParameter("hierarchy");
String attributesFilter=request.getParameter("attributesFilter");
//规则中和团体关系有关的关系类型
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
String rootXmlSource=basePath+"/jsp/authority/tree/orgChooseTree.jsp?submit_all="+submit_all+"&return_type="+return_type+"&tree_level="+tree_level+"&data_limit="+data_limit+"&hierarchy="+hierarchy+"&attributesFilter="+attributesFilter+"&parent_code=";
%>
<body topmargin=0 leftmargin=0 >
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Reference_page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
	function changeRT(v){
		var locationUrl = "deeptree.jsp?inputType=<%=request.getParameter("inputType")%>&submitType=<%=request.getParameter("submitType")==null?"submitAll":request.getParameter("submitType")%>&nodeRelationType=<%=request.getParameter("nodeRelationType")==null?"hasRelation":request.getParameter("nodeRelationType")%>&rootXmlSource=<%=gap.authority.util.StringHelperTools.encodeUrl(rootXmlSource)%>";
		document.myTree.location.href=locationUrl+v;
	}
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
		<iframe name="myTree" width="100%" height="450" src="deeptree.jsp
			?inputType=<%=request.getParameter("inputType")%>
			&submitType=<%=request.getParameter("submitType")==null?"submitAll":request.getParameter("submitType")%>
			&nodeRelationType=<%=request.getParameter("nodeRelationType")==null?"hasRelation":request.getParameter("nodeRelationType")%>
			&rootXmlSource=<%=gap.authority.util.StringHelperTools.encodeUrl(rootXmlSource)+firstParentCode%>">
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

