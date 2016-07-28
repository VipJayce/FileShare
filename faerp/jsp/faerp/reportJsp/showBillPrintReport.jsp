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
	String customerService = request.getParameter("arg2");
	String custName = request.getParameter("arg3");
	
	//System.out.println("custName================================"+custName);
	
	String costCenterId = request.getParameter("arg4");
	String billTypeBd = request.getParameter("arg5");
	String loginName = request.getParameter("arg7");
	//加入公司ID　duhuiyang
	String company_id = request.getParameter("arg8");

	String year = billYearMonth.substring(0, 4)+"年"+billYearMonth.substring(4, 6)+"月";
	StringBuffer param=new StringBuffer();
    param.append("arg1=").append(billYearMonth).append(";");
    if(customerService!=null&&customerService!=""){
	    param.append("arg2=").append(customerService).append(";");
    }
    param.append("arg3=").append(custName).append(";");
    if(costCenterId!=null&&costCenterId!=""){
        param.append("arg4=").append(costCenterId).append(";");
    }
    if(billTypeBd!=null&&billTypeBd!=""){
        param.append("arg5=").append(billTypeBd).append(";");
    }
    param.append("arg7=").append(loginName).append(";");
    param.append("arg8=").append(year).append(";");
    param.append("arg9=").append(company_id).append(";");
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
