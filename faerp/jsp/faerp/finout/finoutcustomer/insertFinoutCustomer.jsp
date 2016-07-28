<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>客户新增</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
	  //history.go(1);  
	function save_onClick(){  //保存
	   if(vailform()){
	   		var  code = document.getElementById("customer_code").value;
	   		form.action="<%=request.getContextPath()%>/Finout_customerAction.do?cmd=insert&customer_code="+code;
			form.submit();
			returnValue = ["0"];
            window.close();
            window.opener.insertcallBack(returnValue);
	   }
	}
	
	function vailform(){
        var  code = document.getElementById("customer_code").value;
        if(code==null || code==""){
            alert("请输入或者选择客户编号");
            jQuery("#customer_code").focus();
            return false;
        }
        
        var  customer_property = document.getElementById("customer_property").value;
        if(customer_property==null || customer_property==""){
            alert("请选择客户性质");
            return false;
        }
        
        var  customer_name = document.getElementById("customer_name").value;
        if(customer_name==null || customer_name==""){
            alert("请输入客户名称");
            return false;
        }
        var  customer_type = document.getElementById("customer_type").value;
        if(customer_type==null || customer_type==""){
            alert("请选择客户类型");
            return false;
        }
        var  is_sale_achievement = document.getElementById("is_sale_achievement").value;
        if(is_sale_achievement==null || is_sale_achievement==""){
            alert("请选择是否销售业绩");
            return false;
        }
        var  customer_service = document.getElementById("customer_service").value;
        if(customer_service==null || customer_service==""){
            alert("请选择销售/客服");
            return false;
        }
       
        var is_account_limit = document.getElementById('is_account_limit').value;
        if(is_account_limit == null || is_account_limit == ''){
            alert('清选择是否有账期');
            return false;
        }
        
        var  receive_money_month = document.getElementById("receive_money_month").value;
        if(receive_money_month==null || receive_money_month==""){
            alert("请选择到款日所属月");
            return false;
        }
        
        var  agree_on_receive_money_date = document.getElementById("agree_on_receive_money_date").value;
        if(agree_on_receive_money_date==null || agree_on_receive_money_date==""){
            alert("请输入约定到款日");
            return false;
        }else{
        if(is_account_limit=="0"){
            if(receive_money_month != '13'){
                if(agree_on_receive_money_date > 5){
                    alert('约定到款日不能超过5号');
                    return false;
                 }
            }else if(agree_on_receive_money_date>31 || agree_on_receive_money_date<0){
                alert('约定到款日只能是1-31之间数字');
              	return false;
            }
            }else if(agree_on_receive_money_date>31 || agree_on_receive_money_date<0){
                alert('约定到款日只能是1-31之间数字');
                return false;
            }
        }
        
        
        
        //yangxu
        
        var  contract_receive_money_month = document.getElementById("contract_receive_money_month").value;
        if(contract_receive_money_month==null || contract_receive_money_month==""){
            alert("请选择合同约定到款日所属月");
            return false;
        }
        
        var  contract_receive_money_date = document.getElementById("contract_receive_money_date").value;
        if(contract_receive_money_date==null || contract_receive_money_date==""){
            alert("请输入合同约定到款日");
            return false;
        }else{
        if(is_account_limit=="0"){
            if(contract_receive_money_month != '13'){
                if(contract_receive_money_date > 5){
                    alert('合同约定到款日不能超过5号');
                    return false;
                 }
            }else if(contract_receive_money_date>31 || contract_receive_money_date<0){
                alert('合同约定到款日只能是1-31之间数字');
              	return false;
            }
            }else if(contract_receive_money_date>31 || contract_receive_money_date<0){
                alert('合同约定到款日只能是1-31之间数字');
                return false;
            }
        }
        
        
         
        //yangxu 
        
        
        
        
        var  if_beforehand_voucher = document.getElementById("is_beforehand_voucher").value;
        if(if_beforehand_voucher==null || if_beforehand_voucher==""){
            alert("请选择是否预开票");
            return false;
        }
        var  if_remittance_error = document.getElementById("is_remittance_error").value;
        if(if_remittance_error==null || if_remittance_error==""){
            alert("请选择是否有汇差");
            return false;
        }
        var  if_fixed_pay_later = document.getElementById("is_fixed_pay_later").value;
        if(if_fixed_pay_later==null || if_fixed_pay_later==""){
            alert("请选择是否固定垫付");
            return false;
        }
        var  trade_type = $id('trade_type').getValue();
        if(trade_type==null || trade_type==""){
            alert("请选择行业类别");
            return false;
        }
        return true;
    }
    
    function onkeyupvaliname() {
        var name = document.getElementById("customer_name").value;
        if(name!=null&&name!=''){
	         jQuery.ajax({
	           url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=vailCustName&name='+encodeURI(name),
	           type: 'POST',
	           dataType: 'html',
	           async: false,
	           timeout: 10000,
	               error: function(){
	                  alert('客户名称重复!');
	                  jQuery("#customer_name").val("");
	                  return;
	               },
	                success: function(data){
		                if(data=='true'){
		                   alert('客户名称重复!');
		                   jQuery("#customer_name").val("");
		                   return;
		               }
	               }
	           });
           }
    }
    
    function onkeyupvalicode(){
        var  code = document.getElementById("customer_code").value;
        if(/.*[\u4e00-\u9fa5]+.*$/.test(code)){ 
			alert("客户编号不能含有汉字！"); 
			return; 
		}
           jQuery.ajax({
           url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=vailCustCode&code='+code,
           type: 'POST',
           dataType: 'html',
           async: false,
           timeout: 10000,
               error: function(){
                  alert('客户编号重复!');
                  jQuery("#customer_code").val("");
                  jQuery("#customer_code").removeAttr("disabled");
                  jQuery("#custbtn").removeAttr("disabled");
                  return;
               },
                success: function(data){
                        if(data=='false'){
                           alert('客户编号重复!');
                           jQuery("#customer_code").val("");
                           jQuery("#customer_code").removeAttr("disabled");
                           jQuery("#custbtn").removeAttr("disabled");
                           return;
                          }
               }
           });
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
	        document.getElementById("customer_code").value= 'FO' + code;
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
    		var opt0=new Option('请选择','');
			var opt1=new Option('账单应收年月的下1月','1');
			var opt13=new Option('到款日所属月','13');
    		rem.options.add(opt0);
    		rem.options.add(opt13);
    		rem.options.add(opt1);
    		rem.value = 13;
    	//有账期显示所有
    	}else{
    		for(var i=rem.length;i>0;i--){
    				rem.remove(i-1);
    		}
    		var opt0=new Option('请选择','');
    		var opt13=new Option('到款日所属月','13');
    		rem.options.add(opt0);
    		rem.options.add(opt13);
    		for(var i=1;i<13;i++){
    			var opt=new Option('账单应收年月的下'+i+'月','' + i + '');
    			rem.options.add(opt);
    			rem.value = 13;
    		}
    	}
    }
	
