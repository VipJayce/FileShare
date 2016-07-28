<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="gap.authority.org.aupartyrelationtype.bs.IAuPartyRelationTypeBS" %>
<%@page import="gap.authority.org.aupartyrelationtype.util.IConstants"%>
<%@page import="gap.authority.org.aupartyrelationtype.vo.AuPartyRelationTypeVo"%>
<%@ page import="venus.frames.mainframe.util.Helper" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%@ page import="java.util.List" %>
<%
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
String src = "deeptree4Au.jsp?inputType="+request.getParameter("inputType")+"&submitType="+(request.getParameter("submitType")==null?"submitAll":request.getParameter("submitType"));
src += ("&nodeRelationType="+(request.getParameter("nodeRelationType")==null?"hasRelation":request.getParameter("nodeRelationType"))+"&relId="+request.getParameter("relId")+"&pType=");
src += (request.getParameter("pType")+"&rootXmlSource="+gap.authority.util.StringHelperTools.encodeUrl(request.getParameter("rootXmlSource"))+"%26parent_code%3D");
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Organization' bundle='${applicationAuResources}' /></title>
</head>
<%
    String retMessage = (String)request.getAttribute("retMessage");
    if(retMessage!=null) {
        out.print("<script language='javascript'>alert('"+retMessage+"'); window.close();</script>");
    } 
%>
<body topmargin=0 leftmargin=0 >
<script language="javascript">
    writeTableTop("<fmt:message key='gap.authority.Authorization_page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
    function changeRT(v){
        var locationUrl = "<%=src%>";
        document.myTree.location.href=locationUrl+v;
    }
</script>
<table class="table_noFrame">
    <tr>
        <td>&nbsp;&nbsp;
            <input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Determine' bundle='${applicationAuResources}' />" onClick="javascript:myTree.saveOnClick();">
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
        <iframe name="myTree" width="100%" height="450" src="<%=src+firstParentCode%>">
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

