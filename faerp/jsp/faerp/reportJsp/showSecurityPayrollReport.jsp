<%@ page contentType="text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>

<%@page import="org.apache.commons.lang.StringUtils"%>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	request.setCharacterEncoding( "GBK" );
	String raq = request.getParameter("raq");
	String batchId = request.getParameter("batch_id");
	String class_id = request.getParameter("class_id");
	StringBuilder param = new StringBuilder();
	param.append("batch_id="+batchId+";");
	if(!StringUtils.isEmpty(class_id)){
		param.append("class_id="+class_id+";");
	}
%>
<jsp:include page="toolbar2.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>
		<report:html name="report1" reportFileName="<%=raq %>"
			funcBarLocation="top"
			needPageMark="yes"
			generateParamForm="no"
			params="<%=param.toString() %>"
			exceptionPage="/jsp/faerp/reportJsp/myError2.jsp"
			appletJarName="runqianReport4Applet.jar,dmGraphApplet.jar"
			textDataLineBreak="\r\n"
			width="-1"
		/>

</table>

<script type="text/javascript">
	//设置分页显示值
	document.getElementById( "t_page_span" ).innerHTML=report1_getTotalPage();
	document.getElementById( "c_page_span" ).innerHTML=report1_getCurrPage();
</script>
</body>
</html>
