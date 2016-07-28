<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList,java.util.HashMap"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<%
		EnumRepository er = EnumRepository.getInstance();
        er.loadFromDir();
        EnumValueMap styleMap = er.getEnumValueMap("Style");
	%>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<html>
<head>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<base target="_self">
<title>Form Select Page</title>
<script language="javascript">
<!--
function submitForm(param) {
	var checkedValue;
	var checkedCount = 0;
	var obj = document.all("checkbox_template");

	if ( isNaN(obj) == false ) {
		return;
	}

	for ( var i = 0; i < obj.length; i++ ) {
		if ( obj[i].checked ) {
			checkedCount++;
		}
	}

	if ( checkedCount == 1 ) {
		for ( var i = 0	; i < obj.length; i++ ) {
			if ( obj[i].checked ) {
				checkedValue = obj[i].value;
				break;
			}
		}
	}

	if ( obj.length == "undefined" || obj.checked ) {
		checkedCount = 1;
		checkedValue = obj.value;
	}

	if ( checkedCount > 1 || checkedCount == 0 ) {
		alert(i18n.please_select_a_record);
		return;
	}

	var radArray = checkedValue.split(",");
	/*mod by huqi*/
	if (param == true) {
		var xref = "/workflowFormShowAction.do?formID=" + radArray[1] + "--" + radArray[0] +"--";
		window.dialogArguments.SetFlowWebFormText(xref);
	}
	/*mod by huqi*/
	if (param == null) {
		var xref = "/workflowFormShowAction.do?formID=" + radArray[1] + "--" + radArray[0] +"--";
		window.dialogArguments.SetActionWebFormText(xref);
	}

	self.close();
}

function showForm() {
	var checkedValue;
	var checkedCount = 0;
	var obj = document.all("checkbox_template");

	if ( isNaN(obj) == false ) {
		return;
	}

	for ( var i = 0; i < obj.length; i++ ) {
		if ( obj[i].checked ) {
			checkedCount++;
		}
	}

	if ( checkedCount == 1 ) {
		for ( var i = 0	; i < obj.length; i++ ) {
			if ( obj[i].checked ) {
				checkedValue = obj[i].value;
				break;
			}
		}
	}

	if ( obj.length == "undefined" || obj.checked ) {
		checkedCount = 1;
		checkedValue = obj.value;
	}

	if ( checkedCount > 1 || checkedCount == 0 ) {
		alert(i18n.please_select_a_record);
		return;
	}


	var radArray = checkedValue.split(",");
	window.self.location = "<%=request.getContextPath()%>/workflowFormShowAction.do?formID=" + radArray[0] + "&isHistory=true";
}

function modifyForm() {
	var checkedValue;
	var checkedCount = 0;
	var obj = document.all("checkbox_template");

	if ( isNaN(obj) == false ) {
		return;
	}

	for ( var i = 0; i < obj.length; i++ ) {
		if ( obj[i].checked ) {
			checkedCount++;
		}
	}

	if ( checkedCount == 1 ) {
		for ( var i = 0	; i < obj.length; i++ ) {
			if ( obj[i].checked ) {
				checkedValue = obj[i].value;
				break;
			}
		}
	}

	if ( obj.length == "undefined" || obj.checked ) {
		checkedCount = 1;
		checkedValue = obj.value;
	}

	if ( checkedCount > 1 || checkedCount == 0 ) {
		alert(i18n.please_select_a_record);
		return;
	}

	var radArray = checkedValue.split(",");
	window.self.location = "<%=request.getContextPath()%>/formDesign.do?cmd=edit&id=" + radArray[0];
}

function operateForm(param) {
	var checkedValue;
	var checkedCount = 0;
	var obj = document.all("checkbox_template");

	if ( isNaN(obj) == false ) {
		return;
	}

	for ( var i = 0; i < obj.length; i++ ) {
		if ( obj[i].checked ) {
			checkedCount++;
		}
	}

	if ( checkedCount == 1 ) {
		for ( var i = 0	; i < obj.length; i++ ) {
			if ( obj[i].checked ) {
				checkedValue = obj[i].value;
				break;
			}
		}
	}

	if ( obj.length == "undefined" || obj.checked ) {
		checkedCount = 1;
		checkedValue = obj.value;
	}

	if ( checkedCount > 1 || checkedCount == 0 ) {
		alert(i18n.please_select_a_record);
		return;
	}

	var radArray = checkedValue.split(",");

	if (confirm(i18n.confirm_to_do_this)) {
		window.self.location = "<%=request.getContextPath()%>/formDesign.do?cmd=" + param + "&id=" + radArray[0];
	}
}
//-->

function query_onClick(){//带条件查询
		if(checkAllForms()){
    		form.action = "<%=request.getContextPath()%>/formDesign.do?cmd=list";
    		form.submit();
    	}
}
</script>
</head>

<body>

