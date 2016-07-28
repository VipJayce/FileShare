<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<venus:base/>/css/tabbar/tabbar.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<venus:base/>/css/tabbar/tabbar.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/controldata.js"></script>
<script type='text/javascript' src="<venus:base/>/js/dd/change.js"></script>
<script type='text/javascript' src='<venus:base/>/dwrdd/interface/ControlDataService.js'></script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="common.edit_page"/>','<%=request.getContextPath()%>/');
</script>
<script language="javascript">
	var params = dialogArguments;
	var code = params[0];
</script>
<form name="form" method="post" >	
	<div id="controlPanel" style="padding:5px">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:save_onClick();">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:cancel_onClick();">
	</div>
	<div>   
		<table class="table_div_content">
			<tr>
				<td align="right" ><fmt:message key="gap.dd.controldata.new_view_name"  bundle="${dd}"></fmt:message></td>
				<td align="left" width="360px">
					<input id="name" type="text" class="text_field" validate="notNull" inputName='<fmt:message key="gap.dd.controldata.new_view_name"  bundle="${dd}"></fmt:message>' value="">			
				</td>
			</tr>
			<tr>
				<td align="right" ><fmt:message key="gap.dd.controldata.new_view_code"  bundle="${dd}"></fmt:message></td>
                <td align="left" width="360px">
                    <input id="code" type="text" class="text_field" validate="notNull" inputName='<fmt:message key="gap.dd.controldata.new_view_code"  bundle="${dd}"></fmt:message>' value="">            
                </td>
			</tr>
		</table>
	</div>  
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');
</script>
</body>
<script>
	function save_onClick(){
		if(checkForm(form)==true){
		  var data = {};
		  data["code"] = code;
		  data["newCode"] = jQuery("#code").val();
		  data["newName"] = jQuery("#name").val();
				ControlDataService.cloneView(data,function(result){
					window.returnValue = result;
					alert(result);
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