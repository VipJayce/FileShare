<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<%@ include file="/jsp/dd/include/ext.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<venus:base/>/js/dd/controldata/fieldList.js"></script>
	<script type="text/javascript" src="<venus:base/>/js/dd/controldata/enumerate.js"></script>
	<script type='text/javascript' src='<venus:base/>/dwrdd/interface/ControlDataService.js'></script>
</head>
<script language="javascript">
	webPath='<%=request.getContextPath()%>';
	viewId='<%=request.getParameter("viewId").toString()%>';
</script>
<body>
	<input type="hidden" name="cmd" value="">
	<div id="viewDetail">
		<div id="ccChild0"> 
			<table class="table_div_content">
				<tr>
					<td align="right" width="10%"><fmt:message key="common.code"/></td>
					<td align="left" width="660px">
						<input id="code" name="code" type="text" class="text_field" inputName='<fmt:message key="common.code"/>'  disabled="true" validate="notNull;isSearch" value="">			
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="name"  bundle="${applicationResources}"></fmt:message></td>
					<td align="left">
						<input id="name" name="name" type="text" class="text_field" inputName='<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>'  disabled="true" validate="notNull;isSearch" value="">			
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.view_viewtype"/></td>
					<td align="left">
						<select id="viewType" name="viewType" disabled="true">
							<option value="1"><fmt:message key="controldata.list_view"/></option>
							<option value="2"><fmt:message key="controldata.edit_view"/></option>
							<option value="3"><fmt:message key="controldata.query_view"/></option>
							<option value="4"><fmt:message key="controldata.toolbar_button"/></option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key="controldata.view_condition"/></td>
					<td colspan="3" align="left">
						<textarea id="condition" class="textarea_limit_words" cols="36" rows="5" name="condition" disabled="true" inputName='<fmt:message key="controldata.view_condition"/>' maxLength="512" ></textarea>
					</td>
				</tr>
				
			</table>
		</div>
	</div>
	</form>
</body>
</fmt:bundle>
</html>

