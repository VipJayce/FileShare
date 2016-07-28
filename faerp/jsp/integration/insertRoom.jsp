<%@ page pageEncoding="gbk" %>
<%@ page import="java.util.*"%>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/workflowForm/global4wf.jsp" %>
<fmt:bundle basename="gap.template.simple_resource" prefix="gap.template.simple.">
<%  //判断是否为修改页面
		boolean isModify = false;
		if(request.getParameter("isModify") != null) {
			isModify = true;
		}
	%>
<title><%=isModify?LocaleHolder.getMessage("gap.template.simple.UpdatePage"):LocaleHolder.getMessage("gap.template.simple.InsertPage")%></title>
<script>

	function insert_onClick(){  //增加记录
		if(checkAllForms()){
    		form.action = "<venus:base/>/ApplyRoomAction.do?cmd=insert";
    		collectRelevantData("wfForm");//调用工作流的方法来收集相关数据。
    		form.submit();
    	}
  	}
  	function update_onClick(){
	  	if(checkAllForms()){
  			form.action = "<venus:base/>/ApplyRoomAction.do?cmd=update";
  			collectRelevantData("wfForm");//调用工作流的方法来收集相关数据。
  			form.submit();
  		}
  	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<%=isModify?LocaleHolder.getMessage("gap.template.simple.UpdatePage"):LocaleHolder.getMessage("gap.template.simple.InsertPage")%>','<venus:base/>/');
</script>

<form name="form" method="post" id="wfForm">
	<input type="hidden" name="id" value="">
	<table class="table_noframe">
		<tr>
			<td valign="middle">
				<input name="button_save" type="button" class="button_ellipse" value="<%=isModify?LocaleHolder.getMessage("gap.wf.submit_apply"):LocaleHolder.getMessage("gap.wf.initiate_process")%>" onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>;">
				<input name="button_cancel" type="button" class="button_ellipse" value='<fmt:message key="cancel" bundle="${applicationResources}"/>'  onClick="javascript:history.go(-1);">
			</td>
		</tr>
	</table>
	
	<div id="ccParent1"> 
	<table class="table_div_control">
		<tr> 
			<td>
				<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><%=isModify?LocaleHolder.getMessage("gap.template.simple.UpdatePage"):LocaleHolder.getMessage("gap.template.simple.InsertPage")%>
			</td>
		</tr>
	</table>
	</div>
	
	<div id="ccChild1"> 
	<table class="table_div_content">
	
	<tr> 
            <td align="right" width="10%" nowrap><font color="red">*</font><%=LocaleHolder.getMessage("gap.wf.proins_id") %></td>
            <td align="left">
                <input type="text" name="<%=IConstant4WF.PROCID %>" <data:relevantData/> value="2099100100000000001">
            </td>
        </tr>
		<tr> 
			<td align="right" width="10%" nowrap><font color="red">*</font><fmt:message key="BuildingName"/></td> 
			<td align="left">
				<input name="build_Id" type="hidden" value="1099100100000000001">
				<input name="build_name" type="text"  value="翠微阁" class="text_field" inputName='<fmt:message key="BuildingName"/>' validate="notNull" readonly="true">
			</td>
		</tr>
		<tr>
			<td align="right"><font color="red">*</font><fmt:message key="RoomName"/></td>
			<td align="left">
				<input name="name" type="text" class="text_field" inputName='<fmt:message key="RoomName"/>' validate="notNull;isSearch" value="${room.name }">			
			</td>
		</tr>
		<tr>
			<td align="right"><font color="red">*</font><fmt:message key="BuildingArea"/></td>
			<td align="left">
				<input name="area" type="text" class="text_field" inputName='<fmt:message key="BuildingArea"/>' validate="notNull;isNumeric" value="${room.area }">			
			</td>
		</tr>
			<tr>
			<td align="right"><fmt:message key="RoomType"/></td>
			<td align="left">
				<select name="type" value="${room.type}">
					<option value="1">普通住宅</option>
	                <option value="0">商业住宅</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="RoomRate"/></td>
			<td align="left">
				<input name="price" type="text" class="text_field" inputName='<fmt:message key="RoomRate"/>' validate="isInteger" value="${room.price }">			
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="IsVacant"/></td>
			<td align="left">
					<select name="is_Empty" value="${room.is_Empty }">
					    <option value="1">是</option>
					    <option value="0">否</option>
					</select>
			</td>
		</tr>
		<tr>
			<td align="right"><font color="red">*</font><fmt:message key="CheckinDate"/></td>
			<td align="left">
				<input name="residing_Date"  id="residing_Date" type="text" class="text_field_reference" inputName='<fmt:message key="CheckinDate"/>' validate="notNull" readonly="readonly" value="${room.residing_Date }">
				<img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('residing_Date','<venus:base/>/')" class="img_1">
			</td>
		</tr>
	</table>
	</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>