<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.jsp.quartz.">
<title><fmt:message key="create_advanced_triggering_rules"/></title>
<script>

	function returnvalue() {  //从多选框到修改页面
		var ids = null;
		if(document.form1.day.value!=""&&document.form1.week.value!=""){
			alert(i18n4WarningSystem.weeks_and_days_can_not_be_together);
			return "* * * * * ?";
		}
		if(document.form1.minute.value==""){
			document.form1.minute.value ="*";
		}
		if(document.form1.hour.value==""){
			document.form1.hour.value ="*";
		}
		if(document.form1.day.value==""&&document.form1.week.value==""){
			document.form1.day.value ="?";
			document.form1.week.value ="*";
		}else if(document.form1.day.value==""){
			document.form1.day.value ="?";
		}else if(document.form1.week.value==""){
			document.form1.week.value ="?";
		}
		if(document.form1.month.value==""){
			document.form1.month.value ="*";
		}
		
		//alert(" 月="+document.form1.month.value+" 日="+document.form1.day.value+" 周="+document.form1.week.value+" 时="+document.form1.hour.value+" 分="+document.form1.minute.value);

		var returnArray = "0 "+document.form1.minute.value+" "+document.form1.hour.value+" "+document.form1.day.value+" "+document.form1.month.value+" "+document.form1.week.value;
		//var returnArray = "* * * * * *";
		window.returnValue = returnArray;
		window.close();
	}  
	function checkAllList_onClick(thisObj){  //全选，全不选
		var elementCheckbox = document.getElementsByName("checkbox_template");
		for(var i=0;i<elementCheckbox.length;i++){
			elementCheckbox[i].checked = thisObj.checked;
		}
	}
	
	 function isDigit(patrn,s)  
	 {  
		// var patrn=/^[1-5]?[0-9]$/;  
		 if (s=="") {
		 	return ""  
		 }
		 if (!patrn.exec(s)) {
		 	alert('<fmt:message key="enter_valid_character"/>');
		 	return ""  
		 }
		 return s  
	 } 
</script>
<base target="_self">
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message bundle='${applicationResources}'  key="reference_page"/>','<venus:base/>/');
</script>

<form name="form1" method="post">
<input type="hidden" name="queryCondition" value="">
<div id="ccParentq">
<table class="table_div_control">
	<tr>
		<td>
			<input type="button" name="Submit" value="<fmt:message bundle='${applicationResources}'  key="submit"/>" class="button_ellipse" onClick="javascript:returnvalue();">
			<input type="button" name="cancel" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>" class="button_ellipse" onClick="javascript:window.close();">
		</td>
	</tr>
</table>
</div>

<div id="ccChildq">
<table class="table_div_content">
	<tr>
		<td  width="50"><fmt:message key="minute"/></td>
		<td  width="210"><input type="text" class="text_field" name="minute" onchange="this.value=isDigit(/^[0-5]?[0-9](\/[0-5]?[0-9])?$/,this.value)">
		<td >(<fmt:message key="range"/>：0~59)</td>
	</tr>	
	<tr>
		<td ><fmt:message key="hour"/></td>
		<td ><input type="text" class="text_field" name="hour" onchange="this.value=isDigit(/^(([0-1]?[0-9])|(2[0-3]))(\/(([0-1]?[0-9])|(2[0-3])))?$/,this.value)">
		<td >(<fmt:message key="range"/>：0~23)</td>
	</tr>
	<tr>
		<td ><fmt:message key="day"/></td>
		<td ><input type="text" class="text_field" name="day" onchange="this.value=isDigit(/^(([1-2]?[0-9])|(3[0-1]))(\/(([1-2]?[0-9])|(3[0-1])))?$/,this.value)">
		<td >(<fmt:message key="range"/>：1~31)</td>
	</tr>
	<tr>
		<td ><fmt:message key="month"/></td>
		<td ><input type="text" class="text_field" name="month" onchange="this.value=isDigit(/^([1-9]|(1[0-2]))(\/([1-9]|(1[0-2])))?$/,this.value)">
		<td >(<fmt:message key="range"/>：1~12 )</td>
	</tr>
	<tr>
		<td ><fmt:message key="week"/></td>
		<td ><input type="text" class="text_field" name="week" onchange="this.value=isDigit(/^[1-7](\/[1-7])?$/,this.value)">
		<td >(<fmt:message key="range"/>：1~7 )</td>
	</tr>
	<!--
	<tr>
		<td >年：</td>
		<td ><input type="text" name="year">
		<td >(<fmt:message key="range"/>：)</td>
	</tr>
	-->

</table>
<table >
	<tr><td><fmt:message key="help"/></td><td></td><td></td></tr>
	<tr><td></td><td><fmt:message key="no_condition"/></td><td></td></tr>
	<tr><td></td><td><fmt:message key="increasing_condition"/></td><td></td></tr>
	<tr><td></td><td><fmt:message key="increasing_condition_example"/></td><td></td></tr>
	<td></td><td><fmt:message key="not_together_condition"/></td><td></td></tr>

</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>