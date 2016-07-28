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
	String report = "/hz/"+request.getParameter( "raq" );//�����ļ�����
	String s_group = request.getParameter("s_group");//�籣/��������
	String yearmonth = request.getParameter("yearmonth");//������
	String s_unit = request.getParameter("s_unit");//��������
	String cust_id = request.getParameter("cust_id");//�ͻ����
	String date1 = request.getParameter("date1");//����12��18:00
    String date2 = request.getParameter("date2");//����12��18:00
    String date3 = request.getParameter("date3");//����1��
	StringBuffer param=new StringBuffer();
	param.append("s_group=").append(s_group).append(";");
	param.append("yearmonth=").append(yearmonth).append(";");
	param.append("s_unit=").append(s_unit).append(";");
	param.append("cust_id=").append(cust_id).append(";");
	param.append("date1=").append(date1).append(";");
	param.append("date2=").append(date2).append(";");
	param.append("date3=").append(date3).append(";");
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
    //���÷�ҳ��ʾֵ
    
    document.getElementById( "t_page_span" ).innerHTML=report1_getTotalPage();
    document.getElementById( "c_page_span" ).innerHTML=report1_getCurrPage();

</script>
</body>
</html>
