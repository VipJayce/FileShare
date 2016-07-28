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
    String start_date = request.getParameter("start_date");
    String end_date = request.getParameter("end_date");
    String rpt_date = "";
    if(start_date!=null && !"".equals(start_date)){
        rpt_date = start_date.substring(0,4)+"年"+start_date.substring(5,7)+"月"+start_date.substring(8)+"日--"+end_date.substring(0,4)+"年"+end_date.substring(5,7)+"月"+end_date.substring(8)+"日";
    }
    System.out.println("rpt_date:"+rpt_date);
    StringBuffer param=new StringBuffer();
    //if(report_type_bd.equals("0")){
        
   // }else if(report_type_bd.equals("1")){
        
    //}else if(report_type_bd.equals("2")){
        
    //}else if(report_type_bd.equals("3")){
    //    param.append("arg1=").append(start_date).append(";");
    //    param.append("arg2=").append(end_date).append(";");
    //}
     param.append("arg1=").append(start_date).append(";");
     param.append("arg2=").append(end_date).append(";");
     param.append("arg3=").append(rpt_date).append(";");
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
