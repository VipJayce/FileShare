<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%
    String relationId = (String)request.getAttribute("relationId");
    if(relationId==null) {
        relationId = "";
    }
    HashMap ruleMap = (HashMap)request.getAttribute("ruleMap");
    if(ruleMap==null) {
        ruleMap = new HashMap();
    }
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GAP<fmt:message key='gap.authority.Organizational_competence_system' bundle='${applicationAuResources}' /></title>
<script language="javascript">
    function toAdd_onClick(addType) {  
        var relationId = document.form.relationId.value;
        if(addType=="comp")
            window.location="<%=request.getContextPath()%>/jsp/authority/sample/company/insertCompany.jsp?parentRelId="+relationId;
        else if(addType=="dept")
            window.location="<%=request.getContextPath()%>/jsp/authority/sample/department/insertDepartment.jsp?parentRelId="+relationId;
        else if(addType=="posi")
            window.location="<%=request.getContextPath()%>/jsp/authority/sample/position/insertPosition.jsp?parentRelId="+relationId;
        else if(addType=="empl")
            window.location="<%=request.getContextPath()%>/jsp/authority/sample/employee/insertEmployee.jsp?parentRelId="+relationId;
        else
            window.location="<%=request.getContextPath()%>/jsp/authority/generate/"+addType+"Organize/insert"+addType+"Organize.jsp?parentRelId="+relationId;
    }
    function toSel_onClick(addType) { 
        var refPath = "";
        if(addType=="comp")
            refPath = "<%=request.getContextPath()%>/jsp/authority/sample/relation/refFrame.jsp?actionStr=CompanyAction";
        else if(addType=="dept")
            refPath = "<%=request.getContextPath()%>/jsp/authority/sample/relation/refFrame.jsp?actionStr=DepartmentAction";
        else if(addType=="posi")
            refPath = "<%=request.getContextPath()%>/jsp/authority/sample/relation/refFrame.jsp?actionStr=PositionAction";
        else if(addType=="empl")
            refPath = "<%=request.getContextPath()%>/jsp/authority/sample/relation/refFrame.jsp?actionStr=EmployeeAction";
        else
           refPath = "<%=request.getContextPath()%>/jsp/authority/sample/relation/refFrame.jsp?actionStr="+addType+"OrganizeAction";
        
        var rtObj = window.showModalDialog(refPath, new Object(),'dialogHeight=600px;dialogWidth=850px;resizable:yes;status:no;scroll:auto;');
        if(rtObj != undefined){ 
            var partyIds = "";
            for(var i=0; i<rtObj.length-1; i++) {
                partyIds += rtObj[i] + ",";
            }
            partyIds += rtObj[rtObj.length-1];
            var relationId = document.form.relationId.value;
            form.action="<%=request.getContextPath()%>/RelationAction.do?cmd=addRelation&partyIds="+partyIds+"&parentRelId="+relationId;
            form.target="_parent";
            form.submit();
        }
    }
