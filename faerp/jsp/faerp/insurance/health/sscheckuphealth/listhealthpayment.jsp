<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
 //tab切换
    
    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabConInner1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("TabConInner2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("TabConInner2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }
 
 //到支付页面
 function topay_onclick(){
   var is_checkup_agent = $id("is_checkup_agent").value  ; 
        if(is_checkup_agent ==''||is_checkup_agent == null){
            alert("请选择体检供应商！") ;
            return false ;
        } else{      
 
 //     var aegnt_check = document.getElementsByName("temp1");
      var dc=$id("dc_healthpaymentid");
      var rowCount=dc.getTotalRowCount();
    
   if(rowCount>0){
  

<!--      var clz=dc.getEntity(rowCount-1);-->
<!--       var ids=clz.getValue("ids");-->
<!--       alert(ids);-->

        var cust_name_s = $id("cust_name_s").value;
        if($id("cust_name_s").value==null)
        cust_name_s="";
     
        var checkup_agent_s = $id("checkup_agent_s").value;
          if($id("checkup_agent_s").value==null)
        checkup_agent_s="";
        
        var emp_code_s = document.getElementById("emp_code_s").value; 
        var emp_id_card_s =document.getElementById("emp_id_card_s").value; 
        
        var emp_name_s =document.getElementById("emp_id_card_s").value; 
        var is_standard_s =document.getElementById("is_standard_s").value; 

            var url="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=toPayForward&cust_name_s="+cust_name_s+"&checkup_agent_s="+checkup_agent_s+"&emp_code_s="+emp_code_s+"&emp_id_card_s="+emp_id_card_s+"&emp_name_s="+emp_name_s+"&is_standard_s="+is_standard_s ;          
      
         showModalCenter(url, window, returnFun, 800, 460, "体检支付申请");            
       
       }else{
       
           alert("没有需要支付的数据");
             return;
       }
       }       
          
       } 
                 //支付页面关闭后的回调函数              
       function returnFun(){
            $id("dc_healthpaymentid").reload();
       }       
  function checkAllList()
       {
        var element = document.getElementsByName("temp1"); 
        for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="temp1") {
             element[i].checked= !element[i].checked ? true : false;
            }
         } 
      } 
      
      function setCheckbox(value,entity,rowNo,cellNo){
      return "<input type='checkbox'  name='temp1'   value=" + entity.getProperty("id") + ">";
   //   return "<input type='checkbox'  name='temp1'   onClick=\"ClickRow1(\'" + entity.getProperty("id") + "\')\";>";
   }
   function search_onclick() {
        $id("dc_healthpaymentid").reload() ;
    }
    
     function search_onclick2() {
        $id("dc_healthfeedbackids").reload() ;
    }
    
    
    function rtnFuncCustomer(arg){
        var lookup = $id("cust_name_s");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];  
        return false;
    }
    function rtnFuncInsuranceAegntByHealth(arg){
        var lookup = $id("checkup_agent_s");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];  
        $id("is_checkup_agent").value = "yes" ;
        return false;
    }
    function rtnFuncInsuranceAegntByHealth1(arg){
        var lookup = $id("checkup_agent_name_h");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];  
        return false;
    }
    
    
 jQuery(function(){
    $id("dc_healthpaymentid").isQueryFirst = false;
    $id("dc_healthfeedbackids").isQueryFirst = false;
});
</script>
</head>
<body>
<div id="bg" class="xixi1" >
            <div id="font1" class="tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'">付款申请</div>
            <div id="font2" class="tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'">付款查询</div>
            <input name="is_checkup_agent" id="is_checkup_agent" type="hidden"/>
        </div>

         <div id="TabCon1">
         <div id="right" class="search" >
       <form name="datacell_formid" action="" id="datacell_formid" method="post"> 
        <div class="box_3">
                  <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                  <tr>
                    <td class="td_1">客户名称</td>
                    <td class="td_2">
                     <w:lookup onReturnFunc="rtnFuncCustomer" readonly="false" id="cust_name_s" name="cust_name_s" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="630"  style="width:170px"/>
                    </td>
                    <td class="td_1">体检供应商</td>
                    
                    <td class="td_2">
                     <w:lookup onReturnFunc="rtnFuncInsuranceAegntByHealth" readonly="true" id="checkup_agent_s" name="checkup_agent_s" lookupUrl="/InsuranceAegntAction.do?cmd=getInsuranceAegntByHealthListPage" dialogTitle="选择体检供应商" height="440" width="630"  style="width:170px"/>
                    </td>
                  </tr>
                  <tr>
                    <td class="td_1">员工唯一号</td>
                    <td class="td_2">
                   <input type="text" name="emp_code_s" id="emp_code_s" height="440" width="600"  style="width:170px"/>
                    </td>
                    <td class="td_1">身份证号码</td>
                    <td class="td_2">
                   <input type="text" name="emp_id_card_s" id="emp_id_card_s" height="440" width="600"  style="width:170px"/>
                    </td>
                  </tr>
                  
                    <tr>
                    <td class="td_1">员工姓名</td>
                    <td class="td_2">
                   <input type="text" name="emp_name_s" id="emp_name_s" height="440" width="600"  style="width:170px"/>
                    </td>
                    <td class="td_1">是否标准</td>
               <td class="td_2">
               <select name="is_standard_s" class="sSelect" id="is_standard_s">
                 <option value="" selected>请选择</option>
                 <option value="1">标准</option>
                 <option value="0">非标准</option>
                              </select>
               </td>
                  </tr>         
                  <tr>
                    <td class="td_2"  colspan="4"  style="text-align: center;">
                   <input type="button"  class="foot_icon_1" value="申请查询" <au:authorityBtn code="tjzf_sqcx" type="1"/> onclick="search_onclick()"/>
                    </td>
                  </tr>
                  
                  </table>
                  </div>
          </form>
          <div class="button">
           <div class="button_right">
             <!--<ul>
               <li class="r"><a onClick="topay_onclick()">支付申请</a></li>
             </ul>
             --><input class="r" type="button"   value="支付申请"  <au:authorityBtn code="tjzf_zfsq" type="1"/>  onClick="topay_onclick();">
          
           </div>
           <div class="clear"></div>
         </div>
            </div>
       </div>   
          <div id="TabConInner1" >
          <r:datacell id="dc_healthpaymentid"
            queryAction="/FAERP/SscheckuphealthAction.do?cmd=seachCheckupHealthPayMent"
            submitAction="/FAERP/SscheckuphealthAction.do?cmd=update"
            width="98%" xpath="SscheckuphealthVo" submitXpath="SscheckuphealthVo"
            paramFormId="datacell_formid" height="320px" >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
