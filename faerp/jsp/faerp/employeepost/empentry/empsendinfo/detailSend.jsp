<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empentry.empsendinfo.vo.SendVo" %>
<%@ page import="rayoo.employeepost.empentry.empsendinfo.util.ISendConstants" %>
<%  //取出本条记录
    SendVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (SendVo)request.getAttribute(ISendConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.employeepost.empentry.empsendinfo.empsendinfo_resource" prefix="rayoo.employeepost.empentry.empsendinfo.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="send_detail"/></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/SendAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function contractdetail(){
        var id = document.getElementById('contract_id').value;
        form.action='<venus:base/>/SalcontractAction.do?cmd=detail&id=' + id+'&detail=detail';
        form.submit();
    }
    
    //返回
    function empGoback(){
        //document.form.action = dir_base + "/empSendListAction.do?cmd=queryAll";
        //document.form.submit();
        window.close();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
       <div id="right">

        <div class="ringht_s">
 
<div id="ccChild0" class="box_3">
 <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1"><fmt:message key="choose_contract"/></td>
          <td class="td_2" >
          <input type="text" class="text_field" readonly="readonly" value="${bean.contract_name }">
          <input type="hidden" name = "contract_id" id="contract_id" value="${bean.contract_id }">
          </td>
          <td class="td_1"><fmt:message key="customer_name"/></td>
          <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="${bean.customer_name }"></td>
          <td class="td_2"><div class="button_right">
                <ul>
                    <li class="a_1"><a href="#" onclick="contractdetail();"><fmt:message key="contract_view"/></a></li>
                </ul>
            </div></td>
        </tr>
      </table>
    </div>

 <div class="box_3">
     <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="send_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.send_name }">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cost_center_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.cost_center_name }">
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_send_name"/></td>
            <td class="td_2 ">
               <input type="text" class="text_field" readonly="readonly" value="${bean.cust_send_name }">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_rece_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.cust_rece_name }">
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_payee"/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field" readonly="readonly" value="${bean.cust_payee }">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="cust_bill"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.cust_bill }">
            </td>
        </tr>
        <tr>
            <td  class="td_1" ><span class="style_required_red">* </span><fmt:message key="payment_day"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" readonly="readonly" value="${bean.payment_day }">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="payment_year_month"/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field" readonly="readonly" value="${bean.payment_month=="0"?"收当月" : "收上月" }">
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="rece_cs"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.rece_cs }">     
            </td>
            <td class="td_1" ><fmt:message key="address"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.address }">
            </td>
        </tr>
        <tr>   
            <td class="td_1" ><fmt:message key="zip_code"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.zip_code }">
            </td>
            <td class="td_1" ><fmt:message key="tel1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.tel1 }">
            </td>
         </tr>
         <tr>   
            <td class="td_1" ><fmt:message key="tel2"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.tel2 }">
            </td>
            <td class="td_1" ><fmt:message key="email"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.email }">
            </td>
        </tr>
        <tr>    
            <td class="td_1" ><fmt:message key="fax"/></td>
            <td class="td_2 ">
               <input type="text" class="text_field" readonly="readonly" value="${bean.fax }">
            </td>
            <td class="td_1" ><fmt:message key="is_employ_notice"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_employ_notice()) %>"/>
            </td>
        </tr>
        <tr>   
            <td class="td_1" ><fmt:message key="security_unit_id"/></td>
            <td class="td_2 ">
              <input type="text" class="text_field" readonly="readonly" value="${bean.security_unit_id }"/> 
            </td>
            <td class="td_1" ><fmt:message key="is_physical_examination"/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_physical_examination()) %>"/>
            </td>
        </tr>
        <tr>   
            <td class="td_1" ><fmt:message key="is_handicapped_monthly"/></td>
            <td class="td_2 ">
               <input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_handicapped_monthly_bd()) %>"/>
            </td>
            <td  class="td_1" ><fmt:message key="subpackage_cost"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" readonly="readonly" value="${bean.subpackage_cost }">
            </td>
        </tr>
        <tr>    
            <td class="td_1" ><fmt:message key="contract_person"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="${bean.contract_person }">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_exclusive_security"/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_exclusive_security()) %>"/>
            </td>
        </tr>
        <tr>   
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_exclusive_accumulation"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_exclusive_accumulation()) %>"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_exclusive_salary"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_exclusive_salary()) %>"/>
            </td>
       </tr>
        <tr>   
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="is_exclusive_tax"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_exclusive_tax()) %>"/>
            </td>
            <td class="td_1"><fmt:message key="remark"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" readonly="readonly" value="${bean.remarks }">
            </td>
        </tr>
    </table>
</div>
</div>


    
<div class="foot_button">
<input type="button" class="foot_icon_1" value="<fmt:message key="go_back"/>"  onclick="empGoback();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

     </div>

</form>
</body>
</fmt:bundle>
</html>
