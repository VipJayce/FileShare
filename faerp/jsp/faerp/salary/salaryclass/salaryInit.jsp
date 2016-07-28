<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salaryclass.salaryclass_resource" prefix="rayoo.salary.salaryclass.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key="salaryinit"/></title>
</head>
<script type="text/javascript">
jQuery(document).ready(function(){
	$id("dc_salary_clz").isQueryFirst = false;
    //修改一个单元格，同列的单元格联动修改
    $id("dc_clz_init").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
	   rc = this.dataset.getLength();
	   for(var i=0; i<rc; i++){
	       var curCell = this.getCell(i,activeCell.cellIndex);
	       this.setCellValue(curCell,newValue); 
	   }
	   return false;
	};
});
//datacell中验证薪资发放日函数
function f_check_payday(obj){
    var pd = obj.value;
    if(!isInteger(pd) || pd<1 || pd>31){
      f_alert(obj,"<fmt:message key="record_payday_err"/>");
      return false;
    }
    return true;
}
//保存工资单类型
function savePayroll(obj){
    //alert(document.getElementById("h_payroll_type").value);
    document.getElementById("h_payroll_type").value =  obj.value;
}
//保存修改，初始化TAB页
function doModifyClz_init(){
    if(!$id("dc_clz_init").isModefied){
        alert("<fmt:message key="alert_modify_err"/>");
    }else{// if($id("dc_clz_init").submit())
         var action="<%=request.getContextPath()%>/SalaryclassAction.do?cmd=update";
        var myAjax = new Ajax(action);
        var data1=$id("dc_clz_init");
        var xmlSubmit=null;
        if(data1!=null ){
        xmlSubmit=data1.dataset.toString();
        }else{
        alert("请选择配置项目，如果没有点击返回按钮!");
        return;
        }
        myAjax.submitXML(xmlSubmit);
       var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
           if(myAjax.getProperty("returnValue")) {
            alert(myAjax.getValue("root/data/returnValue"));
         } 
        }
    }
  }
//保存修改，查询TAB页
function doModifyClz_qry(){
    if(!$id("dc_salary_clz").isModefied){
        alert("<fmt:message key="alert_modify_err"/>");
    }else if($id("dc_salary_clz").submit()){
        alert("<fmt:message key="alert_save_success"/>");
    }
}
//点击查询TAB页时重新加载
function reloadQueryPage(){
    $id("dc_salary_clz").reload();
}
    