<!--            <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList();' />" width="40px" onRefreshFunc="setCheckbox" >-->
<!--            </r:field>-->
         
          
            <r:field fieldName="cust_id" label="客户编号" width="100px">
            </r:field>
            <r:field fieldName="cust_name" label="客户名称" width="150px">
            </r:field>
            <r:field fieldName="emp_code" label="唯一号" width="100px">
            </r:field>          
            <r:field fieldName="emp_name" label="员工名称" width="100px">
            </r:field>          
            <r:field fieldName="emp_id_card" label="身份证号码" width="130px">
            </r:field>          
            <r:field fieldName="serrvername" label="客服" width="100px">
            </r:field>          
            <r:field fieldName="serrverdep" label="客服部门" width="130px">
            </r:field>
            <r:field fieldName="checkup_address" label="体检地点" width="130px">
            </r:field>
            <r:field fieldName="checkup_agent" label="体检供应商" width="130px">
             <r:comboSelect id="agent_name" name="agent_name"
                                   queryAction="/FAERP/InsuranceAegntAction.do?cmd=findAllInsuranceAegnt"
                                   textField="agent_name"
                                   valueField="id"
                                   xpath="InsuranceAegntVo"
                                   width="150px"
                                   nullText="请选择" disabled="true"/>
            </r:field>
            <r:field fieldName="str_date" label="体检开始日期" width="130px">
            <w:date format="yyyy-MM-dd" disabled="true"/>
            </r:field>          
            <r:field fieldName="end_date" label="体检截止日期" width="130px">
            <w:date format="yyyy-MM-dd" disabled="true"/>
            </r:field>          
            <r:field fieldName="settlement_amount" label="结算金额" width="100px" >
            </r:field>            
            
            <r:field fieldName="remark" label="备注" width="150px">
            </r:field>         
        </r:datacell>
          </div>
      <div id="TabCon2" style="display:none">
        <div id="right" class="search"> 
       <form name="datacell_formid2" id="datacell_formid2" action="" method="post"> 
       <div class="box_3">
                  <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                  <tr>
                    <td class="td_1">体检供应商</td>
                    <td class="td_2">
                     <w:lookup onReturnFunc="rtnFuncInsuranceAegntByHealth1" readonly="true" id="checkup_agent_name_h" name="checkup_agent_name_h" lookupUrl="/InsuranceAegntAction.do?cmd=getInsuranceAegntByHealthListPage" dialogTitle="选择体检供应商" height="440" width="600"  style="width:170px"/>
                    
                    <!--<input name="checkup_agent_name_h" type="text" class="xText" id="checkup_agent_name_h" height="440" width="600"  style="width:170px"/>
                    
                    --></td>
                    <td class="td_1">支付年月</td>
                    <td class="td_2">
                    <input name="payment_month_h" type="text" class="xText" id="payment_month_h" onkeyup="this.value=this.value.replace(/\D/g,'')" maxLength="6" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
                    </td>
                  </tr>
                  <tr>
                  <td class="td_1">受款方类型</td>
                    <td class="td_2">
                   <d:select dictTypeId="RECEIVER_TYPE_BD" name="receiver_type_bd_h" disabled="false"   nullLabel="--请选择--"  property="receiver_type_bd_h" id="receiver_type_bd_h"   style="width:190px" />
                    </td>
                    <td class="td_1"><!--支付类型--></td>
                    <td class="td_2">
                    <!--<d:select dictTypeId="PAYMENT_TYPE_BD" name="payment_type_bd_h"  property="payment_type_bd_h" id="payment_type_bd_h"  style="width:190px" nullLabel="--请选择--"/>
                    -->
                    <input type="button" onclick="search_onclick2()" class="foot_icon_1" value="查询"/>
                    </td>
                    
                  </tr>
                  <!--<tr>
                    <td class="td_1"></td>
                    <td class="td_2">
                     
                    </td>
                    <td class="td_2">&nbsp;</td>
                    <td class="td_2"></td>
                  </tr>
                  --></table>
                  </div>
                  </form>
                  </div>
               </div>
