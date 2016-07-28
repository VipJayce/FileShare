<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>

<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
    request.setCharacterEncoding( "utf-8" );
	String report = request.getParameter( "raq" );
	String tId = request.getParameter("arg1");
	String custName = request.getParameter("arg2");
	String costCenterName = request.getParameter("arg3");
	String invoiceCode = request.getParameter("arg4");
	String invoiceAmount = request.getParameter("arg5");
	String loginName = request.getParameter("arg6");
	StringBuffer param=new StringBuffer();
    param.append("arg1=").append(tId).append(";");
    param.append("arg2=").append(custName).append(";");
    param.append("arg3=").append(costCenterName).append(";");
    param.append("arg4=").append(invoiceCode).append(";");
    param.append("arg5=").append(invoiceAmount).append(";");
    param.append("arg6=").append(loginName).append(";");
%>
<jsp:include page="toolbar1.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>

		<report:html name="report1" reportFileName="<%=report%>"
			funcBarLocation="top"
			needPageMark="yes"
			generateParamForm="no"
			params="<%=param.toString()%>"
			exceptionPage="/jsp/faerp/reportJsp/myError2.jsp"
			appletJarName="runqianReport4Applet.jar,dmGraphApplet.jar"
			textDataLineBreak="\r\n"
			width="-1"
		/>

</table>

<script language="javascript">
	//设置分页显示值
	
	document.getElementById( "t_page_span" ).innerHTML=report1_getTotalPage();
	document.getElementById( "c_page_span" ).innerHTML=report1_getCurrPage();

</script>
</body>
</html>
