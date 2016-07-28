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
	String emp_code = request.getParameter("arg5");
	String emp_internal_code = request.getParameter("arg6");
	String  billYearMonth4s =request.getParameter("arg7");

	StringBuffer param=new StringBuffer();
	if(billYearMonth!=null&&billYearMonth!=""){
    param.append("arg1=").append(billYearMonth).append(";");
	}
    if(billTypeBd!=null&&billTypeBd!=""){
	    param.append("arg2=").append(billTypeBd).append(";");
    }
    param.append("arg3=").append(loginName).append(";");
     param.append("arg4=").append(company_id).append(";");
    if(emp_code!=null&&emp_code!=""){
        param.append("arg5=").append(emp_code).append(";");
    }
    if(emp_internal_code!=null&&emp_internal_code!=""){
        param.append("arg6=").append(emp_internal_code).append(";");
    }
    if(billYearMonth4s!=null&&billYearMonth4s!=""){
        param.append("arg7=").append(billYearMonth4s).append(";");
    }
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