</script>
</head>


<body>

<form name="form" method="post">

<div id="right">
 <div class="ringht_x">
   <div id="ccParent0" class="box_3"> 
<div class="xz_title">基本信息</div>
        <input type="hidden" name="customer_simple_create_date">
        <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span>客户编号</td>
            <td width="28%" class="td_2 " colspan = '3'>
                <input type="text" class="text_field"  id="customer_code" name="customer_code" inputName="客户编号" value="" maxLength="25" validate="notNull;" onblur="onkeyupvalicode();" />
                <span class="mx_button" style="margin-left:5px;"><input type="button" id="custbtn" class="icon_2" value="获取编号" onClick="javascript:getcode();" /></span>
                <input type="hidden" name="code_type" id="code_type" value="1"/>
           </td>
        </tr>
        <tr>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span>客户名称</td>
            <td width="26%" class="td_2 " colspan="3">
                <input type="text" class="text_field"  name="customer_name" id="customer_name" inputName="客户名称" value="" maxLength="50" validate="notNull;" onblur="onkeyupvaliname();" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>客户性质</td>
            <td class="td_2" >
            	<d:select dictTypeId="CUSTOMER_PROPERTY" id="customer_property" name="customer_property" value=""/>
            </td>
            <td class="td_1" >客户英文名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="customer_en_name" name="customer_en_name" inputName="客户英文名" value="" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >客户简称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="customer_simple_name" name="customer_simple_name" inputName="客户简称" value="" maxLength="50" />
            </td>
             <td class="td_1" ><span class="style_required_red">* </span>客户类型</td>
            <td class="td_2" >
            <d:select dictTypeId="CUSTOMER_TYPE" id="customer_type" name="customer_type" value=""/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >国家地区</td>
            <td class="td_2" >
              <r:comboSelect id="country_area" name="country_area" queryAction="/FAERP/CustomerAction.do?cmd=queryCountryData" 
                textField="name" valueField="id" xpath="CustomerSelectVo" width="205px"  nullText="请选择" value=""/>

            </td>
            <td class="td_1" >联系地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_address" name="contact_address" inputName="联系地址" value="" maxLength="75" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系人</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_person"  name="contact_person" inputName="联系人" value="" maxLength="50" />
            </td>
            <td class="td_1" >联系电话1</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tel_phone1" name="tel_phone1" inputName="联系电话1" value="" maxLength="12" validate="notChinese" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系邮政编码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="zip_code" name="zip_code" inputName="邮政编码" value="" maxLength="6" vaildate="isNum "/>
            </td>
            <td class="td_1" >传真</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="fax" name="fax" inputName="传真" value="" maxLength="12"  validate="notChinese"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系电话2</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tel_phone2" name="tel_phone2" inputName="联系电话2" value="" maxLength="12" validate="notChinese" />
            </td>
            <td class="td_1" >EMAIL</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="email" name="email" inputName="EMAIL" value="" maxLength="50"  validate="isEmail"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >银行</td>
            <td class="td_2" >
            	<d:select dictTypeId="BANK" id="bank" name="bank" value=""/>
            </td>
            <td class="td_1" >银行帐号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="bank_account" name="bank_account" inputName="银行帐号" value="" maxLength="50" validate="isNum"  />
            </td>
        </tr>
        <tr>
            <td class="td_1" >是否仲量</td>
            <td class="td_2" >
            	<d:select dictTypeId="TrueOrFalse" id="is_zhongliang" name="is_zhongliang" nullLabel="-请选择-"/>
            </td>
            <td class="td_1" >是否导入客户端</td>
            <td class="td_2" >
            	<d:select dictTypeId="TrueOrFalse" id="is_import_client" name="is_import_client" value="0"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否销售业绩</td>
            <td class="td_2" >
            <d:select dictTypeId="TrueOrFalse" id="is_sale_achievement" name="is_sale_achievement" value="0"/>
            </td>
            <td class="td_1">销售业绩备注</td>
            <td class="td_2" >
                 <input type="text" class="text_field" name="sale_achievement_remarks" id="sale_achievement_remarks" inputName="是否销售业绩备注" value="" maxLength="1000" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否有账期</td>
            <td class="td_2 ">
            	<d:select dictTypeId="TrueOrFalse" id="is_account_limit" name="is_account_limit" value="0" onchange="amount(this)"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>销售/客服</td>
            <td class="td_2 ">
                <r:comboSelect id="customer_service" name="customer_service"  queryAction="/FAERP/CustomerAction.do?cmd=queryCustomerServiceData"  
                textField="name" valueField="partyid" xpath="Partyrelation" width="205px"  nullText="请选择"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>约定到款日</td>
            <td class="td_2">
                <input type="text" class="text_field" name="agree_on_receive_money_date" id="agree_on_receive_money_date" inputName="约定到款日" validate="notNull;isNum" value="5"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>到款日所属月</td>
            <td class="td_2 ">
                <d:select dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month" filterOp="in" filterStr="1,13" value="" nullLabel="--请选择--"/>
            </td>
        </tr>
        
        
        <!--   yangxu      -->
		<tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同约定到款日</td>
            <td class="td_2">
                <input type="text" class="text_field" name="contract_receive_money_date" id="contract_receive_money_date" validate="notNull;isNum" value="5"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>合同到款日所属月</td>
            <td class="td_2 ">
                <d:select dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month"  id="contract_receive_money_month" filterOp="in" filterStr="1,13" value="" nullLabel="--请选择--"/>
            </td>
        </tr>
