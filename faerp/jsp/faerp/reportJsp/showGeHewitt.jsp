<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>

<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	request.setCharacterEncoding( "utf-8" );
	String report = request.getParameter( "raq" );
	String cust_id = request.getParameter("arg1");
	String costCenterId = request.getParameter("arg2");
	String yearMonth = request.getParameter("arg3");
    String b_yearhMonth = request.getParameter("arg4");

	StringBuffer param=new StringBuffer();
	param.append("arg1=").append(cust_id).append(";");
    param.append("arg2=").append(costCenterId).append(";");
    param.append("arg3=").append(yearMonth).append(";");
    param.append("arg4=").append(b_yearhMonth).append(";");
    param.append("arg5=").append("1099110200000000005").append(";");
    param.append("arg6=").append("1099110200000000006").append(";");
    param.append("arg7=").append("1099110200000000007").append(";");
    param.append("arg8=").append("1099110200000000008").append(";");
    param.append("arg9=").append("1099110200000000009").append(";");
    param.append("arg10=").append("1099110200000000010").append(";");
    param.append("arg11=").append("1099110200000000014").append(";");
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
