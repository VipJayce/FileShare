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
    String report_type_bd = request.getParameter("arg5");
    StringBuffer param=new StringBuffer();
    if(report_type_bd.equals("10")){
        param.append("arg1=").append( request.getParameter("arg1")).append(";");
        param.append("arg2=").append( request.getParameter("arg2")).append(";");
        param.append("arg3=").append( request.getParameter("emp_post_id")).append(";");
    	if(request.getParameter("join_date") != null){
        	param.append("join_date=").append(request.getParameter("join_date")).append(";");
    	}
    	if(request.getParameter("file_now") != null){
    		request.setCharacterEncoding( "UTF-8" );
    		String file_now = request.getParameter("file_now");
    		file_now  = new String(file_now.getBytes("UTF-8"),"GBK");
        	param.append("file_now=").append(request.getParameter("file_now")).append(";");
    
    	}
    }
%>
<jsp:include page="toolbartaoda.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>

        <report:html name="report1" reportFileName="<%=report%>"
          submit="  "
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
