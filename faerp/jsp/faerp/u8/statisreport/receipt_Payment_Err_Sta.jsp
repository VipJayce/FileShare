<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>
<html>
<%
String login_user_id= RmJspHelper.getParty_idFromRequest(request);
//String login_user_name="";
//LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
//if(null!=loginVo){
    //login_user_name=loginVo.getName();
  //}
%>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收付款异常统计</title>

<script language="javascript">

    function clearId(){
        var lookup = $id("cust_name1");
        lookup.value = '';
        lookup.setDisplayValue('');
        document.form.cust_id.value='';
     }
     
     function rtnFuncCustomer(arg){
            var lookup = $id("cust_name1");
            lookup.value = arg[0];
            lookup.displayValue = arg[2];
            document.form.cust_id.value=arg[0];
            //var security_group_id = document.form.security_group_id.value;
            getfundmonth();
            //reloadAlldate(security_group_id);
            return false;
        }

    function exportEXCEL_onClick(){
        var start_date = document.getElementById("start_date").value;
        var end_date = document.getElementById("end_date").value;
        var report_type = document.getElementById("report_type").value; 
        var cust_id = document.getElementById("cust_name1").value;
        var emp_code = document.getElementById("emp_code").value;
        var emp_name = document.getElementById("emp_name").value;
        var raq = "";
        
        var url="";
        
        if(start_date==null || start_date==""){
            alert("统计起始年月不能为空！");
            return;
        }
        if(end_date==null || end_date==""){
            alert("统计截止年月不能为空！");
            return;
        }
        if(start_date>end_date){
            alert("统计起始年月不能大于统计截止年月！");
            return;
        }
        if(report_type==null || report_type==""){
            alert("请选择报表类型！");
            return ;
        }else{
            if(report_type=="1"){
                if(cust_id==null || cust_id==""){
                    alert("请选择客户！");
                     return ;
                 }
                raq="RECEIPT_PAYMENT_ERR_STA1.raq";                
            }else if(report_type=="2"){
                raq="RECEIPT_PAYMENT_ERR_STA2.raq";
            }else if(report_type=="3"){
                 if(cust_id==null || cust_id==""){
                    alert("请选择客户！");
                     return ;
                 }
                raq="RECEIPT_PAYMENT_ERR_STA3.raq";
            }else if(report_type=="4"){
                if(cust_id==null || cust_id==""){
                    alert("请选择客户！");
                     return ;
                 }
                raq="RECEIPT_PAYMENT_ERR_STA4.raq";
            }
            
        }
        
        url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showReceipt_Payment_Err_Sta.jsp?raq="+raq+"&start_yearmonth="+start_date+"&end_yearmonth="+end_date+"&cust_id="+cust_id+"&emp_code="+emp_code+"&emp_name="+encodeURIComponent(emp_name)+"&login_userid=<%=login_user_id%>";

        //$id("datacell_formid").action=url;
        //$id("datacell_formid").submit();
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
        
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<script language="javascript">
       writeTableTopFesco('收付异常统计','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title">报表</div>
            <!--表格1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1">统计起始年月</td>
                    <td class="td_2">
                      <input type="text" class="text_field" id="start_date" name="start_date" inputName="起始年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                    </td>
                    <td class="td_1">统计截止年月</td>
                    <td class="td_2">
                      <input type="text" class="text_field" id="end_date" name="start_date" inputName="截止年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                    </td>
                </tr>
                <tr>
                    <td class="td_1">客户</td>
                    <td class="td_2">
                       <input type="hidden" name="cust_id" id="cust_id" value="">
                           <w:lookup onReturnFunc="rtnFuncCustomer" id="cust_name1" name="cust_name1"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            dialogTitle="选择客户" height="440" width="600" ondblclick="clearId();"  style="width:170px"/><font color="red">双击清空</font>
                    </td>
                    <td class="td_1">报表类型</td>
                    <td class="td_2">
                        <select id="report_type" name="report_type" >
                            <option value="1">公司账户收付情况统计</option>
                            <option value="2">公司账户收付汇总表</option>
                            <option value="3">个人账户收付情况统计</option>
                            <option value="4">员工代收付负数汇总表</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="td_1">员工编码</td>
                    <td class="td_2">
                           <input type="text" class="text_field" id="emp_code" name="emp_code" inputName="员工编码" />
                    </td>
                    <td class="td_1">员工名称</td>
                    <td class="td_2">
                       <input type="text" class="text_field" id="emp_name" name="emp_name" inputName="员工名称" />
                    </td>
                </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();">导出报表</a>
            </div>
            <!--表格1 end--></div>
            </td>
        </tr>
    </table>
    </form>
</fmt:bundle>
</body>
</html>
