<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>

<html>
<link type="text/css" href="<%=request.getContextPath()%>/jsp/faerp/reportJsp/css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
    request.setCharacterEncoding( "utf-8" );

    String report = request.getParameter( "raq" );
    String emp_code = request.getParameter("emp_code");
    String emp_name = request.getParameter("emp_name");
    String cust_id = request.getParameter("customer_id");
    String cust_code = request.getParameter("customer_code");
    String agent_id = request.getParameter("agent_id");
    String agent_code = request.getParameter("agent_code");
    
    StringBuffer param=new StringBuffer();

    param.append("v_emp_code=").append(emp_code).append(";");
    param.append("v_emp_name=").append(emp_name).append(";");
    param.append("v_cust_id=").append(cust_id).append(";");
    param.append("v_cust_code=").append(cust_code).append(";");
    param.append("v_agent_id=").append(agent_id).append(";");
    param.append("v_agent_code=").append(agent_code).append(";");
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
