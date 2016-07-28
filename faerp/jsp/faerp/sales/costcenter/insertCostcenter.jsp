<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="java.util.List" %>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<%@ page import="rayoo.sales.costcenter.util.ICostcenterConstants" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
//zhouxiaolong  更改实体类
CostcenterVo resultVo = null;  //定义一个临时的vo变量
CostcenterVo resultVo1 = null;  //定义一个临时的vo变量
CostcenterVo resultVo2 = null;  //定义一个临时的vo变量
CostcenterVo vo =null;
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ICostcenterConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
        	resultVo = (CostcenterVo)request.getAttribute(ICostcenterConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        	resultVo1 = (CostcenterVo)request.getAttribute(ICostcenterConstants.REQUEST_BEAN1);  //从request中取出vo, 赋值给resultVo
        	resultVo2 = (CostcenterVo)request.getAttribute(ICostcenterConstants.REQUEST_BEAN2);  //从request中取出vo, 赋值给resultVo
        	RmVoHelper.null2Nothing(resultVo); 
        	RmVoHelper.null2Nothing(resultVo1); 
        	RmVoHelper.null2Nothing(resultVo2); 
        }
    }else{
            vo = (CostcenterVo)request.getAttribute("vo");
    }
%>
<html>
<fmt:bundle basename="rayoo.salse.costcenter.costcenter_resource" prefix="rayoo.salse.costcenter.">
<head>
<style type="text/css">
.datecellCss span{color:#075587;text-align: center;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
<%
if(isModify){%>
     window.onload=function(){
		 var kefuid=document.getElementById('id_bak').value;
    	 $id("datacell1").queryAction="/FAERP/CostcenterAction.do?cmd=simpleQueryVatPayToUpdate"; 
    	 $id("datacell1").addParam("pb_costcenter_id",kefuid);
    	 $id("datacell1").reload();
    	 $id("datacell1").refresh();
	    }
     <%}%>
    function insert_onClick(){  //插入单条数据
       if(vailform()){
    	   if(jQuery("#bill_day").val()!=""){
    		   var params = jQuery("#page_form").serialize();
               jQuery.post("<%=request.getContextPath()%>/CostcenterAction.do?cmd=insertNew", params, function(data){
            	   if (!!data) {
	            	   returnValue = ["1"];
	                   var oid = data;
	                   var xmlSubmit=$id("datacell1").dataset.toString();
	                   var action="<%=request.getContextPath()%>/CostcenterAction.do?cmd=save";
	                   var myAjax = new Ajax(action);
	                   myAjax.addParam('oid',oid);
	                   myAjax.submitXML(xmlSubmit);
	                   window.close();
	                   window.opener.callBack(returnValue);
            	   }
               });
    	   }else{
	    	   alert("账单日不能为空！");
	       }
       }
        
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
              var id_bak=jQuery("#id_bak").val();
              form.action="<%=request.getContextPath()%>/CostcenterAction.do?cmd=update";
              form.submit();
              returnValue = ["1"];
              $id("datacell1").submitAction="/FAERP/CostcenterAction.do?cmd=updateVat&id_bak="+id_bak;
              $id("datacell1").isModefied = true;
              $id("datacell1").submit();
              window.close();
              window.opener.callBack(returnValue);
    }

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/CostcenterAction.do?cmd=queryAll&backFlag=false";
        //form.submit();
        window.close();
    }
    function vailform(){
         var cost_center_name = document.getElementById('cost_center_name').value;
         if(cost_center_name==null || cost_center_name==""){
            alert("<fmt:message key='input_cost_center_name'/>");
            return false;
         }
         var receipt_title = document.getElementById('receipt_title').value;
         if(receipt_title==null || receipt_title==""){
            alert("<fmt:message key='input_receipt_title'/>");
            return false;
         }
         
        var pattern = new RegExp("^[A-Z0-9a-z\u4e00-\u9fa5()（）.\\-— ——&•·,']+$");
         if(pattern.test(receipt_title) == false){
               alert("成本中心发票抬头不能包含特殊字符！");
               return false;
         }
         
         var is_account_limit = '';
         is_account_limit=document.getElementById('is_account_limit').value;
         if(is_account_limit==null || is_account_limit==""){
            alert("<fmt:message key='choose_is_account_limit'/>");
            return false;
         }
         
         
         var is_finance_send = document.getElementById('is_finance_send').value;
           if(is_finance_send==null || is_finance_send==""){
            alert("<fmt:message key='choose_is_finance_send'/>");
            return false;
           }
         var agree_receive_money_date = document.getElementById('agree_receive_money_date').value;
         if(agree_receive_money_date==null || agree_receive_money_date==""){
            alert("<fmt:message key='input_agree_receive_money_date'/>");
            return false;
         }
         if(agree_receive_money_date>31 || agree_receive_money_date<0){
             alert("<fmt:message key='agree_receive_money_date_number'/>");
            return false;
         }       
         
         var receive_money_month = null;
         if(is_account_limit == '0'){
            receive_money_month=  document.getElementById('receive_money_month1').value;
         }else{
            receive_money_month=  document.getElementById('receive_money_month2').value;
         }
         if(receive_money_month==null || receive_money_month==""){
            alert("<fmt:message key='choose_receive_money_month'/>");
            return false;
         }else{
            document.getElementById('receive_money_month').value=receive_money_month;
         }
     
         if(is_account_limit == '0'){
            if(receive_money_month != '13'){
                if(agree_receive_money_date>5){
                    alert("<fmt:message key='receive_money_date_less_number'/>");
                    return false;
                 }
            }
            else if(agree_receive_money_date>31 || agree_receive_money_date<0)
            {
                 alert("<fmt:message key='agree_receive_money_date_number'/>");
              return false;
            }
        }
        else if(agree_receive_money_date>31 || agree_receive_money_date<0)
        {
              alert("<fmt:message key='agree_receive_money_date_number'/>");
              return false;
        }
        /*
        //yangxu
       //2014年1月20日 注释必选项限定 
        var contract_receive_money_date = document.getElementById('contract_receive_money_date').value;
         if(contract_receive_money_date==null || contract_receive_money_date==""){
            alert("请输入合同约定到款日");
            return false;
         }
         if(contract_receive_money_date>31 || contract_receive_money_date<0){
             alert("合同约定到款日只能是1-31之间数字");
            return false;
         }       
         
         var contract_receive_money_month = null;
         if(is_account_limit == '0'){
            contract_receive_money_month=  document.getElementById('contract_receive_money_month1').value;
         }else{
            contract_receive_money_month=  document.getElementById('contract_receive_money_month2').value;
         }
         if(contract_receive_money_month==null || contract_receive_money_month==""){
            alert("请选择到合同约定到款所属月");
            return false;
         }else{
            document.getElementById('contract_receive_money_month').value=contract_receive_money_month;
         }
     
         if(is_account_limit == '0'){
            if(contract_receive_money_month != '13'){
                if(contract_receive_money_date>5){
                    alert("合同约定到款日不能超过5号");
                    return false;
                 }
            }
            else if(contract_receive_money_date>31 || contract_receive_money_date<0)
            {
                 alert("合同约定到款日只能是1-31之间数字");
              return false;
            }
        }
        else if(contract_receive_money_date>31 || contract_receive_money_date<0)
        {
              alert("合同约定到款日只能是1-31之间数字");
              return false;
        }
        
         
        //yangxu 
        */
        
        
        
          var is_beforehand_voucher = "";
          is_beforehand_voucher=document.getElementById('is_beforehand_voucher').value;
          if(is_beforehand_voucher==null || is_beforehand_voucher==""){
            alert("<fmt:message key='choose_is_beforehand_voucher'/>");
            return false;
          }
          
           
           var is_remittance_error ="";
           is_remittance_error=document.getElementById('is_remittance_error').value;
           if(is_remittance_error==null || is_remittance_error==""){
            alert("<fmt:message key='choose_is_remittance_error'/>");
            return false;
           }
           
           var is_fixed_pay_later ="";
           is_fixed_pay_later=document.getElementById('is_fixed_pay_later').value;
           if(is_fixed_pay_later==null || is_fixed_pay_later==""){
            alert("<fmt:message key='choose_is_fixed_pay_later'/>");
            return false;
           }
           
           var fin_invoice_template_id ="";
           fin_invoice_template_id=$id("fin_invoice_template_id").getValue();
           if(fin_invoice_template_id==null || fin_invoice_template_id==""){
            alert("<fmt:message key='choose_fin_invoice_template'/>");
            return false;
           }
           
           return true;
          
    }
    
    
     function account(obj){
     _dofilter(obj.value);
     }
        function _dofilter(obj){
        if(obj==0){
                jQuery("#receive_money_month1").attr("disabled", "disabled");
                jQuery("#receive_money_month1").show();
                jQuery("#receive_money_month2").hide();
                
                //yangxu
                jQuery("#contract_receive_money_month1").attr("disabled", "disabled");
                jQuery("#contract_receive_money_month1").show();
                jQuery("#contract_receive_money_month2").hide();
        }else{
                jQuery("#receive_money_month2").attr("disabled", "disabled");
                jQuery("#receive_money_month2").show();
                jQuery("#receive_money_month1").hide();
                //yangxu
                jQuery("#contract_receive_money_month2").attr("disabled", "disabled");
                jQuery("#contract_receive_money_month2").show();
                jQuery("#contract_receive_money_month1").hide();
                
                
        }
        }
