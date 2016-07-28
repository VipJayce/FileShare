<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ page import="gap.warning.object.model.WarningObject"%> 
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<!--jquery的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<% 
        WarningObject warningObject=(WarningObject)request.getAttribute("vo");
        
        if(warningObject==null) warningObject=new WarningObject();
        
        VoHelper.null2Nothing(warningObject);
    %>
<title><fmt:message key="jsp.warning_object_view"/></title>
<script>
    function findWarningTemplate_onClick(){
            var id=jQuery('input[name="id"]').val();
            location.href="<%=request.getContextPath()%>/WarningTemplateAction.do?cmd=queryWarningTemplatesByObjectId&objId="+id;
    }

    
    function goBack(){
        history.go(-1);
    }
</script>

</head>
<body>
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.warning_object_view"/>','<venus:base/>/');
</script>

<form name="form" method="post">
<input type="hidden" name="id" value="<%=warningObject.getId() %>">
<table class="table_noframe">
    <tr>
        <td valign="middle">
            <input name="button_save" type="button" class="button_ellipse" value="<fmt:message key="jsp.view_related_warning_template"/>" onClick="javascript:findWarningTemplate_onClick()">
            <input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="return"/>"  onClick="javascript:goBack()">
        </td>
    </tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="jsp.warning_object_view"/>
        </td>
    </tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content"><tr><td>
<table class="viewlistCss" cellspacing="1" cellpadding="0" border="0" align="center">
    <tr> 
        <th align="right" width="10%" nowrap><fmt:message key="jsp.warning_object_name"/></th>
        <td align="left">
            &nbsp;<%=warningObject.getObjectName() %>
        </td>
    </tr>
    <tr>
        <th align="right">&nbsp;BeanId</th> 
        <td align="left">
             &nbsp;<%=warningObject.getBeanId()%>
        </td>
    </tr>
    <tr>
        <th align="right"><fmt:message key="jsp.warning_object_instance_name"/></th>
        <td>
             &nbsp;<%=warningObject.getInterfaceName()%>
        </td>
   </tr>
    
    <tr>
        <th align="right"><fmt:message key="jsp.method_name"/></th>
        <td align="left">
            &nbsp;<%=warningObject.getFunctionName()%>
        </td>
    </tr>
</table>
</td></tr></table>
</div>
</form>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>