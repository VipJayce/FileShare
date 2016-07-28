<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript" src="<venus:base/>/js/dd/common.js"></script>
<title><fmt:message key="gap.dd.metadata.add_table_page"></fmt:message></title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=insertTableData";
		form.submit();
	}
	function return_onClick(){
		history.go(-1);
	}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="metadata.add_table_page"></fmt:message>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td><input name="button_save" class="button_ellipse" type="button" value='<fmt:message key="metadata.step_next"></fmt:message>' onClickTo="javascript:insert_onClick()">
			<input name="button_cancel" class="button_ellipse" type="button" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>'  onClick="javascript:return_onClick()" >
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key="metadata.add_table"></fmt:message>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
<tr><td> 
	<table class="table_div_content_inner">
		<tr>
			<td align="right" width="15%"><span class="style_required_red">* </span><fmt:message key="metadata.table_name"></fmt:message></td>
			<td align="left" width="35%">
				<input type="text" class="text_field" name="tableName" inputName='<fmt:message key="metadata.table_name"></fmt:message>' value="" maxLength="64" validate="notNull;isTableName"/>
			</td>
			<td width="15%" align="right">&nbsp;</td>
			<td width="35%" align="left">&nbsp;</td>
		</tr>
		<tr>
			<td align="right"><span class="style_required_red">* </span><fmt:message key="metadata.table_name_zh"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="displayName" inputName='<fmt:message key="metadata.table_name_zh"></fmt:message>' value="" maxLength="64" validate="notNull;"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.isdummy"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isVirtual"  value="1"/><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="isVirtual"  value="0" checked/><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="remark"  bundle="${applicationResources}"></fmt:message></td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName=’<fmt:message key="remark"  bundle="${applicationResources}"></fmt:message>‘ maxLength="256" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</td></tr>
</table>
</div>
            
<input type="hidden" name="id" value="">
<input type="hidden" name="category" value="4">
<input type="hidden" name="iscreated" value="0"/>
<input type="hidden" name="status"  value="1"/>
</form>			
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</fmt:bundle>
</body>
</html>