</script>
</head>
<body>

<form name="form" method="post" id="page_form">

<div id="right">

 
   <div id="ccParent0" class="box_3"> 
<%
if(!isModify){
	String taxpayer_identification_number=vo.getTaxpayer_identification_number();
	String tax_registration_address=vo.getTax_registration_address();
	String tax_registration_telnum=vo.getTax_registration_telnum();
	String tax_registration_bank=vo.getTax_registration_bank();
	String tax_registration_bank_account=vo.getTax_registration_bank_account();
	if(taxpayer_identification_number==null){
		taxpayer_identification_number="";
	}
	if(tax_registration_address==null){
		tax_registration_address="";
	}
	if(tax_registration_telnum==null){
		tax_registration_telnum="";
	}
	if(tax_registration_bank==null){
		tax_registration_bank="";
	}
	if(tax_registration_bank_account==null){
		tax_registration_bank_account="";
	}
    %>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='customer_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" name="customer_code" inputName="客户编号" value="<%=vo.getCustomer_code() %>" maxLength="9.5" validate="notNull;"/>
                <input type="hidden" name="customer_id" value="<%=vo.getCustomer_id() %>">
                <!--2016-04-12  by zhouxiaolong 新增合同增加自动带入字段 begin
                <input type="hidden" name="taxpayer_identity_type" value="<%=vo.getTaxpayer_identity_type() %>">
                <input type="hidden" name="taxpayer_identification_number" value="<%=vo.getTaxpayer_identification_number() %>">
                <input type="hidden" name="tax_registration_address" value="<%=vo.getTax_registration_address() %>">
                <input type="hidden" name="tax_registration_telnum" value="<%=vo.getTax_registration_telnum() %>">
                <input type="hidden" name="tax_registration_bank" value="<%=vo.getTax_registration_bank() %>">
                <input type="hidden" name="tax_registration_bank_account" value="<%=vo.getTax_registration_bank_account() %>">
                016-04-12  by zhouxiaolong 新增合同增加自动带入字段 end-->
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='customer_name'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" id="customer_name" name="customer_name" inputName="客户名称" value="<%=vo.getCustomer_name() %>" maxLength="50" validate="notNull;"/>

            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='cost_center_name'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="cost_center_name" name="cost_center_name" inputName="成本中心名称" value="" maxLength="50" validate="notNull;"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='receipt_title'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="receipt_title" name="receipt_title" inputName="发票抬头" value="<%=vo.getReceipt_title() %>" maxLength="66" validate="notNull;" readonly="readonly"/>
            </td>
        </tr>
         <!--2016-04-12  by zhouxiaolong 新增合同增加自动带入字段 begin-->
        <tr>
            <td class="td_1" >纳税人身份类型</td>
            <td class="td_2 ">
                <select id="taxpayer_identity_type" name="taxpayer_identity_type"  onchange="taxpayeridentitytypeChange1()">
                    <option value="">请选择</option>
                    <option value="1">增值税一般纳税人</option>
                    <option value="2">非增值税一般纳税人</option>
                </select>
                <input type="hidden" class="text_field" id="taxpayer_identity_type_b" value="<%=vo.getTaxpayer_identity_type() %>" name="taxpayer_identity_type" inputName="纳税人身份类型"  maxLength="50" validate="notNull;"/>
            </td>
            <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
            <td class="td_1" >纳税人识别号</td>
            <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
            <td class="td_2 ">
            <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
                <input type="text" class="text_field" id="taxpayer_identification_number_add" value="<%=taxpayer_identification_number %>" name="taxpayer_identification_number" inputName="纳税人识别号"  maxLength="20" validate="notNull;" readonly="readonly"/>
            <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
            </td>
        </tr>
        <tr>
            <td class="td_1" >税务登记地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tax_registration_address_add" readonly="readonly" value="<%=tax_registration_address %> " name="tax_registration_address" inputName="税务登记地址"  maxLength="100" validate="notNull;"/>
            </td>
            <td class="td_1" >税务登记电话号码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tax_registration_telnum_add" readonly="readonly" value="<%=tax_registration_telnum %>" name="tax_registration_telnum" inputName="税务登记电话号码" maxLength="100"  validate="isNum;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >税务登记开户银行</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tax_registration_bank_add" readonly="readonly" value="<%=tax_registration_bank %>" name="tax_registration_bank" inputName="税务登记开户银行"  maxLength="50" validate="notNull;" />
            </td>
            <td class="td_1" >税务登记银行账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="tax_registration_bank_account_add" readonly="readonly" value="<%=tax_registration_bank_account %>" name="tax_registration_bank_account" inputName="税务登记银行账号"  maxLength="100" validate="isNum;"/>
            </td>
        </tr>
                
                <!--2016-04-12  by zhouxiaolong 新增合同增加自动带入字段 end-->
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_account_limit'/></td>
            <td class="td_2 ">
                 <d:select dictTypeId="TrueOrFalse" property="is_account_limit"  id="is_account_limit"  value="${vo.is_account_limit}"  style="width:207px;"  nullLabel="--请选择--" onchange="account(this);"/>
                 <d:select dictTypeId="TrueOrFalse" property="is_account_limit"  id="is_account_limit1"  value="${vo.is_account_limit}"  style="width:207px;"  nullLabel="--请选择--" onchange="account(this);"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_finance_send'/></td>
            <td class="td_2 ">
                <d:select name="is_finance_send" id="is_finance_send" property="vo/is_finance_send" dictTypeId="TrueOrFalse" nullLabel="--请选择--" extAttr="allowNull=false;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='agree_receive_money_date'/></td>
            <td class="td_2">
                <input type="text" class="text_field" name="agree_receive_money_date" id="agree_receive_money_date" value="<%=vo.getAgree_receive_money_date()==null?"":vo.getAgree_receive_money_date()%>" inputName="约定到款日" validate="notNull;isNum"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='receive_money_month'/></td>
            <td class="td_2 ">
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month1"  id="receive_money_month1"    value="${vo.receive_money_month}"     filterOp="in" filterStr="1,13" style="width:207px" nullLabel="--请选择--" />
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month2"  id="receive_money_month2"  value="${vo.receive_money_month}"     style="width:207px;display:none;"  nullLabel="--请选择--"/>
                <input type="hidden" name="receive_money_month" id="receive_money_month" value="${vo.receive_money_month}"/>
            </td>
        </tr>
        
<!--   yangxu      -->
		<tr>
            <td class="td_1" ><fmt:message key='contract_receive_money_date'/></td>
            <td class="td_2">
                <input type="text" class="text_field" name="contract_receive_money_date" id="contract_receive_money_date" value="<%=vo.getContract_receive_money_date()==null?"":vo.getContract_receive_money_date()%>" inputName="合同约定到款日"/>
            </td>
            <td class="td_1" ><fmt:message key='contract_receive_money_month'/></td>
            <td class="td_2 ">
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month1"  id="contract_receive_money_month1"    value="${vo.contract_receive_money_month}"     filterOp="in" filterStr="1,13" style="width:207px" nullLabel="--请选择--" />
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month2"  id="contract_receive_money_month2"  value="${vo.contract_receive_money_month}"     style="width:207px;display:none;"  nullLabel="--请选择--"/>
                <input type="hidden" name="contract_receive_money_month" id="contract_receive_money_month" value="${vo.contract_receive_money_month}"/>
            </td>
        </tr>
<!--   yangxu      -->

        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_beforehand_voucher'/></td>
            <td class="td_2 ">
            <d:select dictTypeId="TrueOrFalse" property="is_beforehand_voucher"  id="is_beforehand_voucher"  value="${vo.is_beforehand_voucher}"  style="width:207px;"  nullLabel="--请选择--"/>
              <d:select dictTypeId="TrueOrFalse" property="is_beforehand_voucher"  id="is_beforehand_voucher1"  value="${vo.is_beforehand_voucher}"  style="width:207px;"  nullLabel="--请选择--"/>
                
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_remittance_error'/></td>
            <td class="td_2 ">
               <d:select dictTypeId="TrueOrFalse" property="is_remittance_error"  id="is_remittance_error"  value="${vo.is_remittance_error}"  style="width:207px;"  nullLabel="--请选择--"/>
                   <d:select dictTypeId="TrueOrFalse" property="is_remittance_error"  id="is_remittance_error1"  value="${vo.is_remittance_error}"  style="width:207px;"  nullLabel="--请选择--"/>
                
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_fixed_pay_later'/></td>
            <td class="td_2 ">
                 <d:select dictTypeId="TrueOrFalse" property="is_fixed_pay_later"  id="is_fixed_pay_later"  value="${vo.is_fixed_pay_later}"  style="width:207px;"  nullLabel="--请选择--"/>
                 <d:select dictTypeId="TrueOrFalse" property="is_fixed_pay_later"  id="is_fixed_pay_later1"  value="${vo.is_fixed_pay_later}"  style="width:207px;"  nullLabel="--请选择--"/>
                
            </td>
            <td class="td_1" ><fmt:message key='contact_person'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_person" inputName="联系人" value="" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_address'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_address" inputName="联系人地址" value="" maxLength="75" />
            </td>
            <td class="td_1" ><fmt:message key='zip_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="zip_code" inputName="邮编" value="" maxLength="6" validate="isNum "/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_tel1'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_tel1" inputName="联系电话1" value="" maxLength="18" validate="notChinese  "/>
            </td>
            <td class="td_1" ><fmt:message key='contact_tel2'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_tel2" inputName="联系电话2" value="" maxLength="18" validate="notChinese  "/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='fax'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  name="fax" inputName="传真" value="" maxLength="13" validate="notChinese  "/>
            </td>
            <td class="td_1" ><fmt:message key='email'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="email" name="email" inputName="电子邮件" value="" maxLength="64" validate="isEmail"/>
            </td>
        </tr>
         <tr>
             <td class="td_1"><span class="style_required_red">* </span>发票是否邮件客户</td><!-- 是否需要开票 -->
             <td class="td_2" >
                 <d:select name="is_finance_invoice" id="is_finance_invoice " property="vo/is_finance_invoice" dictTypeId="TrueOrFalse"/>
            </td>
            <td class="td_1" ><fmt:message key='voucher_rule'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="voucher_rule" inputName="开票规则" value="" maxLength="64" />
            </td>
            
        </tr>
        <tr>
            <td class="td_1" >发票服务年月</td>
            <td class="td_2 ">
                <d:select name="is_display_year_month" id="is_display_year_month " property="vo/is_display_year_month" dictTypeId="IS_DISPLAY_YM"/>
            </td>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key='fin_invoice_template'/></td>
            <td class="td_2" >
                <r:comboSelect id="fin_invoice_template_id" name="fin_invoice_template_id" queryAction="/FAERP/Fin_invoice_templateAction.do?cmd=getInvoiceTemplateList" 
                textField="template_name" valueField="id" xpath="Fin_invoice_templateVo" width="205px"   value="" messagekey="please_choose" />  &nbsp;<img alt="查看模板" src="<venus:base/>/images/au/09.gif" onClick="javascript:showTemplate();"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='remark'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="remarks" inputName="备注" value="" maxLength="1000" />           
            </td>
            <td class="td_1">是否修改账单</td>
            <td class="td_2" >
            <d:select dictTypeId="TrueOrFalse" id="is_bill_modify" nullLabel="--请选择--" name="is_bill_modify"   />
            </td>
         </tr>
         <tr>
	        <td class="td_1" >是否生成福利反馈表</td>
            <td class="td_2">
            <d:select dictTypeId="TrueOrFalse" id="is_feedback_report" nullLabel="--请选择--" name="is_feedback_report" />
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>账单日</td>
            <td class="td_2 ">
               <input type="text" class="text_field" name="bill_day" id="bill_day" maxLength="2" inputName="账单日" validate="notNull;isNum;isValidDay"/>
            </td>
        </tr>
                <!--2016-06-30 by zhouxiaolong  成本中心新增字段   begin-->
         <% if("1".equals(request.getAttribute("flag"))){ %>
         <tr>
          <td class="td_1">代收付开票税率</td>
            <td class="td_2" >
                <select id="payment_invoice_rate"  name="payment_invoice_rate">
                    <!-- 2016-07-25   by zhouxiaolong  增加0%的税率选项   Begin -->
                    <option value="0">--请选择--</option>
                    <!-- 2016-07-25   by zhouxiaolong  增加0%的税率选项   End -->
                    <option value="0.05">5%</option>
                    <option value="0.06">6%</option>
                </select>         
            </td>
             <td class="td_1"></td>
             <td class="td_2" >
             </td>
        </tr>
        <%} %>
        <!--2016-06-30 by zhouxiaolong  成本中心新增字段   end-->
</table>
    <%
}else{
    %>
         <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='customer_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" name="customer_code" inputName="客户编号" value="<%=resultVo.getCustomer_code() %>" maxLength="9.5" readonly="readonly" validate="notNull;"/>
                <input type="hidden" name="customer_id" value="<%=resultVo.getCustomer_id() %>">
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='customer_name'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" id="customer_name" name="customer_name" inputName="客户名称" value="<%=resultVo.getCustomer_name()%>" readonly="readonly" maxLength="50" validate="notNull;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='cost_center_name'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="cost_center_name" name="cost_center_name"  inputName="成本中心名称" value="<%=resultVo.getCost_center_name() %>"  maxLength="50" validate="notNull;"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='receipt_title'/></td>
            <!--2016-04-13 by zhouxiaolong  修改成本中心增加税务字段的显示  begin-->
            <td class="td_2 ">
                <input type="text" class="text_field" id="receipt_title" name="receipt_title" inputName="发票抬头" value="<%=resultVo.getReceipt_title() %>" maxLength="66" readonly="readonly" validate="notNull;"/>
                <input type="hidden" id="receipt_title_bak" name="receipt_title_bak" value="<%=resultVo.getReceipt_title() %>" />
            </td>
        </tr>
            <tr>
                <td class="td_1" >纳税人身份类型</td>
                <td class="td_2 ">
                    <select id="taxpayer_identity_type_bak" name="taxpayer_identity_type"  onchange="taxpayeridentitytypeChange()">
                        <option value="">请选择</option>
                        <option value="1">增值税一般纳税人</option>
                        <option value="2">非增值税一般纳税人</option>
                    </select>
                    <input type="hidden" class="text_field" id="taxpayer_identity_type_bk" name="taxpayer_identity_type" inputName="纳税人身份类型" value="<%=resultVo.getTaxpayer_identity_type() %>" readonly="readonly" maxLength="50" validate="notNull;"/>
                </td>
                <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
                <td class="td_1" >纳税人识别号</td>
                <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
                <td class="td_2 ">
                <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
                    <input type="text" class="text_field" id="taxpayer_identification_number" name="taxpayer_identification_number" inputName="纳税人识别号" readonly="readonly" value="<%=resultVo.getTaxpayer_identification_number() %>" maxLength="20" validate="notNull;"/>
                <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
                </td>
            </tr>
            <tr>
                <td class="td_1" >税务登记地址</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="tax_registration_address" name="tax_registration_address" inputName="税务登记地址" value="<%=resultVo.getTax_registration_address() %>" readonly="readonly" maxLength="100" validate="notNull;"/>
                </td>
                <td class="td_1" >税务登记电话号码</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="tax_registration_telnum" name="tax_registration_telnum" inputName="税务登记电话号码" value="<%=resultVo.getTax_registration_telnum() %>" readonly="readonly" maxLength="100"  validate="isNum;"/>
                </td>
            </tr>
            <tr>
                <td class="td_1" >税务登记开户银行</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="tax_registration_bank" name="tax_registration_bank" inputName="税务登记开户银行" value="<%=resultVo.getTax_registration_bank() %>" readonly="readonly" maxLength="50" validate="notNull;" />
                </td>
                <td class="td_1" >税务登记银行账号</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="tax_registration_bank_account" name="tax_registration_bank_account" inputName="税务登记银行账号" value="<%=resultVo.getTax_registration_bank_account() %>" readonly="readonly" maxLength="100" validate="isNum;"/>
                </td>
            </tr>
            <!--2016-04-13 by zhouxiaolong  修改成本中心增加税务字段的显示  end-->
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_account_limit'/></td>
            <td class="td_2 ">
               <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_account_limit", -1,"TrueOrFalse",resultVo.getIs_account_limit(),"style='width:207px' id='is_account_limit' onchange='account(this);' readonly='true' ",false) %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_finance_send'/></td>
            <td class="td_2 ">
                <d:select name="is_finance_send" id="is_finance_send" property="bean/is_finance_send"  dictTypeId="TrueOrFalse" nullLabel="--请选择--" extAttr="allowNull=false;"/>
                <input type="hidden" id="is_finance_send_bak" name="is_finance_send_bak" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='agree_receive_money_date'/></td>
            <td class="td_2">
                <input type="text" class="text_field" readonly="readonly" name="agree_receive_money_date" id="agree_receive_money_date" value="${bean.agree_receive_money_date }" inputName="约定到款日" validate="notNull;isNum"/>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='receive_money_month'/></td>
            <td class="td_2 ">
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month1"  filterOp="in" filterStr="1,13" value="${bean.receive_money_month }" style="width:207px"   nullLabel="--请选择--"/>
                <d:select   dictTypeId="RECEIVE_MONEY_DATE" property="receive_money_month"  id="receive_money_month2"    value="${bean.receive_money_month }" style="width:207px;display:none;"  />
                <input type="hidden" name="receive_money_month" id="receive_money_month" value=""/>
            </td>
        </tr>
        
        
                
        <!--   yangxu      -->
		<tr>
            <td class="td_1" >合同约定到款日</td>
            <td class="td_2">
                <input type="text" class="text_field" name="contract_receive_money_date" readonly="readonly" id="contract_receive_money_date" value="${bean.contract_receive_money_date }" inputName="约定到款日" />
            </td>
            <td class="td_1" >合同到款日所属月</td>
            <td class="td_2 ">
                <d:select  dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month1"   id="contract_receive_money_month1"  filterOp="in" filterStr="1,13" value="${bean.contract_receive_money_month }" style="width:207px"  nullLabel="--请选择--" />
                <d:select   dictTypeId="RECEIVE_MONEY_DATE" property="contract_receive_money_month2"   id="contract_receive_money_month2"   value="${bean.contract_receive_money_month }" style="width:207px;display:none;"  />
                <input type="hidden" name="contract_receive_money_month" id="contract_receive_money_month" value=""/>
            </td>
        </tr>
<!--   yangxu      -->



         <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_beforehand_voucher'/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_beforehand_voucher", -1,"TrueOrFalse",resultVo.getIs_beforehand_voucher(),"style='width:207px' id=is_beforehand_voucher ",false) %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_remittance_error'/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_remittance_error", -1,"TrueOrFalse",resultVo.getIs_remittance_error(),"style='width:207px' id=is_remittance_error ",false) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='is_fixed_pay_later'/></td>
            <td class="td_2 ">
            
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_fixed_pay_later", -1,"TrueOrFalse",resultVo.getIs_fixed_pay_later(),"style='width:207px' id=is_fixed_pay_later ",false) %>
            </td>
            <td class="td_1" ><fmt:message key='contact_person'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_person" inputName="联系人" value="<%=resultVo.getContact_person() %>" maxLength="50" />
                <input type="hidden" name="contact_person_bak" id="contact_person_bak"  value="<%=resultVo.getContact_person() %>" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_address'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_address" inputName="联系人地址"  value="<%=resultVo.getContact_address() %>" maxLength="75" />
                <input type="hidden" name="contact_address_bak" id="contact_address_bak"  value="<%=resultVo.getContact_address() %>" />
            </td>
            <td class="td_1" ><fmt:message key='zip_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="zip_code" inputName="邮编"  value="<%=resultVo.getZip_code() %>" maxLength="6" validate="isNum"/>
                <input type="hidden" name="zip_code_bak" id="zip_code_bak"  value="<%=resultVo.getZip_code() %>" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_tel1'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_tel1" inputName="联系电话1"  value="<%=resultVo.getContact_tel1() %>" maxLength="18" validate="notChinese"/>
                <input type="hidden" name="contact_tel1_bak" id="contact_tel1_bak"  value="<%=resultVo.getContact_tel1() %>" />
            </td>
            <td class="td_1" ><fmt:message key='contact_tel2'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="contact_tel2" inputName="联系电话2"  value="<%=resultVo.getContact_tel2() %>" maxLength="18" validate="notChinese"/>
                <input type="hidden" name="contact_tel2_bak" id="contact_tel2_bak"  value="<%=resultVo.getContact_tel2() %>" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='fax'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="fax" inputName="传真"  value="<%=resultVo.getFax() %>" maxLength="13" validate="notChinese  "/>
            </td>
            <td class="td_1" ><fmt:message key='email'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="email" inputName="电子邮件"  value="<%=resultVo.getEmail() %>" maxLength="64" validate="isEmail"/>
            </td>
        </tr>
          <tr>
            <td class="td_1"><span class="style_required_red">* </span>是否需要开票</td><!-- 是否需要开票 -->
            <td class="td_2" >
                            <d:select name="is_finance_invoice" id="is_finance_invoice " property="bean/is_finance_invoice" dictTypeId="TrueOrFalse"/>
            </td>
            <td class="td_1" ><fmt:message key='voucher_rule'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="voucher_rule" inputName="开票规则" value="<%=resultVo.getVoucher_rule() %>" maxLength="64" />
            </td>
        </tr>
       <tr>
            <td class="td_1" >发票服务年月</td>
            <td class="td_2 ">
                <d:select name="is_display_year_month" id="is_display_year_month " property="bean/is_display_year_month" dictTypeId="IS_DISPLAY_YM" onchange="checkInvoiceStatus2(this)"/>
            </td>
            <td class="td_1"><span class="style_required_red">* </span><fmt:message key='fin_invoice_template'/></td>
            <td class="td_2" >
                <r:comboSelect id="fin_invoice_template_id" name="fin_invoice_template_id" queryAction="/FAERP/Fin_invoice_templateAction.do?cmd=getInvoiceTemplateList" 
                textField="template_name" valueField="id" xpath="Fin_invoice_templateVo" width="205px"  messagekey="please_choose" value="${bean.fin_invoice_template_id}" onChangeFunc="checkInvoiceStatus" /> &nbsp;<img alt="查看模板" src="<venus:base/>/images/au/09.gif" onClick="javascript:showTemplate();"/> 
            </td>
        </tr>
        <tr>
	        <td class="td_1" ><fmt:message key='remark'/></td>
	            <td class="td_2 ">
	                <input type="text" class="text_field" name="remarks" inputName="<fmt:message key='remark'/>" value="<%=resultVo.getRemarks() %>" maxLength="1000" />           
	                <input type="hidden" id="id_bak"  name="id" value="<%=resultVo.getId() %>">   
            </td>
            <td class="td_1">是否修改账单</td>
            <td class="td_2" >
            <d:select dictTypeId="TrueOrFalse" id="is_bill_modify" nullLabel="--请选择--" name="is_bill_modify" value="<%=resultVo.getIs_bill_modify() %>"  />
            </td>
        </tr>
        <tr>
	        <td class="td_1" >是否生成福利反馈表</td>
            <td class="td_2">
            <d:select dictTypeId="TrueOrFalse" id="is_feedback_report" nullLabel="--请选择--" name="is_feedback_report" value="<%=resultVo.getIs_feedback_report() %>"  />
            </td>
            <td class="td_1" >账单日</td>
            <td class="td_2 ">
               <input type="text" class="text_field" name="bill_day" value="<%=resultVo.getBill_day() %>" maxLength="2" max="31" validate="notNull;isNum;isValidDay"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='cost_center_code'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" readonly="readonly" name="cost_center_code" inputName="成本中心编号" value="<%=resultVo.getCost_center_code() %>" />
            </td>
         <!--2016-06-30 by zhouxiaolong  成本中心新增字段   begin-->
        <% if("1".equals(request.getAttribute("flag"))){ %>
          <td class="td_1">代收付开票税率</td>
            <td class="td_2" >
                <select id="payment_invoice_rate_bak"  name="payment_invoice_rate">
                    <!-- 2016-07-25   by zhouxiaolong  增加0%的税率选项   Begin -->
                    <option value="0">--请选择--</option>
                    <!-- 2016-07-25   by zhouxiaolong  增加0%的税率选项   End -->
                    <option value="0.05">5%</option>
                    <option value="0.06">6%</option>
                </select>
                <script type="text/javascript">
                 //2016-06-30 by zhouxiaolong  成本中心新增字段   Begin
                  var payment_invoice_rate=<%=resultVo.getPayment_invoice_rate()%>
                  jQuery("#payment_invoice_rate_bak").val(payment_invoice_rate);
                 //2016-06-30 by zhouxiaolong  成本中心新增字段   End
                </script>
            </td>
        <%}else{ %>
         <td class="td_1" ></td>
            <td class="td_2 ">
            </td>
        <%} %>
        <!--2016-06-30 by zhouxiaolong  成本中心新增字段   end-->
        </tr>
        <!--2016-04-18 by zhouxiaolong  成本中心新增字段   end-->
</table>
    <%
}
%>
</div>        

