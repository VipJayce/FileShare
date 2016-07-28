<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	request.setCharacterEncoding( "utf-8" );
	String report = request.getParameter( "raq" );
	String imp_id = request.getParameter("imp_id");
	StringBuffer param=new StringBuffer();
    if(imp_id!=null&&imp_id!=""){
	    param.append("imp_id=").append(imp_id).append(";");
    }
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
