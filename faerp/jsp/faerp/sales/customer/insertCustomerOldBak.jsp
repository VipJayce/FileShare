<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>

<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@ page import="rayoo.sales.customer.util.ICustomerConstants" %>
<%@page import="gap.authority.helper.OrgHelper"%>

<%  //判断是否为修改页面 
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
	CustomerVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ICustomerConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (CustomerVo)request.getAttribute(ICustomerConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		    RmVoHelper.null2Nothing(resultVo); 
  		}
	}else{
	    resultVo = new CustomerVo();
	}
%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>codegen</title>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    //history.go(1);  
	function insert_onClick(){  //插入单条数据
	   if(vailform()){
	   		valicode();
	   }
	   else{
	       return;
	   }
	}


  	function update_onClick(id){  //保存修改后的单条数据
  		
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    //form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=update";
    	//form.submit();
    	var isQA = '${isQA}';
            if(isQA!=null&&isQA!=""&&isQA=="false")
            {	
			    upvalicode();
            }else
            {
                if(vailform()){
                		
			            upvalicode();
			       }
			       else{
			           return;
			       }
            }
    	
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=queryAll&backFlag=false";
        form.submit();
    }
    
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
    

    function valicode(){
        var  code = document.getElementById("customer_code").value;
        if(code==null || code==""){
            alert("请输入或者选择客户编号");
            return false;
        }else{
            //var flags=true;
	        jQuery.ajax({
	        url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=vailCustCode&code='+code,
	        type: 'POST',
	        dataType: 'html',
	        async: false,
	        timeout: 10000,
		        error: function(){
		           alert('客户编号重复');
		           jQuery("#customer_code").val("");
		           jQuery("#customer_code").removeAttr("disabled");
		           jQuery("#custbtn").removeAttr("disabled");
		           return;
		        },
		         success: function(data){
				         if(data=='true'){
					       form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=insert&customer_code="+code;
			                form.submit();
			                window.close();
			 	        }else{
					           alert('客户编号重复');
					           jQuery("#customer_code").val("");
					           jQuery("#customer_code").removeAttr("disabled");
					           jQuery("#custbtn").removeAttr("disabled");
					           return;
					       }
		        }
	        });
        }
    }
    
    
        function onblurvalicode(){
                var  code = document.getElementById("customer_code").value;
	        if(code==null || code==""){
	            //alert("请输入或者选择客户编号");
	            //jQuery("#customer_code").focus();
	            //return false;

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

    function upvalicode(){
        var  code = document.getElementById("customer_code").value;
        if(code==null || code==""){
            alert("请输入或者选择客户编号");
            return false;
        }else{
            //AjaxControl.valiCustomerCode(code,getvailMsg);
        var flags=true;
        jQuery.ajax({
        url: '<%=request.getContextPath()%>/CustomerAction.do?cmd=vailCustCode&code='+code,
        type: 'POST',
        dataType: 'html',
        async: false,
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
         success: function(data){
         if(data=='true'){
             if(checkAllForms()){
            form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=update";
            form.submit();
            window.close();
            }
        }else{
            var  vailcode = document.getElementById("cust_code").value;
            if(vailcode ==  code){
                 if(checkAllForms()){
                    form.action="<%=request.getContextPath()%>/CustomerAction.do?cmd=update";
                    form.submit();
                    window.close();
                 }
                
            }else{
               alert('客户编号重复');     
               return;
            }
        }       
        }
        });      
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
        alert(customer_property);
  				return;
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
        var  agree_on_receive_money_date = document.getElementById("agree_on_receive_money_date").value;
        if(agree_on_receive_money_date==null || agree_on_receive_money_date==""){
            alert("请输入约定到款日");
            return false;
        }
        var is_account_limit = document.getElementById('is_account_limit').value;
        if(is_account_limit == null || is_account_limit == ''){
            alert('清选择是否有账期');
            return false;
        }
             
        if(agree_on_receive_money_date>31 && agree_on_receive_money_date<0){
             alert('约定到款日只能是1-31之间数字');
            return false;
         }    
        var  receive_money_month; 
        if(is_account_limit == '0'){
        	//alert(0);
             receive_money_month = document.getElementById("receive_money_month2").value;
            if(receive_money_month != '13'){
                if(agree_on_receive_money_date>5){
                    alert('约定到款日不能超过5号');
                    return false;
                 }
            }else if(agree_on_receive_money_date>31 || agree_on_receive_money_date<0){
                alert('约定到款日只能是1-31之间数字');
              	return false;
            }
        }else{
        	//alert(1);
        	receive_money_month = document.getElementById("receive_money_month").value;
        	 //alert(receive_money_month);
        	if(agree_on_receive_money_date>31 || agree_on_receive_money_date<0){
              alert('约定到款日只能是1-31之间数字');
              return false;
        	}
        } 
       //alert(receive_money_month+ "===receive_money_month");
        if(receive_money_month==null || receive_money_month==""){
        	
            alert("请选择到款日所属月");
            return false;
        }
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
    
    function getService(){
        var url = "<%=request.getContextPath()%>/CustomerAction.do?cmd=simpleCustomerService&_ts="+(new Date()).getTime();
        var data = showModalCenter(url, window, callBack, 1024, 768, "选择销售/客服"); 
        if(data == undefined) return;
        document.getElementById('customer_service').value=data[0];
        document.getElementById('service_name').value=data[1];
    }
    
    function callBack(reg){
    //alert(reg);
    if(reg!=""&&reg!=null){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    }
    
    function account(obj){
    	_dofilter(obj.value);
        if(obj.value == '0'){
            document.getElementById('bank').value='1';
            document.getElementById('agree_on_receive_money_date').value = '';
           // alert( document.getElementById('receive_money_month').value);
           // alert( "02" +  document.getElementById('receive_money_month2').value);
            return;
        }
        else{
            document.getElementById('bank').value='2';
            document.getElementById('agree_on_receive_money_date').value = '5';
         //alert( document.getElementById('receive_money_month').value);
         //alert( "12" +document.getElementById('receive_money_month2').value);
            return;
        }
    }
    function _dofilter(obj){
        if(obj==0){
         	//alert( "0");
             document.getElementById("receive_money_month2").disabled=false;
              jQuery("#receive_money_month2").show();
              document.getElementById("receive_money_month").disabled=true;
             jQuery("#receive_money_month").hide();
        }else{
        	//alert( "1");
             document.getElementById("receive_money_month").disabled=false;
              jQuery("#receive_money_month").show();
               document.getElementById("receive_money_month2").disabled=true;
             jQuery("#receive_money_month2").hide();
        }
      
    }
    
    function test(){
    	alert("test");
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
 <div class="ringht_x">
   <div id="ccParent0" class="box_3"> 
<div class="xz_title">基本信息</div>
 
<%if(!isModify){
  %>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span>客户编号</td>
            <td colspan="3" class="td_2 ">
                <input type="text" class="text_field" id="customer_code" name="customer_code" inputName="客户编号"   onblur="onkeyupvalicode();" maxLength="20"  vaildate="isNum"/>
                <span class="mx_button" style="margin-left:5px;"><input type="button" id="custbtn" class="icon_2" value="获取编号" onClick="javascript:getcode();" /></span>
                <input type="hidden" name="code_type" id="code_type" value="1"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>客户性质</td>
            <td width="28%" class="td_2" >
               <%=gap.rm.tools.helper.RmJspHelper.getSelectField("customer_property", -1,"CUSTOMER_PROPERTY","0","id=customer_property",false) %> 
            </td>
            <td width="22%" class="td_1" ><span class="style_required_red">* </span>客户名称</td>
            <td width="27%" class="td_2 ">
                <input type="text" class="text_field" id="customer_name" name="customer_name" inputName="客户名称" value="" maxLength="50" validate="notNull;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >客户简称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="customer_simple_name" inputName="客户简称" value="" maxLength="50" />
            </td>
            <td class="td_1" >客户英文名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="customer_en_name" inputName="客户英文名" value="" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >国家地区</td>
            <td class="td_2" >
                 <r:comboSelect id="country_area" name="country_area" queryAction="/FAERP/CustomerAction.do?cmd=queryCountryData" 
                textField="name" valueField="id" xpath="CustomerSelectVo" value="9033802" width="205px"  nullText="请选择"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>客户类型</td>
            <td class="td_2" >
                <d:select dictTypeId="CUSTOMER_TYPE" id="customer_type" name="customer_type" value="${bean.customer_type}"/> 
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系人</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_person" inputName="联系人" value="" maxLength="50" />
            </td>
            <td class="td_1" >联系地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_address" inputName="联系地址" value="" maxLength="75" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系邮政编码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="zip_code" inputName="邮政编码" value="" maxLength="6" vaildate="isNum "/>
            </td>
            <td class="td_1" >联系电话1</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="tel_phone1" inputName="联系电话1" value="" maxLength="12" validate="notChinese"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系电话2</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="tel_phone2" inputName="联系电话2" value="" maxLength="12" validate="notChinese" />
            </td>
            <td class="td_1" >传真</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="fax" inputName="传真" value="" maxLength="12"  validate="notChinese"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >EMAIL</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="email" inputName="EMAIL" value="" maxLength="50" validate="isEmail"/>
            </td>
            <td class="td_1" >银行</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bank", -1,"BANK","1","onChange=\"bank()\" id='bank'",false) %> 
            </td>
        </tr>
        <tr>
            <td class="td_1" >银行帐号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="bank_account" inputName="银行帐号" value="" maxLength="50" validate="isNum"/>
            </td>
            <td class="td_1" >是否仲量</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_zhongliang", -1,"TrueOrFalse","0","",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" >是否导入客户端</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_import_client", -1,"TrueOrFalse","0","",true) %>
            </td>
            <td class="td_1" >是否入职体检</td>
            <td class="td_2" >
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_physical_examination", -1,"TrueOrFalse","0","",true) %> 
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否销售业绩</td>
            <td class="td_2" >
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_sale_achievement", -1,"TrueOrFalse","0"," id=is_sale_achievement",true) %>
            </td>
            <td class="td_1">销售业绩备注</td>
            <td class="td_2" >
                 <input type="text" class="text_field" name="sale_achievement_remarks" inputName="是否销售业绩备注" value="" maxLength="1000" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否有账期</td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_account_limit", -1,"TrueOrFalse","0"," id='is_account_limit' onchange='account(this);' ",false) %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>销售/客服</td>
            <td class="td_2 ">
                <r:comboSelect id="customer_service" name="customer_service" queryAction="/FAERP/CustomerAction.do?cmd=queryCustomerServiceData"
                textField="name" valueField="partyid" xpath="Partyrelation" width="205px"  nullText="请选择"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>约定到款日</td>
            <td class="td_2">
                <input type="text" class="text_field" name="agree_on_receive_money_date" id="agree_on_receive_money_date" inputName="约定到款日" value="5" validate="notNull;isNum"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>到款日所属月</td>
            <td class="td_2 ">
                  <d:select disabled="true" dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month"  style="width:205px;display:none;"  nullLabel="--请选择--"/>
                <d:select disabled="false"  dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month2"   filterOp="in" filterStr="1,13" value="13"  style="width:205px;"  nullLabel="--请选择--"/> 
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否预开票</td>
            <td class="td_2 ">
              <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_beforehand_voucher", -1,"TrueOrFalse","0"," id=is_beforehand_voucher",true) %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>是否有汇差</td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_remittance_error", -1,"TrueOrFalse","0"," id=is_remittance_error",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否固定垫付</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_fixed_pay_later", -1,"TrueOrFalse","0"," id=is_fixed_pay_later",true) %>
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
    </table>
    <p></p>
     <div class="xz_title">附加信息</div>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
        <td width="23%" class="td_1" >组织机构代码</td>
        <td width="27%" class="td_2 ">
              <input type="text" class="text_field" name="organization_number" inputName="组织机构代码" value="" maxLength="50" />
        </td>
         <td width="23%" class="td_1" ><span class="style_required_red">* </span>行业类别</td>
         <td width="27%" class="td_2" >
               <r:comboSelect id="trade_type" name="trade_type" queryAction="/FAERP/CustomerAction.do?cmd=queryIndustryTypeData"
              textField="name" valueField="id" xpath="CustomerSelectVo" width="205px"  nullText="请选择" value="${bean.trade_type}"/>
          </td>
    </tr>
    <tr>
        <td class="td_1" >公司网址</td>
        <td class="td_2" >
            <input type="text" class="text_field" name="company_webadress" inputName="公司网址" value="" maxLength="75" />
        </td>
        <td class="td_2" ></td>
        <td class="td_2" ></td>
    </tr>
    <tr>
            <td class="td_1">备注说明</td>
            <td colspan="3" class="td_2" >
                 <input type="text" class="text_field" name="remarks" inputName="备注说明" value="" maxLength="1000" style="width:100%;"/>
            </td>
        </tr>
    <tr>
        <td class="td_1">客户情况简介</td>
         <td colspan="3" class="td_2" >
                 <input type="text" class="text_field" name="customer_situation" inputName="客户情况简介" value="" maxLength="1000" style="width:100%;"/>
            </td>
    </tr>
    <tr>
            <td class="td_1">不良记录</td>
            <td colspan="3" class="td_2" >
                <input type="text" class="text_field" name="bad_record" inputName="不良记录" value="" maxLength="1000" style="width:100%;"/>
            </td>
        </tr>
      </table>
      
      
      
      
      
       <%
      }else{
          %>
        <input type="hidden" id="cust_code" value="<%=resultVo.getCustomer_code() %>">
        <input type="hidden" name="customer_simple_create_date">
        <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span>客户编号</td>
            <td width="28%" class="td_2 ">
                <input type="text" class="text_field"  id="customer_code" name="customer_code" inputName="客户编号" value="<%=resultVo.getCustomer_code() %>" maxLength="25" validate="notNull;" readonly="readonly"/>
           </td>
            <td width="23%" class="td_1" ><span class="style_required_red">* </span>客户名称</td>
            <td width="26%" class="td_2 ">
                <input type="text" class="text_field"  name="customer_name" id="customer_name" inputName="客户名称" value="<%=resultVo.getCustomer_name() %>" maxLength="50" validate="notNull;" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>客户性质</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("customer_property", -1,"CUSTOMER_PROPERTY",resultVo.getCustomer_property()," id=customer_property ",false) %> 
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("customer_property", -1,"CUSTOMER_PROPERTY",resultVo.getCustomer_property()," id=customer_property1 onchange='test()'",false) %> 
            </td>
            <td class="td_1" >客户英文名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="customer_en_name" name="customer_en_name" inputName="客户英文名" value="<%=resultVo.getCustomer_en_name() %>" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >客户简称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="customer_simple_name" name="customer_simple_name" inputName="客户简称" value="<%=resultVo.getCustomer_simple_name() %>" maxLength="50" />
            </td>
             <td class="td_1" ><span class="style_required_red">* </span>客户类型</td>
            <td class="td_2" >
               <d:select dictTypeId="CUSTOMER_TYPE" id="customer_type" name="customer_type" value="${bean.customer_type}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >国家地区</td>
            <td class="td_2" >
              <r:comboSelect id="country_area" name="country_area" queryAction="/FAERP/CustomerAction.do?cmd=queryCountryData" 
                textField="name" valueField="id" xpath="CustomerSelectVo" width="205px"  nullText="请选择" value="${bean.country_area}"/>

            </td>
            <td class="td_1" >联系地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_address" name="contact_address" inputName="联系地址" value="<%=resultVo.getContact_address() %>" maxLength="75" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系人</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_person"  name="contact_person" inputName="联系人" value="<%=resultVo.getContact_person() %>" maxLength="50" />
            </td>
            <td class="td_1" >联系电话1</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tel_phone1" name="tel_phone1" inputName="联系电话1" value="<%=resultVo.getTel_phone1() %>" maxLength="12" validate="notChinese" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系邮政编码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="zip_code" name="zip_code" inputName="邮政编码" value="<%=resultVo.getZip_code() %>" maxLength="6" vaildate="isNum "/>
            </td>
            <td class="td_1" >传真</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="fax" name="fax" inputName="传真" value="<%=resultVo.getFax() %>" maxLength="12"  validate="notChinese"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >联系电话2</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tel_phone2" name="tel_phone2" inputName="联系电话2" value="<%=resultVo.getTel_phone2() %>" maxLength="12" validate="notChinese" />
            </td>
            <td class="td_1" >EMAIL</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="email" name="email" inputName="EMAIL" value="<%=resultVo.getEmail() %>" maxLength="50"  validate="isEmail"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >银行</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bank", -1,"BANK",resultVo.getBank(),"id='bank'",false) %> 
            </td>
            <td class="td_1" >银行帐号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="bank_account" name="bank_account" inputName="银行帐号" value="<%=resultVo.getBank_account() %>" maxLength="50" validate="isNum"  />
            </td>
        </tr>
        <tr>
            <td class="td_1" >是否仲量</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_zhongliang", -1,"TrueOrFalse",resultVo.getIs_zhongliang(),"id='is_zhongliang'",true) %>
            </td>
            <td class="td_1" >是否导入客户端</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_import_client", -1,"TrueOrFalse",resultVo.getIs_import_client(),"id='is_import_client'",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否销售业绩</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_sale_achievement", -1,"TrueOrFalse",resultVo.getIs_sale_achievement(),"id='is_sale_achievement'",true) %>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_sale_achievement", -1,"TrueOrFalse",resultVo.getIs_sale_achievement(),"id='is_sale_achievement1'",true) %>
            </td>
            <td class="td_1">销售业绩备注</td>
            <td class="td_2" >
                 <input type="text" class="text_field" name="sale_achievement_remarks" id="sale_achievement_remarks" inputName="是否销售业绩备注" value="<%=resultVo.getSale_achievement_remarks() %>" maxLength="1000" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否有账期</td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_account_limit", -1,"TrueOrFalse",resultVo.getIs_account_limit(),"id='is_account_limit' onchange='account(this);'",true) %>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_account_limit", -1,"TrueOrFalse",resultVo.getIs_account_limit(),"id='is_account_limit1' onchange='account(this);'",true) %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>销售/客服</td>
            <td class="td_2 ">
                <r:comboSelect id="customer_service" name="customer_service"  queryAction="/FAERP/CustomerAction.do?cmd=queryCustomerServiceData" value="${bean.customer_service}"
                textField="name" valueField="pid" xpath="Partyrelation" width="205px"  nullText="请选择"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>约定到款日</td>
            <td class="td_2">
                <input type="text" class="text_field" name="agree_on_receive_money_date" id="agree_on_receive_money_date" inputName="约定到款日" validate="notNull;isNum" value="<%=resultVo.getAgree_on_receive_money_date() %>"/>
                <input type="hidden" class="text_field" name="agree_on_receive_money_date" id="agree_on_receive_money_date1"  value="<%=resultVo.getAgree_on_receive_money_date() %>"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>到款日所属月</td>
            <td class="td_2 ">
                <d:select disabled="false" dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month" style="width:205px"  nullLabel="--请选择--" value="${bean.receive_money_month }"/>
                <d:select disabled="false"  dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month2"  filterOp="in" filterStr="1,13"  style="width:205px;display:none;"  nullLabel="--请选择--" value="${bean.receive_money_month }"/> 
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否预开票</td>
            <td class="td_2 ">
              <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_beforehand_voucher", -1,"TrueOrFalse",resultVo.getIs_beforehand_voucher(),"id=is_beforehand_voucher",true) %>
              <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_beforehand_voucher", -1,"TrueOrFalse",resultVo.getIs_beforehand_voucher(),"id=is_beforehand_voucher1",true) %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>是否有汇差</td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_remittance_error", -1,"TrueOrFalse",resultVo.getIs_remittance_error(),"id=is_remittance_error",true) %>
                  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_remittance_error", -1,"TrueOrFalse",resultVo.getIs_remittance_error(),"id=is_remittance_error1",true) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>是否固定垫付</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_fixed_pay_later", -1,"TrueOrFalse",resultVo.getIs_fixed_pay_later(),"id=is_fixed_pay_later",true) %>
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_fixed_pay_later", -1,"TrueOrFalse",resultVo.getIs_fixed_pay_later(),"id=is_fixed_pay_later1",true) %>
            </td>
            <td class="td_1" >是否入职体检</td>
            <td class="td_2" >
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_physical_examination", -1,"TrueOrFalse",resultVo.getIs_physical_examination(),"id=is_physical_examination",true) %>
            </td>
        </tr>
        </table>
        <p></p>
        <div class="xz_title">客户信息</div>
        <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">   
            <tr>
            <td width="23%"  class="td_1" >投资总额</td>
            <td width="28%"  class="td_2" >
                <input type="text" class="text_field" id="invest_total_sum" name="invest_total_sum" inputName="投资总额" value="<%=resultVo.getInvest_total_sum()==null?"":resultVo.getInvest_total_sum() %>"  maxLength="21" />
            </td>
            <td width="23%"  class="td_1" >注册资金</td>
            <td width="26%"  class="td_2" >
                <input type="text" class="text_field" id="register_money" name="register_money" inputName="注册资金" value="<%=resultVo.getRegister_money()==null?"":resultVo.getRegister_money() %>" maxLength="21" />
            </td>
            </tr>
            
            <tr>
              <td class="td_1" >组织机构代码</td>
              <td class="td_2 ">
                <input type="text" class="text_field" id="organization_number" name="organization_number" inputName="组织机构代码" value="<%=resultVo.getOrganization_number() %>" maxLength="50" />
            </td>
            <td class="td_1" >CEO英文姓名</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_en_name" name="ceo_en_name" inputName="CEO英文姓名" value="<%=resultVo.getCeo_en_name() %>" maxLength="50" />
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
                <input type="text" class="text_field" id="registered_capital" name="registered_capital" inputName="注册资本" maxLength="21"  value="<%=resultVo.getRegistered_capital()==null?"":resultVo.getRegistered_capital() %>"  />
            </td>
            <td  class="td_1" >投资总额</td>
            <td  class="td_2" >
                <input type="text" class="text_field" id="registered_total_sum" name="registered_total_sum" inputName="投资总额" maxLength="21"   value="<%=resultVo.getRegistered_total_sum()==null?"":resultVo.getRegistered_total_sum() %>" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >承办单位</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="undertake_company" name="undertake_company" inputName="承办单位" value="<%=resultVo.getUndertake_company() %>" maxLength="50" />
            </td>
            <td class="td_1" >投资方</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="invest_company"  name="invest_company" inputName="投资方" value="<%=resultVo.getInvest_company() %>" maxLength="50" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >CEO国别</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_county" name="ceo_county" inputName="CEO国别" value="<%=resultVo.getCeo_county() %>" maxLength="50" />
            </td>
            <td class="td_1" >CEO生日</td>
            <td class="td_2">
                <w:date allowInput="true" id="ceo_birthday" name="ceo_birthday" format="YYYY-MM-DD" property="bean/ceo_birthday" width="190px"/>                
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >CEO姓名</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="ceo_name"  name="ceo_name" inputName="CEO姓名" value="<%=resultVo.getCeo_name() %>" maxLength="50" />
            </td>
            <td class="td_1" >法人代表</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="corporation" name="corporation" inputName="法人代表" value="<%=resultVo.getCorporation() %>" maxLength="50" />
            </td>
            </tr>
            
            <tr>
            <td class="td_1" >注册地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="invest_adress" name="invest_adress" inputName="注册地址" value="<%=resultVo.getInvest_adress() %>" maxLength="75" />
            </td>
            <td class="td_1">营业范围</td>
            <td colspan="3" class="td_2" >
                 <input type="text" class="text_field" id="business_scope" name="business_scope" inputName="营业范围" value="<%=resultVo.getBusiness_scope() %>" maxLength="1000" />
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
              textField="name" valueField="id" xpath="CustomerSelectVo" width="205px"  nullText="请选择" value="${bean.trade_type}" />
        </td>
        <td width="23%" class="td_1" >公司网址</td>
        <td width="26%" class="td_2" >
            <input type="text" class="text_field" id="company_webadress" name="company_webadress" inputName="公司网址" value="<%=resultVo.getCompany_webadress() %>" maxLength="75" />
        </td>
        </tr>
       <tr>
            <td class="td_1">备注说明</td>
            <td colspan="3" class="td_2" >
                 <input type="text" class="text_field"  id="remarks" name="remarks" inputName="备注说明" value="<%=resultVo.getRemarks() %>" maxLength="1000" style="width:100%;" />
            </td>
        </tr>
    <tr>
        <td class="td_1">客户情况简介</td>
         <td colspan="3" class="td_2" >
                 <input type="text" class="text_field" id="customer_situation" name="customer_situation" inputName="客户情况简介" value="<%=resultVo.getCustomer_situation() %>" maxLength="1000" style="width:100%;"/>
            </td>
    </tr>
    <tr>
            <td class="td_1">不良记录</td>
            <td colspan="3" class="td_2" >
                <input type="text" class="text_field" id="bad_record" name="bad_record" inputName="不良记录" value="<%=resultVo.getBad_record() %>" maxLength="1000" style="width:100%;"/>
                <input type="hidden" name="id" value="<%=resultVo.getId() %>">
            </td>
        </tr>
       </table>
          <%
      }
      %>


     
     <div class="mx_button" style="text-align: center;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
</div>           

<input type="hidden" name="create_date" />
</div>
</div>
</div>


</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
	//alert(<%=isModify%>);
	var is_limit ='${bean.is_account_limit}';
  //邓鹏添加 *******对页面元素进行权限控制
        if(<%=isModify%>)
        {
            var isQA = '${isQA}';
            alert("isQa == " +isQA);
            if(isQA==null || isQA=="" || isQA=="true")
            {
               
            	jQuery("#agree_on_receive_money_date1").attr("disabled", "disabled");
		        jQuery("#is_sale_achievement").attr("disabled", "disabled");
		        jQuery("#is_sale_achievement1").show();
		        jQuery("#is_sale_achievement").hide();
		        jQuery("#customer_type").attr("disabled", "disabled");
		        jQuery("#customer_type1").show();
		        jQuery("#customer_type").hide();
		        jQuery("#is_account_limit").attr("disabled", "disabled");
		        jQuery("#is_account_limit1").show();
		        jQuery("#is_account_limit").hide();
		        jQuery("#is_beforehand_voucher").attr("disabled", "disabled");
		        jQuery("#is_beforehand_voucher1").show();
		        jQuery("#is_beforehand_voucher").hide();
		        jQuery("#is_remittance_error").attr("disabled", "disabled");
		        jQuery("#is_remittance_error1").show();
		        jQuery("#is_remittance_error").hide();
		        jQuery("#is_fixed_pay_later").attr("disabled", "disabled");
		        jQuery("#is_fixed_pay_later1").show();
		        jQuery("#is_fixed_pay_later").hide();
		        jQuery("#customer_property").attr("disabled", "disabled");
                jQuery("#customer_property1").show();
                jQuery("#customer_property").hide();
                
                //如果QA进来   是无账期的
                if(is_limit =='' || is_limit==0)
				{
					//修改第二个
		             document.getElementById("receive_money_month2").disabled=false;
		             jQuery("#receive_money_month2").show();
		             document.getElementById("receive_money_month").disabled=false;
		             jQuery("#receive_money_month").hide();
		             
		        }else{
		        	//否则修改第一个
		             document.getElementById("receive_money_month").disabled=false;
		             jQuery("#receive_money_month").show();
		             document.getElementById("receive_money_month2").disabled=false;
		             jQuery("#receive_money_month2").hide();
			    }
            }
            else
            {
            	 //jQuery("#customer_name").attr("readOnly", true);
	            jQuery("#agree_on_receive_money_date").attr("disabled", "disabled");
	            jQuery("#manage_start_date").attr("readOnly", true);
	            jQuery("#manage_end_date").attr("readOnly", true);
	            jQuery("#ceo_birthday").attr("readOnly", true);
                jQuery("#customer_type").attr("disabled", "disabled");
                jQuery("#customer_type").show();
                jQuery("#customer_type1").hide();
                jQuery("#customer_property").attr("disabled", "disabled");
                jQuery("#customer_property").show();
                jQuery("#customer_property1").hide();
                jQuery("#is_sale_achievement").attr("disabled", "disabled");
                jQuery("#is_sale_achievement").show();
                jQuery("#is_sale_achievement1").hide();
                jQuery("#is_account_limit").attr("disabled", "disabled");
                jQuery("#is_account_limit").show();
                jQuery("#is_account_limit1").hide();
                jQuery("#is_beforehand_voucher").attr("disabled", "disabled");
                jQuery("#is_beforehand_voucher").show();
                jQuery("#is_beforehand_voucher1").hide();
                jQuery("#is_remittance_error").attr("disabled", "disabled");
                jQuery("#is_remittance_error").show();
                jQuery("#is_remittance_error1").hide();
                jQuery("#is_fixed_pay_later").attr("disabled", "disabled");
                jQuery("#is_fixed_pay_later").show();
                jQuery("#is_fixed_pay_later1").hide();
            	
                //如果非QA进来
                 if(is_limit =='' || is_limit==0)
				{	
		             document.getElementById("receive_money_month2").disabled=true;
		             jQuery("#receive_money_month2").show();
		             document.getElementById("receive_money_month").disabled=false;
		             jQuery("#receive_money_month").hide();
		        }else{
		             document.getElementById("receive_money_month").disabled=true;
		             jQuery("#receive_money_month").show();
		             document.getElementById("receive_money_month2").disabled=false;
		             jQuery("#receive_money_month2").hide();
			    }
            }
            
        }
        jQuery(document).ready(function() {
        var isQA = '${isQA}';
            if(isQA!=null&&isQA!=""&&isQA=="false")
            {
            $id("trade_type").readOnly=true;
            $id("customer_service").readOnly=true;
            }
        });
        

</script>