<div class="datecellCss" id="centerNew7">
 <r:datacell id="datacell1" queryAction="/FAERP/CostcenterAction.do?cmd=simpleQueryVatPay" 
    submitAction="/FAERP/CostcenterAction.do?cmd=insert" width="730px" height="210px" xpath="CostcenterVo" 
    paramFormId="datacell_formid" pageSize="10">
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <r:field fieldName="social_unit_name"   label="福利办理方" allowModify="false"  width="80px">
    </r:field>
    <r:field fieldName="service_type_name"  label="业务类型名称" allowModify="false" width="90px">
    </r:field>
    <r:field fieldName="product_type_name" label="代收付产品小类名称"  width="140px">
    </r:field>
    <r:field fieldName="is_payticket_for_delegate" label="开票类型" allowModify="true"  width="80px">
        <d:select dictTypeId="IS_PAY_FOR_DELEGATE" id="is_pay_for_delegate"></d:select>
    </r:field>
    <r:field fieldName="add_tax_rate_for_delegate" label="附加税率" allowModify="true"  width="80px">
	       <select>
	           <option value="0">0</option>
	           <option value="0.0078613183">0.0078613183</option>
	           <option value="0.0065425264">0.0065425264</option>
	        </select>
	    </r:field>
	      <r:field fieldName="start_date" width="110px" messagekey="start_date"  allowModify="true">
	       </r:field>  
	       <r:field fieldName="end_date" width="110px" messagekey="end_date"  allowModify="true">
           </r:field>
 </r:datacell>