</script>
</head>
<body>
<script language="javascript">
    writeTableTop("<fmt:message key='gap.authority.Add_the_lower_node' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
    <tr>
        <td>
            <input name="button_back" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Return' bundle='${applicationAuResources}' />"  onclick="javascript:returnBack()" >
        </td>
    </tr>
</table>

<div id="ccParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key='gap.authority.Add_the_lower_node' bundle='${applicationAuResources}' />
        </td>
    </tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
    <tr>
        <td>
            <table class="table_div_content_inner">
                <tr> 
                    <td height="20" colspan="3"></td> 
                </tr>
                <%
                    if(ruleMap.keySet().contains("comp")) {
                %>
                <tr> 
                    <td align="right">
                    <fmt:message key='gap.authority._Company_Add_' bundle='${applicationAuResources}' />
                    </td> 
                    <td align="left">
                        <input name="btnAdd1" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Entry_of_new_companies' bundle='${applicationAuResources}' />"  onClick="javascript:toAdd_onClick('comp')">&nbsp;&nbsp;
                    </td> 
                    <td align="left">
                        <!--input name="btnSel1" class="button_ellipse" type="button" value="从现有公司中选择"  onClick="javascript:toSel_onClick('comp')"-->
                    </td> 
                </tr>
                <tr> 
                    <td height="20" colspan="3"></td> 
                </tr>
                <%
                    }
                    if(ruleMap.keySet().contains("dept")) {
                %>
                <tr> 
                    <td align="right">
                    <fmt:message key='gap.authority.Department_Add_' bundle='${applicationAuResources}' />
                    </td> 
                    <td align="left">
                        <input name="btnAdd2" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Input_new_department' bundle='${applicationAuResources}' />"  onClick="javascript:toAdd_onClick('dept')">&nbsp;&nbsp;
                    </td> 
                    <td align="left">
                        <!--input name="btnSel2" class="button_ellipse" type="button" value="从现有部门中选择"  onClick="javascript:toSel_onClick('dept')"-->
                    </td> 
                </tr> 
                <tr> 
                    <td height="20" colspan="3"></td> 
                </tr>
                <%
                    }
                    if(ruleMap.keySet().contains("posi")) {
                %>
                <tr> 
                    <td align="right">
                    <fmt:message key='gap.authority._Add_Post_' bundle='${applicationAuResources}' />
                    </td> 
                    <td align="left">
                        <input name="btnAdd3" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Input_new_posts' bundle='${applicationAuResources}' />"  onClick="javascript:toAdd_onClick('posi')">&nbsp;&nbsp;
                    </td> 
                    <td align="left">
                        <!--input name="btnSel3" class="button_ellipse" type="button" value="从现有岗位中选择"  onClick="javascript:toSel_onClick('posi')"-->
                    </td> 
                </tr> 
                <tr> 
                    <td height="20" colspan="3"></td> 
                </tr>
                <%
                    }
                    if(ruleMap.keySet().contains("empl")) {
                %>
                <tr> 
                    <td align="right">
                    <fmt:message key='gap.authority.Staff_Add_' bundle='${applicationAuResources}' />
                    </td> 
                    <td align="left">
                        <input name="btnAdd4" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Entry_of_new_employees' bundle='${applicationAuResources}' />"  onClick="javascript:toAdd_onClick('empl')">&nbsp;&nbsp;
                    </td> 
                    <td align="left">   
                        <input name="btnSel4" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Select_from_the_existing_staff' bundle='${applicationAuResources}' />"  onClick="javascript:toSel_onClick('empl')">
                    </td> 
                </tr> 
                <tr> 
                    <td height="20" colspan="3"></td> 
                </tr>
                <%
                    }
                    if(ruleMap.keySet().contains("common")) {
                        List subNodes = (List)ruleMap.get("common");
                        for(int i=0;i<subNodes.size();i++){
                            String subNodeAction = (String)subNodes.get(i);                         
                %>
                <tr> 
                    <td align="right">
                    <fmt:message key='gap.authority._Add_Prefix_' bundle='${applicationAuResources}' /><%=venus.frames.i18n.util.LocaleHolder.getMessage("organize."+subNodeAction.toLowerCase()+".key") %><fmt:message key='gap.authority._Add_Suffix_' bundle='${applicationAuResources}' />
                    </td> 
                    <td align="left">
                        <input name="btnAdd<%=(i+5) %>" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Entry_of_new_' bundle='${applicationAuResources}' /><%=venus.frames.i18n.util.LocaleHolder.getMessage("organize."+subNodeAction.toLowerCase()+".key") %>"  onClick="javascript:toAdd_onClick('<%=subNodeAction%>')">&nbsp;&nbsp;
                    </td> 
                    <td align="left">    
                        <!-- <input name="btnSel<%=(i+5) %>" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Select_from_the_existing_' bundle='${applicationAuResources}' /><%=venus.frames.i18n.util.LocaleHolder.getMessage("organize."+subNodeAction.toLowerCase()+".key") %><fmt:message key='gap.authority.Select_from_the_existing_choose' bundle='${applicationAuResources}' />"  onClick="javascript:toSel_onClick('<%=subNodeAction%>')"> -->
                    </td> 
                </tr> 
                <tr> 
                    <td height="20" colspan="3"></td> 
                </tr>
                <% 
                        }
                    }
                %>
            </table>
        </td>
    </tr>
</table>
</div>
<input type="hidden" name="relationId" value="<%=relationId%>">
</form>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>