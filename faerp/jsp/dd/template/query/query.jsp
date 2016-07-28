<html><body>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/DynamicQueryAjax.js'></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<%@ include file="/jsp/dd/include/jquery.jsp" %>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/view.js"></script>
<title><fmt:message key="common.list_template"></fmt:message></title>
<script>
	var moduleId ='<%=request.getParameter("moduleId")%>';
	jQuery.noConflict();
	function initAll(){
		DynamicQueryAjax.forwardQueryPage(moduleId,function(data){
			jQuery("#QueryItemDiv").replaceWith(data);
		})
	}

	function query_onClick(){
		if(checkAllForms()){
			form.action = "<venus:base/>/DynamicQueryAction.do";
			form.cmd.value="forwardListPage";
			form.submit();
		}
	}
	
	function reset_onClick(){
		jQuery("#form").clearForm();
	}


</script>
</head>
<body onload="initAll();">
<script language="javascript">
	writeTableTop('<%=request.getParameter("moduleName")%>','<venus:base/>/');
</script>

<form id="form" name="form" method="post" action="<venus:base/>/DynamicQueryAction.do">
	<input type="hidden" name="moduleId" value='<%=request.getParameter("moduleId")%>' />
	<input type="hidden" name="moduleName" value='<%=request.getParameter("moduleName")%>' />
	<input type="hidden" name="cmd" value='' />
<!-- 查询开始 -->
<div id="ccParent0" class="table_div_control" style="Padding:5px;"> 
			<div style="float:left">
				<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="common.detail_table"></fmt:message>
			</div>
			<div style="float:right"> 
				<input type='button' style="float:right" class="button_ellipse" onClick="javascript:reset_onClick();" value='<fmt:message key="clear"  bundle="${applicationResources}"></fmt:message>'></input>
				<input type='button' style="float:right" class="button_ellipse" onClick="javascript:query_onClick();" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>'></input>
			</div>
</div>

<div id="ccChild0"> 
	<div id="QueryItemDiv"> </div>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</fmt:bundle>
</body>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>