<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.template.common.util.ReferenceFilter"%>
<%@ page import="venus.pub.util.VoHelper" %>
<fmt:bundle basename="gap.template.complex_resource" prefix="gap.template.complex.">
<title><fmt:message key="QueryList"/></title>
<script language="javascript" src="<venus:base/>/js/jquery/plugin/PrintArea-2.1.js"></script>
<script>
	function simpleQuery_onClick(){ //简单条件查询功能
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
  	
	function findCheckbox_onClick() {  //从多选框到修改页面,只能对当前的一条记录修改
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var empId = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				empId = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert('<fmt:message key="SelectRecord"/>')
	  		return;
		}
		if(number > 1) {
	  		alert('<fmt:message key="OnlyCanARecord"/>')
	  		return;
		}
	    form.action="<venus:base/>/MasterTableAction.do?cmd=find&empId=" + empId + "&isModify=true";	
    	form.submit();
	}
	
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var empId = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				empId += "'" + elementCheckbox[i].value + "',";
			}
		}
		if(empId.length>0) {
			empId = empId.substr(0,empId.length-1);	
		}
		if(number == 0) {
	  		alert('<fmt:message key="SelectRecord"/>')
	  		return;
		}
		if(confirm('<fmt:message key="SureToDelete"/>')) {
	    	form.action="<venus:base/>/MasterTableAction.do?cmd=delete&empId=" + empId;
    		form.submit();
		}
	}
	
	function toAdd_onClick() {  //跳转到新增数据页面
		window.location="<venus:base/>/jsp/complexTemplate/masterTable.jsp";	
	}
	
	function refresh_onClick(){  //刷新列表
		form.submit();
	}
	
	function search_onKeyDown() {//回车后执行页面查询功能
		if (event.keyCode==13) { 
			simpleQuery_onClick();
		}
	}
	
	function print_onClick(){
	   jQuery("#print_div").printArea();
	}
	
</script>
</head>

<body>
<script language="javascript">
	writeTableTop('<fmt:message key="query_with_condition" bundle="${applicationResources}"/>','<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/MasterTableAction.do">
<input type="hidden" name="cmd" value="simpleQuery">

<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			<fmt:message key="query_with_condition" bundle="${applicationResources}"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="EmployeeOrName"/></td>
	<td><input name="empSearch" type="text" class="text_field" inputName='<fmt:message key="EmployeeOrName"/>' validate="isSearch" onKeyDown="javascript:search_onKeyDown();">
	       <input type="button" name="Submit" class="button_ellipse" value='<fmt:message key="query" bundle="${applicationResources}"/>' onClickTo="javascript:simpleQuery_onClick();">
	</td>
</tr>
</table>
</div>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="DetailTable"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key="add" bundle="${applicationResources}"/></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete" bundle="${applicationResources}"/></td>
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify" bundle="${applicationResources}"/></td>
					<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<venus:base/>/images/icon/refresh.gif" class="div_control_image"><fmt:message key="refresh" bundle="${applicationResources}"/></td>
					<td class="button_ellipse" onClick="javascript:print_onClick();"><img src="<venus:base/>/images/icon/print.gif" class="div_control_image"><fmt:message key="print_table"/> </td>
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
		<DIV style="OVERFLOW: auto;HEIGHT:300" id="print_div">
		<layout:collection name="demo" id="demo1" styleClass="listcssgd" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
					<bean:define id="demo3" name="demo1" property="empId"/><input type="checkbox" name="checkbox_template" value="<%=demo3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence") %>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.template.complex.EmployeeNo.") %>' property="empId" sortable="true"/>
			<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.template.complex.EmployeeName") %>' property="empName" sortable="true"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.complex.Sex") %>' property="empSex" sortable="true">
				<bean:define id="demo2" name="demo1" property="empSex"/>
					<%=ReferenceFilter.get("EmpSex",String.valueOf(demo2))%>
			</layout:collectionItem>			
			<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.template.complex.Birthday") %>' property="empBirthday" sortable="true">
				<logic:notEmpty name="demo1" property="empBirthday">
					<bean:define id="demo7" name="demo1" property="empBirthday"/>
							<%
								java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
								out.print(format.format(format.parse(String.valueOf(demo7))));
							%>			
					</logic:notEmpty>
			</layout:collectionItem>
			<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.template.complex.Trade") %>' property="empCareer" sortable="true">
				<bean:define id="demo5" name="demo1" property="empCareer"/>
					<%=ReferenceFilter.get("EmpCareer",String.valueOf(demo5))%>
			</layout:collectionItem>
			<layout:collectionItem width="20%" title='<%=LocaleHolder.getMessage("gap.template.complex.Phone") %>' property="empMobile" sortable="true"/>
		</layout:collection>
		</DIV>
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