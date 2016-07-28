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
    String report_type_bd = request.getParameter("report_type_bd");
    String flag = request.getParameter("flag");
    String start_date = request.getParameter("start_date");
    String end_date = request.getParameter("end_date");
    String debt_amount = request.getParameter("debt_amount");
    StringBuffer param=new StringBuffer();
    if(flag.equals("1")){
        param.append("start_date=").append(start_date).append(";");
        param.append("end_date=").append(end_date).append(";");
        param.append("debt_amount=").append(debt_amount).append(";");
        //param.append("report_date=").append(start_date.substring(0,4)+"年"+start_date.substring(5,7)+"月"+start_date.substring(8)+"日--"+end_date.substring(0,4)+"年"+end_date.substring(5,7)+"月"+end_date.substring(8)+"日");
        param.append("report_type_bd=").append(report_type_bd);
    }else if(flag.equals("2")){
        param.append("start_date=").append(start_date).append(";");
        param.append("end_date=").append(end_date).append(";");
        param.append("report_type_bd=").append(report_type_bd);
    }else if(flag.equals("3")){
        param.append("start_date=").append(start_date).append(";");
        param.append("end_date=").append(end_date).append(";");
        param.append("report_type_bd=").append(report_type_bd);
    }
%>
<jsp:include page="toolbar.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>

        <report:html name="report1" reportFileName="<%=report%>"
            funcBarLocation="top"
            needPageMark="yes"
            scrollWidth="900"
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