//查询
function qry(){
    pf = document.getElementById("txt_pay_from").value;
    pt = document.getElementById("txt_pay_to").value;
    
    if(pf){
        if(!isInteger(pf) || pf<1 || pf>31){
           alert("<fmt:message key="alert_payday_err"/>");
           return;
        }
        
    }
    if(pt){
        if(!isInteger(pt) || pt<1 || pt>31){
           alert("<fmt:message key="alert_payday_err"/>");
           return;
        }
        
    }
    if((pf && pt) && (pt < pf)){
        alert("<fmt:message key="alert_payday_err"/>");
        return;    
    }  
    $id("dc_salary_clz").reload();
}
//选择客户
function rtnFunc(arg){
    //alert(arg[0]+'--'+arg[1]+'--'+arg[2]);
    var lookup = $id("lk_cust");
    
    var customerId = arg[0];
    jQuery.post("<%=request.getContextPath()%>/SalaryclassAction.do?cmd=checkCust&custId="+customerId,function(data){
        //alert(data);
        rst = data.split(",");
        if(rst[0] < 1){
            alert("<fmt:message key="alert_no_sendpost"/>");
        }else if(rst[1] > 0){
            alert("<fmt:message key="alert_have_been_init"/>");
            
            jQuery("#h_cust_id").val(arg[0]);
            jQuery("#h_cust_code").val(arg[1]);
            jQuery("#h_cust_name").val(arg[2]);
            lookup.setValue(arg[0]);
            lookup.setDisplayValue(arg[2]);
            
            jQuery("#h_clzId").val(rst[1]);
            $id("h_custId").value = arg[0];
            $id("dc_clz_init").reload();
        }else{
            jQuery("#h_cust_id").val(arg[0]);
            jQuery("#h_cust_code").val(arg[1]);
            jQuery("#h_cust_name").val(arg[2]);
            lookup.setValue(arg[0]);
            lookup.setDisplayValue(arg[2]);
            
            //清空薪资类别ID
            $id("h_clzId").value = "";
            $id("h_custId").value = arg[0];
            $id("dc_clz_init").reload();
        }
    });
            
    
    return false;
}
//执行薪资初始化
function doSalaryInit(){
 
    if(!jQuery("#h_cust_id").val()){
        alert("<fmt:message key="alert_select_customer"/>");
        return;
    }
    pf = jQuery("#t_payday").val();
    if(pf){
        if(!isInteger(pf) || pf<1 || pf>31){
           alert("<fmt:message key="alert_payday_err"/>");
           return;
        }
    }
    else{
        alert("<fmt:message key="alert_payday_null"/>");
        return; 
    }
    document.getElementById("isRepetition").disabled = true;
    jQuery.post("<%=request.getContextPath()%>/SalaryclassAction.do?cmd=checkCust&custId="+jQuery("#h_cust_id").val(),function(data){
        rst = data.split(",");
        if(rst[0] < 1){
            alert("<fmt:message key="alert_no_sendpost"/>");
            return;
        }else if(rst[1] > 0){
            alert("<fmt:message key="alert_have_been_init"/>");
            return;
        }
        else{
        	//给datacell所在的表单工资单类型赋值
		    jQuery("#h_payroll_type").val(jQuery("#s_payroll_type").val());
		    //序列化表单
		    param = jQuery("#addform").serialize();
		    jQuery.post("<%=request.getContextPath()%>/SalaryclassAction.do?cmd=salaryInit&"+param,function(data){
		   document.getElementById("isRepetition").disabled = false;
		       if(data){
		        
		        jQuery("#h_clzId").val(data);
		        $id("dc_clz_init").reload();
		        alert("<fmt:message key="alert_init_success"/>");
		        
		       }
		    }
		    
		    );
		    
        }
    });
    
}
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
    return "<input " +check_is_valid(entity)+ " onclick='return procSend(this);' " + 
            " type='checkbox' name='chk_send_id' value='" + entity.getProperty("send_id") + "' />";
}
//处理委派单的有效性
function procSend(obj){
    dc = $id("dc_clz_init");
    clz = dc.getActiveEntity();
    dispatch_id = clz.getValue("dispatch_id");
    clzId = clz.getValue("id");
    if(!clzId){
    	alert("<fmt:message key="alert_customer_not_init"/>");
    	return false;
    }
    send_id = jQuery(obj).val();
    param = "clzId="+clzId+"&send_id="+send_id+"&is_valid="+obj.checked;
    //alert(param);
    msg = obj.checked? "<fmt:message key="alert_set_available"/>":"<fmt:message key="alert_set_disable"/>";
    if(confirm(msg)){
        jQuery.post("<%=request.getContextPath()%>/SalaryclassAction.do?cmd=procSend&"+param,function(data){
	       if(data){
	           rst = data.split("|");
	           d_id = rst[0];
	           backWriteDispatch_id(d_id);
	           alert("<fmt:message key="alert_success"/>");
	       }
        });
    }else{
        return false;
    }
    return true;
}
//处理委派单有效性完成后，回写dispatch_id
function backWriteDispatch_id(d_id){
    dc = $id("dc_clz_init");
    ds = dc.dataset;
    rc = ds.getLength();
    for(var i=0; i<rc; i++){
        entity = ds.get(i);
        entity.setProperty("dispatch_id", d_id);
    }
}
//datacell 重载后处理‘是否有效’checkbox是否选中
function check_is_valid(clz){
	//委派单都置为有效，入离职时员工的档案都已经生成
	return "checked";
    dispatch_id = clz.getValue("dispatch_id");
    send_id = clz.getProperty("send_id");
    if(dispatch_id){
        return dispatch_id.indexOf(send_id)==-1?"":"checked";
    }else{
        return false;
    }
}
//跳转到短信模板页面
function toMsgTemplate(){
        var h_cust_id = $id("h_cust_id").value ;
        if(!h_cust_id){
            alert("<fmt:message key="alert_select_customer"/>") ;
            return false ;
        }
         jQuery.post("<%=request.getContextPath()%>/SalaryclassAction.do?cmd=checkCust&custId="+h_cust_id,function(data){
        //alert(data);
        rst = data.split(",");
        if(rst[0] < 1){
            alert("<fmt:message key="alert_no_sendpost"/>");
        }else if(rst[1] > 0){
             url="<%=request.getContextPath()%>/jsp/faerp/salary/salaryclass/tomsgTemp.jsp?sa_class_id="+rst[1];
            window.open(url,"newwindow","width=900px,height=600px,location=no,scroll=yes");
        }
        
    });
    
    }
