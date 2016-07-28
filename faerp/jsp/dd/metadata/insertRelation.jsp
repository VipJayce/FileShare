<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="metadata.add_relation"></fmt:message></title>
<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
<script type="text/javascript" src="<venus:base/>/dwrdd/interface/MetadataAjax.js"></script>
<script type="text/javascript" src="<venus:base/>/dwr/engine.js"></script>
<script type="text/javascript" src="<venus:base/>/dwr/util.js"></script>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=insertRelation";
		form.submit();
	}
	function return_onClick(){  //实现转到列表页面
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=queryRelation";
		form.submit();
	}
	function refreshTableSelect(tName){
		DWRUtil.removeAllOptions(tName);
		DWREngine.setAsync(false);
		MetadataAjax.queryTables(function(data)  {
			DWRUtil.addOptions(tName,data,"tableName","displayName");
		});
		DWREngine.setAsync(true);
	}
	function refreshColumnSelect(tableName,cName) {
		DWRUtil.removeAllOptions(cName);
		DWREngine.setAsync(false); 
		MetadataAjax.queryColumnsByTableName(tableName, function(data)  {
			DWRUtil.addOptions(cName,data,"columnName","displayName");
		});
		DWREngine.setAsync(true); 
	}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="new_page"  bundle="${applicationResources}"></fmt:message>',"<%=request.getContextPath()%>/");  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
	<tr>
		<td><input name="button_save" class="button_ellipse" type="button" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClickTo="javascript:insert_onClick()">
			<input name="button_cancel" class="button_ellipse" type="button" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>'  onClick="javascript:return_onClick()" >
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key="metadata.add_relation"></fmt:message>
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td> 
			<table class="table_div_content_inner">
				<tr>
					<td align="right" width="15%" ><span class="style_required_red">* </span><fmt:message key="metadata.relationname"></fmt:message></td>
					<td align="left" width="35%" >
						<input type="text" class="text_field" name="relationname" inputName='<fmt:message key="metadata.relationname"></fmt:message>' value="" maxLength="64" validate="notNull;isSearch"/>
					</td>
					<td width="15%" align="right">&nbsp;</td>
					<td width="35%" align="left">&nbsp;</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="metadata.mastertable"></fmt:message></td>
					<td align="left" id="td1"><select id="pktable" name="pktable" style="width:206" onchange="javascript:refreshColumnSelect(DWRUtil.getValue('pktable'),'pkcolumn')"></select></td>
					<td align="right"><fmt:message key="metadata.mastertablecolumn"></fmt:message></td>
					<td align="left" id="td2"><select id="pkcolumn" name="pkcolumn" style="width:206"></select></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="metadata.subtable"></fmt:message></td>
					<td align="left" id="td3"><select id="fktable" name="fktable" style="width:206" onchange="javascript:refreshColumnSelect(DWRUtil.getValue('fktable'),'fkcolumn')"></select></td>
					<td align="right"><fmt:message key="metadata.subtablecolumn"></fmt:message></td>
					<td align="left" id="td4"><select id="fkcolumn" name="fkcolumn" style="width:206"></select></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	refreshTableSelect("pktable");
	refreshTableSelect("fktable");
	refreshColumnSelect(DWRUtil.getValue("pktable"),"pkcolumn");
	refreshColumnSelect(DWRUtil.getValue("fktable"),"fkcolumn");
</script>
</body>
</html>
</fmt:bundle>