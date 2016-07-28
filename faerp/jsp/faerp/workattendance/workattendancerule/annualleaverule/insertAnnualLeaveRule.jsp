<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>年假规则新增</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    function vailform(){
        var  custId = jQuery("#cust_id").val();
        if(!custId){
            alert("请选择客户");
            return false;
        }
        
        var  annualleaveyear = jQuery("#annualleaveyear").val();
        if(!annualleaveyear || isNaN(annualleaveyear)){
            alert("请正确输入年份");
            jQuery("#annualleaveyear").focus();
            return false;
        }
        
        var  annualleavedays = jQuery("#annualleavedays").val();
        if(!annualleavedays || isNaN(annualleavedays)){
            alert("法定年假天数必须为整数");
            jQuery("#annualleavedays").focus();
            return false;
        }
        
        var  c_annualleavedays = jQuery("#c_annualleavedays").val();
        if(!c_annualleavedays || isNaN(c_annualleavedays)){
            alert("公司福利年假天数必须为整数");
            jQuery("#c_annualleavedays").focus();
            return false;
        }
        
        var  overtimemultiple = jQuery("#overtimemultiple").val();
        if(!overtimemultiple || isNaN(overtimemultiple)){
            alert("法定加班工资倍数必须为整数");
            jQuery("#overtimemultiple").focus();
            return false;
        }
        
        var  c_overtimemultiple = jQuery("#c_overtimemultiple").val();
        if(!c_overtimemultiple || isNaN(c_overtimemultiple)){
            alert("公司福利年假加班工资倍数必须为整数");
            jQuery("#c_overtimemultiple").focus();
            return false;
        }
        
        var  takeworksstartdate = jQuery("#takeworksstartdate_input").val();
        if(!takeworksstartdate){
            alert("请输入可调休开始时间");
            jQuery("#takeworksstartdate_input").focus();
            return false;
        }
        
        var  takeworksenddate = jQuery("#takeworksenddate_input").val();
        if(!takeworksenddate){
            alert("请输入可调休结束时间");
            jQuery("#takeworksenddate_input").focus();
            return false;
        }
        
        if (parseInt(takeworksstartdate.replace(/\-/g,"")) > parseInt(takeworksenddate.replace(/\-/g,""))){
            alert("可调休开始时间必须小于可调休结束时间");
            jQuery("#takeworksenddate_input").focus();
            return false;
        }
        
        return true;
    }

    function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/AnnualLeaveRuleAction.do?cmd=update&id="+code;
            }else{
	            form.action="<%=request.getContextPath()%>/AnnualLeaveRuleAction.do?cmd=insert&id="+code;
            }
            form.submit();
       }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/AnnualLeaveRuleAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function rtnFunc(arg){
	    var lookup = $id("lk_cust");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    jQuery("#cust_id").val(arg[0]);       
	    return false;
	}
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<div class="xz_title">基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
              <td class="td_1"  width="23%" ><span style="color:red;">*</span>客户名称</td>
            <td class="td_2 " width="28%">
                <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false" displayValue="${bean.customer_name}" id="lk_cust" 
                                   lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
            </td>
            <td class="td_1" width="23%"><span style="color:red;">*</span>年份</td>
            <td class="td_2"  width="28%">
                <input type="text" class="text_field" id="annualleaveyear" name="annualleaveyear" inputName="年份" value="${bean.annualleaveyear}" maxLength="4" />
            </td>
        </tr>
		<tr>
			<td  class="td_1" width="23%" ><span style="color:red;">*</span>法定年假天数</td>
			<td  class="td_2" width="28%">
				<input type="text" class="text_field" name="annualleavedays" id="annualleavedays" inputName="法定年假天数" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.annualleavedays}"/>
			</td>
			<td  class="td_1"  width="23%" ><span style="color:red;">*</span>公司福利年假天数</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="c_annualleavedays" id="c_annualleavedays" inputName="公司福利年假天数" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.c_annualleavedays}"/>
            </td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span style="color:red;">*</span>法定加班工资倍数</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="overtimemultiple" id="overtimemultiple" inputName="法定加班工资倍数" maxLength="23" integerDigits="22" decimalDigits="0" value="${bean.overtimemultiple}"/>
            </td>
			<td  class="td_1"  width="23%" ><span style="color:red;">*</span>公司福利年假加班工资倍数</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="c_overtimemultiple" id="c_overtimemultiple" inputName="公司福利年假加班工资倍数" maxLength="23" integerDigits="22" decimalDigits="0" value="${bean.c_overtimemultiple}"/>
            </td>
		</tr>
		<tr>
			<td class="td_1"  width="23%" ><span style="color:red;">*</span>可调休开始时间</td>
			<td class="td_2 " width="28%">
				<w:date allowInput="true" id="takeworksstartdate" name="takeworksstartdate" format="YYYY-MM-DD" property="bean/takeworksstartdate" width="190px"/>         
			</td>
			<td class="td_1"  width="23%" ><span style="color:red;">*</span>可调休结束时间</td>
            <td class="td_2 " width="28%">
                <w:date allowInput="true" id="takeworksenddate" name="takeworksenddate" format="YYYY-MM-DD" property="bean/takeworksenddate" width="190px"/>       
            </td>
		</tr>
	</table>
   
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
    </div>  
</div>         
            
<input type="hidden" name="id" id="edit_id" value="${bean.id}">
<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="create_date" />
</form>
</body>
</html>
