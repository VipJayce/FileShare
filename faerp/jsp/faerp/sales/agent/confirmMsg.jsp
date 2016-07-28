<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<html>
<fmt:bundle basename="rayoo.salse.agent.agent_resource" prefix="rayoo.salse.agent.">
	<head>
<% String ids = request.getParameter("id");%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
<script type="text/javascript">
	var doc = window.dialogArguments   ;

	function sendSubmit(obj){
		
		if(obj == 0){
			var ids = doc.getElementById("agentId").value;
			var reason = $id("reason").value;
			if(reason == null || reason == "" ){
				alert("<fmt:message key='excuse_delete'/>");
				return;
			}
			_$.ajax({
	        type : "post",
	        url : "<%=request.getContextPath()%>/AgentAction.do?cmd=deleteMulti1&ids=" + ids,
	        dataType : "html",
	        data : jQuery('form').serialize(),
	        success : function(data) {
	                alert(data);
	                window.close();
	            }
	       	});
		}else{
			window.close();
		}
	}
</script>	
	</head>
	<body>

	<form name="form1" method="post" id="form1" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<textarea rows="10" cols="35" id="reason" name="reason"></textarea>
		<input type="button" class="foot_icon_1" value="<fmt:message key='submit'/>" onclick="sendSubmit(0)">
		<input type="button" class="foot_icon_1" value="<fmt:message key='cancel'/>" onclick="sendSubmit(1)">
	</table>
	</form>
</body>
</fmt:bundle>
</html>
