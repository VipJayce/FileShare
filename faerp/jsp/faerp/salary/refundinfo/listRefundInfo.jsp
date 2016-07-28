<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%
     String flag = request.getParameter("flag");
     request.setAttribute("flag",flag);
%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.refundinfo.refundinfo_resource" prefix="rayoo.salary.refundinfo.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_refundinfo'/></title>
</head>

<body>
<form id="refundInfoForm" name="form"  method="post">
<input type="hidden" id="h_cmd" name="cmd"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='title_refundinfo'/></div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
      <div class="search">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="135" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div></td>
            <td width="80"><fmt:message key='customer_name'/></td>
            <td width="220">
                <w:lookup name="customer_name" onReturnFunc="rtnFunc" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="600"/>
                <input type="hidden" name="customer_id" id="h_customer_id"/>
            </td>
            <td width="80"><fmt:message key='servers_user'/></td>
            <td width="220">
            	<r:comboSelect id="combo_cs" name="servers_user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_select" />
            	<!-- 
                <w:lookup onReturnFunc="rtnFuncCS" readonly="true" id="lk_cs" 
                lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" 
                height="500" width="400"/>
                <input type="hidden" name="servers_user_id" id="h_servers_user"/> -->
            </td> 
            <td width="80"><fmt:message key='emp_name'/></td>
            <td width="220">
                <input name="emp_name" class="sText" id="t_emp_name"/>
            </td>
          </tr>
          <tr>
            <td width="80"><fmt:message key='refund_state_bd'/></td>
            <td width="220">
               <select class="sSelect" name="refund_state_bd" id="refund_state_bd">
                   <option selected="true" value=""><fmt:message key='select_null'/></option> 
                   <option value="0"><fmt:message key='refund_state_bd_0'/></option>
                   <option value="1"><fmt:message key='refund_state_bd_1'/></option>
                   <option value="2"><fmt:message key='refund_state_bd_2'/></option>
               </select>
            </td>
            <td width="80"><fmt:message key='refund_code'/></td>
            <td width="220"><input name="refund_code" class="sText" id="t_refund_code"/></td>
            <td width="80"><fmt:message key='refund_amount'/></td>
            <td width="220">
                <input id="refund_amount_f" name="refund_amount_f" class="sText_1"/>
                <input id="refund_amount_t" name="refund_amount_t" class="sText_1" />
            </td>
          </tr>
          <tr>
            <td width="80"><fmt:message key='refund_type'/></td>
            <td width="220">
            	<select class="sSelect" name="refund_type" id="refund_type">
                   <option selected="true" value=""><fmt:message key='select_null'/></option> 
                   <option value="1"><fmt:message key='refund_type_1'/></option>
                   <option value="0"><fmt:message key='refund_type_0'/></option>
               </select>
            </td>
             <td width="80"><fmt:message key='refund_name'/></td>
            <td width="220">
                <input name="refund_name" class="sText" id="t_refund_name"/>
            </td>
         
            <td>薪资批次号</td>
            <td>  <input name="sa_batch_code" class="sText" id="sa_batch_code"/></td>
          </tr>
          
          
             <tr>
            <td width="80"></td>
            <td width="220">
           
            </td>
            
     
      
            <td><input onclick="qrySalarybatch(1)" type="button" class="icon_1" value="<fmt:message key='button_search'/>" /></td>
            <td><input onclick="qrySalarybatch(2)" type="button" class="icon_4" value="<fmt:message key='button_search_1'/>" /></td>
           <td ><input onclick="qrySalarybatch(3)" type="button" class="icon_4" value="退票分析"  <au:authorityBtn code="exportAnalyseButton" type="1"/> /> </td>
          </tr>
          
          
        </table>
      </div>
        <!--查询 end-->
        <!--按钮-->
        <div class="button">
            <div class="button_right">
                <!--<ul>
                    <li class="bl_1"><a onClick="refundApply()" href="javascript:void(0);">申请重发</a></li>
                </ul>
                -->
                <input id="btn_apply1" class="bl_1" type="button" value="<fmt:message key='button_refundApply'/>" <au:authorityBtn code="sqcf_sqcf" type="1"/> onClick="refundApply();">
                <input id="btn_apply2" style="display:none;" class="bl_1" type="button" value="<fmt:message key='button_refundApply'/>" <au:authorityBtn code="sqcf_sqcf" type="1"/>  onClick="refundApply2();">
                <input id="btn_apply3" style="display:none;" class="h_2" type="button" value="<fmt:message key='button_refundApply_1'/>" <au:authorityBtn code="sqcf_sqxxtp" type="1"/>  onClick="refundApply3();">
                <input id="btn_save"  class="bl_1" type="button" value="<fmt:message key='button_save'/>" <au:authorityBtn code="sqcf_sqcf" type="1"/> onClick="modifyRefund('dc_refund_info');">
                <input id="btn_save2" style="display:none;" class="bl_1" type="button" value="<fmt:message key='button_save'/>" <au:authorityBtn code="sqcf_sqcf" type="1"/> onClick="modifyRefund('dc_refund_info2');">
                
                <input id="btn_again"  class="bl_1" type="button" value="自动匹配" <au:authorityBtn code="sqcf_sqcf" type="1"/> onClick="Refund_again('dc_refund_info');">
                <input id="btn_again2" style="display:none;" class="bl_1" type="button" value="自动匹配" <au:authorityBtn code="sqcf_sqcf" type="1"/> onClick="Refund_again('dc_refund_info2');">
                <input id="btn_again3" style="display:none;" class="bl_1" type="button" value="自动匹配" <au:authorityBtn code="sqcf_sqcf" type="1"/> onClick="Refund_again('dc_refund_info3');">
              
                <input class="e" type="button" value="导出" <au:authorityBtn code="sqcf_export" type="1"/> onClick="javascript:exportExcel();">
                 <input class="bl_4" type="button" value="当天申请导出"  onClick="javascript:downApplyExcel();">
                
                
                  <input class="e" type="button" value="分析导出" <au:authorityBtn code="exportAnalyseExcel" type="1"/> onClick="javascript:exportAnalyseExcel();">
                
                <input class="bl_4"  type="button" value="导入申请重发" <au:authorityBtn code="importrefundappl" type="1"/>  onClick="javascript:importRefundApply();">
                
            </div>
            <div class="clear"></div>
        </div>
        <!--按钮 end-->
        <!--表格 -->
        <div id="dc_div1">
        <r:datacell 
              id="dc_refund_info"
              queryAction="/FAERP/RefundInfoAction.do?cmd=simpleQuery"
              submitAction="/FAERP/RefundInfoAction.do?cmd=modifyRefund"
              width="100%"
              xpath="RefundInfoVo"
              submitXpath="RefundInfoVo"
              paramFormId="refundInfoForm"
              pageSize="100"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
              
              <r:field fieldName="id" 
              label="<input type='checkbox' name='checkall' onclick='chk_all(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox">
              </r:field>
              <r:field sortAt="none" fieldName="customer_name" messagekey="customer_name">
              </r:field>
              <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name">
              </r:field>
               <r:field sortAt="none" fieldName="refund_amount" messagekey="refund_amount" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_code" messagekey="refund_code" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_cause" messagekey="refund_cause" >
              </r:field>
              <r:field sortAt="none" fieldName="re_pay_time" messagekey="re_pay_time" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_type" messagekey="refund_type" allowModify="false">
                <h:select name="list_refund_type" property="refund_type">
                   <h:option value="1" label="工资类"></h:option>
                   <h:option value="0" label="报销类"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="refund_name" messagekey="refund_name" >
              <h:text name="txt_refund_name1" property="refund_name" validateAttr="maxLength:50;"/>
              </r:field>
              <r:field sortAt="none" fieldName="refund_num" messagekey="refund_num" width="150px">
              <!--<h:text onchange="checkCard(this,'dc_refund_info');" property="refund_num" validateAttr="maxLength:50;"/>
              --></r:field>
              <r:field sortAt="none" fieldName="servers_user" messagekey="servers_user" >
              </r:field>
              <r:field sortAt="none" fieldName="create_user" messagekey="create_user" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_date" messagekey="refund_date" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_state_bd" messagekey="refund_state_bd" allowModify="false">
                <h:select name="list_refund_state_bd" property="refund_state_bd">
                   <h:option value="0" label="未申请"></h:option>
                   <h:option value="1" label="待补发"></h:option>
                   <h:option value="2" label="已补发"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="remarks" messagekey="remarks" width="200px" >
              </r:field>
        </r:datacell>
        </div>
        <div id="dc_div2" style="display:none;">
        <r:datacell 
              id="dc_refund_info2"
              queryAction="/FAERP/RefundInfoAction.do?cmd=simpleQuery2"
              submitAction="/FAERP/RefundInfoAction.do?cmd=modifyRefund"
              width="100%"
              xpath="RefundInfoVo"
              submitXpath="RefundInfoVo"
              paramFormId="refundInfoForm"
              pageSize="100"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
              
              <r:field fieldName="id" 
              label="<input type='checkbox' name='checkall' onclick='chk_all(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox2">
              </r:field>
              <r:field sortAt="none" fieldName="refund_code" messagekey="refund_code" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_amount" messagekey="refund_amount" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_cause" messagekey="refund_cause" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_name" messagekey="refund_name" >
              	<h:text name="txt_refund_name" property="refund_name" validateAttr="maxLength:50;"/>
              </r:field>
              <r:field sortAt="none" fieldName="refund_num" messagekey="refund_num" width="150px">
              	<h:text onchange="checkCard(this,'dc_refund_info2');" property="refund_num" validateAttr="maxLength:50;"/>
             </r:field>
              <r:field sortAt="none" fieldName="customer_name" messagekey="customer_name">
              </r:field>
              <r:field sortAt="none" fieldName="servers_user" messagekey="servers_user" >
              </r:field>
              <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name">
              </r:field>
              <r:field sortAt="none" fieldName="refund_date" messagekey="refund_date" >
              </r:field>
              <r:field sortAt="none" fieldName="re_pay_time" messagekey="re_pay_time" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_type" messagekey="refund_type" allowModify="false">
                <h:select name="list_refund_type" property="refund_type">
                   <h:option value="1" label="工资类"></h:option>
                   <h:option value="0" label="报销类"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="refund_state_bd" messagekey="refund_state_bd" allowModify="false">
                <h:select name="list_refund_state_bd" property="refund_state_bd">
                   <h:option value="0" label="未申请"></h:option>
                   <h:option value="1" label="待补发"></h:option>
                   <h:option value="2" label="已补发"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="create_user" messagekey="create_user" >
              </r:field>
              <r:field sortAt="none" fieldName="remarks" messagekey="remarks" width="200px" >
              </r:field>
        </r:datacell>
        </div>
        
       <div id="dc_div3" style="display:none;">
        <r:datacell 
              id="dc_refund_info3"
              queryAction="/FAERP/RefundInfoAction.do?cmd=simpleQuery3"
              submitAction="/FAERP/RefundInfoAction.do?cmd=modifyRefund33"
              width="100%"
              xpath="RefundInfoVo"
              submitXpath="RefundInfoVo"
              paramFormId="refundInfoForm"
              pageSize="100"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
              
              <r:field fieldName="id" 
              label="<input type='checkbox' name='checkall' onclick='chk_all(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox2">
              </r:field>
              <r:field sortAt="none" fieldName="refund_code" messagekey="refund_code" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_amount" messagekey="refund_amount" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_cause" messagekey="refund_cause" >
              </r:field>
               
 
              <r:field sortAt="none" fieldName="refund_name" messagekey="refund_name" >
              	<h:text name="txt_refund_name" property="refund_name" validateAttr="maxLength:50;"/>
              </r:field>
              <r:field sortAt="none" fieldName="refund_num" messagekey="refund_num" width="150px">
              	<h:text onchange="checkCard(this,'dc_refund_info3');" property="refund_num" validateAttr="maxLength:50;"/>
             </r:field>
              <r:field sortAt="none" fieldName="customer_name" messagekey="customer_name">
              </r:field>
              <r:field sortAt="none" fieldName="servers_user" messagekey="servers_user" >
              </r:field>
              <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name">
              </r:field>
                 <r:field sortAt="none" fieldName="id_card" label="证件号" >
                              </r:field>
              <r:field sortAt="none" fieldName="refund_date" messagekey="refund_date" >
              </r:field>
              <r:field sortAt="none" fieldName="re_pay_time" messagekey="re_pay_time" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_type" messagekey="refund_type" allowModify="false">
                <h:select name="list_refund_type" property="refund_type">
                   <h:option value="1" label="工资类"></h:option>
                   <h:option value="0" label="报销类"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="refund_state_bd" messagekey="refund_state_bd" allowModify="false">
                <h:select name="list_refund_state_bd" property="refund_state_bd">
                   <h:option value="0" label="未申请"></h:option>
                   <h:option value="1" label="待补发"></h:option>
                   <h:option value="2" label="已补发"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="create_user" messagekey="create_user" >
              </r:field>
              <r:field sortAt="none" fieldName="remarks" messagekey="remarks" width="200px" >
              </r:field>
        </r:datacell>
        </div>
        <!--表格 end-->
    </div>
