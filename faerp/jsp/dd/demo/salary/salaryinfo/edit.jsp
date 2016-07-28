<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="venus.pub.util.VoHelper" %>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<%@ include file="/jsp/dd/include/jquery.jsp" %>
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/view.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
<%  //判断是否为修改页面
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
<title><%=isModify?"修改模板":"新增模板"%></title>
<script>
	jQuery.noConflict();
	webPath='<%=request.getContextPath()%>';	
	var detailView ='<%=request.getParameter("detailView")%>';
	var tableView ='<%=request.getParameter("tableView")%>';
	var queryView ='<%=request.getParameter("queryView")%>';
	var toolView ='<%=request.getParameter("toolView")%>';
	var moduleName ='<%=request.getParameter("moduleName")%>';

	function insert_onClick(){  //增加记录
		if(checkAllForms()){
    		form.action = "<venus:base/>/SalaryInfoAction.do?cmd=insert&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
    		form.submit();
    	}
  	}
  	function update_onClick(){
	  	if(checkAllForms()){
  			form.action = "<venus:base/>/SalaryInfoAction.do?cmd=update&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
  			form.submit();
  		}
  	}
  	
  	 function cancel_onClick(){
  		window.location="<venus:base/>/jsp/dd/demo/salary/salaryinfo/list.jsp?moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
  	}

</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<%=isModify?"修改页面":"新增页面"%>','<venus:base/>/');
</script>

<form name="form"  enctype="multipart/form-data"method="post">
<input type="hidden" name="primary" value="<%=primary%>">
<input type="hidden" name="primary_value" value="<%=primary_value%>">
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value="保存" onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>;">
			<input name="button_cancel" type="button" class="button_ellipse" value="取消"  onClick="javascript:cancel_onClick()">
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
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>
