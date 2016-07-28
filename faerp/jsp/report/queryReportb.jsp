<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.report.report_resource" prefix="gap.report.">
<title><fmt:message key="template.query_template"/></title>
<script>
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.action="<venus:base/>/frameset?__report=WEB-INF/reports/functreeReport/functree.rptdesign&__showtitle=false";
		document.form.whereClause.value = "";
		if (document.form.build_name.value!="" )
		  document.form.whereClause.value=document.form.whereClause.value+" and a.name like '%"+document.form.build_name.value+"%'";
		if (document.form.name.value!="" )
		  document.form.whereClause.value=document.form.whereClause.value+" and b.name like '%"+document.form.name.value+"%'";
    	form.submit();
  	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
	function getBuildList() {
		var obj = window.showModalDialog('<venus:base/>/jsp/report/buildframe.jsp','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
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

<form name="form" method="post" action="<venus:base/>/ReportAction.do" target="frame2">
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
<%@page import="gap.report.util.VoHelperTools"%>
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