</div>
</form>
</body>
<script type="text/javascript">
jQuery(function(){
    if("${flag}" == ""){
        $id("dc_refund_info").isQueryFirst = false;
    }
});
//校验银行卡
function checkCard(obj,dc_id){
	var en = $id(dc_id).getActiveEntity();
	var emp_id = en.getValue("emp_id");
	if(obj.value){
		//$id("dc_refund_info2").isModefied = true;
		jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=findCard&refund_num="+obj.value+"&emp_id="+emp_id,function(data){
			if(data < 0){
				alert("<fmt:message key='alert_long_msg'/>");
				var dc = $id(dc_id);
				var cell = dc.getActiveCell();
				dc.setCellValue(cell,"");
			}		
    	}); 
	}
	
}

//选择客户
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    //jQuery("#h_customer_id").val(arg[0]);        
    return false;
}
//选择客服
function rtnFuncCS(arg){
    var lookup = $id("lk_cs");
    lookup.value = arg[1];
    lookup.displayValue = arg[1];
    jQuery("#h_servers_user").val(arg[0]);        
    return false;
}
//申请重发
function refundApply(){

var _updated = $id("dc_refund_info").isModefied;
    if(_updated){
        alert("<fmt:message key='alert_earlier_save'/>");
        return;
    }
	//设置16:15时间点
    var timePoint = new Date();
    timePoint.setHours(16);
    timePoint.setMinutes(15);
    timePoint.setSeconds(0);
    
    //给申请发放日期设置默认值
    _now = new Date();
    if(_now.getTime() > timePoint.getTime()){
        _now.setDate(_now.getDate()+1);
        /*
        if(!window.confirm("<fmt:message key='alert_long_msg_1'/>")){
        	return;
        };*/
    }
    
    var ds = $id("dc_refund_info").dataset;
	var ids = new Array();
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value);
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("refund_state_bd");
            var account_nm = entity.getValue("refund_name");
            var account_no = entity.getValue("refund_num");
            
            if(!account_nm || !account_no){
            	alert("<fmt:message key='alert_long_msg_2'/>");
            	ids = "-1";
            	return false;
            }
              var customer_name = entity.getValue("customer_name");
              var refund_amount = entity.getValue("refund_amount");
              var servers_user = entity.getValue("servers_user");
              if(customer_name==null||customer_name==''){
                alert("客户名称不能为空！") ;
                ids = "-1";
                return   false ;
              }
               if(refund_amount==null||refund_amount==''){
                alert("退票金额不能为空！") ;
                ids = "-1";
                return   false ;
              }
               if(servers_user==null||servers_user==''){
                alert("客服不能为空！") ;
                ids = "-1";
                return   false ;
              }
            if(state != 0){
            	var code = entity.getValue("refund_code");
            	var msg = code?"<fmt:message key='alert_refund_code_1'/>" + code + "<fmt:message key='alert_refund_code_2'/>":"<fmt:message key='alert_refund_code_3'/>";
            	alert(msg);
            	ids = "-1";
            	return false;
            }
            //判断是否开户名对应银行卡对应的开户名称一样
           var account_name = entity.getValue("account_name"); 
           if( account_nm != account_name){
               alert("开户名跟银行卡对应的开户名不同") ;
                ids = "-1";
                return false;
           }
        }
    });
    if(ids == "-1"){
    	return;
    }
	len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=refundApply&ids="+ids.join()+"&apply_pay_time="+dateToString(_now),function(data){
                if(data == 1){
                    alert("申请成功");
                    $id("dc_refund_info").reload();
                }else{
                    alert(data);
                }
    });
}
//申请重发
function refundApply2(){
	var _updated = $id("dc_refund_info2").isModefied;
	if(_updated){
		alert("<fmt:message key='alert_earlier_save'/>");
		return;
	}
	//设置16:15时间点
    var timePoint = new Date();
    timePoint.setHours(16);
    timePoint.setMinutes(15);
    timePoint.setSeconds(0);
    
    //给申请发放日期设置默认值
    _now = new Date();
    if(_now.getTime() > timePoint.getTime()){
        _now.setDate(_now.getDate()+1);
        /*
        if(!window.confirm("当前时间已超过16:15分，申请补发日期已设为明天，是否继续申请！")){
        	return;
        };*/
    }
    
    var ds = $id("dc_refund_info2").dataset;
	var ids = new Array();
    jQuery("input[name='chk_id2']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value);
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("refund_state_bd");
            var account_nm = entity.getValue("refund_name");
            var account_no = entity.getValue("refund_num");
            if(!account_nm || !account_no){
            	alert("<fmt:message key='alert_long_msg_2'/>");
            	ids = "-1";
            	return false;
            }
             var customer_name = entity.getValue("customer_name");
              var refund_amount = entity.getValue("refund_amount");
              var servers_user = entity.getValue("servers_user");
              if(customer_name==null||customer_name==''){
                alert("客户名称不能为空！") ;
                ids = "-1";
                return   false ;
              }
               if(refund_amount==null||refund_amount==''){
                alert("退票金额不能为空！") ;
                ids = "-1";
                return   false ;
              }
               if(servers_user==null||servers_user==''){
                alert("客服不能为空！") ;
                ids = "-1";
                return   false ;
              }
            if(state != 0){
            	var code = entity.getValue("refund_code");
            	var msg = code?"<fmt:message key='alert_refund_code_1'/>" + code + "<fmt:message key='alert_refund_code_2'/>":"<fmt:message key='alert_refund_code_3'/>";
            	alert(msg);
            	ids = "-1";
            	return false;
            }
             //判断是否开户名对应银行卡对应的开户名称一样
           var account_name = entity.getValue("account_name"); 
           if( account_nm != account_name){
               alert("开户名跟银行卡对应的开户名不同") ;
                ids = "-1";
                return false;
           }
            
            
        }
    });
    if(ids == "-1"){
    	return;
    }
	len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=refundApply&ids="+ids.join()+"&apply_pay_time="+dateToString(_now),function(data){
            if(data == 1){
                 alert("申请成功");
                 $id("dc_refund_info2").reload();
             }else{
                 alert(data);
             }
    });
}
//申请线下重发
function refundApply3(){
    var ds = $id("dc_refund_info2").dataset;
	var ids = new Array();
    jQuery("input[name='chk_id2']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value);
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("refund_state_bd");
            if(state != 0){
            	var code = entity.getValue("refund_code");
            	var msg = code?"<fmt:message key='alert_refund_code_1'/>" + code + "<fmt:message key='alert_refund_code_2'/>":"<fmt:message key='alert_refund_code_3'/>";
            	alert(msg);
            	ids = "-1";
            	return false;
            }
        }
    });
    if(ids == "-1"){
    	return;
    }
	len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    //设置16:15时间点
    var timePoint = new Date();
    timePoint.setHours(16);
    timePoint.setMinutes(15);
    timePoint.setSeconds(0);
    
    //给申请发放日期设置默认值
    _now = new Date();
    if(_now.getTime() > timePoint.getTime()){
        _now.setDate(_now.getDate()+1);
        /*
        if(!window.confirm("当前时间已超过16:15分，申请补发日期已设为明天，是否继续申请！")){
            return;
        };*/
    }
    
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=refundApply&ids="+ids.join()+"&apply_pay_time="+dateToString(_now),function(data){
          if(data == 1){
               alert("申请成功");
               $id("dc_refund_info2").reload();
           }else{
               alert(data);
           }
    });
}

