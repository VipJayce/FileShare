<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
    request.setCharacterEncoding( "utf-8" );
    String report = request.getParameter( "raq" );
    String bill_cm = request.getParameter("arg1");//当前月
    String cust_id = request.getParameter("arg2");
    String cost_center_id = request.getParameter("arg3");
    String bill_type = request.getParameter("arg4");
    String bill_lm = request.getParameter("arg5");//上月
    StringBuffer param=new StringBuffer();
      param.append("arg1=").append(bill_cm).append(";");
      param.append("arg2=").append(cust_id).append(";");
      param.append("arg3=").append(cost_center_id).append(";");
      param.append("arg4=").append(bill_type).append(";");
      param.append("arg5=").append(bill_lm).append(";");
%>
    <input type="button" onclick="group_saveAsExcel();" value="保存报表" />
<table id="rpt" align="center"><tr><td>
        <report:group    groupFileName="<%=report%>"
            funcBarLocation="top"
            useTabControl="yes"
            needSaveAsExcel="yes"
            params="<%=param.toString()%>"
            exceptionPage="/jsp/faerp/reportJsp/myError2.jsp"
            />

</table>

</body>
</html>
