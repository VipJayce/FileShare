<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.report.util.VoHelperTools" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<fmt:bundle basename="gap.report.report_resource" prefix="gap.report.">
<title><fmt:message key="filemanage.query_template"/></title>
<script>
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.action="<venus:base/>/run?__report=WEB-INF/reports/functreeReport/functree.rptdesign";
		document.form.whereClause.value = "";
		if (document.form.build_name.value!="" )
		  document.form.whereClause.value=document.form.whereClause.value+" and a.name like '%"+document.form.build_name.value+"%'";
		if (document.form.name.value!="" )
		  document.form.whereClause.value=document.form.whereClause.value+" and b.name like '%"+document.form.name.value+"%'";
    	form.submit();
  	}
	function findCheckbox_onClick() {  //从多选框到修改页面
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
	  		alert('<fmt:message key="message_select_data"  bundle="${applicationResources}"></fmt:message>')
	  		return;
		}
		if(number > 1) {
	  		alert('<fmt:message key="message_can_only_select_a_record"  bundle="${applicationResources}"></fmt:message>')
	  		return;
		}
		form.action = "<venus:base/>/ReportAction.do?cmd=find&ids=" + ids;
		form.submit();
	}
	function detail_onClick(thisId){
		form.action = "<venus:base/>/ReportAction.do?cmd=find&ids=" + thisId;
		form.submit();
	}
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids += "'" + elementCheckbox[i].value + "',";
			}
		}
		if(ids.length>0) {
			ids = ids.substr(0,ids.length-1);	
		}
		if(number == 0) {
	  		alert('<fmt:message key="message_select_data"  bundle="${applicationResources}"></fmt:message>')
	  		return;
		}
		if(confirm('<fmt:message key="message_confirm_delete_data"  bundle="${applicationResources}"></fmt:message>')) {
	    	form.action="<venus:base/>/ReportAction.do?cmd=delete&ids=" + ids;
    		form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		window.location="<venus:base/>/jsp/simpleTemplate/insertRoom.jsp";
	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
	/*
	function buildQueryCondition() {
		var queryCondition = "";
		var qca = new Array();
		pushCondition(qca, "name");
		pushCondition(qca, "build_Id");
		
		if(qca.length >= 1) {  //组装查询条件
			queryCondition += " " + qca[0] + " ";
		}
		for(var i=1; i<qca.length; i++) {
			queryCondition += " and " + qca[i] + " ";
		}
		return queryCondition;
	}
	*/
	function getBuildList() {
		var obj = window.showModalDialog('<venus:base/>/jsp/report/buildframe.jsp','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:1;');
		if(obj) {
			document.form.build_name.value = obj[1];
			document.form.build_Id.value = obj[0];
		}
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="template.query_list"/>','<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/ReportAction.do">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="whereClause" value="">

<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			<fmt:message key="template.query_by_condition"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="template.build_name"/></td>
	<td>
		<input name="build_name" type="text" class="text_field_reference" validate="isSearch" readOnly="true" rubber_id="build_Id"><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getBuildList();" class="img_1">
		<input type="hidden" name="build_Id" id="rubber_id" value="">
	</td>
</tr>
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="template.room_name"/></td>
	<td><input name="name" type="text" class="text_field" validate="isSearch"><input type="button" name="Submit" class="button_ellipse" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:simpleQuery_onClick();">
	</td>
</tr>
</table>

</div>

<div id="ccChild1"> 

</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>
</body>
</fmt:bundle>
</html>