<div id="TabConInner2" style="display:none">
              <r:datacell id="dc_healthfeedbackids"
            queryAction="/FAERP/SscheckuphealthAction.do?cmd=HealthSeachPayMent"
            submitAction="/FAERP/SscheckuphealthAction.do?cmd=update"
            width="98%" xpath="PayMenthealthVo" submitXpath="PayMenthealthVo"
            paramFormId="datacell_formid2" height="330px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="checkup_agent_name" label="体检供应商" width="150px">
            </r:field>
            <r:field fieldName="payment_month" label="支付年月" width="100px">
            </r:field>
            <r:field fieldName="payment_type_bd" label="支付类型" width="100px">
            <d:select dictTypeId="PAYMENT_TYPE_BD" disabled="true"/>
            </r:field>          
            <r:field fieldName="receiver_type_bd" label="受款类型" width="100px">
            <d:select dictTypeId="RECEIVER_TYPE_BD" disabled="true"/>
            </r:field>          
            <r:field fieldName="receiver_name" label="受款方" width="130px">
            </r:field>          
            <r:field fieldName="invoice_num" label="单据数量" width="100px">
            </r:field>          
            <r:field fieldName="audit_amount" label="应付总金额" width="100px">
            </r:field>
            <r:field fieldName="apply_amount" label="申请支付金额" width="100px">
            </r:field>            
            <r:field fieldName="payment_desc" label="备注" width="150px">
            </r:field>            
        </r:datacell>
</div>
</body>
</html>
