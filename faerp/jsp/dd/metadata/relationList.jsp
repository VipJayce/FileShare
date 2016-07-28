<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.dd.util.VoHelper" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
<script language="javascript">
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert(i18n.please_choose_record_to_delete)
			return;
		}
		if(confirm(i18n.confirm_to_delete_record)) {
	    	form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=deleteRelation&relationname=" + ids;
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
		form.queryCondition.value = buildQueryCondition();  //获得组合后的查询条件的字符串描述
    	form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=queryRelation";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/dd/metadata/insertRelation.jsp";
		form.submit();
	}
	function buildQueryCondition() {  //构建简单查询
		var queryCondition = "";  //定义组合后的查询条件的字符串变量
		var qca = new Array();  //定义查询条件的数组变量,每一个可能的查询条件会被压入这个数组
		pushCondition(qca, "pktable");
		pushCondition(qca, "pkcolumn");
		pushCondition(qca, "fktable");
		pushCondition(qca, "fkcolumn");
		if(qca.length >= 1) {  //如果有效的查询条件大于1
			queryCondition += " " + qca[0] + " ";  //组装第1个查询条件
		}
		for(var i=1; i<qca.length; i++) {  //从第2个开始循环查询条件
			queryCondition += " and " + qca[i] + " ";  //组装第2个以后的查询条件
		}
		return queryCondition;
	}
	function clear_onClick(){  //实现转到详细页面
		form.pktable.value="";
		form.pkcolumn.value="";
		form.fktable.value="";
		form.fkcolumn.value="";
	}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="metadata.tablerelationmgr"></fmt:message>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post" action="<venus:base/>/MetadataAction.do">
<input type="hidden" name="cmd" value="queryRelation">
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
<table class="table_div_content">
<tr><td>
	<table class="table_noFrame" width="100%">
		<tr>
			<td width="15%" align="right"><fmt:message key="metadata.mastertable"></fmt:message></td>
			<td width="35%" align="left"><input type="text" class="text_field" name="pktable" inputName='<fmt:message key="metadata.mastertable"></fmt:message>' maxLength="64"/></td>
			<td width="15%" align="right"><fmt:message key="metadata.mastertablecolumn"></fmt:message></td>
			<td width="35%" align="left"><input type="text" class="text_field" name="pkcolumn" inputName='<fmt:message key="metadata.mastertablecolumn"></fmt:message>' maxLength="64"/></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.subtable"></fmt:message></td>
			<td align="left"><input type="text" class="text_field" name="fktable" inputName='<fmt:message key="metadata.subtablecolumn"></fmt:message>' maxLength="64"/></td>
			<td align="right"><fmt:message key="metadata.subtablecolumn"></fmt:message></td>
			<td align="left"><input type="text" class="text_field" name="fkcolumn" inputName='<fmt:message key="metadata.subtablecolumn"></fmt:message>' maxLength="64"/></td>
		</tr>
	</table>
</td></tr>
</table>
</div>
					
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="metadata.relationlist"></fmt:message>
		</td>
		<td> 
			<table align="right">
				<tr>
					<td class="button_ellipse" id="btnAdd" onClick="javascript:toAdd_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="add"  bundle="${applicationResources}"></fmt:message></td>
					<td class="button_ellipse" id="btnDel" onClick="javascript:deleteMulti_onClick();"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete"  bundle="${applicationResources}"></fmt:message></td>
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
		<layout:collection name="relationList" id="rmBean" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0">
			<layout:collectionItem width="5%" title="<input type='hidden' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="rmValue" name="rmBean" property="relationname"/>
				<input type="radio" name="checkbox_template" value="<%=rmValue%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>"/>
			</layout:collectionItem>
			<layout:collectionItem title='<%=LocaleHolder.getMessage("gap.dd.metadata.relationname")%>' width="10%" property="relationname" sortable="false" />
			<layout:collectionItem title='<%=LocaleHolder.getMessage("gap.dd.metadata.mastertable")%>' width="10%" property="pktable" sortable="false"/>
			<layout:collectionItem title='<%=LocaleHolder.getMessage("gap.dd.metadata.mastertablecolumn")%>' width="10%" property="pkcolumn" sortable="false" />
			<layout:collectionItem title='<%=LocaleHolder.getMessage("gap.dd.metadata.subtable")%>' width="10%" property="fktable" sortable="false"/>
			<layout:collectionItem title='<%=LocaleHolder.getMessage("gap.dd.metadata.subtablecolumn")%>' width="10%" property="fkcolumn" sortable="false"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.dd.metadata.iscreated")%>' property="iscreated" sortable="false">
				<bean:define id="rmValue" name="rmBean" property="iscreated"/>
				<%="1".equals(rmValue)?LocaleHolder.getMessage("gap.dd.metadata.created"):LocaleHolder.getMessage("gap.dd.metadata.uncreated")%>
			</layout:collectionItem>
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