</div> 
   </div>         
   
  <input type="hidden" name="create_date" /> 
<div class="mx_button" style="text-align: center;padding-top:10px;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div> 
 



</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
		  var isModify = <%=isModify%>;
		  if(isModify){
		    _dofilter(${bean.is_account_limit});
		  } else {
		    _dofilter(${vo.is_account_limit});
		  }
            jQuery("#agree_receive_money_date").attr("readOnly", true);
            jQuery("#contract_receive_money_date").attr("readOnly", true);
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
            
            function showTemplate(){
                var fin_invoice_template_id=$id("fin_invoice_template_id").getValue()+"";
                if(fin_invoice_template_id==""){
                        alert("请先选择一个开票模板！");
                        return;
                }
                
                var url = "<%=request.getContextPath()%>/jsp/faerp/system/fin_invoice_template/show_template_item.jsp?id=" + fin_invoice_template_id;
                url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
                showModalCenter(url, window, "", 350, 350, "查看模板");  //增加子岗位
            }
            
            
		//判断此成本中心的账单的开票状态是否有属于部分开票的，有则不允许更换，反之则允许；
        function checkInvoiceStatus(selectEntity,obj){
	        var bill_invoice_status_bd="0";
	        var fin_invoice_template_id=obj.getValue();
	        var customer_code="${bean.customer_code}";
	        var cost_center_id = "${bean.id}";
		    if(!fin_invoice_template_id){
		        return ;
		    }
	        //alert("customer_code="+customer_code+"______"+fin_invoice_template_id);
        
             jQuery.ajax({
                    url : "/FAERP/Fin_invoice_template_itemAction.do?cmd=checkInvoiceStatus&cust_code="+customer_code+"&cost_center_id="+cost_center_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){
                        if(text!=null){       
                               if(text == '1'){
                                       bill_invoice_status_bd="1";
                                        return false;
                                   }
                            }
                        }
            });
            
        var old_fin_invoice_template_id="${bean.fin_invoice_template_id}";
        if(bill_invoice_status_bd!="0"){
            //alert("此成本中心下账单的开票状态有部分开票不可更改模板！");
            //alert($id("fin_invoice_template_id").activeOption());
            var entity=$id("fin_invoice_template_id").getEntityByValue(old_fin_invoice_template_id);
            var idx=entity.__index;
            obj.selectOptionByIndex(idx);
        }
        
        if(bill_invoice_status_bd!="0"){
            if(old_fin_invoice_template_id!=fin_invoice_template_id){
            //alert("old_fin_invoice_template_id="+old_fin_invoice_template_id+"___fin_invoice_template_id="+fin_invoice_template_id)
            alert("此成本中心下账单的开票状态有部分开票或者待开票，不可更改模板！");
            }
        }

}

