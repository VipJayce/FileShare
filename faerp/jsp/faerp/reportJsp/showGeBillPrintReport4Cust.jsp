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
	String billYearMonth = request.getParameter("arg1");
	String billTypeBd = request.getParameter("arg2");
	String loginName = request.getParameter("arg3");
	String company_id = request.getParameter("arg4");
	String cust_name = request.getParameter("arg5");
	String billYearMonth4s=request.getParameter("arg10");
	String cust_group=request.getParameter("arg11");
	
	String year = billYearMonth.substring(0, 4)+"年"+billYearMonth.substring(4, 6)+"月";
	StringBuffer param=new StringBuffer();
    param.append("arg1=").append(billYearMonth).append(";");
    if(billTypeBd!=null&&billTypeBd!=""){
	    param.append("arg2=").append(billTypeBd).append(";");
    }
    param.append("arg3=").append(loginName).append(";");
     param.append("arg4=").append(company_id).append(";");
    if(cust_name!=null&&cust_name!=""){
        param.append("arg5=").append(cust_name).append(";");
    }
    param.append("arg10=").append(billYearMonth4s).append(";");
    param.append("arg11=").append(cust_group).append(";");
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
