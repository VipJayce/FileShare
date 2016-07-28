<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page import="gap.dd.controldata.util.IControlDataConstants"%>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/controldata.js"></script>
<script type='text/javascript' src="<venus:base/>/js/dd/common.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/gap-ajaxList.js"></script>
<script type='text/javascript' src='<venus:base/>/dwrdd/interface/ControlDataService.js'></script>
<script type='text/javascript' src='<venus:base/>/dwr/engine.js'></script>
<script type='text/javascript' src='<venus:base/>/dwr/util.js'></script>
</head>
<body onload="init()" >
<script language="javascript">
	writeTableTop('<fmt:message key="controldata.template_button_title"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<script language="javascript">
	var params = dialogArguments;
	var field = getField();
	field.viewId=params[0];
	field.viewCode=params[1];
	//alert(dwr.util.toDescriptiveString(field,2));
	function init(){
		setForms(field);
	}
	jQuery(document).ready(function(){
		ControlDataService.getTemplateButtonHTML(function(data){
			jQuery("#displayType").html(data);
		});
	});
	
</script>
<form id="form" name="form" method="post" >	
	<input id='viewId' name='viewId' type='hidden'></input>
	<input id='viewCode' name='viewCode' type='hidden'></input>
	<div id="controlPanel" style="padding:5px">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:save_onClick(params[0]);">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:cancel_onClick();">
	</div>	
    <div id="listView" >
	  	<div id="ccParent1"> 
			<table class="table_div_control">
				<tr> 
					<td>
						<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key="edit"  bundle="${applicationResources}"></fmt:message>
					</td>
				</tr>
			</table>
		</div>

		<div id="ccChild1" > 
			<table class="table_div_content" >
				<tr>
					<td align="right"><fmt:message key="controldata.select_template_button" /></td>
					<td colspan="3" align="left">
						<select id="displayType" name="displayType">
							<!-- <option value="0"><fmt:message key="controldata.send_to_audit" /></option> -->
							<!-- <option value="1"><fmt:message key="controldata.monitor" /></option> -->
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
</body>
<script>
	function save_onClick(){
		if(confirm(i18n_dd.confirm_add_button)==true)
		{	
			getForms(field);
			field.id = '<%=IControlDataConstants.KEY_TEMPLATE_BUTTON%>';
			ControlDataService.insertField(field,function(){
				window.returnValue = field;
				window.close();
			});
		}
	}
	function cancel_onClick()
	{
		window.returnValue=null;
		window.close();
	}
</script>
</fmt:bundle>	
</html>