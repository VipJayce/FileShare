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
	
	
	//String bill_id = request.getParameter("bill_id");//
	//String show_type = request.getParameter("show_type");//
	StringBuffer param=new StringBuffer();
	

    Enumeration<String> em = request.getParameterNames();
    while (em.hasMoreElements()) {
        String key = (String) em.nextElement();
        param.append(key+"=").append(request.getParameter(key)).append(";");
    }
	System.out.println(param);
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
