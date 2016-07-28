<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<head>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/BaseDataService.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
   <script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/common.js"></script>  
   <script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/basedata/basedata.js"></script>  
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script language="javascript">
var params = dialogArguments;
var tempObj = params[0];

function initBaseDataType(){
	var baseDataType= params[0];
	jQuery("#id").val(baseDataType.id)
	jQuery("#code").val(baseDataType.code)
	jQuery("#name").val(baseDataType.name)
	if(baseDataType.state!="insert")
	{
		document.getElementById("code").readOnly='true';
	}
}

function save_onClick(){
	var baseDataType= tempObj;
	baseDataType.id = jQuery("#id").val();
	baseDataType.name = jQuery("#name").val();
	baseDataType.code = jQuery("#code").val();
	if(checkForm(detailForm)==true)
	{
		if(baseDataType.state=="insert")
		{
			show(baseDataType,2);
			BaseDataService.insertBaseDataType(baseDataType,function(){
				window.returnValue = baseDataType;
				window.close();
			});
		}
		else
		{
			BaseDataService.updateBaseDataType(baseDataType,function(){
				window.returnValue = baseDataType;
				window.close();
			});
		}
	}
}
function cancel_onClick(obj)
{
	window.returnValue=null;
	window.close();
}
</script>
</head>
<base target="_self">
<body onload="javascript:initBaseDataType();">
<script language="javascript">
	writeTableTop('<fmt:message key="common.edit_page"/>','<venus:base/>/');
</script>
<form name="detailForm" method="post" action="<venus:base/>/BaseDataAction.do">
	<input type="hidden" name="cmd" value="">
	<input type="hidden" name="sessionId" value="<%=request.getSession().getId()%>">
	<input id="id" name="id" type="hidden">
	<table class="table_noframe">
		<tr>
			<td valign="middle">
				<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:save_onClick();">
			</td>
			<td valign="middle">
				<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:cancel_onClick(params[0]);">
			</td>
		</tr>
	</table>
	
	<div id="ccParent1"> 
		<table class="table_div_control">
			<tr> 
				<td>
					<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key="common.edit"></fmt:message>
				</td>
			</tr>
		</table>
	</div>
	<div id="ccChild1"> 
		<table class="table_div_content">
			<tr>
				<td align="right" width="10%"><fmt:message key="common.code" /></td>
				<td align="left">
					<input id="code" name="code" type="text" class="text_field" inputName='<fmt:message key="common.code" />'   validate="notNull;isSearch;notChinese" value="">			
				</td>
			</tr>
			<tr>
				<td align="right"><fmt:message key="name"  bundle="${applicationResources}"></fmt:message></td>
				<td align="left">
					<input id="name" name="name" type="text" class="text_field" inputName='<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>'   validate="notNull;isSearch" value="">			
				</td>
			</tr>
		</table>
	</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
</html>
