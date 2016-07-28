<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%String bill_id=request.getParameter("bill_id")==null?"":request.getParameter("bill_id").toString(); 
%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一次性收费项目</title>
<script language="javascript">
/*******************************************************************************************************/
function save_onClick (){
    var department=document.getElementById("department").value;
    var charge_item=document.getElementById("charge_item").value;
    var amount=document.getElementById("amount").value;
    var remark=document.getElementById("remark").value;
    var bill_id=document.getElementById("bill_id").value;
    if(department=="请选择"){
    alert("请选择部门！");
    return;
    }
    if(charge_item=="请选择"){
    alert("请选择项目名称！");
    return;
    }
    if(amount==""){
    alert("请输入金额！");
    return;
    }
    
    if(charge_item == "31" || charge_item == "32"){
        var remarkIndex = remark.indexOf("20");
        if(remarkIndex < 0){
            alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
            return;
        }else{
            var remarkYear = remark.substring(remark.indexOf("20"),remark.indexOf("20")+4);
            var remarkYearCheck = remark.substring(remark.indexOf("20"),remark.indexOf("20")+5);
            var lengthVal=remark.length-remark.indexOf("20");
            if(lengthVal > 4){
               if(!isNaN(remarkYearCheck)){
                    alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                    return;
                }
            }else if(lengthVal == 4){
               if(isNaN(remarkYear)){
                    alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
                    return;
                }
            }else if(lengthVal < 4){
               alert("备注中没有输入正确的年份格式，例如：2014,在年分前后不可以出现任何数字");
               return;
            }
        }
    }
    
    var addValueTax = document.getElementById("addValueTax").title;//增值税金额
    var addValueTaxRate = document.getElementById("addValueTaxRate").value;//增值税税率
    var additionalTax = document.getElementById("additionalTax").title;//附加税金额
    var additionalTaxRate = document.getElementById("additionalTaxRate").value;//附加税税率
    var serviceType = document.getElementById("serviceType").value;//业务类型
    
    var action="<%=request.getContextPath()%>/FinbillAction.do?cmd=insertBillOthers";
    var myAjax = new Ajax(action);
    myAjax.addParam("department",department);
    myAjax.addParam("charge_item",charge_item);
    myAjax.addParam("amount",amount);
    myAjax.addParam("remark",remark);
    myAjax.addParam("bill_id",bill_id);
    myAjax.addParam("addValueTax",addValueTax);
    myAjax.addParam("addValueTaxRate",addValueTaxRate);
    myAjax.addParam("additionalTax",additionalTax);
    myAjax.addParam("additionalTaxRate",additionalTaxRate);
    myAjax.addParam("serviceType",serviceType);
    myAjax.submit();
    var returnNode = myAjax.getResponseXMLDom();
     if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      window.close();
                      window.opener.showListData();//回调父页面函数
                 }
    
}
function showTenNum(e){
	e.value = e.title;
}
function showTwoNum(e){
	//var value = (parseFloat(e.title)+0).toFixed(3);
	var value = (parseFloat(e.title)+0).toFixed(2);
	e.value = value;
}
</script>
</head>
<body>

<form name="form" method="post">
<input type="hidden" value="<%=bill_id %>" id="bill_id"> 
<div id="right">

<div id="ccChild1"     class="box_xinzeng" style="height:200px "> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>部门</td>
            <td class="td_2">
            <r:comboSelect id="department"  name ="department" 
                queryAction="/FAERP/FinbillAction.do?cmd=getDeNameFromBaseData"
                textField="description"
                valueField="description"
                nullText="请选择"
                xpath="BillOthersVo"
                width="190" >
            </r:comboSelect>
            </td>
            <td class="td_1"><span class="style_required_red">* </span>项目名称</td>
            <td class="td_2">
             <r:comboSelect id="charge_item"  name ="charge_item" 
                linkId="department"
                queryAction="/FAERP/FinbillAction.do?cmd=getChargeItemFromBaseData"
                textField="name"
                valueField="code"
                nullText="请选择"
                xpath="BillOthersVo" onChangeFunc = "showAddValueTax"
                width="190" >
            </r:comboSelect>
            </td>
        </tr>
        <tr>
        <td class="td_1" ><span class="style_required_red">* </span> 金额</td>
        <td class="td_2" ><input  style="width:190px" id="amount"  onkeyup="clearNoNum(this)"  > </td><!-- change(document.getElementById('amount').value) -->>
         <td class="td_1"> 备注</td>
        <td class="td_2"  ><input style="width:190px" id="remark">  </td>
        </tr>
        <tr id="typeFJS">
        <td class="td_1" ><span class="style_required_red"></span>附加税率 </td>
        <td class="td_2" ><input  style="width:190px" id="additionalTaxRate"  readonly="readonly"  value= "0"> </td>
         <td class="td_1"> 附加税金额</td>
        <td class="td_2"  ><input class="noborder_input" style="width:190px" id="additionalTax" readonly="readonly" value = "0" onclick="showTenNum(this)" onblur="showTwoNum(this)"></td>
        </tr>
        <tr id="typeZZS">
        <td class="td_1" ><span class="style_required_red"></span> 增值税率</td>
        <td class="td_2" ><input class="noborder_input" style="width:190px" id="addValueTaxRate"  readonly="readonly" value = "0"/></td>
         <td class="td_1">增值税金额</td>
        <td class="td_2"  ><input class="noborder_input" style="width:190px" id="addValueTax"  readonly="readonly" value = "0" onclick="showTenNum(this)" onblur="showTwoNum(this)"/></td>
        </tr>
        <tr id="typeYWLX">
        <td class="td_1" >业务类型</td>
        <td class="td_2" >
        	<select id="serviceType" onchange="showAddValueTax()"> 
        		<option value="1">派遣</option>
        		<option value="2">委托</option>
        		<option value="3">专项外包</option> 
        		<option value="4">补充福利</option> 
        	</select>
        </td>
        <td class="td_1">合计</td>
        <td class="td_2"  ><input class="noborder_input" style="width:190px" id="allValueTax"  readonly="readonly" value = "0" onclick="showTenNum(this)" onblur="showTwoNum(this)"/></td>
        </tr>