//查询
function qrySalarybatch(flag){
	v1 = $id("refund_amount_f").value;
   	v2 = $id("refund_amount_t").value;
   	if(checkMoney(v1,v2)){
   		if(flag==1){
   			$id("dc_refund_info").reload();
   			jQuery("#dc_div1").show();
   			jQuery("#btn_apply1").show();
   			jQuery("#btn_save").show();
   			jQuery("#btn_again").show();
   			jQuery("#dc_div2").hide();
   			jQuery("#dc_div3").hide();
   			jQuery("#btn_apply2").hide();
   			jQuery("#btn_apply3").hide();
   			jQuery("#btn_save2").hide();
   			jQuery("#btn_again2").hide();
   		   jQuery("#btn_again3").hide();
   		
   			
   		}else if(flag==2){
   			$id("dc_refund_info2").reload();
   			jQuery("#dc_div2").show();
   			jQuery("#btn_apply2").show();
   			jQuery("#btn_apply3").show();
   			jQuery("#btn_save2").show();
   			jQuery("#btn_save").hide();
   			  jQuery("#btn_again2").show();
            jQuery("#btn_again").hide();
   			jQuery("#dc_div1").hide();
   			jQuery("#dc_div3").hide();
   					jQuery("#btn_again3").hide();
   			jQuery("#btn_apply1").hide();
   		}else
   		{
   		
   		     jQuery("#refund_state_bd").children("option").each(function(){
		              var temp_value = jQuery(this).val();
		              if(temp_value == '0'){
		                    jQuery(this).attr("selected",true);
		              }
		         });
		          jQuery("#refund_type").children("option").each(function(){
		              var temp_value = jQuery(this).val();
		              if(temp_value == '1'){
		                    jQuery(this).attr("selected",true);
		              }
		         }); 
		          var sa_batch_code = document.getElementById("sa_batch_code").value;

    if(sa_batch_code=='')
     {
     alert('薪资批次号为必填项');
     return ;
     }   
   		$id("dc_refund_info3").reload();
   		jQuery("#btn_again").hide();
   		jQuery("#btn_again2").hide();
   			  jQuery("#btn_again3").show();
   			jQuery("#dc_div3").show();
   		   jQuery("#dc_div2").hide();
   		   jQuery("#dc_div1").hide();
   			
   		}
   		
   	}
}
//验证金额有效性
function checkMoney(f,t){
    if((f && !isDecimal(f)) || (t && !isDecimal(t))){
        alert("<fmt:message key='alert_isDecimal'/>");
        return false;
    }
    if(f && t && (t < f)){
        alert("<fmt:message key='alert_isDecimal_1'/>");
        return false;
    }
    return true;
}
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id' value='" + entity.getProperty("id") + "' onclick='validateCard(this,\"dc_refund_info\")'/>";
}
//全选
function chk_all(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox").attr("checked", true);
    } else {
        jQuery(":checkbox").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox2(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id2' value='" + entity.getProperty("id") + "' onclick='validateCard(this,\"dc_refund_info2\")'/>";
}
//验证银行卡信息
function validateCard(obj,dc){
	var ds = $id(dc).dataset;
	var entity = ds.findEntity("id",obj.value);
    var refund_num = entity.getValue("refund_num");
    var customer_id = entity.getValue("customer_id");
    //var emp_id = entity.getValue("emp_id");
    var _dmss=new Date();
	if (jQuery(obj).attr("checked")) {
		//线上退票
		if(refund_num && customer_id){
			jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=findCard&refund_num="+refund_num+"&_datemss="+_dmss,function(data){
			if(data < 0){
				alert("<fmt:message key='alert_refund_num_1'/>");
				jQuery(obj).attr("checked", false);
			}else if(data > 1){
				alert("<fmt:message key='alert_refund_num_2'/>");
				jQuery(obj).attr("checked", false);
			}
    	});
		}
    } 
}

