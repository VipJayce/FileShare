<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/workflowForm/extendFormHead.jsp" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<%@ include file="/jsp/dd/include/jquery.jsp" %>	
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/view.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
<%  
	boolean isModify = false;
	if(request.getParameter("isModify") != null) {
		isModify = true;
	}
	String condition = (String) request.getAttribute("condition");
	if(condition==null) {
		condition = "";
	}
	String primary = (String) request.getAttribute("primary");
	if(primary==null) {
		primary = "";
	}
	String primary_value = (String) request.getAttribute("primary_value");
	if(primary_value==null) {
		primary_value = "";
	}
	String ds = (String) request.getAttribute("dispStyle");
	int dispStyle=0;
	if(ds!=null) {
		dispStyle =new Integer(ds).intValue();
	}	
%>
<script>
	jQuery.noConflict();
	webPath='<%=request.getContextPath()%>';	
	var detailView ='<%=request.getParameter("detailView")%>';
	var tableView ='<%=request.getParameter("tableView")%>';
	var queryView ='<%=request.getParameter("queryView")%>';
	var toolView ='<%=request.getParameter("toolView")%>';
	var moduleName ='<%=request.getParameter("moduleName")%>';

    function commitTask(){
        collectRelevantData("form4wf");
        var form1 = jQuery("#form4wf")[0];
         /**
      通过request attribute域中获取任务对象，此对象在接受任务时已设置，接着获取任务的表单配置路径
      从路径中获得提交Action地址
        **/
        var actionUrl = "${task.xref}".split("\?")[0];
        form1.action = "<venus:base/>" +actionUrl + "?cmd=commitTask";
        form1.submit();
    }
  	 function cancel_onClick(){
  		window.history.go(-1);
  	}

</script>

</head>
<body>  <fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">
  
	  writeTableTop('<fmt:message key="actived_task" />','<venus:base/>/');
	
</script>
</fmt:bundle>
    

<form name="form4wf" id="form4wf" method="post">
<input type="hidden" name="primary" value="<%=primary%>">
<input type="hidden" name="primary_value" value="<%=primary_value%>">
<input type="hidden" name="<%=WFConstants.Success_ProcDefName%>" value="${processname}">
<input type="hidden" name="actDefId" value="${task.actDefId}">
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"/>' onClick="javascript:commitTask();">
			<input name="button_cancel" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"/>'  onClick="javascript:cancel_onClick()">
		</td>
	</tr>
</table>

<dd:editView code='<%=request.getParameter("detailView")%>' condition="<%=condition%>" dispStyle="<%=dispStyle%>"/>
<input type="hidden" name="code" value='<%=request.getParameter("detailView")%>' />

</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
<%@ include file="/workflowForm/extendFormFoot.jsp" %>
<%@page import="com.alexander.workflow.extend.util.WFConstants"%>
</html>
<%  
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>
