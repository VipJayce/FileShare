<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<%@ page import="venus.pub.util.VoHelper" %>

<%  //判断是否为修改页面
	boolean isModify = false;
	if(request.getParameter("isModify") != null) {
		isModify = true;
	}
	  
	EnumRepository er = EnumRepository.getInstance();
    er.loadFromDir();
    EnumValueMap empCareerMap = er.getEnumValueMap("EmpCareer");
    EnumValueMap empSexMap = er.getEnumValueMap("EmpSex");
    
    String empId = request.getParameter("empId");  
    String cudType = (String)request.getAttribute("cudType");
%>
<fmt:bundle basename="gap.template.complex_resource" prefix="gap.template.complex.">
<title><%=isModify?"修改模板":"新增模板"%></title>
<link href="<venus:base/>/css/tabs.css.jsp" rel="stylesheet" type="text/css">
<script>
	var tabs;
	function createData() { //定义新增状态时显示的标签页
		tabs  =  new Array(
			new Array ('<fmt:message key="DetailA"/>',"<venus:base/>/ChildTableAAction.do?cmd=queryAll"),
			new Array ('<fmt:message key="DetailB"/>',"<venus:base/>/ChildTableBAction.do?cmd=queryAll")
		);
	}
		
	function updateData() { //定义修改状态时显示的标签页
		tabs  =  new Array(
			new Array ('<fmt:message key="DetailA"/>',"<venus:base/>/ChildTableAAction.do?cmd=queryAll&isModify=true&empId=<%=empId%>"),
			new Array ('<fmt:message key="DetailB"/>',"<venus:base/>/ChildTableBAction.do?cmd=queryAll&isModify=true&empId=<%=empId%>")
		); 		
	}
	
	<%=isModify?"updateData();":"createData();"%> //判断标签页的显示状态

	function goBack_onClick() { //返回到列表页面
	    form.action="<venus:base/>/MasterTableAction.do?cmd=queryAll";
	    form.submit();
	}
	
	function insert_onClick() { //插入数据到数据库中
		var empId = document.all.empId.value;
		if(checkAllForms()) {
			if(!isCode(empId)) {
				alert('<fmt:message key="employeeno_must_integer"/>');
				return false;
			}
			showBlockPage();
			form.action = "<venus:base/>/MasterTableAction.do?cmd=insert&empId=" + empId;
    		setTimeout('form.submit()',2000);
    	}
  	}	
  	
  	function update_onClick() { //修改数据库中的数据
	  	if(checkAllForms()) {
	  		showBlockPage();
	  		form.action = "<venus:base/>/MasterTableAction.do?cmd=update"
	  		setTimeout('form.submit()',500);
  		}
  	}	  	
  	
	function isCode(str)  { //判断代码中是否包括中文,如果包括中文返回false
	  	var reg = /^[a-zA-Z0-9]+$/;
	 	if (reg.test(str)) {
	  		return true;
	  	} else {
	  		return false;
	  	}
	}
  	
  	function transactionMessage() { //返回事务操作的类型
  		hideBlockPage();
  		var cudType = "<%=cudType%>";
  		if (cudType == "insert"||cudType == "update") {
            alert('<fmt:message key="operation_successful" bundle="${applicationResources}"/>');
        }
  	}

</script>
<script src="<venus:base/>/js/template/tabs.js"></script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="MasterDetail"/>','<venus:base/>/');
</script>
<form name="form" method="post">
<input type="hidden" name="id" value="">

<div id="auDivChild1" align="center"> 
<div>
	<table class="table_div_control" style="width:96%">
		<tr> 
			<td>
				<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
				<%if(isModify){ %>
				        <fmt:message key="modify_page" bundle="${applicationResources}"/>
				<%}else{ %>
				        <fmt:message key="new_page" bundle="${applicationResources}"/>
				<% }%>
			</td>
		</tr>
	</table>
</div>
<div id="ccChild1">
	<table class="table_div_content" style="width:96%">
		<tr>
			<td align="right"><%if(!isModify){%><font color="red">*</font><%}%><fmt:message key="EmployeeNo."/></td>
			<td align="left">
				<%if(isModify){%>
				<input name="empId" type="text" maxlength="8" class="text_field" inputName='<fmt:message key="EmployeeNo."/>' readonly="true" value="">
				<%} else {%>
				<input name="empId" type="text" maxlength="8" class="text_field" inputName='<fmt:message key="EmployeeNo."/>' validate="notNull;isSearch" value="">
				<%}%>
			</td>
		</tr>
		<tr>
			<td align="right"><font color="red">*</font><fmt:message key="EmployeeName"/></td>
			<td align="left">
				<input name="empName" type="text" class="text_field" inputName='<fmt:message key="EmployeeName"/>' validate="notNull;isSearch" value="">			
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="Sex"/></td>
			<td align="left">
					<%
						List empSex= empSexMap.getEnumList();
						for(int i=0;i<empSex.size();i++){%>
					<input name="empSex" type="radio" <%=(empSex.get(i).toString().equals("男")||empSex.get(i).toString().equals("Male"))?"checked":""%> value="<%=empSexMap.getValue(empSex.get(i).toString())%>"><%=empSex.get(i)%>
	     			 <%}%>
			</td>
		</tr>
		<tr>
			<td align="right"><font color="red">*</font><fmt:message key="Birthday"/></td>
			<td align="left">
				<input name="empBirthday"  id="empBirthday" type="text" class="text_field_reference" inputName='<fmt:message key="Birthday"/>' validate="notNull" readonly="true" value=""><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('empBirthday','<venus:base/>/')" class="img_1">
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="Trade"/></td>
			<td align="left">
				<select name="empCareer" >
					<%
						List empCareer = empCareerMap.getEnumList();
						for(int i=0;i<empCareer.size();i++){%>
					<option value="<%=empCareerMap.getValue(empCareer.get(i).toString())%>"><%=empCareer.get(i)%></option>
	     			 <%}%>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="Phone"/></td>
			<td align="left">
				<input name="empMobile" type="text" maxlength="11" validate="isMobile" class="text_field" value="">		
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="left">
				<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save" bundle="${applicationResources}"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>;">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="button_back" type="button" class="button_ellipse" value='<fmt:message key="return" bundle="${applicationResources}"/>'  onClick="goBack_onClick();">
			</td>
		</tr>	
	</table>
</div>
<div>
	<table class="table_div_content" style="width:96%">
		<tr>
			<td>
				<table width="100%">
				  <tr>
					<td>
					<div id="tabsDiv"></div>
					</td>
				</tr>
				</table>
			</td>
		</tr>
	</table>
</div>	

</form>
</body>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</html>

<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>

<script language="javascript">
<!--
writeTabs(250);
transactionMessage();
//-->
</script>