<script language="javascript">
	writeTableTop('<fmt:message key="form_list"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<form name="form" action="<%=request.getContextPath()%>/formDesign.do?cmd=list" method="post" target="_self">
<div id="ccParent0"> 
	<table class="table_div_control">
		<tr> 
			<td>
				<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')">
				<fmt:message key="query_with_condition" bundle="${applicationResources}"/>
			</td>
		</tr>
	</table>
</div>
<div id="ccChild0"> 
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="form_type"/></td>
	<td>
		<select name="frmStyle" >
			<option value="">&nbsp;</option>
			<%
				List al = styleMap.getEnumList();
				for(int i=0;i<al.size();i++){%>
			<option value="<%=styleMap.getValue(al.get(i).toString())%>"><%=al.get(i)%></option>
 			 <%}%>
		</select>
	</td>
</tr>
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="form_name"/></td>
	<td><input name="frmName" type="text" class="text_field" inputName='<fmt:message key="form_name"/>' validate="isSearch"><input type="button" name="Submit" class="button_ellipse" value='<fmt:message key="query" bundle="${applicationResources}"/>' onclick="javascript:query_onClick();">
		<input type="reset"  class="button_ellipse" name="Reset" value='<fmt:message key="clear" bundle="${applicationResources}"/>'>
	</td>
</tr>
</table>

</div>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="form_management"/>
		</td>
		<td>
		<table align="right">
		<tr>

		<%if(request.getParameter("subwindow") == null){%>
		<td nowrap class="button_ellipse" onClick="javascript:showForm();">
			<img src="<%=request.getContextPath()%>/images/icon/view.gif" class="div_control_image"><fmt:message key="view" bundle="${applicationResources}"/>
		</td>
		<td nowrap class="button_ellipse" onClick="window.location.href='<%=request.getContextPath()%>/formDesign.do?cmd=edit'">
			<img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="add" bundle="${applicationResources}"/>
		</td>
		<td nowrap class="button_ellipse" onClick="javascript:modifyForm();">
			<img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify" bundle="${applicationResources}"/>
		</td>
		<td nowrap class="button_ellipse" onClick="javascript:operateForm('delete');">
			<img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete" bundle="${applicationResources}"/>
		</td>
		<td nowrap class="button_ellipse" onClick="javascript:operateForm('copy');">
			<img src="<%=request.getContextPath()%>/images/icon/copy.gif" class="div_control_image"><fmt:message key="copy" />
		</td>
		<%}%>

		<%if(request.getParameter("subwindow") != null){%>
		<td nowrap class="button_ellipse" onClick="javascript:submitForm(<%=request.getParameter("isflow")%>);">
			<img src="<%=request.getContextPath()%>/images/icon/confirm.gif" class="div_control_image"><fmt:message key="confirm" bundle="${applicationResources}"/>
		</td>
		<%}%>


		</tr>
		</table>
		</td>

	</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content2">
<tr>
	<td>
			<layout:collection name="formList" id="formId" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0">

				<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
					<bean:define id="param1" name="formId" property="id"/>
					<bean:define id="param2" name="formId" property="name"/>
					<input title="<%=param2%>" type="checkbox" name="checkbox_template" value="<%=param1 + "," + param2%>"/>
				</layout:collectionItem>

				<layout:collectionItem width="5%" title='<%=LocaleHolder.getMessage("sequence") %>' style="text-align:center;">
					<venus:sequence/>
					<bean:define id="param3" name="formId" property="id"/>
					<input type="hidden" signName="hiddenId" value="<%=param3%>"/>
				</layout:collectionItem>

				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.form_type") %>' property="style" sortable="true"/>
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.form_name") %>' property="name" sortable="true"/>
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.form_describe") %>' property="remark"/>
			</layout:collection>

			<jsp:include page="/jsp/include/page.jsp" /> 
		</td>
	</tr>
</table>
</div>

<%if(request.getParameter("subwindow") != null){%>
<input type="hidden" name="subwindow" value="<%=request.getParameter("subwindow") == null ? "" : request.getParameter("subwindow")%>"/>
<input type="hidden" name="isflow" value="<%=request.getParameter("isflow") == null ? "" : request.getParameter("isflow")%>"/>
<%}%>

</form>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>

</body>
</fmt:bundle>
</html>

<%if (request.getAttribute("error.copy.name.existed") != null) {%>
<script language="javascript">
<!--
alert('<%=request.getAttribute("error.copy.name.existed")%>');
//-->
</script>
<%}%>
	
	
<script language="javascript">

function assignSelected(sel,val) {
	for (i = 0; i < sel.options.length; i++) {
		if (sel.options[i].text == val) {
			sel.options[i].selected = "true";
		}
	}
}


document.getElementById("frmName").value="<%=request.getAttribute("frmName")==null ? "" : request.getAttribute("frmName")%>";
assignSelected(document.getElementById("frmStyle"), "<%=request.getAttribute("frmStyle")%>");
</script>