//判断此成本中心的账单的开票状态是否有属于部分开票的，有则不允许更换账期属性；
function checkInvoiceStatus2(obj){
        var bill_invoice_status_bd="0";
        var is_display_year_month=obj.value;
        var customer_code="${bean.customer_code}";
        var cost_center_id = "${bean.id}";
        if(!is_display_year_month){
            return ;
        }
        //alert("customer_code="+customer_code+"______"+fin_invoice_template_id);
        
             jQuery.ajax({
                    url : "/FAERP/Fin_invoice_template_itemAction.do?cmd=checkInvoiceStatus&cust_code="+customer_code+"&cost_center_id="+cost_center_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){
                        if(text!=null){       
                               if(text == '1'){
                                       bill_invoice_status_bd="1";
                                        return false;
                                   }
                            }
                        }
            });
            
        var old_is_display_year_month="${bean.is_display_year_month}";
        if(bill_invoice_status_bd!="0"){
            document.getElementById("is_display_year_month").value = old_is_display_year_month;
            if(old_is_display_year_month!=is_display_year_month){
                alert("此成本中心下账单的开票状态有部分开票或者待开票，不可更改账期！");
            }
        }

}
jQuery("#centerNew7").hide();
jQuery("#taxpayer_identity_type").val(jQuery("#taxpayer_identity_type_b").val());
jQuery("#taxpayer_identity_type").attr("disabled",true);

jQuery("#taxpayer_identity_type_bak").val(jQuery("#taxpayer_identity_type_bk").val());
jQuery("#taxpayer_identity_type_bak").attr("disabled",true);

//2016-04-18  by zhouxiaolong 当用户选择‘代收付进入增票时’时，填写附加税比率  begin
//进入修改页面时的加载事件




function batch_date(obj,name){
    var enCurEntity1 = $id("datacell1").activeEntity;
    var entity = enCurEntity1.getProperty(name);
            enCurEntity1.setProperty(name,obj);
    return true;            
}




//2016-04-18  by zhouxiaolong 当用户选择‘代收付进入增票时’时，填写附加税比率  end
</script>
