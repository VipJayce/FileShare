<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Datacell</title>
<script language="javascript">

        //选择客服
    function rtnFuncCS(arg){
        var lookup = $id("lk_cs");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        jQuery("#h_user_id").val(arg[0]);        
        return false;
    }
    
 function init(){
    var day = new Date(); 
    var year=day.getFullYear();
    var month=day.getMonth()+1; 
    if(month<=9){
        month="0"+month;
    }
    var yearmonth=year+""+month;
    document.form.fund_month1.value=yearmonth;
}



        //客户名称查询条件
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         document.form.cust_name.value=data[2];
    }
    
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   );>";  
    }

     
        function showListData(){
                    var security_group_id=$id("group_List").getValue();
			        if(security_group_id==null || security_group_id==''){
			            alert('请选择社保公积金组！');
			            return;
			        }
                    var    social_unit_id = $id("social_unit_id").value;
                    var fund_month1= $id("fund_month1").value;
            //        if(social_unit_id==null||social_unit_id==""){
            //            alert("福利办理方不能为空！");
           //             return;
           //          }
                    if(fund_month1==null||fund_month1==""){
                        alert("报表月不能为空！");
                        return;
                    }
   
                    $id("datacell1").loadData();
                    $id("datacell1").refresh();
    }   

     function exportEmpSend(){ 
                    var security_group_id=$id("group_List").getValue();
			        if(security_group_id==null || security_group_id==''){
			            alert('请选择社保公积金组！');
			            return;
			        }
                    var    social_unit_id = $id("social_unit_id").value;
                    var fund_month1= $id("fund_month1").value;
          //          if(social_unit_id==null||social_unit_id==""){
         //               alert("福利办理方不能为空！");
        //                return;
         //             }
                    if(fund_month1==null||fund_month1==""){
                        alert("报表月不能为空！");
                        return;
                    }
                    
                    
        form.cmd.value = "export";
        form.submit();
    }

     
</script>
</head>
<body  onload="init();">
<form name="form" method="post" id="datacell_formid"  action="<%=request.getContextPath()%>/EmpsecurityAction.do">
<input type="hidden" name="cmd" />
<input type="hidden" id="payment_type" name="payment_type" value="1"/>

<div id="right">
<div class="ringht_s">
<div class="box_3">
<table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">

                <tr>
   
                <td class="td_1">
                        <p>城市</p>
                    </td>
                    <td class="td_2">
                         <r:comboSelect id="city_idList_search" name="city_id"
                               queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                               textField="city_name"
                               valueField="id"
                               xpath="PB_CITYVo"
                               width="200px"
                               value="1099110100000000357"
                               nullText="请选择"
                               />
                    </td>
                    </td>
                      <td align="right" class="td_1"><span class="style_required_red">* </span>社保组</td>
                      <td align="left"  class="td_2">
                             <r:comboSelect id="group_List" name="security_group_id"
                               queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=1"
                               valueField="id"
                               textField="group_name"
                               xpath="SecuritygroupVo"
                               width="200px"
                               linkId="city_idList_search"
                               nullText="请选择" />
                      </td>
                    
                                   <td class="td_1">福利办理方</td>
                                    <td class="td_2"><faerp:SoialunitSelectTag tagname="social_unit_id" beanname="social_unit_id" style="width:205px" /></td>
            
        </tr>
        
        
        <tr>
             <td class="td_1">报表月</td>
                    <td class="td_2"><input type="text" class="text_field"  id="fund_month1"    name="fund_month1" inputName="报表月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /></td>
                     <td class="td_1">专管员</td>
                    <td class="td_2">
                    
                                <r:comboSelect id="partyid" name="partyid"
                       queryAction="CustServiceAction.do?cmd=getListData&id=2013100700000000143"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText="请选择"
                        />
                    
                    </td>
                     <td class="td_1">负责客服</td>
                    <td class="td_2">
                    
                      <r:comboSelect id="user_id" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=2013100700000000148"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText="请选择" />
                    
                    </td>
        </tr>
        <tr>
                     <td class="td_1">客户名称</td>
                    <td class="td_2">
                        <input type="text" name="custName" id="custName" class="text_field">          
                    </td>
                     <td class="td_1">客户编号</td>
                    <td class="td_2"><input type="text" name="custCode" id="custCode" class="text_field"></td>
        </tr>
        <tr>
                   
                    
                     <td class="td_1">应支付查询类型</td>
                    <td class="td_2"><select name="status" class="sSelect" id="status" style="width:205px">
                       <option value="1" selected="selected">未申请</option>
                      <option value="2">审核中</option>
                      <option value="3">已支付</option>
                    </select></td>
                    
                       <td colspan="4"  align="center" class="td_2">
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' <au:authorityBtn code="sbzf_exp" type="1"/> onClick="$id('isClickQuery').value=true;showListData()">
                
                <!-- 
                 <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
                
                 -->
                 
                 </td>
        </tr>
        
      
</table>
</div>
</div>
</div>
     <div class="button_right">
                <ul>
                      <li class="e">      <a  onclick="exportEmpSend();">导出</a> </li>
                </ul>
     </div>
     <div class="clear"></div>     
   <input type="hidden" id="isClickQuery" value="false" />
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
         queryAction="/FAERP/EmpsecurityAction.do?cmd=listPayshebao"
        width="98%"
        height="320px"
        xpath="SearchPayVo"
        submitXpath="SearchPayVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="customer_code" label="客户编号" width="100px">
       </r:field>   
       <r:field fieldName="customer_name" width="340px" label="客户名称">
      </r:field>
       <r:field fieldName="status" label=" 类型"  allowModify="false">
      </r:field>
    </r:datacell>
 
</div>


</form>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">
<!--
    $id("datacell1").beforeLoadData = function(){
        if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
           //alert("run hear");
           return false;
        }
        return true;
    }
//-->
</script>
