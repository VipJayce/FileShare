<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>

<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	//request.setCharacterEncoding( "GBK" );
	String reportFileName = request.getParameter( "reportFileName" );//报表文件名称
	//String security_group_id = request.getParameter("arg1");//社保/公积金组
    request.setAttribute("employeeName","sdfdsfdsf");
	
	
	String title = request.getParameter("title");//
	String employeeName = request.getParameter("employeeName");//
	String employeeCode = request.getParameter("employeeCode");//
	String payMessage = request.getParameter("payMessage");//
	
	String expMony = request.getParameter("expMony");//
	
	String payee = request.getParameter("payee");//
	
	String isIndieBd = request.getParameter("isIndieBd");//
	String open_unit = request.getParameter("open_unit");//开户单位名称
	StringBuffer param=new StringBuffer();
	if(true){
	    param.append("title=").append(title).append(";");
	    param.append("employeeName=").append(employeeName).append(";");
        param.append("employeeCode=").append(employeeCode).append(";");
        param.append("payMessage=").append(payMessage).append(";");
        param.append("expMony=").append(expMony).append(";");
        param.append("payee=").append(payee).append(";");
	}
%>
<jsp:include page="toolbarExcel.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>

		<report:html name="report1" reportFileName="<%=reportFileName%>"
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
