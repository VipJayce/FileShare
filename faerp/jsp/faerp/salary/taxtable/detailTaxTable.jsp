<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.taxtable.taxTable_resource" prefix="rayoo.salary.taxtable.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>新增税率表</title>
</head>
<%
String mod = request.getAttribute("pageModel")==null? "" : request.getAttribute("pageModel").toString();
boolean dis = "detail".equals(mod)? false : true;
String isReadonly = "detail".equals(mod)? "readonly" : "";
String gridReadonly = "detail".equals(mod)? "true" : "false";
%>
<body>
<form id="taxItemForm" name="taxItemForm" action="" method="post"> 
<input id="h_cmd" type="hidden" name="cmd"/>
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key="taxtable_add"/></div>
	</div>
    <div class="ringht_s">
   	<!--表格2-->
    <div class="box_3">
    	  <div class="xz_title"><fmt:message key="taxtable_info"/></div>
	      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	            <input id="hid_tax_id" type="hidden" name="tax_table_id" value="${bean.id }"/>
	          <tr>
	            <td class="td_1"><span style="color:red">*</span><fmt:message key="taxtable_name"/></td>
	            <td class="td_2">
	                <input <%=isReadonly %> maxlength="100" validate="notNull;" id="tax_table_name" 
	                name="tax_table_name" class="sText" value="${bean.tax_table_name }"/>
	                   
	            </td>
	            <td class="td_1"><span style="color:red">*</span><fmt:message key="taxtable_deduct_amount"/></td>
	            <td class="td_2">
	                <input <%=isReadonly %> maxlength="18" validate="notNull;isNum" 
	                id="txt_deduct_amount" class="sText" value="${bean.deductStr }" 
	                onfocus="handlerFocus(this)" onblur="handlerBlur(this)"/>
	                
	                <input id="hid_deduct_amount" type="hidden" name="deduct_amount" 
	                value="${bean.deduct_amount }"/>
	            </td>
	            <td class="td_1"><span style="color:red">*</span><fmt:message key="taxtable_fix_rate"/></td>
	            <td class="td_2"><input <%=isReadonly %> maxlength="18" validate="notNull;isNum" 
	               id="fix_rate" name="fix_rate" class="sText" value="${bean.fix_rate }"/></td>
	          </tr>
	        </table>
    </div>
   
    <div class="box_3">
      <div class="xz_title"><fmt:message key="taxtable_detail"/></div>
    </div>
	     <c:if test="<%=dis %>">
	        <div id="div_mod" class="button">
		        <div class="button_right">
		            <ul>
		              <li class="c"><a onclick="addTaxItem()" href="javascript:void(0);"><fmt:message key="button_add"/></a></li>
		              <li class="d"><a onclick="delTaxItem()" href="javascript:void(0);"><fmt:message key="button_del"/></a></li>
		            </ul>
		        </div>
		        <div class="clear"></div>
	        </div>
	     </c:if>
    
	    <!--表格2 end-->
	    <div class="dc_box" id="values_div">
	      <r:datacell 
	        id="dc_taxitem"
	        queryAction="/FAERP/TaxTableAction.do?cmd=detail"
	        submitAction="/FAERP/TaxTableAction.do?cmd=saveTaxtableAndItem"
	        width="100%"
	        xpath="TaxItem"
	        submitXpath="TaxItem"
	        paramFormId="taxItemForm" submitReturnValue="" readonly="<%=gridReadonly %>"
	        >
	
	        <r:field fieldName="tax_level" messagekey="taxtable_tax_level">
	            <h:text validateAttr="type=number ;message=不是数字;allowNull=false"/>
	        </r:field>
	         <r:field fieldName="min_amount" messagekey="taxtable_min_amount" onRefreshFunc="formatNum">
	            <h:text validateAttr="totalDigit=13;fracDigit=2;type=double;message=不是数字或精度有误！;allowNull=false"/>
	        </r:field>
	         <r:field fieldName="max_amount" messagekey="taxtable_max_amount" onRefreshFunc="formatNum">
	            <h:text validateAttr="totalDigit=13;fracDigit=2;type=double;message=不是数字或精度有误！;allowNull=false"/>
	        </r:field>
	         <r:field fieldName="tax_rate" messagekey="taxtable_tax_rate">
	            <h:text validateAttr="totalDigit=2;fracDigit=2;type=double;message=不是数字或精度有误！;allowNull=false"/>
	        </r:field>
	        <r:field fieldName="quick_deduct" messagekey="taxtable_quick_deduct" onRefreshFunc="formatNum">
	            <h:text validateAttr="totalDigit=13;fracDigit=2;type=double;message=不是数字或精度有误！;allowNull=false"/>
	        </r:field>
	      </r:datacell>
	    </div>
        <div class="foot_button">
          <c:if test="${param.pageModel!='detail'}">
          	<input onclick="saveTax()" type="button" class="foot_icon_1" value="<fmt:message key="button_save"/>"/>
          </c:if>
           
          <input onClick="funcGoback()" type="button" class="foot_icon_1" value="<fmt:message key="button_back"/>"/>
        </div>
    </div>
</div>
</form>
</body>
<script type="text/javascript">
$id("dc_taxitem").afterSubmit = function(ajax){
    rst = ajax.getProperty("returnValue");
    document.getElementById("hid_tax_id").value=rst;
    
};
//新增一条税率表明细
function addTaxItem(){
    $id("dc_taxitem").addRow();
}
//删除税率表明细
function delTaxItem(){
    if(confirm("<fmt:message key="alert_sure_to_delete"/>")){
        $id("dc_taxitem").deleteRow();
    }
    
}
//保存税率表信息
function saveTax(){
    if(save_check()){
        $id("dc_taxitem").isModefied = true;
        $id("dc_taxitem").submit();
        if(rst){
            alert("<fmt:message key="alert_save_success"/>");
        }
    }
}

function formatNum(value,entity,rowNo,cellNo){
    return formatNumber (value,'#,###.00');
}
//数字千分位显示begin,获得焦点时显示非千分位
function handlerFocus(el){
    el.value = document.getElementById("hid_deduct_amount").value;
}
//数字千分位显示end,失去焦点时显示千分位
function handlerBlur(el){
    var reg = /^\d+(\.\d+)?$/;
    if(el.value && !reg.test(el.value)){
        el.value = "";
        document.getElementById("hid_deduct_amount").value="";
        alert("<fmt:message key="alert_deduct_amount"/>");
        return;
    }
    if(el.value){
        document.getElementById("hid_deduct_amount").value = el.value;
        el.value = formatNumber (el.value,'#,###.00');
    }
    
}
//保存验证
function save_check(){
    nm = document.getElementById("tax_table_name").value;
    amount = document.getElementById("hid_deduct_amount").value;
    rate = document.getElementById("fix_rate").value;
    
    if(!nm || !amount || !rate){
        alert("<fmt:message key="alert_cant_null"/>");
        return false;
    }
    
    var reg = /^\d+(\.\d+)?$/;
     if (!reg.test(amount)) {
        alert("<fmt:message key="alert_amount_is_num"/>");
        return false;
     }
     if (!reg.test(rate)) {
        alert("<fmt:message key="alert_rate_is_num"/>");
        return false;
     }
     return true;
}
//返回
function funcGoback(){
    document.taxItemForm.action = "<%=request.getContextPath()%>/TaxTableAction.do";
    document.taxItemForm.cmd.value = "queryAll";
    document.taxItemForm.tax_table_name.value = "";
    document.taxItemForm.submit();
}
</script>
</fmt:bundle>
</html>
