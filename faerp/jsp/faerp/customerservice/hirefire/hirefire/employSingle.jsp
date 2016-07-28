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
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.employSingle_resource' prefix='auto.'>
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
        var hire_handle_date_from = document.form.hire_handle_date_from.value;
        var hire_handle_date_to = document.form.hire_handle_date_to.value;
        var apply_onpost_date_from = document.form.apply_onpost_date_from.value;
        var apply_onpost_date_to = document.form.apply_onpost_date_to.value;
        var people_type = document.form.people_type.value;
        var party_id = document.form.party_id.value;
        var company_id = document.form.company_id.value;
        if(social_unit_id == null || social_unit_id == ""){
            alert("<fmt:message key='employSingle0005'/>必须选择！");
            return;
        }
        if(is_indie_bd == "1"){
            if(cust_id == null || cust_id == ""){
                alert("<fmt:message key='employSingle0001'/>");
                return;
            }
        }
        if(people_type == null || people_type == ""){
            alert("<fmt:message key='employSingle0011'/>必须选择！");
            return;
        }else{
            if(people_type == "1"){
                if(is_indie_bd == "1"){
                    var url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showHireSingleReport.jsp?raq=report_hiresingle_SHdanlihu.raq&arg1="+social_unit_id+"&arg2="+cust_id+"&arg3="+hire_handle_date_from+"&arg4="+hire_handle_date_to+"&arg5="+party_id+"&arg6="+apply_onpost_date_from+"&arg7="+apply_onpost_date_to+"&arg18="+company_id;
                }else if(is_indie_bd == "0"){
                    var url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showHireSingleReport.jsp?raq=report_hiresingle_SHdaku.raq&arg1="+social_unit_id+"&arg2="+cust_id+"&arg3="+hire_handle_date_from+"&arg4="+hire_handle_date_to+"&arg5="+party_id+"&arg6="+apply_onpost_date_from+"&arg7="+apply_onpost_date_to+"&arg18="+company_id;
                }else{
                    alert("<fmt:message key='employSingle0005'/>数据错误！");
                }
            }else if(people_type == "2"){
                if(is_indie_bd == "1"){
                    var url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showHireSingleReport.jsp?raq=report_hiresingle_WDdanlihu.raq&arg1="+social_unit_id+"&arg2="+cust_id+"&arg3="+hire_handle_date_from+"&arg4="+hire_handle_date_to+"&arg5="+party_id+"&arg6="+apply_onpost_date_from+"&arg7="+apply_onpost_date_to+"&arg18="+company_id;
                }else if(is_indie_bd == "0"){
                    var url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showHireSingleReport.jsp?raq=report_hiresingle_WDdaku.raq&arg1="+social_unit_id+"&arg2="+cust_id+"&arg3="+hire_handle_date_from+"&arg4="+hire_handle_date_to+"&arg5="+party_id+"&arg6="+apply_onpost_date_from+"&arg7="+apply_onpost_date_to+"&arg18="+company_id;
                }else{
                    alert("<fmt:message key='employSingle0005'/>数据错误！");
                }
            }
            window['returnValue'] = [encodeURI(url)];
            window.close();
            window.opener.callBack_toEmploySingle(url);
        }
    }
    
</script>
</head>
<body>
 
<form name="form" method="post">
<input type="hidden" name="party_id" id="party_id" value="<%=RmJspHelper.getParty_idFromRequest(request) %>"/>
<input type="hidden" name="company_id" id="company_id" value="${company_id }">
<div id="right">
<div class="ringht_s">
<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
   <tr>
    <td class="td_1"><fmt:message key='employSingle0005'/></td>
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
    <td class="td_1"><fmt:message key='employSingle0007'/></td>
    <td class="td_2">
        <w:lookup readonly="true" id="cust_id" validateAttr="allowNull=false;" name="cust_id"
            lookupUrl="/CustomersimpleAction.do?cmd=queryCustomerData" 
            messagekey="employSingle0008" height="500" width="810"  onReturnFunc="rtnFuncCustomer" style="width:210px"/>
    </td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='employSingle0009'/></td>
    <td class="td_2">
        <w:date id="hire_handle_date_from" name="hire_handle_date_from" format="YYYY-MM-DD" width="80px" />&nbsp;<fmt:message key='employSingle0010'/>&nbsp;<w:date id="hire_handle_date_to" name="hire_handle_date_to" format="YYYY-MM-DD" width="80px" />   
    </td>
    <td class="td_1"><fmt:message key='employSingle0011'/></td>
    <td class="td_2">
        <select id="people_type" name="people_type" >
           <option value="1"><fmt:message key='employSingle0012'/></option>
           <option value="2"><fmt:message key='employSingle0013'/></option>
        </select>
    </td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='employSingle0014'/></td>
    <td class="td_2" colspan="3">
        <w:date id="apply_onpost_date_from" name="apply_onpost_date_from" format="YYYY-MM-DD" width="80px" />&nbsp;<fmt:message key='employSingle0010'/>&nbsp;<w:date id="apply_onpost_date_to" name="apply_onpost_date_to" format="YYYY-MM-DD" width="80px" />   
    </td>
    
  </tr>
  
    </table>
</div>
    
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key='employSingle0016'/>'  onclick="javascript:submit_onClick();" />
</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</fmt:bundle>
</html>
