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
    String start_yearmonth = request.getParameter("start_yearmonth");
    String end_yearmonth = request.getParameter("end_yearmonth");
    String login_userid = request.getParameter("login_userid");
    String cust_id = request.getParameter("cust_id");
    String emp_code = request.getParameter("emp_code");
    String emp_name = request.getParameter("emp_name");
    System.out.println(emp_name);
    StringBuffer param=new StringBuffer();
    
    param.append("start_yearmonth=").append(start_yearmonth).append(";");
    param.append("end_yearmonth=").append(end_yearmonth).append(";");
    param.append("cust_id=").append(cust_id).append(";");
    param.append("emp_code=").append(emp_code).append(";");
    param.append("emp_name=").append(emp_name).append(";");
    param.append("login_userid=").append(login_userid).append(";");
%>
<jsp:include page="toolbar.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>

        <report:html name="report1" reportFileName="<%=report%>"
            funcBarLocation="top"
            needPageMark="yes"
            scrollWidth="1200"
            scrollHeight="540"
            needScroll="yes"
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