//保存
function modifyRefund(dc_id){
var en = $id(dc_id).getActiveEntity();
//alert("refund_amount"+en.getValue("refund_num"));
var action = "<%=request.getContextPath()%>/RefundInfoAction.do?cmd=modifyRefund";


//var xmlSubmit = $id(dc_id).dataset.toString();
    //        alert(xmlSubmit);
  //          var myAjax = new Ajax(action);
         //   myAjax.submitXML(xmlSubmit, 'UTF-8');


	rst = $id(dc_id).submit();
	if(rst){
	    alert("<fmt:message key='alert_save_success'/>");
	}else{
		alert("<fmt:message key='alert_save_fail'/>");
	}
}

//自动匹配
function Refund_again(dc_id){
 if(confirm('确定自动匹配这条数据?')) {
    var en = $id(dc_id).getActiveEntity();
    if(!en){
      alert("请选择一条记录") ;
      return false ;
     }
    var refund_id = en.getValue("id") ;
    var refund_type = en.getValue("refund_type") ;
    if(refund_id != null){
        jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=refundInfoAgain&refund_id="+refund_id+"&refund_type="+refund_type,function(data){
            if(data == '1'){
                alert("匹配成功！") ;
                $id(dc_id).reload();
            }else{
              alert("匹配失败，请检查银行卡信息是否都维护好或者判断银行卡号对应的开户名称是否一样 ！");
              return false ;
            }       
        }); 
    }
    }
}

