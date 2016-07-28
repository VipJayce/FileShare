<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import = "gap.commons.xmlenum.EnumRepository" %>
<%@ page import = "gap.commons.xmlenum.EnumValueMap" %>
<%@ page import = "gap.authority.util.GlobalConstants"%>
<%@ page import="java.util.List" %>
<%
	EnumRepository er = EnumRepository.getInstance();
	er.loadFromDir();
	EnumValueMap typeMap = er.getEnumValueMap("OperateType");
%>
<title><fmt:message key='gap.authority.Query_Template' bundle='${applicationAuResources}' /></title>
<script>
	function simpleQuery_onClick(){
		form.action="<%=request.getContextPath()%>/HistoryLogAction.do?cmd=simpleQuery";
		form.submit();
	}
	
	//新增导出功能   李娜敏
	function export_onClick() {
	   if(confirm('是否确定要导出数据？')) {
          document.form.action="<%=request.getContextPath()%>/HistoryLogAction.do?cmd=exportToExcelHistoryLog";
          
          document.form.submit(); 
          document.form.action="<%=request.getContextPath()%>/HistoryLogAction.do?cmd=simpleQuery";
      }
	}
	
	function view_onClick() {  //从多选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		var actionurl = "<venus:base/>/HistoryLogAction.do?cmd=findByPartyId&source_id=" + ids;
		var topValue=screen.width/2-400;
		var leftValue=screen.height/2-70;
		window.open(actionurl,"newwindow","height=700, width=600, top="+topValue+", left="+leftValue+",toolbar=no,menubar=no,resizable=yes,location=no,status=no,scrollbars=yes");
	}
	function viewListDetail() {
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}	
		var thisHidden = getLayoutHiddenObjectById(ids);
		var treePath = "<venus:base/>/jsp/authority/history/listDetailFrame.jsp?id=" + ids;
		window.showModalDialog(treePath, new Object(),'dialogHeight=470px;dialogWidth=400px;resizable:yes;status:no;scroll:auto;');			
		/*
			机构的操作类型可能使用thisHidden.operate_type判断,如:
			thisHidden.operate_type == <%=GlobalConstants.HISTORY_LOG_DELETE%>
		*/
	}
	function getLayoutHiddenObjectById(id) {
		if(id == null) {
			return null;
		}
		var allInput = document.getElementsByTagName("input");
		for(var i=0; i<allInput.length; i++) {
			if(allInput[i].type == "hidden" && allInput[i].signName == "hiddenId" && allInput[i].value == id) {
				return allInput[i];
			}
		}
		return null;
	}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.History_Log_Management' bundle='${applicationAuResources}' />",'<venus:base/>/');
</script>
<form name="form" method="post">
<div id="auDivParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;<fmt:message key='gap.authority.Conditional_query_history_log' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>
<div id="auDivChild0"> 
<table class="table_div_content">
<tr><td>
	<table class="table_noFrame" width="100%">
		<tr>
			<td width="15%" align="right"><fmt:message key='gap.authority.Operation_Name' bundle='${applicationAuResources}' /></td>
			<td width="35%" align="left">
				<input type="text" class="text_field" validate="isSearch" name="operator_name" inputName="<fmt:message key='gap.authority.Operation_Name' bundle='${applicationAuResources}' />" maxLength="300" value=""/>
			</td>
			<td width="15%" align="right"><fmt:message key='gap.authority.Resource_Name' bundle='${applicationAuResources}' /></td>
			<td width="35%" align="left">
				<input type="text" class="text_field" validate="isSearch" name="source_name" inputName="<fmt:message key='gap.authority.Operation_Resource_Name' bundle='${applicationAuResources}' />" maxLength="300" value=""/>
			</td>
		</tr>
		<tr>
			<td width="15%" align='right'><fmt:message key='gap.authority.Operating_time' bundle='${applicationAuResources}' /></td>
			<td width="30%" align="left">
      			<input id='log_start_time' type="text" class="text_field_half_reference_readonly" name='log_start_time' /><img src='<venus:base/>/images/icon/reference.gif' onClick="javascript:getYearMonthDay('log_start_time','<venus:base/>/');"  title="Calendar" class="img_1" style="cursor:hand;"/>&nbsp;<fmt:message key='gap.authority.To_' bundle='${applicationAuResources}' />&nbsp;<input id='log_end_time' type="text" class="text_field_half_reference_readonly"  name='log_end_time' /><img src='<venus:base/>/images/icon/reference.gif' onClick="javascript:getYearMonthDay('log_end_time','<venus:base/>/');"  title="Calendar" class="img_1" style="cursor:hand;"/>
      		</td>
			<td  align="right"><fmt:message key='gap.authority.Action_Type' bundle='${applicationAuResources}' /></td>
			<td  align="left">
				<select name="optType" style="width:60px">
					<%
						List operateTypeList = typeMap.getEnumList();
						for(int i=0;i<operateTypeList.size();i++){%>
					<option value="<%=typeMap.getValue(operateTypeList.get(i).toString())%>"><%=operateTypeList.get(i)%></option>
	     			 <%}%>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" name="Submit" class="button_ellipse" value="<fmt:message key='gap.authority.Inquiry' bundle='${applicationAuResources}' />" onClickTo="javascript:simpleQuery_onClick();">&nbsp;&nbsp;
				<input name="del" type="reset" id="del" value="<fmt:message key='gap.authority.Empty' bundle='${applicationAuResources}' />" class="button_ellipse">&nbsp;&nbsp;
				<input type="button" name="export" class="button_ellipse" value="导出" onClickTo="javascript:export_onClick();">
			</td>
		</tr>		
	</table>

</td></tr>
</table>
</div>

<div id="auDivParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.Details_Form' bundle='${applicationAuResources}' />
		</td>
		<td> 
			<table align="right">
				<tr> 
					<!--<td class="button_ellipse" onClick="javascript:view_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image">跟踪</td>-->
					<!--<td class="button_ellipse" onClick="javascript:undo_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image">恢复</td>-->
					<td id="viewImgTd" class="button_ellipse" onClick="javascript:viewListDetail();"><img src="<venus:base/>/images/icon/view.gif" class="div_control_image"><fmt:message key='gap.authority.View' bundle='${applicationAuResources}' /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="auDivChild1"> 
<table class="table_div_content">
	<tr>
		<td>
		<layout:collection name="beans" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="40" title="" style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="id"/>
				<input type="radio" name="checkbox_template" value="<%=null==wy3?"":wy3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="30"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
				<venus:sequence/>
				<bean:define id="id" name="wy1" property="id"/>
				<bean:define id="operateType" name="wy1" property="operate_type"/>
				<input type="hidden" signName="hiddenId" value="<%=id%>" operate_type="<%=operateType%>"/>
			</layout:collectionItem>
			<layout:collectionItem  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Resource_Name") %>' property="source_name" />
			<layout:collectionItem  title='资源类型' property="source_type" />
			<layout:collectionItem  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Original_organization") %>' property="source_orgtree" />
			<layout:collectionItem  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Operation_Name") %>' property="operate_name" />
			<layout:collectionItem  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Operating_time") %>' >
				<bean:define id="operate_date" name="wy1" property="operate_date"/>
		    	<%=StringHelperTools.prt(operate_date,19)%>			
			</layout:collectionItem>
			<layout:collectionItem width="60" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Action_Type") %>' style="text-align:center;" property="operate_type" />
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
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>

