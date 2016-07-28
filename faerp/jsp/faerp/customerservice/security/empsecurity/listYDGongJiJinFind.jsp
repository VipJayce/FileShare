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
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listYDGongJiJinFind_resource' prefix='auto.'>
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


function toConfi_onClick(){
 var id = document.getElementById("emp_service_id").value;
 if(null==id||id==""){
 alert("<fmt:message key='listYDGongJiJinFind0012'/>！");
 return;
 }
  form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=updateEmpService&backFlag=true&id="+id;
  form.submit();
}

        //<fmt:message key='listYDGongJiJinFind0019'/>查询条件
    function getbyid(){
         var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         document.form.cust_name.value=data[2];
    }
    
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   );>";  
    }

   function ClickRow(value,value1){
     //     alert(value1);
        $id("emp_service_id").value = value;
        $id("city_id1").value = value1;
        
  //       $id("product_id").queryParam= "<param><key>security_group_id</key><value>" + value + "</value><key>city_id</key><value>" + value1 + "</value></param>";
          $id("celllist1").queryParam= "<param><key>emp_service_id</key><value>" + value +  "</value></param>"; 
          $id("service_idList").queryParam= "<param><key>city_id1</key><value>" + value1 +  "</value></param>"; 
          
       
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        
        $id("service_idList").loadData();
        $id("service_idList").refresh();

    }
    
    
    
        function showListData(){
        
				    var    social_unit_id = $id("social_unit_id").value;
				    var fund_month1= $id("fund_month1").value;
				    
		//	 	    if(social_unit_id==null||social_unit_id==""){
		//	 	        alert("<fmt:message key='listYDGongJiJinFind0008'/>不能为空！");
		//	 	        return;
		// 		    }
			 	    
				    if(fund_month1==null||fund_month1==""){
                        alert("<fmt:message key='listYDGongJiJinFind0002'/>");
                        return;
                    }
   
                    $id("datacell1").loadData();
                    $id("datacell1").refresh();
    }
    
    
     
  

           
        
        

     function exportEmpSend(){ 
                     var    social_unit_id = $id("social_unit_id").value;
                    var fund_month1= $id("fund_month1").value;
             //        if(social_unit_id==null||social_unit_id==""){
            //             alert("<fmt:message key='listYDGongJiJinFind0008'/>不能为空！");
           //              return;
           //          }
                    if(fund_month1==null||fund_month1==""){
                        alert("<fmt:message key='listYDGongJiJinFind0002'/>");
                        return;
                    }
        form.cmd.value = "export1";
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
                                    <td class="td_1"><fmt:message key='listYDGongJiJinFind0005'/></td>
                                    <td class="td_2">
                                       <select id="security_group_id" name="security_group_id">
                                               <option value="1099110700000000203"  selected="selected"><fmt:message key='listYDGongJiJinFind0006'/></option>
                                               <option value="1099110700000000075"  ><fmt:message key='listYDGongJiJinFind0007'/></option>
                                       </select>
                                    </td>
                                   <td class="td_1"><fmt:message key='listYDGongJiJinFind0008'/></td>
                                    <td class="td_2"><faerp:SoialunitSelectTag tagname="social_unit_id" beanname="social_unit_id" style="width:205px" /></td>
            
        </tr>
        
        
        <tr>
             <td class="td_1"><fmt:message key='listYDGongJiJinFind0009'/></td>
                    <td class="td_2"><input type="text" class="text_field"  id="fund_month1"   name="fund_month1" inputName="<fmt:message key='listYDGongJiJinFind0009'/>" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /></td>
                     <td class="td_1"><fmt:message key='listYDGongJiJinFind0011'/></td>
                    <td class="td_2">
                       <r:comboSelect id="partyid" name="partyid"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000103"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey='listYDGongJiJinFind0012'
                       value="1099110100000000050"
                        />
                        
                        
                    </td>
        </tr>
        <tr>
                     <td class="td_1"><fmt:message key='listYDGongJiJinFind0013'/></td>
                    <td class="td_2">
                   
				                    
				         <r:comboSelect id="user_id" name="user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey='listYDGongJiJinFind0012' />
						                    
                    </td>
                    
                     <td class="td_1"><fmt:message key='listYDGongJiJinFind0015'/></td>
                    <td class="td_2"><select name="status" class="sSelect" id="status">
                      <option value="1" selected="selected"><fmt:message key='listYDGongJiJinFind0016'/></option>
                      <option value="2"><fmt:message key='listYDGongJiJinFind0017'/></option>
                      <option value="3"><fmt:message key='listYDGongJiJinFind0018'/></option>
                    </select></td>
        </tr>
        <tr>
                     <td class="td_1"><fmt:message key='listYDGongJiJinFind0019'/></td>
                    <td class="td_2">
                        <input type="text" name="custName" id="custName" class="text_field">          
                    </td>
                     <td class="td_1"><fmt:message key='listYDGongJiJinFind0020'/></td>
                    <td class="td_2"><input type="text" name="custCode" id="custCode" class="text_field"></td>
        </tr>
        <tr>
          
              <td colspan="4"  align="right"  class="td_2">
                <input name="button_ok2" class="icon_1"   type="button"   <au:authorityBtn code="gjjzf_exp" type="1"/>  value='<fmt:message key="query"/>' onClick="$id('isClickQuery').value=true;showListData()">
               
               <!-- 
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
               
                -->
                 </td>
        </tr>
</table>
</div>

 <input type="hidden" id="isClickQuery" value="false" />
     <div class="button_right">
                <ul>
                      <li class="e">      <a  onclick="exportEmpSend();"><fmt:message key='listYDGongJiJinFind0021'/></a> </li>
                </ul>
     </div>
     <div class="clear"></div>     
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
         queryAction="/FAERP/EmpsecurityAction.do?cmd=listPaygongjijin"
        width="98%"
        height="320"
        xpath="SearchPayVo"
        submitXpath="SearchPayVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="customer_code" messagekey='listYDGongJiJinFind0020' width="100px">
       </r:field>   
       <r:field fieldName="customer_name" width="340px" messagekey='listYDGongJiJinFind0019'>
      </r:field>
       <r:field fieldName="get_day" messagekey='listYDGongJiJinFind0024'  allowModify="false">
      </r:field>
    </r:datacell>
    </div>


</div>
</div>
</form>
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

