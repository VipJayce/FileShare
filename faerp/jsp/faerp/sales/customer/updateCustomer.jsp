<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title><fmt:message key="customer_modify"/></title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    
    jQuery(document).ready(function(){
        var mmvalue = '${bean.receive_money_month}';
        var rem = $id("receive_money_month");
        var vv = $id("is_account_limit");
        
        //没有账期 
        if(vv.value=="0"){
            for(var i=rem.length;i>0;i--){
                    rem.remove(i-1);
            }
            var opt0=new Option('<fmt:message key="please_choose"/>','');
            var opt1=new Option('<fmt:message key="bills_receivable_in_month"/>','1');
            var opt13=new Option('<fmt:message key="receive_money_month"/>','13');
            rem.options.add(opt0);
            rem.options.add(opt13);
            rem.options.add(opt1);
            rem.value = mmvalue;
        //有账期显示所有
        }else{
            for(var i=rem.length;i>0;i--){
                    rem.remove(i-1);
            }
            var opt0=new Option('<fmt:message key="please_choose"/>','');
            var opt13=new Option('<fmt:message key="receive_money_month"/>','13');
            rem.options.add(opt0);
            rem.options.add(opt13);
            for(var i=1;i<13;i++){
                var opt=new Option('<fmt:message key="bills_receivable_in"/>'+i+'<fmt:message key="month"/>','' + i + '');
                rem.options.add(opt);
                
            }
            rem.value = mmvalue;
        }
        
        var lookup = $id("group_family_prop");
	    if(lookup.value == null || lookup.value == "null" || lookup.value == ""){
	        $id("group_family_prop").value="";
	        $id("group_family_prop").displayValue="";
	        $id("group_family_prop_input").value = "";
	    }
    });
    
	var isQA = '${isQA}';
	var cust_status = '${cust_status}';
	function save_onClick(){  //保存
		if(isQA=='true'){
			if(vailform()){
		   		form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=update&cust_status="+cust_status;
				form.submit();
				window.close();
				window.opener.simpleQuery_onClick();
	    	}
		}else{
	   		form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=update&cust_status="+cust_status;
			form.submit();
			window.close();
			window.opener.simpleQuery_onClick();
		}
	   
	}
	
	function vailform(){
        var  code = document.getElementById("customer_code").value;
        if(code==null || code==""){
            alert("<fmt:message key="input_customer_code"/>");
            jQuery("#customer_code").focus();
            return false;
        }
        
        var  customer_property = document.getElementById("customer_property").value;
        if(customer_property==null || customer_property==""){
            alert("<fmt:message key="input_customer_property"/>");
            return false;
        }
        
        var  customer_name = document.getElementById("customer_name").value;
        if(customer_name==null || customer_name==""){
            alert("<fmt:message key="input_customer_name"/>");
            return false;
        }
        var  customer_type = document.getElementById("customer_type").value;
        if(customer_type==null || customer_type==""){
            alert("<fmt:message key="input_customer_type"/>");
            return false;
        }
        var  is_sale_achievement = document.getElementById("is_sale_achievement").value;
        if(is_sale_achievement==null || is_sale_achievement==""){
            alert("<fmt:message key="choose_is_sale_achievement"/>");
            return false;
        }
        //var  customer_service = document.getElementById("customer_service").value;
        //if(customer_service==null || customer_service==""){
        //    alert("请选择销售/客服");
        //    return false;
        //}
       
        var is_account_limit = document.getElementById('is_account_limit').value;
        if(is_account_limit == null || is_account_limit == ''){
            alert('<fmt:message key="choose_is_account_limit"/>');
            return false;
        }
        var  receive_money_month = document.getElementById("receive_money_month").value;
        if(receive_money_month==null || receive_money_month==""){
            alert("<fmt:message key="choose_receive_money_month"/>");
            return false;
        }
       /*
        var  agree_on_receive_money_date = document.getElementById("agree_on_receive_money_date").value;
        if(agree_on_receive_money_date==null || agree_on_receive_money_date==""){
            alert("<fmt:message key="input_agree_receive_money_date"/>");
            return false;
        }else{
            if(receive_money_month != '13'){
                if(agree_on_receive_money_date > 5){
                    alert('<fmt:message key="receive_money_date_less_number"/>');
                    return false;
                 }
            }else if(agree_on_receive_money_date>31 || agree_on_receive_money_date<0){
                alert('<fmt:message key="agree_receive_money_date_number"/>');
                return false;
            }
        }
        */
        //modifyby sqp
        var  agree_on_receive_money_date = document.getElementById("agree_on_receive_money_date").value;
        if(agree_on_receive_money_date==null || agree_on_receive_money_date==""){
            alert("<fmt:message key='input_agree_receive_money_date'/>");
            return false;
        }else{
        if(is_account_limit=="0"){
            if(receive_money_month != '13'){
                if(agree_on_receive_money_date > 5){
                    alert('<fmt:message key='receive_money_date_less_number'/>');
                    return false;
                 }
            }else if(agree_on_receive_money_date>31 || agree_on_receive_money_date<0){
                alert('<fmt:message key='agree_receive_money_date_number'/>');
                return false;
            }
            }
            else if(agree_on_receive_money_date>31 || agree_on_receive_money_date<0){
                alert('<fmt:message key='agree_receive_money_date_number'/>');
                return false;
                }
        }
        
        //yangxu 合同约定到款日
        
        var  contract_receive_money_month = document.getElementById("contract_receive_money_month").value;
        //if(contract_receive_money_month==null || contract_receive_money_month==""){
        //    alert("请选择合同约定到款日所属月");
        //    return false;
        //}
        
        
        var  contract_receive_money_date = document.getElementById("contract_receive_money_date").value;
        if(contract_receive_money_month!=null && contract_receive_money_month!="" && contract_receive_money_date!=null && contract_receive_money_date!=""){
         //   alert("请输入合同约定到款日");
        //    return false;
        //}else{
        if(is_account_limit=="0"){
            //alert(contract_receive_money_month);
            if(contract_receive_money_month != '13'){
                if(contract_receive_money_date > 5){
                    alert('合同约定到款日不能超过5号');
                    return false;
                 }
            }else if(contract_receive_money_date>31 || contract_receive_money_date<0){
                alert('合同约定到款日只能是1-31之间数字');
                return false;
            }
            }
            else if(contract_receive_money_date>31 || contract_receive_money_date<0){
                alert('合同约定到款日只能是1-31之间数字');
                return false;
                }
        }
        //yangxu 合同约定到款日 end
        
        
        
        var  if_beforehand_voucher = document.getElementById("is_beforehand_voucher").value;
        if(if_beforehand_voucher==null || if_beforehand_voucher==""){
            alert("<fmt:message key="choose_is_beforehand_voucher"/>");
            return false;
        }
        var  if_remittance_error = document.getElementById("is_remittance_error").value;
        if(if_remittance_error==null || if_remittance_error==""){
            alert("<fmt:message key="choose_is_remittance_error"/>");
            return false;
        }
        var  if_fixed_pay_later = document.getElementById("is_fixed_pay_later").value;
        if(if_fixed_pay_later==null || if_fixed_pay_later==""){
            alert("<fmt:message key="choose_is_fixed_pay_later"/>");
            return false;
        }
           var  is_sale_achievement = document.getElementById("is_sale_achievement").value;
        if(is_sale_achievement=="1"){
            var  customer_sales_name = document.getElementById("customer_sales_service").value;
            if(customer_sales_name==null || customer_sales_name=="" ){
            alert("<fmt:message key='choose_customer_sales_name'/>");
            return false;
            }
        }
        
        var  trade_type = $id('trade_type').getValue();
        if(trade_type==null || trade_type==""){
            alert("<fmt:message key="choose_trade_type"/>");
            return false;
        }
        return true;
    }
    
    function onkeyupvaliname() {
        var name = document.getElementById("customer_name").value;
        var cust_name = document.getElementById("cust_name").value;
        if(name != cust_name){
            if(name!=null&&name!=''){
                 jQuery.ajax({
                   url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=vailCustName&name='+encodeURI(name),
                   type: 'POST',
                   dataType: 'html',
                   async: false,
                   timeout: 10000,
                       error: function(){
                          alert('<fmt:message key="repeat_customer_name"/>');
                          jQuery("#customer_name").val("");
                          return;
                       },
                        success: function(data){
                            if(data=='true'){
                               alert('<fmt:message key="repeat_customer_name"/>');
                               jQuery("#customer_name").val("");
                               return;
                           }
                       }
                   });
               }
          }
    }
    
    function onkeyupvalicode(){
        var  code = document.getElementById("customer_code").value;
        var cust_code = document.getElementById("cust_code").value;
        if(code!=cust_code){        
            if(/.*[\u4e00-\u9fa5]+.*$/.test(code)){ 
                alert("<fmt:message key="customer_type_error"/>"); 
                return; 
           }
           jQuery.ajax({
           url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=vailCustCode&code='+code,
           type: 'POST',
           dataType: 'html',
           async: false,
           timeout: 10000,
               error: function(){
                  alert('<fmt:message key="repeat_customer_type"/>');
                  jQuery("#customer_code").val("");
                  jQuery("#customer_code").removeAttr("disabled");
                  jQuery("#custbtn").removeAttr("disabled");
                  return;
               },
                success: function(data){
                        if(data=='false'){
                              alert('<fmt:message key="repeat_customer_type"/>');
                              jQuery("#customer_code").val("");
                              jQuery("#customer_code").removeAttr("disabled");
                              jQuery("#custbtn").removeAttr("disabled");
                              return;
                          }
               }
           });
       }
    }
    
    //获取客户code
    function getcode(){
       //AjaxControl.getCustomerCode(getMsg);
       var flags=true;
        jQuery.ajax({
        url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=getCustCode',
        type: 'POST',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(code){
            document.getElementById("customer_code").value=code;
            document.getElementById("custbtn").disabled="disabled";
            document.getElementById("customer_code").disabled="disabled";
            document.getElementById("code_type").value = '0';
        }
        });
        return flags;
    }
    
    //控制是否有账期时 到款日所属月显示值
    function amount(v){
        var rem = $id("receive_money_month");
        //没有账期 
        if(v.value=="0"){
        
            for(var i=rem.length;i>0;i--){
                    rem.remove(i-1);
            }
            var opt0=new Option('<fmt:message key="please_choose"/>','');
            var opt1=new Option('<fmt:message key="bills_receivable_in_month"/>','1');
            var opt13=new Option('<fmt:message key="receive_money_month"/>','13');
            rem.options.add(opt0);
            rem.options.add(opt13);
            rem.options.add(opt1);
            rem.value = 13;
        //有账期显示所有
        }else{
            for(var i=rem.length;i>0;i--){
                    rem.remove(i-1);
            }
            var opt0=new Option('<fmt:message key="please_choose"/>','');
            var opt13=new Option('<fmt:message key="receive_money_month"/>','13');
            rem.options.add(opt0);
            rem.options.add(opt13);
            for(var i=1;i<13;i++){
                var opt=new Option('<fmt:message key="bills_receivable_in"/>'+i+'<fmt:message key="month"/>','' + i + '');
                rem.options.add(opt);
                rem.value = 13;
            }
        }
    }
    
        function dochange(valu){
    if (valu.value=="1"){
        document.getElementById("customer_sales_req").style.display="inline";
        }else{
        document.getElementById("customer_sales_req").style.display="none";
        }
  }
  
  function rtnFunc(arg){
      var lookup = $id("group_family_prop");
      lookup.value = arg[0];
      lookup.displayValue = arg[2]+"-"+arg[4];
      return false;
  }
    
    function double_onchlick(){
        $id("group_family_prop").value = "";
        $id("group_family_prop").displayValue="";
        $id("group_family_prop_input").value = "";
    }
    
    //新增到款公司名称
    function addCustIncName(){
        $id("datacell2").addRow();
    }
    
    //删除到款公司名称
    function deleteCustIncName(){
         $id("datacell2").deleteRow();
    }
    
    //提交操作
    function saveCustIncName(){
        if($id("datacell2").submit()){
             alert("操作成功！");
             $id("datacell2").loadData();
             $id("datacell2").refresh();
        }
    }
