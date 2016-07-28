<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.fireProve_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function rtnFuncCustomer(arg){
        var lookup = $id("cust_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        return false;
    }
    
    function submit_onClick(){
        var social_unit_id = document.form.social_unit_id.value;
        var selectedEnt = $id("com2").getSelectEntity();
        var is_indie_bd = selectedEnt.getProperty("is_indie_bd");
        var cust_id = document.form.cust_id.value;
        var fire_handle_date_from = document.form.fire_handle_date_from.value;
        var fire_handle_date_to = document.form.fire_handle_date_to.value;
        var apply_offpost_date_from = document.form.apply_offpost_date_from.value;
        var apply_offpost_date_to = document.form.apply_offpost_date_to.value;
        var party_id = document.form.party_id.value;
        if(social_unit_id == null || social_unit_id == ""){
            alert("<fmt:message key='fireProve0000'/>");
            return;
        }
        if(is_indie_bd == "1"){
            if(cust_id == null || cust_id == ""){
                alert("<fmt:message key='fireProve0001'/>");
                return;
            }else{
                var url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showFireSingleReport.jsp?raq=report_tuigong_WDdanlihu.raq&arg1="+social_unit_id+"&arg2="+cust_id+"&arg3="+fire_handle_date_from+"&arg4="+fire_handle_date_to+"&arg5="+party_id+"&arg6="+apply_offpost_date_from+"&arg7="+apply_offpost_date_to;
            }
        }else if(is_indie_bd == "0"){
            var url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showFireSingleReport.jsp?raq=report_tuigong_WDdaku.raq&arg1="+social_unit_id+"&arg2="+cust_id+"&arg3="+fire_handle_date_from+"&arg4="+fire_handle_date_to+"&arg5="+party_id+"&arg6="+apply_offpost_date_from+"&arg7="+apply_offpost_date_to;
        }else{
            alert("<fmt:message key='fireProve0002'/>");
            return;
        }
        window['returnValue'] = [url];
        window.close();
       window.opener.callBack_fireProve(url);
    }
    
</script>
</head>
<body>
 
<form name="form" method="post">
<input type="hidden" name="party_id" id="party_id" value="<%=RmJspHelper.getParty_idFromRequest(request) %>"/>
<div id="right">
<div class="ringht_s">
<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
   <tr>
    <td class="td_1"><fmt:message key='fireProve0003'/></td>
    <td class="td_2">
        <r:comboSelect id="com2"  name="social_unit_id"
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                nullText=""
                width="210px">
            </r:comboSelect> 
    </td>
    <td class="td_1"><fmt:message key='fireProve0005'/></td>
    <td class="td_2">
        <w:lookup readonly="true" id="cust_id" validateAttr="allowNull=false;" name="cust_id"
            lookupUrl="/CustomersimpleAction.do?cmd=queryCustomerData" 
            messagekey="fireProve0006" height="500" width="810"  onReturnFunc="rtnFuncCustomer" style="width:210px"/>
    </td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='fireProve0007'/></td>
    <td class="td_2">
        <w:date id="fire_handle_date_from" name="fire_handle_date_from" format="YYYY-MM-DD" width="80px" />&nbsp;<fmt:message key='fireProve0008'/>&nbsp;<w:date id="fire_handle_date_to" name="fire_handle_date_to" format="YYYY-MM-DD" width="80px" />   
    </td>
    <td class="td_1"><fmt:message key='fireProve0009'/></td>
    <td class="td_2">
        <w:date id="apply_offpost_date_from" name="apply_offpost_date_from" format="YYYY-MM-DD" width="80px" />&nbsp;<fmt:message key='fireProve0008'/>&nbsp;<w:date id="apply_offpost_date_to" name="apply_offpost_date_to" format="YYYY-MM-DD" width="80px" />   
    </td>
  </tr>
    </table>
</div>
    
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key='fireProve0011'/>'  onclick="javascript:submit_onClick();" />
</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</fmt:bundle>
</html>
