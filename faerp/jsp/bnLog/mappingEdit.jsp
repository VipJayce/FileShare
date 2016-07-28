<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<html>
<fmt:bundle basename="gap.bnLog.bnLog_resource" prefix="gap.bnLog.">
<SCRIPT language="JavaScript">
function checkMethodName(value,obj) {
    var reg = /^[A-Za-z.]+$/;
    if (!reg.test(obj.value)) {
        writeValidateInfo('<fmt:message key="only_can_no_space_english"/>', obj);
        return false;
    } else {
        return true;
    }
}

function doUpdate(){
	if(checkAllForms()){
		form.action = "<venus:base/>/MappingAction.do?cmd=insert";
		form.submit();
	}
}

function doInsert(){
	if(checkAllForms()){
		form.action = "<venus:base/>/MappingAction.do?cmd=insert";
		form.submit();
	}
}
</SCRIPT>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- </head> -->
<body>

<script language="javascript">
	writeTableTop('<fmt:message key="method_mapping"/>','<venus:base/>/');
</script>
<form name="form" method="post">
<table class="table_noframe">
	<tr>
		<td valign="middle">
	        <%
	        if(request.getParameter("key")!=null) {
	        %>	
			<input type="button" name="update" class="button_ellipse" value='<fmt:message key="save" bundle="${applicationResources}" />' onclick="doUpdate()">
	        <%
	        }else{
	        %>
	        <input type="button" name="insert" class="button_ellipse" value='<fmt:message key="save" bundle="${applicationResources}" />' onclick="doInsert()">
	        <%
	        }
	        %>
	      <input name="cancelButton" type="button" class="button_ellipse" value='<fmt:message key="cancel" bundle="${applicationResources}" />' onclick="javascript:history.go(-1)" />
		</td>
	</tr>
</table>
<div id="ccParent1"> 
<table class="table_div_control">
<tr>
	<td>
		<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
		<fmt:message key="method_mapping"/>
	</td>
</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content">
  <tr>
    <td align="right" width="10%" nowrap ><fmt:message key="full_path_method_name"/></td>
    <td align="left"><input name="mappingKey" class="text_field_reference" type="text" value="<%=request.getParameter("key")==null?"": request.getParameter("key") %>" size="70" maxlength="100" inputName='<fmt:message key="full_path_method_name"/>' validate="checkMethodName" /></td>
  </tr>
  <tr>
    <td align="right" width="10%" nowrap ><fmt:message key="mapping_name"/></td>
    <td align="left"><input name="mappingValue" class="text_field_reference" type="text" value="<%=request.getAttribute("value")==null?"": request.getAttribute("value") %>" size="70" maxlength="100"  inputName='<fmt:message key="mapping_name"/>' validate="notNull" /></td>
  </tr>
</table>
</div>

</form>

<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>

</body>
</fmt:bundle>
</html>