</script>
</head>


<body>

<form name="form" method="post">

<div id="right">
 <div class="ringht_x">
   <div id="ccParent0" class="box_3"> 
<div class="xz_title"><fmt:message key="basic_information"/></div>
        <input type="hidden" name="customer_simple_create_date">
        <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="customer_code"/></font></td>
            <td width="28%" class="td_2 ">
                <input type="text" class="text_field"  id="customer_code" name="customer_code" inputName="客户编号" value="${bean.customer_code}" maxLength="25" validate="notNull;" onblur="onkeyupvalicode();" />
                <input type="hidden" name="cust_code" id="cust_code" value="${bean.customer_code }"/>
                <input type="hidden" name="id" value="${bean.id}"/>
           </td>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="customer_name"/></font></td>
            <td width="26%" class="td_2 " >
                <input type="text" class="text_field"  name="customer_name" id="customer_name" inputName="客户名称" value="${bean.customer_name}" maxLength="300" validate="notNull;" onblur="onkeyupvaliname();"/>
                <input type="hidden" name="cust_name" id="cust_name" value="${bean.customer_name}" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="customer_property"/></font></td>
            <td class="td_2" >
                <d:select dictTypeId="CUSTOMER_PROPERTY" id="customer_property" name="customer_property" value="${bean.customer_property}"/>
            </td>
            <td class="td_1" ><fmt:message key="customer_en_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="customer_en_name" name="customer_en_name" inputName="客户英文名" value="${bean.customer_en_name}" maxLength="2000" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="customer_simple_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="customer_simple_name" name="customer_simple_name" inputName="客户简称" value="${bean.customer_simple_name}" maxLength="50" />
            </td>
             <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="customer_type"/></font></td>
            <td class="td_2" >
            <d:select dictTypeId="CUSTOMER_TYPE" id="customer_type" name="customer_type" value="${bean.customer_type}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="country_name"/></td>
            <td class="td_2" >
              <r:comboSelect id="country_area" name="country_area" queryAction="/FAERP/CustomerAction.do?cmd=queryCountryData" 
                textField="name" valueField="id" xpath="CustomerSelectVo" width="205px"  messagekey="please_choose" value="${bean.country_area}"/>

            </td>
            <td class="td_1" ><fmt:message key="contact_address"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_address" name="contact_address" inputName="联系地址" value="${bean.contact_address}" maxLength="75" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="contact_person"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_person"  name="contact_person" inputName="联系人" value="${bean.contact_person}" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="tel_phone1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tel_phone1" name="tel_phone1" inputName="联系电话1" value="${bean.tel_phone1}" maxLength="50" validate="notChinese" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="zip_code"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="zip_code" name="zip_code" inputName="邮政编码" value="${bean.zip_code}" maxLength="6" vaildate="isNum "/>
            </td>
            <td class="td_1" ><fmt:message key="fax"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="fax" name="fax" inputName="传真" value="${bean.fax}" maxLength="12"  validate="notChinese"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="tel_phone2"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tel_phone2" name="tel_phone2" inputName="联系电话2" value="${bean.tel_phone2}" maxLength="50" validate="notChinese" />
            </td>
            <td class="td_1" >EMAIL</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="email" name="email" inputName="EMAIL" value="${bean.email}" maxLength="50"  validate="isEmail"/>
                <input type="hidden" id="email_bak" name="email_bak" value="${bean.email }">
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="bank"/></td>
            <td class="td_2" >
                <d:select dictTypeId="BANK" id="bank" name="bank" value="${bean.bank}"/>
            </td>
            <td class="td_1" ><fmt:message key="bank_account"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="bank_account" name="bank_account" inputName="银行帐号" value="${bean.bank_account}" maxLength="50" validate="isNum"  />
            </td>
        </tr>
        <tr>
            <td class="td_1" >服务模式</td>
            <td class="td_2" >
                <d:select dictTypeId="IS_ZHONGLIANG" id="is_zhongliang" name="is_zhongliang" nullLabel="-请选择-" value="${bean.is_zhongliang}"  />
            </td>
            <td class="td_1" ><fmt:message key="is_import_client"/></td>
            <td class="td_2" >
                <d:select dictTypeId="TrueOrFalse" id="is_import_client" name="is_import_client" value="${bean.is_import_client}" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="is_sale_achievement"/></font></td>
            <td class="td_2" >
            <d:select dictTypeId="TrueOrFalse" id="is_sale_achievement" name="is_sale_achievement" value="${bean.is_sale_achievement}" onchange="javascript:dochange(this);"/>
            </td>
            <td class="td_1"><fmt:message key="sale_achievement_remarks"/></td>
            <td class="td_2" >
                 <input type="text" class="text_field" name="sale_achievement_remarks" id="sale_achievement_remarks" inputName="是否销售业绩备注" value="${bean.sale_achievement_remarks}" maxLength="1000" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="is_account_limit"/></td>
            <td class="td_2 ">
                <d:select dictTypeId="TrueOrFalse" id="is_account_limit" name="is_account_limit" value="${bean.is_account_limit}" onchange="amount(this)" />
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="customer_service_name"/></font></td>
            <td class="td_2 ">
                <r:comboSelect id="customer_service" name="customer_service"  queryAction="/FAERP/CustomerAction.do?cmd=queryCustomerServiceData" value="${bean.customer_service}"
                textField="name" valueField="pid" xpath="Partyrelation" width="205px"  messagekey="please_choose" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="agree_on_receive_money_date"/></td>
            <td class="td_2">
                <input type="text" class="text_field" name="agree_on_receive_money_date" id="agree_on_receive_money_date" inputName="约定到款日" validate="notNull;isNum" value="${bean.agree_on_receive_money_date}"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="receive_money_month"/></td>
            <td class="td_2 "><!-- filterOp="in" filterStr="1,13"-->
                <d:select dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month" value="${bean.receive_money_month}" />
            </td>
        </tr>
        
