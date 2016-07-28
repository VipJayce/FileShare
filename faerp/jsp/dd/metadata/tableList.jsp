<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.dd.util.VoHelper" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
<%@ include file="/jsp/dd/include/jquery.jsp" %>	
<script type="text/javascript" src="<venus:base/>/js/jquery/plugin/jquery.tableresizer.js"></script>	
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script language="javascript">
	function findCheckbox_onClick() {  //查看详细和维护
		var ids = findSelections4Modify();
		if(ids == -1)return;
		detail_onClick(ids);
	}  
	
	function clear_onClick(){  //实现转到详细页面
		jQuery("#form").clearForm();
	}
	
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
		var ids = findSelections4Delete();
		if(ids == -1)return;
 		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=deleteTables&ids=" + ids;
	    form.submit();
	}
	

	function simpleQuery_onClick(){  //简单的模糊查询
		form.queryCondition.value = buildQueryCondition();  //获得组合后的查询条件的字符串描述
    	form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=queryTables";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/dd/metadata/insertTable.jsp";
		form.submit();
	}
	function refresh_onClick(){  //刷新本页
		simpleQuery_onClick();
	}
	function detail_onClick(thisId){  //实现转到详细页面
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=queryColumns&tableid="+thisId;
		form.submit();
	}
	function buildQueryCondition() {  //构建简单查询
		var queryCondition = "";  //定义组合后的查询条件的字符串变量
		var qca = new Array();  //定义查询条件的数组变量,每一个可能的查询条件会被压入这个数组
		
		pushCondition(qca, "tableName");
				
		pushCondition(qca, "isVirtual", "='", "'");
				
		pushCondition(qca, "isCreated", "='", "'");
				
		if(qca.length >= 1) {  //如果有效的查询条件大于1
			queryCondition += " " + qca[0] + " ";  //组装第1个查询条件
		}
		for(var i=1; i<qca.length; i++) {  //从第2个开始循环查询条件
			queryCondition += " and " + qca[i] + " ";  //组装第2个以后的查询条件
		}
		if(qca.length>=1)
			queryCondition=queryCondition+" and displayName like'%"+ form.elements["cName"].value+"%'";
		else	
			queryCondition=queryCondition+" displayName like'%"+ form.elements["cName"].value+"%'";
		return queryCondition;
	}
	
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="metadata.table_management"></fmt:message>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form id="form" name="form" method="post" action="<venus:base/>/MetadataAction.do">
<input type="hidden" name="cmd" value="">

<div id="ccParent0" class="table_div_control" style="Padding:5px;"> 
			<div style="float:left">
				<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="common.query_by_condition"></fmt:message>
			</div>
			<div style="float:right"> 
				<input type='button' style="float:right" class="button_ellipse" onClick="javascript:clear_onClick();" value='<fmt:message key="clear"  bundle="${applicationResources}"></fmt:message>'></input>
				<input type='button' style="float:right" class="button_ellipse" onClick="javascript:simpleQuery_onClick();" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>'></input>
			</div>
</div>

<div id="ccChild0"> 
<table class="table_div_content" >
<tr><td>
	<table class="table_noFrame" width="100%">
		<tr>
			<td width="15%" align="right"><fmt:message key="metadata.table_name"></fmt:message></td>
			<td width="35%" align="left"><input type="text" class="text_field" name="tableName" inputName='<fmt:message key="metadata.table_name"></fmt:message>' maxLength="64"/></td>
			<td width="15%" align="right"><fmt:message key="metadata.table_name_zh"></fmt:message></td>
			<td width="35%" align="left"><input type="text" class="text_field" name="cName" inputName='<fmt:message key="metadata.table_name_zh"></fmt:message>' maxLength="64"/></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.isdummy"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isVirtual"  value="1"/><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="isVirtual"  value="0"/><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"><fmt:message key="metadata.iscreated"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isCreated"  value="1"/><fmt:message key="metadata.created"></fmt:message>
				<input type="radio" name="isCreated"  value="0"/><fmt:message key="metadata.uncreated"></fmt:message>
			</td>
		</tr>
	</table>

</td></tr>
</table>
</div>
					
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="metadata.tablelist"></fmt:message>
		</td>
		<td> 
			<table align="right">
				<tr>
						<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="add"  bundle="${applicationResources}"></fmt:message></td>
						<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete"  bundle="${applicationResources}"></fmt:message></td>
						<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify"  bundle="${applicationResources}"></fmt:message></td>
						<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<%=request.getContextPath()%>/images/icon/refresh.gif" class="div_control_image"><fmt:message key="refresh"  bundle="${applicationResources}"></fmt:message></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content2" class="sortable" >
	<tr>
		<td>
		<layout:collection  name="tableList" id="rmBean" styleClass="listCss" width="100%"  indexId="orderNumber" align="center" sortAction="0" onRowDblClick='javascript:detail_onClick(getRowHiddenId(event))'>
			
			<layout:collectionItem width="30" title='<%=LocaleHolder.getMessage("gap.dd.common.select")%>' style="text-align:center;">
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="rmDisplayName" name="rmBean" property="id"/>
				<input type="radio" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="30"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem  title='<%=LocaleHolder.getMessage("gap.dd.metadata.table_name")%>' property="tableName" sortable="true"/>
			
			<layout:collectionItem  title='<%=LocaleHolder.getMessage("gap.dd.metadata.table_name_zh")%>' property="displayName" sortable="true"/>
			
			<layout:collectionItem width="60" title='<%=LocaleHolder.getMessage("gap.dd.metadata.isdummy")%>' property="isVirtual" sortable="false">
				<bean:define id="rmValue" name="rmBean" property="isVirtual"/>
				<%=gap.dd.util.StringHelper.prtYesNo((String)rmValue)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="60" title='<%=LocaleHolder.getMessage("gap.dd.metadata.iscreated")%>' property="isCreated" sortable="false">
				<bean:define id="rmValue" name="rmBean" property="isCreated"/>
				<%="1".equals(rmValue)?LocaleHolder.getMessage("gap.dd.metadata.created"):LocaleHolder.getMessage("gap.dd.metadata.uncreated")%>
			</layout:collectionItem>
			
			<layout:collectionItem width="200" title='<%=LocaleHolder.getMessage("remark")%>' property="remark" sortable="false"/>
			
		</layout:collection>
		
		<!-- 下边这句是翻页, 如果去掉就不带翻页了,同时注意Action中也要调整方法 -->
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>

<input type="hidden" name="queryCondition" value="">

</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
<script>

</script>
</body>
</html>
</fmt:bundle>
<script language="javascript">
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {  //如果request中取出的表单回写bean不为空
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));  //输出表单回写方法的脚本
		out.print("writeBackMapToForm();\n");  //输出执行回写方法
	}
%>
</script>	
