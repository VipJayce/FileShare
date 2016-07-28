<%@ page contentType="text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
    request.setCharacterEncoding( "GBK" );
    String report = request.getParameter( "raq" );
    String billId = request.getParameter("arg1");
    StringBuffer param=new StringBuffer();
    param.append("arg1=").append(billId).append(";");
    %>
<jsp:include page="toolbar2.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>
        <report:html name="report1" reportFileName="<%=report%>"
            funcBarLocation="top"
            needPageMark="yes"
            generateParamForm="no"
            params="<%=param.toString()%>"
            needPivot="yes"
            pivotLabel=""
            exceptionPage="/reportJsp/myError2.jsp"
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
