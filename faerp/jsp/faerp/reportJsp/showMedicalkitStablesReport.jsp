<%@ page contentType="text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>

<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	request.setCharacterEncoding( "GBK" );
	String report = request.getParameter( "raq" );
	String cust_id = request.getParameter("arg1");
	String create_date_from = request.getParameter("arg2");
	String create_date_to = request.getParameter("arg3");
	
	StringBuffer param=new StringBuffer();
    param.append("arg1=").append(cust_id).append(";");
    param.append("arg2=").append(create_date_from).append(";");
    param.append("arg3=").append(create_date_to).append(";");
%>
<jsp:include page="toolbar.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>

		<report:html name="report1" reportFileName="<%=report%>"
			funcBarLocation="top"
			needPageMark="yes"
			generateParamForm="no"
			params="<%=param.toString()%>"
			exceptionPage="/reportJsp/myError2.jsp"
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
