<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<title><fmt:message bundle='${applicationResources}'  key="reference_page"/></title>

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
	  		alert("请选择一条记录!")
	  		return;
		}
		if(number > 1) {
	  		alert("只能选择一条记录!")
	  		return;
		}
		var returnArray = new Array();
		returnArray[0] = ids.substring(0,ids.indexOf(":"));
		returnArray[1] = ids.substring(ids.indexOf(":")+1);
		parent.window.returnValue = returnArray;
		parent.window.close();
	}  
	function checkAllList_onClick(thisObj){  //全选，全不选
		var elementCheckbox = document.getElementsByName("checkbox_template");
		for(var i=0;i<elementCheckbox.length;i++){
			elementCheckbox[i].checked = thisObj.checked;
		}
	}
	
</script>
<base target="_self">
</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message bundle='${applicationResources}'  key="reference_page"/>",'<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/AjaxSingleTableAction.do?cmd=queryFactory">
<input type="hidden" name="cmd" value="">
<table>
	<tr>
		<td>
			<input type="button" name="Submit" value="<fmt:message bundle='${applicationResources}'  key="confirm"/>" class="button_ellipse" onClick="javascript:returnvalue();">
			<input type="button" name="cancel" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>" class="button_ellipse" onClick="javascript:parent.window.close();">
		</td>
	</tr>
</table>
<table>
	<tr>
		<td>
		<layout:collection name="factoryList" id="wy1" styleClass="listCss" width="98%" indexId="orderNumber" align="center" sortAction="0">
			<layout:collectionItem width="20" title=" " style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="factoryid"/>
				<bean:define id="wy6" name="wy1" property="name"/>
					<input type="radio" name="checkbox_template" value="<%=wy3.toString() + ":" + wy6.toString()%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="20"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem width="180" title='<%=LocaleHolder.getMessage("gap.ajax.ordercontent.factory_name")%>' property="name" sortable="true"/>
		</layout:collection>
		
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>

</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>