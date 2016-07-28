<%@ page contentType="text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
    request.setCharacterEncoding( "GBK" );
    String report = request.getParameter( "raq" );
    String reporttype = request.getParameter( "reporttype" );
    String arg1 = request.getParameter("arg1");
    String arg2 = request.getParameter("arg2");
    String arg3 = request.getParameter("arg3");
    
    StringBuffer param=new StringBuffer();
    //本月工作汇报
    if(reporttype != null&&reporttype.equals("1")){
	    if(arg1 != null&&!arg1.equals("")&&!arg1.equals("null")){
	        param.append("arg1=").append(arg1).append(";") ;
	    }
	    if(arg2 != null&&!arg2.equals("")&&!arg2.equals("null")){
	        param.append("arg2=").append(arg2).append(";") ;
	    }
	    if(arg3 != null&&!arg3.equals("")&&!arg3.equals("null")){
            param.append("arg3=").append(arg3.trim()).append(";") ;
        }
    }
    //福利办理明细
    else if (reporttype!=null&&reporttype.equals("2")){
        if(arg1 != null&&!arg1.equals("")&&!arg1.equals("null")){
            param.append("arg1=").append(arg1).append(";") ;
        }
        if(arg2 != null&&!arg2.equals("")&&!arg2.equals("null")){
            param.append("arg2=").append(arg2).append(";") ;
        }
        if(arg3 != null&&!arg3.equals("")&&!arg3.equals("null")){
            param.append("arg3=").append(arg3.trim()).append(";") ;
        }
    }
    
    %>
<jsp:include page="toolbar.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>
        <report:html name="report1" reportFileName="<%=report%>"
            funcBarLocation="top"
            needPageMark="yes"
            generateParamForm="no"
            params="<%=param.toString()%>"
            needPivot="yes"
            pivotLabel=""
            exceptionPage="/jsp/faerp/reportJsp/myError2.jsp"
            appletJarName="runqianReport4Applet.jar,dmGraphApplet.jar"
            pageMarkLabel=""
            textDataLineBreak="\r\n"
            width="-1"
        />

</table>

<script language="javascript">
    //设置分页显示值
    document.getElementById( "t_page_span" ).innerHTML=report1_getTotalPage();
    document.getElementById( "c_page_span" ).innerHTML=report1_getCurrPage() ;
</script>
</body>
</html>
