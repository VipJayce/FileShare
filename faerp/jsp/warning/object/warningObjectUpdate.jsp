<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %> 

<%@ page import="venus.pub.util.VoHelper" %>

<%@ page import="gap.warning.object.model.WarningObject"%>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<% 
        WarningObject warningObject=(WarningObject)request.getAttribute("vo");
        if(warningObject==null) warningObject=new WarningObject();
        VoHelper.null2Nothing(warningObject);
    %>
<title><fmt:message key="jsp.object.warning_object_modify"/></title>
<!--jquery的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>

<script>
	    jQuery(function() {
	        <%
	               String reference = (String)request.getAttribute("isReference");
	               if("true".equals(reference)){
	        %>
	            jQuery('input[name="functionName"]').removeClass("text_field_reference").addClass("text_field");
	            jQuery(".img_1").remove();
	           <%}%>
      });
    function update_onClick(){//修改记录
        if(checkAllForms()){
            form.action = "<venus:base/>/WarningObjectAction.do?cmd=update";
            form.submit();
        }
    }
    function method_onClick(){
        var interfaceName=document.getElementById("interfaceName").value;
        var obj=window.showModalDialog("<venus:base/>/jsp/warning/interface/methodFrame.jsp?interfaceName="+interfaceName,'','dialogHeight:350px;dialogWidth:450px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
        if(obj){
            document.form.functionName.value = obj[0];
        }
    }
    
    function goBack(){
        //location.href="<%=request.getContextPath()%>/WarningObjectAction.do?cmd=queryAllWarningObjects";
        history.go(-1);
    }
</script>

</head>
<body>
<script language="javascript">
    writeTableTop('<fmt:message key="jsp.warning_object_modify"/>','<venus:base/>/');
</script>

<form name="form" method="post">
<input type="hidden" name="id" value="<%=warningObject.getId() %>">
<table class="table_noframe">
    <tr>
        <td valign="middle">
            <input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:update_onClick()">
            <input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>"  onClick="javascript:goBack()">
        </td>
    </tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="jsp.warning_object_modify"/>
        </td>
    </tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
    <tr> 
        <td align="right" width="15%" nowrap><font color="red">*</font><fmt:message key="jsp.warning_object_name"/></td>
        <td align="left">
            <input name="objectName" type="text" class="text_field" inputName="<fmt:message key="jsp.warning_object_name"/>" validate="notNull;isSearch" value="<%=warningObject.getObjectName() %>">         
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font>BeanId</td> 
        <td align="left">
            <input name="beanId" inputName="BeanId" type="text"  class="text_field" id="beanId" value="<%=warningObject.getBeanId()%>"size="20" readOnly="true"  validate="notNull;isNormalStrOnWeb">
        </td>
    </tr>
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.warning_object_instance_name"/></td>
        <td>
            <input name="interfaceName" inputName="<fmt:message key="jsp.warning_object_instance_name"/>" type="text"  class="text_field" id="interfaceName" value="<%=warningObject.getInterfaceName()%>"size="20" readOnly="true"  validate="notNull;isNormalStrOnWeb">
        </td>
   </tr>
    
    <tr>
        <td align="right"><font color="red">*</font><fmt:message key="jsp.method_name"/></td>
        <td align="left">
            <input name="functionName"  type="text" inputName="<fmt:message key="jsp.method_name"/>" class="text_field_reference" id="functionName"  validate="notNull;isSearch" value="<%=warningObject.getFunctionName()%>"size="20"  readOnly="true" ><img src="<venus:base/>/images/icon/reference.gif" class="img_1" onClick="javascript:method_onClick();"/>
        </td>
    </tr>

</table>
</div>
</form>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>