//系统退票重发导出EXCEL功能
function exportExcel(){
    var custName = document.getElementById("lk_clz_hidden").value;//客户名称
    var csID = document.getElementById("combo_cs_hidden").value;//客服
    var empName = document.getElementById("t_emp_name").value;//员工姓名
    var refundStateBD = document.getElementById("refund_state_bd").value;//退票重发状态
    var refundCode = document.getElementById("t_refund_code").value;//退票编号
    var amountStart = document.getElementById("refund_amount_f").value;//金额开始
    var amountEnd = document.getElementById("refund_amount_t").value;//金额结束
    var refundType = document.getElementById("refund_type").value;//退票类型
    var refundName = document.getElementById("t_refund_name").value;//开户名
    
    //拼装查询条件
    var conditionStr = "&custName="+custName+"&csID="+csID+"&empName="+empName+"&refundStateBD="+refundStateBD+"&refundCode="+refundCode+"&amountStart="+amountStart+"&amountEnd="+amountEnd+"&refundType="+refundType+"&refundName="+refundName
    conditionStr = encodeURI(conditionStr);//编码json
    var form = document.getElementById("refundInfoForm");
     form.action="<%=request.getContextPath()%>/RefundInfoAction.do?cmd=exportExcel"+conditionStr;
     form.submit();
}



