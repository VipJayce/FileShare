<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>

<%@page import="rayoo.finance.receivable.MyUtils"%>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	request.setCharacterEncoding( "utf-8" );
	String report = request.getParameter( "raq" );
	String socialUnitId = request.getParameter("arg1");
	String custId = request.getParameter("arg2");
	String hireHandleDateFrom = request.getParameter("arg3");
	String hireHandleDateTo = request.getParameter("arg4");
	String applyonpostDateFrom = request.getParameter("arg6");
    String applyonpostDateTo = request.getParameter("arg7");
	String partyId = request.getParameter("arg5");
	String emp_name = request.getParameter("arg8");
	String emp_code = request.getParameter("arg9");
	String id_card = request.getParameter("arg10");
	String classify_date_from = request.getParameter("arg11");
	String classify_date_to = request.getParameter("arg12");
	String service_status = request.getParameter("arg13");
	String big_name = request.getParameter("arg14");
	String hire_fire_status_bd = request.getParameter("arg15");
	String cust_name = request.getParameter("arg16");
	String social_unit = request.getParameter("arg17");
	String company_id = request.getParameter("arg18");
	StringBuffer param=new StringBuffer();
    param.append("arg1=").append(socialUnitId).append(";");
    if(custId!=null&&custId!=""){
	    param.append("arg2=").append(custId).append(";");
    }
    if(hireHandleDateFrom!=null&&hireHandleDateFrom!=""){
        param.append("arg3=").append(hireHandleDateFrom).append(";");
    }
    if(hireHandleDateTo!=null&&hireHandleDateTo!=""){
        param.append("arg4=").append(hireHandleDateTo).append(";");
    }
    param.append("arg5=").append(partyId).append(";");
    if(applyonpostDateFrom!=null&&applyonpostDateFrom!=""){
        param.append("arg6=").append(applyonpostDateFrom).append(";");
    }
    if(applyonpostDateTo!=null&&applyonpostDateTo!=""){
        param.append("arg7=").append(applyonpostDateTo).append(";");
    }
    if(!MyUtils.isNull(emp_name)){
        param.append("arg8=").append(emp_name).append(";");
    }
    if(!MyUtils.isNull(emp_code)){
        param.append("arg9=").append(emp_code).append(";");
    }
    if(!MyUtils.isNull(id_card)){
        param.append("arg10=").append(id_card).append(";");
    }
    if(!MyUtils.isNull(classify_date_from)){
        param.append("arg11=").append(classify_date_from).append(";");
    }
    if(!MyUtils.isNull(classify_date_to)){
        param.append("arg12=").append(classify_date_to).append(";");
    }
    if(!MyUtils.isNull(service_status)){
        param.append("arg13=").append(service_status).append(";");
    }
    if(!MyUtils.isNull(big_name)){
        param.append("arg14=").append(big_name).append(";");
    }
    if(!MyUtils.isNull(hire_fire_status_bd)){
        param.append("arg15=").append(hire_fire_status_bd).append(";");
    }
    if(!MyUtils.isNull(cust_name)){
        param.append("arg16=").append(cust_name).append(";");
    }
    if(!MyUtils.isNull(social_unit)){
        param.append("arg17=").append(social_unit).append(";");
    }
    if(!MyUtils.isNull(company_id)){
        param.append("arg18=").append(company_id).append(";");        
    }
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
