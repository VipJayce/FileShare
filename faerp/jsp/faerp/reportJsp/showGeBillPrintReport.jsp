<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>

<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<!-- modify  by  sqp  把用不到的所有参数都删除，并重新规划参数 -->
<%
	request.setCharacterEncoding( "utf-8" );
	String report = request.getParameter( "raq" );
	String billYearMonth = request.getParameter("arg1");
	String custName = request.getParameter("arg2");
	String costCenterId = request.getParameter("arg3");
	String billTypeBd = request.getParameter("arg4");
	//加入公司ID　duhuiyang
	String  billYearMonth4s =request.getParameter("arg5");
	StringBuffer param=new StringBuffer();
    param.append("arg1=").append(billYearMonth).append(";");
    param.append("arg2=").append(custName).append(";");
    if(costCenterId!=null&&costCenterId!=""){
        param.append("arg3=").append(costCenterId).append(";");
    }
    if(billTypeBd!=null&&billTypeBd!=""){
        param.append("arg4=").append(billTypeBd).append(";");
    }
    param.append("arg5=").append(billYearMonth4s).append(";");
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