//延后报税申请
function applyDelayTax() {
        var custId = $id("h_cust_id").value ;
        if(custId == null || custId == ""){
            alert("请选择一个客户");
            return;
        }
        jQuery.ajax({
	          url : "<%=request.getContextPath()%>/SalaryclassAction.do?cmd=delayTaxApplyValidation&custId="+custId+"&_ts="+(new Date()).getTime(),
	          type: 'GET',
	          dataType: 'html',
	          async: false,
	          timeout: 10000,
	          error: function(){
	              alert('Error loading XML document');
	              return  null;
	          },
	          success: function(text){
	                               if(text != null){       
	                                     if(text == '1'){
	                                        var strUrl = "<%=request.getContextPath()%>/SalaryclassAction.do?cmd=applyDelayTax&custId="+custId;
                                            showModalCenter(strUrl, "", "", "880", "250", "延后报税申请");
	                                     }else{
	                                        alert(text);
	                                     }
	                                }else{
	                                     alert("Ajax异常，请联系系统管理员！");
	                                }
	                           }
        });
} 
</script>
<body>
<div id="right">
	<!--  
	<div class="right_title_bg">
	  <div class=" right_title">薪资初始化</div>
	</div>-->
    <div class="ringht_s">
	<div class="social_tab">
    	<div id="bg" class="social_xixi1">
			<div id="font1" class="social_tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='social_xixi1'">初始化</div>
			<div onclick="reloadQueryPage()" id="font2" class="social_tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='social_xixi2'">查询</div>
		</div>
    	<div id="TabCon1">
	        	<!--表格1-->
	            <div class="xz_title" style="margin-top:10px;"><fmt:message key="select_customer"/></div>
    			<div class="box_tab">
    			<form id="addform">
                  <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                  <tr>
                    <td class="td_1"><fmt:message key="select_customer"/></td>
                    <td class="td_2">
                      <w:lookup onReturnFunc="rtnFunc" readonly="true" id="lk_cust" 
                      lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" 
                      messagekey="select_customer" height="500" width="600" />
                      <input type="hidden" id="h_cust_id" name="customer_id" />
                      <input type="hidden" id="h_cust_code" name="customer_code" />
                      <input type="hidden" id="h_cust_name" name="customer_name" />
                      <input onclick="applyDelayTax();" type="button" class="foot_icon_2" style="margin-left: 13px;" <au:authorityBtn code="xzcsh_bsyhsq" type="1"/> value="报税延后申请"/>
                    </td>
                    </tr>
                  </table>
                  <div class="xz_title" style="margin-top:10px;"><fmt:message key="salary_type_setup"/></div>
                     <!--表格 -->
                     <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" >
                       <tr>
                         <td class="td_1"><span style="color:red">*</span><fmt:message key="pay_day"/></td>
                         <td class="td_2"><input name="payday" class="sText" id="t_payday"/></td>
                         <td class="td_1"><span style="color:red">*</span><fmt:message key="is_si"/></td>
                         <td class="td_2"><select name="is_si" class="sSelect" id="s_is_si">
                           <option value="0"><fmt:message key="unobtain"/></option>
                           <option value="1" selected><fmt:message key="obtain"/></option>
                         </select></td> 
                         <td class="td_1"><span style="color:red">*</span><fmt:message key="get_month_bd"/></td>
                         <td class="td_2"><select name="get_month_bd" class="sSelect" id="s_get_month_bd">
                            <option value="0" selected><fmt:message key="get_month_now"/></option>
                            <option value="1" ><fmt:message key="get_month_before"/></option>
                         </select></td>

                       </tr>
                       <tr> 
                       <td class="td_1"><span style="color:red">*</span><fmt:message key="si_source"/></td>
                         <td class="td_2"><select name="si_source" class="sSelect" id="s_si_source">
                          <option value="0"><fmt:message key="si_source_bill"/></option>
                         </select></td>

                         <td class="td_1"><span style="color:red">*</span><fmt:message key="payroll_type_bd"/></td>
                         <td class="td_2" colspan="3">
                         <d:select name="payroll_type_bd" dictTypeId="PAYROLL_TYPE_BD" id="s_payroll_type" onchange="savePayroll(this)"/>
                         </td>
                         <!--  <td class="td_1">
                         <span style="color:red">*</span><fmt:message key="tax_region_bd"/>
                        </td>                        <td class="td_2">
                        	<select name="tax_region_bd" class="sSelect" id="s_tax_region_bd">
                        		<option value="0" selected><fmt:message key="tax_region_before"/></option>
                        		<option value="1"><fmt:message key="tax_region_now"/></option>
                        	</select>
                        </td>-->
                       </tr>
                       <tr>
                       <td class="td_1"></td>
                         <td class="td_2"></td>
                         <td class="td_1"></td>
                         <td class="td_2">
                         </td>
                        <td class="td_1">  
                        </td>
                        <td class="td_2">
                        	<input onclick="doSalaryInit();" id="isRepetition" type="button" class="foot_icon_1" <au:authorityBtn code="xzcsh_qd" type="1"/> value="<fmt:message key="button_confirm"/>"/>
                        	<input onclick="toMsgTemplate();" type="button" class="foot_icon_1" <au:authorityBtn code="xzcsh_qd" type="1"/> value=" 短信模板"/> 
                        </td>
                       </tr>
                  </table>
                  </form>
    			</div>
    			<!--表格 end-->
                <div class="button_salary">
                  <div class="button_right">
                    <!--<ul>
                      <li class="bc"><a onclick="doModifyClz_init()">保存</a></li>
                    </ul>
                    -->
                    <input class="bc" type="button"   value="<fmt:message key="button_save"/>"  <au:authorityBtn code="xzcsh_save" type="1"/>  onClick="doModifyClz_init();">
                  </div>
                  <div class="clear"></div>
                </div>
				<form id="inform" action="/SalaryclassAction.do?cmd=initQuery" method="post">
	              <input type="hidden" id="h_clzId" name="clzId" value=""/>
	              <input type="hidden" id="h_custId" name="custId" value=""/>
	              <input type="hidden" id="h_payroll_type" name="payroll_type" value=""/>
	              <input type="hidden" id="h_tax_region_bd" name="tax_region_bd" />
	                <r:datacell 
	                     id="dc_clz_init"
	                     queryAction="/FAERP/SalaryclassAction.do?cmd=initQuery"
	                     submitAction="/FAERP/SalaryclassAction.do?cmd=update"
	                     width="100%"
	                     xpath="SalaryclassVo"
	                     submitXpath="SalaryclassVo"
	                     paramFormId="inform"
	                     pageSize="100"
	                     >
	             
	                     <r:field width="200" sortAt="none" fieldName="sa_class_name" messagekey="salary_type">
	                         <h:text validateAttr="maxLength=500"/>
	                     </r:field>
	                     <r:field sortAt="none" fieldName="payday" messagekey="payday">
	                         <h:text validateAttr="type=payday"/>
	                     </r:field>
	                     <r:field width="150" sortAt="none" fieldName="is_si" messagekey="is_si">
	                         <h:select property="is_si">
	                             <h:option value="1" label="获取"/>
	                             <h:option value="0" label="不获取"/>
	                         </h:select>
	                     </r:field>
	                     <r:field sortAt="none" fieldName="get_month_bd" messagekey="get_month_bd">
	                         <h:select property="get_month_bd">
	                             <h:option value="0" label="本月"/>
	                             <h:option value="1" label="上月"/>
	                         </h:select>
	                     </r:field>
	                     <r:field sortAt="none" fieldName="tax_region_bd" label="报税区间" allowModify="false">
                             <h:select property="tax_region_bd">
                                 <h:option value="0" label="报上月"/>
                                 <h:option value="1" label="报当月"/>
                             </h:select>
                         </r:field>
	                     <r:field sortAt="none" fieldName="si_source" messagekey="si_source" allowModify="false">
	                         <h:select property="si_source">
	                              <h:option value="0" label="账单"/>
	                         </h:select>
	                     </r:field>
	                     <r:field sortAt="none" fieldName="payroll_type_bd" messagekey="payroll_type_bd">
	                         <d:select property="payroll_type_bd" name="list_payroll_type" dictTypeId="PAYROLL_TYPE_BD"/>
	                     </r:field>
	                     <r:field width="240" sortAt="none" fieldName="send_name" messagekey="send_name" allowModify="false">
	                         <h:text/>
	                     </r:field>
	                     <r:field sortAt="none" fieldName="is_valid" messagekey="is_valid" onRefreshFunc="showchkbox">
	                     </r:field>
	                   </r:datacell>
	             </form>	
        </div>
        <!-- 查询标签页 -->
		<form id="form_qry" name="form_qry" action="/SalaryclassAction.do?cmd=simpleQuery" method="post">
		<div id="TabCon2" style="display:none;">
          <div class="box_tab">
            <div class="xz_title" style="margin-top:10px;"><fmt:message key="salaryclass_search"/></div>
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
            <tr>
              <td class="td_1"><fmt:message key="customer_code"/></td>
              <td class="td_2"><input name="customer_code" inputName="客户编号" maxLength="128" class="sText"/></td>
              <td class="td_1"><fmt:message key="customer_name"/></td>
              <td class="td_2"><input name="customer_name" inputName="客户名称" maxLength="100"/></td>
            </tr>
            <tr>
              <td class="td_1"><fmt:message key="payday_from"/></td>
              <td class="td_2"><input name="payday_from" id="txt_pay_from" class="sText" validate="isNum" style="width:91px;"/>
              <input name="payday_to" id="txt_pay_to" class="sText"  validate="isNum" style="width:91px;"/></td>
              <td class="td_1">&nbsp;</td>
              <td class="td_2"><input onclick="qry()" type="button" class="icon_1" value="<fmt:message key="button_search"/>" /></td>
            </tr>
            </table>
               
          </div>
          <!-- 
          <div class="button_salary">
            <div class="button_right">
              <ul>
                <li class="bc"><a onclick="doModifyClz_qry()">保存</a></li>
              </ul>
            </div>
            <div class="clear"></div> 
          </div> -->
          <r:datacell 
              id="dc_salary_clz"
              queryAction="/FAERP/SalaryclassAction.do?cmd=simpleQuery"
              submitAction="/FAERP/SalaryclassAction.do?cmd=update"
              width="100%"
              xpath="SalaryclassVo"
              submitXpath="SalaryclassVo"
              paramFormId="form_qry"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
      
              <r:field fieldName="customer_code" messagekey="customer_code">
              </r:field>
               <r:field width="300" fieldName="customer_name" messagekey="customer_name">
              </r:field>
               <r:field width="300" fieldName="sa_class_name" messagekey="salary_type" >
              </r:field>
              <r:field fieldName="payday" messagekey="payday">
              </r:field>
              <r:field fieldName="is_si" messagekey="is_si"  allowModify="false">
	                <h:select property="is_si">
	                     <h:option value="1" label="获取"/>
	                     <h:option value="0" label="不获取"/>
	                </h:select>            
              </r:field>
              <r:field fieldName="get_month_bd" messagekey="get_month_bd" allowModify="false">
	               <h:select property="get_month_bd">
	                     <h:option value="0" label="本月"/>
	                     <h:option value="1" label="上月"/>
	               </h:select>
              </r:field>
              <r:field fieldName="si_source" messagekey="si_source" allowModify="false">
	              <h:select property="si_source">
	                   <h:option value="0" label="账单"/>
	              </h:select>
              </r:field>
            </r:datacell>
		</div>
	</form>
    <!-- 查询标签页 -->
    </div>
</div>
</div>
</body>
</fmt:bundle>
</html>