function downApplyExcel(){
   var form = document.getElementById("refundInfoForm"); 
     form.action="<%=request.getContextPath()%>/RefundInfoAction.do?cmd=downApplyExcel";
     form.submit();

}

function exportAnalyseExcel(){
    var custName = document.getElementById("lk_clz_hidden").value;//客户名称
      
  
     jQuery("#refund_state_bd").children("option").each(function(){
		              var temp_value = jQuery(this).val();
		              if(temp_value == '0'){
		                    jQuery(this).attr("selected",true);
		              }
		         });
      
     jQuery("#refund_type").children("option").each(function(){
		              var temp_value = jQuery(this).val();
		              if(temp_value == '1'){
		                    jQuery(this).attr("selected",true);
		              }
		         });  
    var csID = document.getElementById("combo_cs_hidden").value;//客服
    var empName = document.getElementById("t_emp_name").value;//员工姓名
    var refundStateBD = document.getElementById("refund_state_bd").value;//退票重发状态
    var refundCode = document.getElementById("t_refund_code").value;//退票编号
    var amountStart = document.getElementById("refund_amount_f").value;//金额开始
    var amountEnd = document.getElementById("refund_amount_t").value;//金额结束
    var refundType = document.getElementById("refund_type").value;//退票类型
    var refundName = document.getElementById("t_refund_name").value;//开户名
    var sa_batch_code = document.getElementById("sa_batch_code").value;//开户名

    if(sa_batch_code=='')
     {
     alert('薪资批次号为必填项');
     return ;
     }
    
    //拼装查询条件
    var conditionStr = "&sa_batch_code="+sa_batch_code+"&custName="+custName+"&csID="+csID+"&empName="+empName+"&refundStateBD="+refundStateBD+"&refundCode="+refundCode+"&amountStart="+amountStart+"&amountEnd="+amountEnd+"&refundType="+refundType+"&refundName="+refundName
    conditionStr = encodeURI(conditionStr);//编码json
    var form = document.getElementById("refundInfoForm"); 
     form.action="<%=request.getContextPath()%>/RefundInfoAction.do?cmd=exportAnalyseExcel"+conditionStr;
     form.submit();
}

//批量导入申报重发
function importRefundApply() {
    form.action="<%=request.getContextPath()%>/jsp/faerp/salary/refundinfo/importRefundInfo.jsp";
    form.submit();
}
</script>
</fmt:bundle>
</html>