<!--   yangxu      -->
        
        
        
        
        
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否预开票</td>
            <td class="td_2 ">
            	<d:select dictTypeId="TrueOrFalse" id="is_beforehand_voucher" name="is_beforehand_voucher" value="0" />
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>是否有汇差</td>
            <td class="td_2 ">
            	<d:select dictTypeId="TrueOrFalse" id="is_remittance_error" name="is_remittance_error" value="0" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否固定垫付</td>
            <td class="td_2" >
            	<d:select dictTypeId="TrueOrFalse" id="is_fixed_pay_later" name="is_fixed_pay_later" value="0"/>
            </td>
            <td class="td_1" >是否入职体检</td>
            <td class="td_2" >
            	<d:select dictTypeId="TrueOrFalse" id="is_physical_examination" name="is_physical_examination" value="0"/>
            </td>
        </tr>
        </table>
        <p></p>
        <div class="xz_title">客户信息</div>
        <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">   
            <tr>
            <td width="23%"  class="td_1" >投资总额</td>
            <td width="28%"  class="td_2" >
                <input type="text" class="text_field" id="invest_total_sum" name="invest_total_sum" inputName="投资总额" value=""  maxLength="21" />
            </td>
            <td width="23%"  class="td_1" >注册资金</td>
            <td width="26%"  class="td_2" >
                <input type="text" class="text_field" id="register_money" name="register_money" inputName="注册资金" value="" maxLength="21" />
            </td>
            </tr>
            
            <tr>
              <td class="td_1" >组织机构代码</td>
              <td class="td_2 ">
                <input type="text" class="text_field" id="organization_number" name="organization_number" inputName="组织机构代码" value="" maxLength="50" />
            </td>
            <td class="td_1" >CEO英文姓名</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_en_name" name="ceo_en_name" inputName="CEO英文姓名" value="" maxLength="50" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >经营开始日期</td>
            <td class="td_2">
                <w:date allowInput="true" id="manage_start_date" name="manage_start_date" format="YYYY-MM-DD" property="bean/manage_start_date" width="190px"/>
            </td>
            <td class="td_1" >经营结束日期</td>
            <td class="td_2">
                <w:date allowInput="true" id="manage_end_date" name="manage_end_date" format="YYYY-MM-DD" property="bean/manage_end_date" width="190px"/>
            </td>
            </tr>           
            <tr>
            <td  class="td_1" >注册资本</td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="registered_capital" name="registered_capital" inputName="注册资本" maxLength="21"  value=""  />
            </td>
            <td  class="td_1" >投资总额</td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="registered_total_sum" name="registered_total_sum" inputName="投资总额" maxLength="21"   value="" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >承办单位</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="undertake_company" name="undertake_company" inputName="承办单位" value="" maxLength="50" />
            </td>
            <td class="td_1" >投资方</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="invest_company"  name="invest_company" inputName="投资方" value="" maxLength="50" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >CEO国别</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_county" name="ceo_county" inputName="CEO国别" value="" maxLength="50" />
            </td>
            <td class="td_1" >CEO生日</td>
            <td class="td_2">
                <w:date allowInput="true" id="ceo_birthday" name="ceo_birthday" format="YYYY-MM-DD" property="bean/ceo_birthday" width="190px"/>                
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >CEO姓名</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_name"  name="ceo_name" inputName="CEO姓名" value="" maxLength="50" />
            </td>
            <td class="td_1" >法人代表</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="corporation" name="corporation" inputName="法人代表" value="" maxLength="50" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >注册地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="invest_adress" name="invest_adress" inputName="注册地址" value="" maxLength="75" />
            </td>
            <td class="td_1">营业范围</td>
            <td colspan="3" class="td_2" >
                 <input type="text" class="text_field" id="business_scope" name="business_scope" inputName="营业范围" value="" maxLength="1000" />
            </td>
            </tr>
            
        </table>
        <p></p>
       <div class="xz_title">附加信息</div>
       <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
         <td width="23%" class="td_1" ><span class="style_required_red">* </span>行业类别</td>
         <td width="28%" class="td_2" > 
         <r:comboSelect id="trade_type" name="trade_type" queryAction="/FAERP/CustomerAction.do?cmd=queryIndustryTypeData"
              textField="name" valueField="id" xpath="CustomerSelectVo" width="205px"  nullText="请选择" value="" />
        </td>
        <td width="23%" class="td_1" >公司网址</td>
        <td width="26%" class="td_2" >
            <input type="text" class="text_field" id="company_webadress" name="company_webadress" inputName="公司网址" value="" maxLength="75" />
        </td>
        </tr>
       <tr>
            <td class="td_1">备注说明</td>
            <td colspan="3" class="td_2" >
                 <input type="text" class="text_field"  id="remarks" name="remarks" inputName="备注说明" value="" maxLength="1000" style="width:100%;" />
            </td>
        </tr>
    <tr>
        <td class="td_1">客户情况简介</td>
         <td colspan="3" class="td_2" >
                 <input type="text" class="text_field" id="customer_situation" name="customer_situation" inputName="客户情况简介" value="" maxLength="1000" style="width:100%;"/>
            </td>
    </tr>
    <tr>
            <td class="td_1">不良记录</td>
            <td colspan="3" class="td_2" >
                <input type="text" class="text_field" id="bad_record" name="bad_record" inputName="不良记录" value="" maxLength="1000" style="width:100%;"/>
            </td>
        </tr>
       </table>
     
     <div class="mx_button" style="text-align: center;">
        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
	</div>           
</div>
</div>
</div>
</form>
</body>
</html>
