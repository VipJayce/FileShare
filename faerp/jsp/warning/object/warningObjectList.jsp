<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<script language="javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
<script language="javascript" src="<venus:base/>/js/warning/gap-ajaxList-jquery.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-impromptu.1.8.js"></script >
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<!--提示框，选择框，确认框控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/warning/dialog/jquery-dialog.css" type="text/css">
<title><fmt:message key="jsp.warning_object_list"/></title>
<script>
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.submit();
  	}
  	
  	function add_OnClick(){
  		window.location="<venus:base/>/jsp/warning/object/warningObjectInsert.jsp";
  	}
  	
  	function modify_OnClick(){
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);//提示框
            return ;
        }

        form.action = "<venus:base/>/WarningObjectAction.do?cmd=find&id=" + getCheckBoxValByName("checkbox_template");
        form.submit();
  	}

    function delete_OnClick(){
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);//提示框
            return ;
        }
        i18n4WarningSystem.delete_prompt(submitForm);
    }
    function submitForm(value,dom){
        if(!value)
            return false;
         form.action = "<venus:base/>/WarningObjectAction.do?cmd=delete&id=" + getCheckBoxValByName("checkbox_template");
          form.submit();
    }

    function view_OnClick(){
        if(getCheckBoxSizeByName("checkbox_template")==0){
            jQuery.prompt(i18n.please_select_a_record);//提示框
            return ;
        }

        form.action = "<venus:base/>/WarningObjectAction.do?cmd=view&id=" + getCheckBoxValByName("checkbox_template");
        form.submit();
    }
</script>

</head>
<body align="center">
<script language="javascript">
	writeTableTop('<fmt:message key="jsp.warning_object_list"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/WarningObjectAction.do?cmd=queryAllWarningObjects">

<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			<fmt:message bundle='${applicationResources}'  key="query_with_condition"/>
		</td>
	</tr>
</table>
</div>
<div id="ccChild0"> 
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap>BeanId</td>
	<td>
		<input name="beanId" type="text" class="text_field" inputName="beanId" validate="isSearch" rubber_id="build_Id">
	</td>
</tr>
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="jsp.warning_object_name"/></td>
	<td><input name="objectName" type="text" class="text_field" inputName='<fmt:message key="jsp.warning_object_name"/>'  validate="isSearch"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="query"/>" onClickTo="javascript:simpleQuery_onClick();">
	</td>
</tr>
</table>

</div>


<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
		  <img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="jsp.details_table"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:add_OnClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="add"/></td>
					<td class="button_ellipse" onClick="javascript:modify_OnClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="modify"/></td>
					<td class="button_ellipse" onClick="javascript:delete_OnClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:view_OnClick();"><img src="<venus:base/>/images/icon/view.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="view"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td>
		<layout:collection name="warningObjects" id="warningObject" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="10%"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem width="20%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.warning_object_name")%>' property="objectName" sortable="true" style="text-align:center;">
                <bean:define id="objId" name="warningObject" property="id"/>
                <input type="radio" name="checkbox_template" value="<%=objId%>" style="display:none"/>
				<bean:write name="warningObject" property="objectName"/>
			</layout:collectionItem>
			<layout:collectionItem width="15%" title="Bean Id" property="beanId" sortable="true" style="text-align:center;"/>
			<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.method_name")%>' property="functionName" sortable="true" style="text-align:center;"/>
			<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.warningsystem.jsp.return_type")%>' property="returnType" sortable="true" style="text-align:center;"/>
			
		</layout:collection>
		<jsp:include page="/jsp/include/page.jsp" />
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
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>