<!--         <tr id="typeDSFIN"> -->
<!--         <td class="td_1" >代收付是否进增票</td> -->
<!--         <td class="td_2" ><input type="checkbox" id="isShow" checked="checked" onclick ="isShowAddValue()"/></td> -->
<!--          <td class="td_1"></td> -->
<!--         <td class="td_2"  ></td> -->
<!--         </tr> -->
        <td class="td_2"  colspan="4"  align="center">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:save_onClick();"  />
        &nbsp; &nbsp;
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="window.close();"/>
        </td>
        </tr>
        </table>
        
        </div>
        </div>
        </form>

<script language="javascript">
function showAddValueTax(type){
	//查询一次性收费产品类型 1服务费、2工资、3社保、4公积金
	var code = document.getElementById("charge_item").value;
	var bill_id = document.getElementById("bill_id").value;
	var service_type = document.getElementById("serviceType").value;
	if(code!=null && code!=""){
		var action="<%=request.getContextPath()%>/FinbillAction.do?cmd=queryProductType";
	    var myAjax = new Ajax(action);
	    myAjax.addParam("code",code);
	    myAjax.addParam("bill_id",bill_id);
	    myAjax.addParam("service_type",service_type);
	    myAjax.submit();
	    var returnNode = myAjax.getResponseXMLDom();
		var obj = new Array();
	    if( returnNode ) {
	    	//document.getElementById("typeFJS").style.display="inline";
	        //document.getElementById("typeZZS").style.display="inline";
	        //document.getElementById("typeDSFIN").style.display="none";
	    	var type = ""+myAjax.getProperty("returnValue");//返回结果类型
	    	var jsonMess = ""+myAjax.getProperty("returnMessage");//增值税税率
	    	if("1" == type){//该一次性收费产品尚未分类，无法计算增值税！
	    		alert(jsonMess);
	    		document.getElementById("serviceType").value = "1";
	    		document.getElementById("charge_item").value = "";
	    		$id("charge_item").loadData();
	            $id("charge_item").refresh();
	    	}
	    	if("3" == type){//计算增值税
	    		jsonMess = eval('(' + jsonMess + ')');
		    	var productType = jsonMess.productType;//产品类型
		    	var taxRate = jsonMess.taxRate;//增值税
		    	var addTaxRate = jsonMess.addTaxRate;//附加税
		    	var isInTax = jsonMess.isInTax;//是否进增票
				document.getElementById("additionalTaxRate").value = addTaxRate;
				document.getElementById("addValueTaxRate").value = taxRate;
				generateTax();
// 		    	if("1" == productType){//服务费
// 					document.getElementById("addValueTaxRate").value = taxRate;
// 					generateTax();
// 		    	}else{//代收付
// 		    		document.getElementById("addValueTaxRate").value = taxRate;
// 		    		document.getElementById("typeDSFIN").style.display="inline";
// 		    		document.getElementById("isShow").checked = "checked";
// 		    		generateTax();
// 		    	}
	    	}
	    }
	}
}
function change(str) { 
  document.getElementById("amount").value = str.replace(/[^d.]/g, "");
}

function clearNoNum(obj)
{
   //先把非数字的都替换掉，除了数字和.
   obj.value = obj.value.replace(/[^\d.]/g,"");
   //必须保证第一个为数字而不是.
   obj.value = obj.value.replace(/^\./g,"");
   //保证只有出现一个.而没有多个.
   obj.value = obj.value.replace(/\.{2,}/g,".");
   //保证.只出现一次，而不能出现两次以上
   obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
   generateTax();
}
//计算增值税及附加税
function generateTax(){
	var additionalRate = document.getElementById("additionalTaxRate").value;
	var addValueRate = document.getElementById("addValueTaxRate").value;
   	var amount = document.getElementById("amount").value;
   	if(amount == ""){
	   amount = 0;
   	}
   	if(additionalRate == ""){
	   additionalRate = 0;
   	}
   	var amountArray = taxGenerate(amount,addValueRate,additionalRate);
   	document.getElementById("additionalTax").value = saveTwoNum(amountArray[1]);
   	document.getElementById("addValueTax").value = saveTwoNum(amountArray[0]);
   	document.getElementById("additionalTax").title = amountArray[1];
   	document.getElementById("addValueTax").title = amountArray[0];
   	var allValue = parseFloat(amountArray[0])+parseFloat(amountArray[1])+parseFloat(amount);
   	document.getElementById("allValueTax").value = saveTwoNum(allValue);
   	document.getElementById("allValueTax").title = allValue;
}

//代收付是否进增票
function isShowAddValue(){
	var checked = document.getElementById("isShow").checked;
	if(checked){
		document.getElementById("typeFJS").style.display="inline";
        document.getElementById("typeZZS").style.display="inline";
        generateTax();
	}else{
		document.getElementById("typeFJS").style.display="none";
        document.getElementById("typeZZS").style.display="none";
    	document.getElementById("additionalTax").value = "0";
       	document.getElementById("addValueTax").value = "0";
	}
}
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>


