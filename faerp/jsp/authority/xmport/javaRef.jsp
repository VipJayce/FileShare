<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/jsp/include/global.jsp" %>

<title><fmt:message key='gap.authority.Reference_template' bundle='${applicationAuResources}' /></title>

<script>
	function returnvalue() {  //从多选框到修改页面
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
		var returnArray = new Array();
		window.returnValue = ids;
		window.close();
	}  
</script>
</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Reference_list' bundle='${applicationAuResources}' />",'<venus:base/>/');
</script>

<form name="form">
<table>
	<tr>
		<td>
			<input type="button" name="Submit" value="<fmt:message key='gap.authority.Determine' bundle='${applicationAuResources}' />" class="button_ellipse" onClick="javascript:returnvalue();">
			<input type="button" name="cancel" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />" class="button_ellipse" onClick="javascript:window.close();">
		</td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td>
			<layout:collection name="javaclass" id="wy1" styleClass="listCss" width="98%"  align="center">
			<layout:collectionItem width="20" title=" " style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="name"/>
				<input type="radio" name="checkbox_template" value="<%=wy3.toString()%>"/>
			</layout:collectionItem>
			<layout:collectionItem title="Java<fmt:message key='gap.authority.Class_name' bundle='${applicationAuResources}' />" property="name" sortable="false"/>
		</layout:collection>
		</td>
	</tr>	
</table>

</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>

