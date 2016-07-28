<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="gap.ajax.util.VoHelperTools" %>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<script>
	function simpleQuery_onClick(){  //简单的模糊查询
//		form.queryCondition.value = buildQueryCondition();
    	form.cmd.value = "simpleQuery";
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
	  		alert(i18n.please_select_a_record);
	  		return;
		}
		if(number > 1) {
	  		alert(i18n.can_only_select_a_record);
	  		return;
		}
		form.action = "<venus:base/>/SingleSubmitAction.do?cmd=find&ids=" + ids;
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
	  		alert(i18n.please_choose_record_to_delete);
	  		return;
		}
		if(confirm(i18n.confirm_to_delete_record)) {
	    	form.action="<venus:base/>/SingleSubmitAction.do?cmd=deleteOrders&ids=" + ids;
    		form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<venus:base/>/SingleSubmitAction.do?cmd=addOrders";
    	form.submit();
	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}

</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="masterdetailtable.single_table"/>','<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/SingleSubmitAction.do">
<input type="hidden" name="cmd" value="">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message  key="masterdetailtable.singlesubmit.order_table"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="add"/></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="modify"/></td>
					<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<venus:base/>/images/icon/refresh.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="refresh"/></td>
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
		<layout:collection name="wy" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_master'/>" style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="orderNo"/>
					<input type="checkbox" id="checkbox_master" name="checkbox_template" value="<%=wy3%>"/>
					<input type="hidden" signName="hiddenId" value="<%=wy3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.masterdetailtable.singlesubmit.order_type")%>' property="type" sortable="true">
				<bean:define id="wy6" name="wy1" property="type"/>
					<%=ReferenceFilter.get("OrderType",String.valueOf(wy6))%>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.masterdetailtable.singlesubmit.the_total_amount_of_orders")%>' property="totalamount" sortable="true"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.masterdetailtable.singlesubmit.order_number_of_products")%>' property="count" sortable="true"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.masterdetailtable.singlesubmit.agents")%>' property="buyer" sortable="true"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.masterdetailtable.singlesubmit.suppliers")%>' property="vendor" sortable="true"/>
			<layout:collectionItem width="12%" title='<%=LocaleHolder.getMessage("gap.ajax.masterdetailtable.singlesubmit.order_created_date")%>' property="beginDate" sortable="true">
			<bean:define id="wy7" name="wy1" property="beginDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
			<layout:collectionItem width="18%" title='<%=LocaleHolder.getMessage("gap.ajax.masterdetailtable.singlesubmit.order_descriptions")%>' property="description"/>
		</layout:collection>
		
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>
</form>
<div id="child"></div>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>