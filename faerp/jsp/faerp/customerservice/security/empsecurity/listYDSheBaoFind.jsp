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
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listYDSheBaoFind_resource' prefix='auto.'>
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



        //<fmt:message key='listYDSheBaoFind0025'/>查询条件
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         document.form.cust_name.value=data[2];
    }
    
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   );>";  
    }

     
        function showListData(){
        
                    var    social_unit_id = $id("social_unit_id").value;
                    var fund_month1= $id("fund_month1").value;
            //        if(social_unit_id==null||social_unit_id==""){
            //            alert("<fmt:message key='listYDSheBaoFind0000'/>");
           //             return;
           //          }
                    if(fund_month1==null||fund_month1==""){
                        alert("<fmt:message key='listYDSheBaoFind0001'/>");
                        return;
                    }
   
                    $id("datacell1").loadData();
                    $id("datacell1").refresh();
    }   

    

        



    
     function exportEmpSend(){ 
     
                    var    social_unit_id = $id("social_unit_id").value;
                    var fund_month1= $id("fund_month1").value;
          //          if(social_unit_id==null||social_unit_id==""){
         //               alert("<fmt:message key='listYDSheBaoFind0000'/>");
        //                return;
         //             }
                    if(fund_month1==null||fund_month1==""){
                        alert("<fmt:message key='listYDSheBaoFind0001'/>");
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


<div id="right">
<div class="ringht_s">
<div class="box_3">
<table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">


                <tr>
                                    <td class="td_1"><fmt:message key='listYDSheBaoFind0004'/></td>
                                    <td class="td_2">
                                       <select id="security_group_id" name="security_group_id">
                               <option value="1099110700000000199"  selected="selected"><fmt:message key='listYDSheBaoFind0005'/></option>
                               <option value="1099110700000000202"  ><fmt:message key='listYDSheBaoFind0006'/></option>
                               <option value="1099110700000000074"  ><fmt:message key='listYDSheBaoFind0007'/></option>
                               <option value="1099110700000000201"  ><fmt:message key='listYDSheBaoFind0008'/></option>
                               <option value="1099110700000000200"  ><fmt:message key='listYDSheBaoFind0009'/></option>
                               <option value="1099110700000000198"  ><fmt:message key='listYDSheBaoFind0005'/>社保IBM<fmt:message key='listYDSheBaoFind0011'/></option>
                                       </select>
                                    </td>
                                   <td class="td_1"><fmt:message key='listYDSheBaoFind0012'/></td>
                                    <td class="td_2"><faerp:SoialunitSelectTag tagname="social_unit_id" beanname="social_unit_id" style="width:205px" /></td>
            
        </tr>
        
        
        <tr>
             <td class="td_1"><fmt:message key='listYDSheBaoFind0013'/></td>
                    <td class="td_2"><input type="text" class="text_field"  id="fund_month1"    name="fund_month1" inputName="<fmt:message key='listYDSheBaoFind0013'/>" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /></td>
                     <td class="td_1"><fmt:message key='listYDSheBaoFind0015'/></td>
                    <td class="td_2">
                    
                                <r:comboSelect id="partyid" name="partyid"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000102"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText=''
                       value="1099110100000000050"
                        />
                    
                    </td>
        </tr>
        <tr>
                     <td class="td_1"><fmt:message key='listYDSheBaoFind0017'/></td>
                    <td class="td_2">
                    
                      <r:comboSelect id="user_id" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       nullText='' />
                    
                    </td>
                    
                     <td class="td_1">应支付查询<fmt:message key='listYDSheBaoFind0026'/></td>
                    <td class="td_2"><select name="status" class="sSelect" id="status">
                       <option value="1" selected="selected"><fmt:message key='listYDSheBaoFind0020'/></option>
                      <option value="2"><fmt:message key='listYDSheBaoFind0021'/></option>
                      <option value="3"><fmt:message key='listYDSheBaoFind0022'/></option>
                    </select></td>
        </tr>
        
        <tr>
       
              <td colspan="4"  align="right" class="td_2">
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
                      <li class="e">      <a  onclick="exportEmpSend();"><fmt:message key='listYDSheBaoFind0023'/></a> </li>
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
       <r:field fieldName="customer_code" messagekey='listYDSheBaoFind0024' width="100px">
       </r:field>   
       <r:field fieldName="customer_name" width="340px" messagekey='listYDSheBaoFind0025'>
      </r:field>
       <r:field fieldName="status" messagekey='listYDSheBaoFind0026'  allowModify="false">
      </r:field>
    </r:datacell>
 
</div>


</form>
</fmt:bundle>
</body>
</fmt:bundle>
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
