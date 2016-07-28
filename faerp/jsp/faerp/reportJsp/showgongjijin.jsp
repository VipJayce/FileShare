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
   // System.out.println("report_type_db:"+report_type_bd);
    String security_group_id = request.getParameter("arg1");
    String fund_month = request.getParameter("arg2");
    String social_unit_id = request.getParameter("arg3");
    String cust_id = request.getParameter("arg4");
    String user_id=request.getParameter("arg6");
    String user_name=request.getParameter("arg7");
    String user_namez = request.getParameter("arg8");
    String user_namek = request.getParameter("arg9");
    String lastmonth=request.getParameter("lastmonth");
    String  title=request.getParameter("title");
    String customer_name=(String)request.getParameter("customer_name");
    String isIndieBd=(String)request.getParameter("isIndieBd");
    if(null==customer_name||"".equals(customer_name)||customer_name=="null"){
        customer_name="";
    }
    String accounts=request.getParameter("accounts");
    String role_type = request.getParameter("role_type");//社保公积金类型
    //System.out.println("role_type:"+role_type);
    String rpt_create_id = request.getParameter("rpt_create_id");//报表批次号
    if(null==accounts||"".equals(accounts)||accounts=="null"){
        accounts="";
    }
    //String transact_date_from = request.getParameter("arg5");
    //String transact_date_to = request.getParameter("arg6");
    StringBuffer param=new StringBuffer();
    if(report_type_bd.equals("3")){
        param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5="      ).append(fund_month.substring(0,4)+"     年"+fund_month.substring(4)+"       月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("arg9=").append(user_namek).append(";");
       
        param.append("title=").append(title).append(";");
        param.append("customer_name=").append(customer_name).append(";");
        param.append("accounts=").append(accounts).append(";");
        param.append("role_type_bd=").append("6").append(";");
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
        param.append("title=").append(title).append(";");
        param.append("customer_name=").append(customer_name).append(";");
        param.append("accounts=").append(accounts).append(";");
        param.append("role_type_bd=").append("6").append(";");
        param.append("isIndieBd=").append(isIndieBd).append(";");
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
        param.append("customer_name=").append(customer_name).append(";");
        param.append("accounts=").append(accounts).append(";");
        param.append("role_type_bd=").append("6").append(";");

    }else if(report_type_bd.equals("1")){
        param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5="      ).append(fund_month.substring(0,4)+"     年"+fund_month.substring(4)+"      月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("arg9=").append(user_namek).append(";");
        param.append("title=").append(title).append(";");
        param.append("customer_name=").append(customer_name).append(";");
        param.append("accounts=").append(accounts).append(";");
       
        
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
        param.append("title=").append(title).append(";");
        param.append("customer_name=").append(customer_name).append(";");
        param.append("accounts=").append(accounts).append(";");
        param.append("role_type_bd=").append("6").append(";");
        param.append("isIndieBd=").append(isIndieBd).append(";");
 
        
    }else if(report_type_bd.equals("11")){
        param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5=").append(fund_month.substring(0,4)+"年"+fund_month.substring(4)+"月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("arg9=").append(user_namek).append(";");
        param.append("customer_name=").append(customer_name).append(";");
        param.append("accounts=").append(accounts).append(";");
        param.append("arg10=").append(lastmonth).append(";");
        if("1".equals(role_type)){
            param.append("role_type_bd=").append("5").append(";");
        }else if("2".equals(role_type)){
            param.append("role_type_bd=").append("6").append(";");
        }
        param.append("rpt_create_id=").append(rpt_create_id).append(";");
    }
    else{
     
        param.append("arg1=").append(fund_month).append(";");
        param.append("arg2=").append(security_group_id).append(";");
        param.append("arg3=").append(social_unit_id).append(";");
        param.append("arg4=").append(cust_id).append(";");
        param.append("arg5=").append(fund_month.substring(0,4)+"年"+fund_month.substring(4)+"月").append(";");
        param.append("arg6=").append(user_id).append(";");
        param.append("arg7=").append(user_name).append(";");
        param.append("arg8=").append(user_namez).append(";");
        param.append("arg9=").append(user_namek).append(";");
        param.append("customer_name=").append(customer_name).append(";");
        param.append("accounts=").append(accounts).append(";");
        param.append("arg10=").append(lastmonth).append(";");
        //System.out.println("role_type:"+role_type);
        if("1".equals(role_type)){
            if("".equals(user_namez)){
                param.append("role_type_bd=").append("").append(";");
            }else{
                param.append("role_type_bd=").append("5").append(";");
            }
        }else if("2".equals(role_type)){
            /****edit by lvj***/
            //if("".equals(user_namez)){
              //  param.append("role_type_bd=").append("").append(";");
            //}else{
              //  param.append("role_type_bd=").append("6").append(";");
           // }
            param.append("role_type_bd=").append("6").append(";");
        }
        param.append("rpt_create_id=").append(rpt_create_id).append(";");
        
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
