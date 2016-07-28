<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%  //判断是否为修改页面
	boolean isModify = false;
	if(request.getParameter("isModify") != null) {
		isModify = true;
	}
	String empId = request.getParameter("empId");
%>
<fmt:bundle basename="gap.template.complex_resource" prefix="gap.template.complex.">
<title>子表A页面</title>
<script>
	function addChild_onClick() { //弹出新增窗口
		var empId = parent.document.all("empId").value;
		var empName = parent.document.all("empName").value;
		var empBirthday = parent.document.all("empBirthday").value;
		var id = parent.document.all("id").value;

		if (empId == "" || empId ==undefined || empName == "" || empName ==undefined || empBirthday == "" || empBirthday ==undefined) {
				alert('<fmt:message key="FillMaster"/>');
				return;
		} 		
		
		if(id == ""){
				alert('<fmt:message key="SaveMaster"/>');
				return;
		} 		

		var obj = window.showModalDialog('<venus:base/>/jsp/complexTemplate/tableFrame.jsp?tableId=A&empId=' + empId,'','dialogTop:' + (window.screen.height / 3) + 'px;dialogLeft:' + (window.screen.width / 3) + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
		
		if(obj != null || obj != undefined) {
			refresh();
		}		
	} 
		
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var empId = "<%=empId%>";
		var id = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id += "'" + elementCheckbox[i].value + "',";
			}
		}
		if(id.length>0) {
			id = id.substr(0,id.length - 1);	
		}		
		if(number == 0) {
	  		alert('<fmt:message key="SelectRecord"/>')
	  		return;
		}
		if(confirm('<fmt:message key="SureToDelete"/>')) {
	    	form.action="<venus:base/>/ChildTableAAction.do?cmd=delete&empId=" + empId + "&id=" + id;
    		form.submit();
		}
	}

	function modifyChild_onClick() { //弹出修改窗口
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var empId = "<%=empId%>";
		var id = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id = elementCheckbox[i].value;
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
		var obj = window.showModalDialog('<venus:base/>/jsp/complexTemplate/tableFrame.jsp?tableId=A&isModify=true&empId=' + empId + '&id=' + id,'','dialogTop:' + (window.screen.height / 3) + 'px;dialogLeft:' + (window.screen.width / 3) + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
		if(obj != null || obj != undefined) {
			refresh();
		}
	}
	
	function refresh() {  //刷新本页
		form.action = "";
		form.submit();
	}	

</script>
</head>

<body>
<form name="form" method="post" action="<venus:base/>/ChildTableAAction.do?empId=<%=empId%>">
<input type="hidden" name="cmd" value="queryAll">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="DetailTable"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:addChild_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key="add" bundle="${applicationResources}"/></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete" bundle="${applicationResources}"/></td>
					<td class="button_ellipse" onClick="javascript:modifyChild_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify" bundle="${applicationResources}"/></td>
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
		<layout:collection name="demo" id="demo1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="demo3" name="demo1" property="id"/>
					<input type="checkbox" name="checkbox_template" value="<%=demo3%>"/>									
			</layout:collectionItem>
			<layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence") %>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.complex.Graduated") %>' property="empCollege" sortable="true"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.complex.Profession") %>'  property="empMajor" sortable="true"/>		
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.complex.EntryDate") %>'  property="stDate" sortable="true">
			<bean:define id="demo7" name="demo1" property="stDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(demo7))));
					%>			
			</layout:collectionItem>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.complex.GraduationDate") %>'  property="edDate" sortable="true">
			<bean:define id="demo8" name="demo1" property="edDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(demo8))));
					%>			
			</layout:collectionItem>
		</layout:collection>
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>
</form>

</body>
</fmt:bundle>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
</html>