<!--     yangxu   -->
        <tr>
            <td class="td_1" ><font style="color: red;"><fmt:message key="contract_receive_money_date"/></font></td>
            <td class="td_2">
                <input type="text" class="text_field" name="contract_receive_money_date" id="contract_receive_money_date" inputName="约定到款日" validate="notNull;isNum" value="${bean.contract_receive_money_date}"/>
            </td>
            <td class="td_1" ><font style="color: red;"><fmt:message key="contract_receive_money_month"/></font></td>
            <td class="td_2 ">  <!--filterOp="in" filterStr="1,13" -->
                <d:select dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month"  id="contract_receive_money_month" value="${bean.contract_receive_money_month}" />
            </td>
        </tr>
<!--     yangxu   -->
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="is_beforehand_voucher"/></td>
            <td class="td_2 ">
                <d:select dictTypeId="TrueOrFalse" id="is_beforehand_voucher" name="is_beforehand_voucher" value="${bean.is_beforehand_voucher}"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="is_remittance_error"/></td>
            <td class="td_2 ">
                <d:select dictTypeId="TrueOrFalse" id="is_remittance_error" name="is_remittance_error" value="${bean.is_remittance_error}"  />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="is_fixed_pay_later"/></td>
            <td class="td_2" >
                <d:select dictTypeId="TrueOrFalse" id="is_fixed_pay_later" name="is_fixed_pay_later" value="${bean.is_fixed_pay_later}"  />
            </td>
            <td class="td_1" ><fmt:message key="is_physical_examination"/></td>
            <td class="td_2" >
                <d:select dictTypeId="TrueOrFalse" id="is_physical_examination" name="is_physical_examination" value="${bean.is_physical_examination}"  />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='cust_source'/></td>
            <td class="td_2" >
               <%
                rayoo.sales.customer.vo.CustomerIBDVo ibdBeanVo = (rayoo.sales.customer.vo.CustomerIBDVo)request.getAttribute("ibdBean");
                String cust_source = "";
                if (ibdBeanVo != null){
                    cust_source = String.valueOf(ibdBeanVo.getCust_source());
                }
                %>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("cust_source", -1, "CUST_SOURCE_BD", cust_source, "", false) %>
            </td>
            <td class="td_1" ><fmt:message key='ibd_sales'/></td>
            <td class="td_2" >
                <r:comboSelect id="ibd_sales" name="ibd_sales"  queryAction="/FAERP/CustomerAction.do?cmd=queryIbdCustomerServiceData" value="${ibdBean.ibd_sales }"
                textField="name" valueField="pid" xpath="Partyrelation" width="205px"  messagekey="please_choose"/>
            </td>
        </tr>
        <tr>
          <td class="td_1" ><span  id="customer_sales_req" class="style_required_red" style="display:none">* </span><font style="color: red;"><fmt:message key='customer_sales_name'/></font></td>
            <td class="td_2 ">
                <r:comboSelect id="customer_sales_service" name="customer_sales_service"  queryAction="/FAERP/CustomerAction.do?cmd=queryCustomerServiceDataForSales"  value="${bean.customer_sales_service}" 
                textField="name" valueField="pid" xpath="Partyrelation" width="205px"  messagekey="please_choose"/>
            </td>
              <td width="23%" class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_salary_unconfirm_import'/></td>
            <td width="26%" class="td_2 ">
            <d:select dictTypeId="TrueOrFalse" id="is_salary_unconfirm_import" name="is_salary_unconfirm_import" value="${bean.is_salary_unconfirm_import}" />
            </td>
        </tr>
        <tr>
            <td width="23%" class="td_1" >集团户属性</td>
            <td width="28%" class="td_2" >
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="108px" readonly="true" id="group_family_prop" name="group_family_prop_id" lookupUrl="/CustomerAction.do?cmd=queryGroupFamilyPropAllGetByID" displayValue="${bean.group_family_prop_name }-${bean.group_family_prop_type }" dialogTitle="选择集团户属性" height="350" width="650"/>
                &nbsp;&nbsp;<a style="color: red; cursor: pointer;" ondblclick="double_onchlick();">双击清空</a>
            </td>
            <td width="23%" class="td_1" >客户组</td>
            <td width="26%" class="td_2 ">
            <r:comboSelect id="cust_group" name="cust_group" queryAction="/FAERP/Cust_groupAction.do?cmd=queryListCustname"
              textField="cust_group_name" valueField="cust_group_code" xpath="Cust_groupVo" width="200px"  messagekey="--请选择--"  value="${bean.cust_group}"/> 
            </td>
        </tr>
        </table>
        <p></p>
        <div class="xz_title"><fmt:message key="customer_information"/></div>
        <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">   
            <tr>
            <td width="23%"  class="td_1" ><fmt:message key="invest_total_sum"/></td>
            <td width="28%"  class="td_2" >
                <input type="text" class="text_field" id="invest_total_sum" name="invest_total_sum" inputName="投资总额" value="${bean.invest_total_sum}"  maxLength="21" />
            </td>
            <td width="23%"  class="td_1" ><fmt:message key="register_money"/></td>
            <td width="26%"  class="td_2" >
                <input type="text" class="text_field" id="register_money" name="register_money" inputName="注册资金" value="${bean.register_money}" maxLength="21" />
            </td>
            </tr>
            
            <tr>
              <td class="td_1" ><fmt:message key="organization_number"/></td>
              <td class="td_2 ">
                <input type="text" class="text_field" id="organization_number" name="organization_number" inputName="组织机构代码" value="${bean.organization_number}" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="ceo_en_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_en_name" name="ceo_en_name" inputName="CEO英文姓名" value="${bean.ceo_en_name}" maxLength="50" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" ><fmt:message key="manage_start_date"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="manage_start_date" name="manage_start_date" format="YYYY-MM-DD" property="bean/manage_start_date" width="190px"/>
            </td>
            <td class="td_1" ><fmt:message key="manage_end_date"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="manage_end_date" name="manage_end_date" format="YYYY-MM-DD" property="bean/manage_end_date" width="190px"/>
            </td>
            </tr>           
            <tr>
            <td  class="td_1" ><fmt:message key="registered_capital"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="registered_capital" name="registered_capital" inputName="注册资本" maxLength="21"  value="${bean.registered_capital}"  />
            </td>
            <td  class="td_1" ><fmt:message key="registered_total_sum"/></td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="registered_total_sum" name="registered_total_sum" inputName="投资总额" maxLength="21"   value="${bean.registered_total_sum}" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" ><fmt:message key="undertake_company"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="undertake_company" name="undertake_company" inputName="承办单位" value="${bean.undertake_company}" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="invest_company"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="invest_company"  name="invest_company" inputName="投资方" value="${bean.invest_company}" maxLength="50" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" ><fmt:message key="ceo_county"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_county" name="ceo_county" inputName="CEO国别" value="${bean.ceo_county}" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="ceo_birthday"/></td>
            <td class="td_2">
                <w:date allowInput="true" id="ceo_birthday" name="ceo_birthday" format="YYYY-MM-DD" property="bean/ceo_birthday" width="190px"/>                
            </td>
            </tr>
            
            <tr>
            <td class="td_1" ><fmt:message key="ceo_name"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_name"  name="ceo_name" inputName="CEO姓名" value="${bean.ceo_name}" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="corporation"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="corporation" name="corporation" inputName="法人代表" value="${bean.corporation}" maxLength="50" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" ><fmt:message key="invest_adress"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="invest_adress" name="invest_adress" inputName="注册地址" value="${bean.invest_adress}" maxLength="75" />
            </td>
            <td class="td_1"><fmt:message key="business_scope"/></td>
            <td colspan="3" class="td_2" >
                 <input type="text" class="text_field" id="business_scope" name="business_scope" inputName="营业范围" value="${bean.business_scope}" maxLength="1000" />
            </td>
            </tr>
        </table>
        <p></p>
        <div class="xz_title">客户到款公司名称</div>
        <c:if test="${isQA == true}">
	        <div class="button_right">
	            <input class="c"  type="button"   value="新增"    onClick="addCustIncName();">
	            <input class="d"  type="button"   value="删除"    onClick="deleteCustIncName();">
	            <input class="dj_3"  type="button"   value="保存操作"    onClick="saveCustIncName();">
	        </div>
        </c:if>
        <div id="incCustNameDiv">
            <r:datacell id="datacell2"
             queryAction="/FAERP/CustomerIncNameAction.do?cmd=searchCustIncName&cust_id=${bean.id}"
             submitAction="/FAERP/CustomerIncNameAction.do?cmd=updateMulti&cust_id=${bean.id}"
             width="100%" height="128px" xpath="CustomerIncNameVo" submitXpath="CustomerIncNameVo"
             pageSize="1000">
	             <r:field width="0px" fieldName="id" label="id" allowModify="false"></r:field>
	             <r:field width="0px" fieldName="cust_id" label="cust_id" allowModify="false"></r:field>
	             <r:field width="300px" fieldName="inc_cust_name" label="<font style='color:#075587;'>到款公司名称</font>" >
	                 <c:if test="${isQA == true}"><h:text /></c:if>
	             </r:field>
	             <r:field width="100px" fieldName="create_user_name" label="<font style='color:#075587;'>创建人</font>"  allowModify="false">
	             </r:field>
	             <r:field width="200px" fieldName="create_date" label="<font style='color:#075587;'>创建时间</font>" allowModify="false">
	             </r:field>
            </r:datacell>
        </div>
            
        <p></p>
        
       <div class="xz_title"><fmt:message key="extra_message"/></div>
       <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
         <td width="23%" class="td_1" ><span class="style_required_red">* </span><font style="color: red;"><fmt:message key="industry_type_name"/></font></td>
         <td width="28%" class="td_2" > 
         <r:comboSelect id="trade_type" name="trade_type" queryAction="/FAERP/CustomerAction.do?cmd=queryIndustryTypeData"
              textField="name" valueField="id" xpath="CustomerSelectVo" width="205px"  messagekey="please_choose" value="${bean.trade_type}" />
        </td>
        <td width="23%" class="td_1" ><fmt:message key="company_webadress"/></td>
        <td width="26%" class="td_2" >
            <input type="text" class="text_field" id="company_webadress" name="company_webadress" inputName="公司网址" value="${bean.company_webadress}" maxLength="75" />
        </td>
        </tr>
       <tr>
            <td class="td_1"><fmt:message key="remarks"/></td>
            <td colspan="3" class="td_2" >
                 <input type="text" class="text_field"  id="remarks" name="remarks" inputName="备注说明" value="${bean.remarks}" maxLength="1000" style="width:100%;" />
            </td>
        </tr>
    <tr>
        <td class="td_1"><fmt:message key="customer_situation"/></td>
         <td colspan="3" class="td_2" >
                 <input type="text" class="text_field" id="customer_situation" name="customer_situation" inputName="客户情况简介" value="${bean.customer_situation}" maxLength="1000" style="width:100%;"/>
            </td>
    </tr>
    <tr>
            <td class="td_1"><fmt:message key="bad_record"/></td>
            <td colspan="3" class="td_2" >
                <input type="text" class="text_field" id="bad_record" name="bad_record" inputName="不良记录" value="${bean.bad_record}" maxLength="1000" style="width:100%;"/>
                <input type="hidden" name="id" value="${bean.id}">
            </td>
        </tr>
        <tr>
            <td class="td_1">legal entity code</td>
            <td colspan="3" class="td_2" >
                <input type="text" class="text_field" id="legal_entity_code" name="legal_entity_code" inputName="legal entity code" value="${bean.legal_entity_code }" maxLength="75"/>
            </td>
        </tr>
       </table>
     
     <div class="mx_button" style="text-align: center;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:save_onClick()"/>
    </div>           
</div>
</div>
</div>
</form>
</body>


<script language="javascript">
	var isQA = '${isQA}';
    if(isQA=="true"){
		$id("customer_service").disabled = "true";
	}else{
		jQuery("#receive_money_month").attr("disabled", "disabled");
		jQuery("#agree_on_receive_money_date").attr("disabled", "disabled");
		
		jQuery("#contract_receive_money_date").attr("disabled", "disabled");
		jQuery("#contract_receive_money_month").attr("disabled", "disabled");
		
		jQuery("#customer_code").attr("disabled", "disabled");
		jQuery("#customer_name").attr("disabled", "disabled");
		jQuery("#is_sale_achievement").attr("disabled", "disabled");
		jQuery("#customer_type").attr("disabled", "disabled");
		jQuery("#is_account_limit").attr("disabled", "disabled");
		jQuery("#is_beforehand_voucher").attr("disabled", "disabled");
		jQuery("#is_remittance_error").attr("disabled", "disabled");
		jQuery("#is_fixed_pay_later").attr("disabled", "disabled");
		jQuery("#customer_property").attr("disabled", "disabled");
		$id("customer_service").disabled = "true";
		
	}
</script>
</fmt:bundle>
</html>
