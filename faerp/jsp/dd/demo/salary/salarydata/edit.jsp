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
<%  
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
%>
<title>基础数据维护</title>
<script>
	jQuery.noConflict();
	webPath='<%=request.getContextPath()%>';	
	var detailView ='<%=request.getParameter("detailView")%>';
  	function update_onClick(){
  		form.action = "<venus:base/>/SalaryDataAction.do?cmd=update&detailView="+detailView;
  		form.submit();
  	}

</script>

</head>
<body>
<script language="javascript">
	writeTableTop('基础数据维护','<venus:base/>/');
</script>

<form name="form" method="post">
<input type="hidden" name="primary" value="<%=primary%>">
<input type="hidden" name="primary_value" value="<%=primary_value%>">
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value="保存" onClick="javascript:update_onClick();">
		</td>
	</tr>
</table>

<dd:editView code='<%=request.getParameter("detailView")%>' condition="<%=condition%>" dispStyle="0"/>
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
