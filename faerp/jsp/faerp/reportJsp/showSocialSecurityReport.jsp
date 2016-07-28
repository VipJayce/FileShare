<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.runqian.report4.usermodel.Context"%>

<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
	//request.setCharacterEncoding( "GBK" );
	String report = request.getParameter( "raq" );//报表文件名称
	String report_type_bd = request.getParameter("arg5");//报表类型
	String security_group_id = request.getParameter("arg1");//社保/公积金组
	String fund_month = request.getParameter("arg2");//报表月
	String social_unit_id = request.getParameter("arg3");//福利办理方
	String cust_id = request.getParameter("arg4");//客户编号
	String user_id = request.getParameter("arg6");//登录用户ID
	String user_name = request.getParameter("arg7");//用户名
	String user_namez = request.getParameter("arg8");//专管员ID
	String user_namek = request.getParameter("arg9");//客服ID
	String rpt_create_id = request.getParameter("rpt_create_id");//报表批次号
	String role_type = request.getParameter("role_type");//社保公积金类型
    	
	String title = request.getParameter("title");//
	String isIndieBd = request.getParameter("isIndieBd");//
	String open_unit = request.getParameter("open_unit");//开户单位名称
	StringBuffer param=new StringBuffer();
	if(report_type_bd.equals("3")){
	    param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5=").append(fund_month.substring(0,4)+"年"+fund_month.substring(4)+"月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("arg9=").append(user_namek).append(";");
        param.append("role_type_bd=").append("5").append(";");
        param.append("title=").append(title).append(";");
	}else if(report_type_bd.equals("4")){
	    param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5=").append(fund_month.substring(0,4)+"年"+fund_month.substring(4)+"月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("arg9=").append(user_namek).append(";");
        param.append("role_type_bd=").append("5").append(";");
        param.append("title=").append(title).append(";");
    }else if(report_type_bd.equals("6")){
        param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5=").append(fund_month.substring(0,4)+"年"+fund_month.substring(4)+"月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("arg9=").append(user_namek).append(";");
        if("1".equals(role_type)){
            if("".equals(user_namez)){
                param.append("role_type_bd=").append("").append(";");
            }else{
                param.append("role_type_bd=").append("5").append(";");
            }
        }else if("2".equals(role_type)){
            if("".equals(user_namez)){
                param.append("role_type_bd=").append("").append(";");
            }else{
                param.append("role_type_bd=").append("6").append(";");
            }
        }
        param.append("rpt_create_id=").append(rpt_create_id).append(";");
        param.append("title=").append(title).append(";");

	}else if(report_type_bd.equals("1")){
	    param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5=").append(fund_month.substring(0,4)+"年"+fund_month.substring(4)+"月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("role_type_bd=").append("5").append(";");
        param.append("title=").append(title).append(";");
        param.append("isIndieBd=").append(isIndieBd).append(";");
        
	}else if(report_type_bd.equals("2")){
	    param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5=").append(fund_month.substring(0,4)+"年"+fund_month.substring(4)+"月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("arg9=").append(user_namek).append(";");
        param.append("role_type_bd=").append("5").append(";");
        param.append("title=").append(title).append(";");
    }else if(report_type_bd.equals("10")){
        param.append("arg1=").append( request.getParameter("arg1")).append(";");
        param.append("arg2=").append( request.getParameter("arg2")).append(";");
        param.append("arg3=").append( request.getParameter("arg7")).append(";");
        param.append("arg4=").append( request.getParameter("arg6")).append(";");
        param.append("arg5=").append( request.getParameter("arg8")).append(";");
        param.append("open_unit=").append( request.getParameter("open_unit")).append(";");
        
    }
%>
<jsp:include page="toolbarExcel.jsp" flush="false" />
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
