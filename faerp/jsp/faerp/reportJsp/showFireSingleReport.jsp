<%@ page contentType="text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>

<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	request.setCharacterEncoding( "GBK" );
	String report = request.getParameter( "raq" );
	String socialUnitId = request.getParameter("arg1");
	String custId = request.getParameter("arg2");
	String hireHandleDateFrom = request.getParameter("arg3");
	String hireHandleDateTo = request.getParameter("arg4");
	String applyoffpostDateFrom = request.getParameter("arg6");
    String applyoffpostDateTo = request.getParameter("arg7");
	String partyId = request.getParameter("arg5");
	StringBuffer param=new StringBuffer();
    param.append("arg1=").append(socialUnitId).append(";");
    if(custId!=null&&custId!=""){
	    param.append("arg2=").append(custId).append(";");
    }
    if(hireHandleDateFrom!=null&&hireHandleDateFrom!=""){
        param.append("arg3=").append(hireHandleDateFrom).append(";");
    }
    if(hireHandleDateTo!=null&&hireHandleDateTo!=""){
        param.append("arg4=").append(hireHandleDateTo).append(";");
    }
    param.append("arg5=").append(partyId).append(";");
    if(applyoffpostDateFrom!=null&&applyoffpostDateFrom!=""){
        param.append("arg6=").append(applyoffpostDateFrom).append(";");
    }
    if(applyoffpostDateTo!=null&&applyoffpostDateTo!=""){
        param.append("arg7=").append(applyoffpostDateTo).append(";");
    }
%>
<jsp:include page="toolbar.jsp" flush="false" />
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
