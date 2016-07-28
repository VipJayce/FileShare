<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page
	import="rayoo.finance.bill.billsalaryrel.util.IBillSalaryRelConstants"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />

<style type="text/css">
tr.odd {
	background: #fff;
}

tr.even {
	background: #f9fcfd;
}

.box tr:hover,tr.hover {
	background: #c4e7f8;
}

.box tr:selected,tr.selected {
	background-color: #eef8ff;
	border-bottom-color: #daf1ff;
	border-right-color: #daf1ff;
}

.fex_row {
	LEFT: expression(document .   getElementById('values_div') .  
		scrollLeft );
	POSITION: relative;
}
</style>
<script language="javascript">
	jQuery.noConflict();
	function querySalaryDetail(){
		form.action="<%=request.getContextPath()%>/BillSalaryRelAction.do?";
        form.cmd.value = "queryForList";
       //	$id("cost_center_name").value=$id("cost_center_id").text.value;
        form.submit();
	}

	function rtnFuncCustomer(arg){
		
    	var lookup = $id("customer_id");
    	lookup.value = arg[0];
    	lookup.displayValue = arg[2];
    	$id("customer_name").value=arg[2];
    	//var costCenter = $id("cost_center_id");
    	
    	$id("cost_center_id").addParam("cust_id", arg[0]);
       	$id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
      
        //alert(costCenter);
    	return false;
	}

    function simpleQuery_onClick(){  
    	$id("celllist1").addParam("customer_id",$id("customer_id").value);
    	$id("celllist1").addParam("pay_year_month",$id("pay_year_month").value);
    	//$id("celllist2").addParam("customer_id",$id("customer_id").value);
    	//$id("celllist2").addParam("cost_center_id",$id("cost_center_id").value);
    	//$id("celllist2").addParam("pay_year_month",$id("pay_year_month").value);
    	
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        //$id("celllist2").loadData();
        //$id("celllist2").refresh();
    }
      //datacell1 checkbox begin
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck3(" + rowNo + ",this);'  name='checkbox1' id='checkboxId' value='" + entity.getProperty("id") + "'>";
       return returnStr;
    }
    function checkAllList(all){
    	if(all.checked){
	        var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= true;
	            }
	        } 
	    }else{
	    	var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= false;
	            }
	        } 
	    }
    }
    
    function changeCheck(rowNo,box){
    	
    }
    
  	// end
    //datacell3 checkbox begin
    function checkAllList3(all){
    	if(all.checked){
    		var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox3") {
	                element[i].checked= true;
	            }
	        } 
    	}else{
    		var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox3") {
	                element[i].checked= false;
	            }
        	} 
    	}
        
    }
       
   
    function setCheckboxForCellList3(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck(" + rowNo + ",this);'  name='checkbox3' id='checkboxId3' value=" + entity.getProperty("id") + ">";
       return returnStr;
    }
    
     function changeCheck3(rowNo,box){
    	
    }
    //end
    //删除工资查看明细
     function setRadiochecked(value,entity,rowNo,cellNo ){
     	  var returnStr = "";
       returnStr =  "<input type='radio' onclick='radiochange(" + rowNo + ",this);'  name='radioId' id='radioId' value=" + entity.getProperty("id") + ">";
       return returnStr;
     }
     
     //点击radio回调
     function radiochange(rowNo,rdo){
     	//alert( rdo.value);
     	$id("bill_id").value = rdo.value;
     	$id("celllist3").addParam("bill_id",rdo.value);
        $id("celllist3").loadData();
        $id("celllist3").refresh();
     }
     //end
     function deleteRel(){
     	var ids = findSelections("checkbox3","id");
     	//alert("ids ===============" + ids);
     	//return;
     	if(ids=="" || ids==null){
     		alert("请选择要删除的记录");
     		return;
     	}
     	var bill_id = $id("bill_id").value;
     	if(ids=="" || ids==null){
     		alert("账单为空!");
     		return;
     	}
   	   if(confirm("确定要清空数据吗？")){
		    jQuery.getJSON("<venus:base/>/BillSalaryRelAction.do?cmd=deleteToRel&ids=" + ids,{"bill_id":bill_id},function(json){
				alert(json.returnString);
		     	$id("celllist3").addParam("bill_id",$id("bill_id").value);
		        $id("celllist3").loadData();
		        $id("celllist3").refresh();
	        });
	   }
     }
     
     function saveRel(){
     		var bill_year_month = $id("bill_year_month").value;
     		var cost_center_id = $id("cost_center_id").getValue();
     		var ids = findSelections("checkbox1","id");
     		
     		
     		if(bill_year_month==""){
     			alert("请输入合并的账单年月！");
     			return;
     		}
     		if(cost_center_id==""){
                alert("请选择成本中心！");
                return;
            }
            if(ids==null || ids== 'null'){
                alert("请选择要合并的工资！");
                return;
            }
     		
		    jQuery.getJSON("<venus:base/>/BillSalaryRelAction.do?cmd=saveToRelMerge&bill_year_month=" + bill_year_month + "&ids=" + ids,{"cost_center_id":cost_center_id},function(json){
				alert(json.returnString);
		     	$id("celllist1").addParam("customer_id",$id("customer_id").value);
    			$id("celllist1").addParam("pay_year_month",$id("pay_year_month").value);
		        $id("celllist1").loadData();
		        $id("celllist1").refresh();
		        json = null;
	        });
     }
     
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    
</script>
</head>
<body>
<form action="/FAERP/BillSalaryRelAction.do?" name="form" id="form"
	method="post"><input type="hidden" name="cmd" id="cmd" />
<div id="right">
<div class="right_title_bg">
<div class=" right_title">工资合并账单</div>
</div>
<div class="ringht_s">
<div class="tab">
<div class="box_tab">

<table width="100%" border="0" cellspacing="1" cellpadding="0"
	bgcolor="#c5dbe2">
	<tr>
		<td class="td_1">选择客户</td>
		<td class="td_2">
		<div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="false"
			id="customer_id" name="customer_id" property="customer_id"
			displayProperty="customer_name"
			lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
			dialogTitle="选择客户" height="440" width="600" style="width:170px" /><input
			type="hidden" name="customer_name" id="customer_name"></div>
		</td>
		<td class="td_1">客户成本中心</td>
		<td align="left"><r:comboSelect id="cost_center_id"
			name="cost_center_id"
			queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			textField="cost_center_name" valueField="id" xpath="CostcenterVo"
			property="cost_center_id" width="180" nullText="--请选择--">
		</r:comboSelect><input type="hidden" name="cost_center_name" id="cost_center_name"></td>
	</tr>
	<tr>
		<td class="td_1">薪资账单年月</td>
		<td class="td_2"><input type="text" value="" class="sText"
			id="pay_year_month" name="pay_year_month" /></td>
		<td class="td_2">&nbsp;</td>
		<td class="td_2">&nbsp;</td>
	</tr>
</table>
<div class="dc_button"><input type="button" class="icon_2"
	value="查询" onclick="simpleQuery_onClick()" />
</div>
<div id="bg" class="xixi1">
<div id="font1" class="tab1"
	onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'">合并工资</div>
<div id="font2" class="tab2"
	onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'">拆分工资</div>
</div>
<div id="TabCon1"><!--表格1-->
<div class="xz_title" style="margin-top: 10px;">选择想要并入社保账单的工资</div>
 <div id="values_div3" style="width:100%;height:200px; margin-top:5px;">
<r:datacell id="celllist1"
	queryAction="/FAERP/BillSalaryRelAction.do?cmd=queryForSalaryList"
	paramFormId="datacell_formid" width="100%" height="350px"
	xpath="SalaryBatchDetail" readonly="true">
	<r:field allowModify="false" fieldName="id" sortAt="none"
		label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
		width="70px" onRefreshFunc="setCheckboxStatus">
	</r:field>
	<r:field fieldName="pay_name" label="工资发放名称" width="230px">
		<h:text />
	</r:field>
	<r:field fieldName="pay_year_month" label="工资所属年月" width="235px">
		<h:text />
	</r:field>
	<r:field fieldName="bill_year_month" label="薪资所属账单年月" width="235px">
		<h:text />
	</r:field>
	<r:field fieldName="tax_month" label=" 薪资报税年月 " width="335px">
		<h:text />
	</r:field>
</r:datacell>
</div>
 <!--</div>-->
<div
	style="text-align: center; height: 2px; margin-top: 10px; width: 100%;">
请输入合并的账单年月 <input type="text" value="" class="sText" id="bill_year_month" name="bill_year_month" /> 201208
<input type="button" class="icon_2" value="合并" onclick="saveRel()"/><br />
</div>
<div style="margin: 10px 0px 0px 10px;"><span>注：合并工资时，该账单年月的社保帐单下，若已有工资将会率先删除，因此若该账单年月有多笔工资的情况下，请一并勾选！若无社保帐单，将生成仅含工资类型的账单！</span></div>
<!--表格 end--></div>
<!--表格1 end--></div>

<div id="TabCon2" style="display: none;"><!--表格2-->
<div class="box_tab"><!--按钮-->
<div class="xz_title" style="margin-top: 10px;">生成日志</div>
<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
    <tr>
        <td valign="top" width="40%">下属产品比例<br>
                <r:datacell 
                        id="celllist111"
                        isCount="false"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/SecuritygrouprelAction.do?cmd=searchSecurityGroupData"
                        submitAction="/FAERP/SecuritygrouprelAction.do?cmd=insertSecurityGroupData"
                        width="97%" height="200px"
                        xpath="SecuritygrouprelVo"
                        submitXpath="SecuritygrouprelVo"
                        >
                
                      <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>
                      <r:field fieldName="security_product_id" label="社保公积金产品" width="100px">
                              <r:comboSelect id="product_id" name="security_product_id"
                               queryAction="SecurityproductAction.do?cmd=getProductListData"
                               textField="product_name"
                               valueField="id"

                               xpath="SecurityproductVo"
                               width="100px"
                               nullText="请选择" />
                      </r:field>
                      <r:field fieldName="month_pay_bd" label="是否每月支付">
                        <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'"/>
                      </r:field>
                      <r:field fieldName="is_supply" label="是否可补收">
                        <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'"/>
                      </r:field>
                      <r:field fieldName="serial_no" label="比例排序">
                        <h:text/>
                      </r:field>
                    </r:datacell>
        </td>
        <td valign="top" width="35%">
            新开类别<br>
                    <r:datacell 
                        id="celllist222"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/SecuritygroupnewAction.do?cmd=searchSecurityGroupData"
                        submitAction="/FAERP/SecuritygroupnewAction.do?cmd=insertSecurityGroupData"
                        width="97%" height="200px"
                        xpath="SecuritygroupnewVo">
                
                      <r:toolbar location="bottom" tools="nav,edit:add del,pagesize,info"/>
                      <r:field fieldName="type_code" label="新开类型编码">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="type_name" label="新开类型名称">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="is_oneoff" label="是否是一次性补缴方式" width="150px">
                        <d:select dictTypeId="TrueOrFalse" extAttr="validateAttr='allowNull=false'"/>
                      </r:field>
                    </r:datacell>
            
        </td>
     </tr>
   </table>
</div>
</div>
</div>
<!-- 
<div style="margin-left: 0; margin-right: 0; width: 49%; float: left;">
<div class="button">
<div class="button_right">
<ul>
	<li class="a_1"><a href="账单明细.html">查看明细</a></li>
</ul>
</div>
<div class="clear"></div>
</div>
<div class="box" id="values_div">
<div id="values_div3" style="width:100%;height:200px; margin-top:5px;">
<r:datacell id="celllist2"
	queryAction="/FAERP/BillSalaryRelAction.do?cmd=queryForBillList"
	paramFormId="form" width="100%" height="350px"
	xpath="FinbillVo" 
	readonly="true">
	<r:field allowModify="false" fieldName="id" sortAt="none"
		label=""
		width="55px" onRefreshFunc="setRadiochecked"
		>
	</r:field>
	<r:field fieldName="cust_name" label="客户名称" width="130px">
		<h:text/>
	</r:field>
	<r:field fieldName="cost_center_name" label="客户成本中心" width="130px">
		<h:text/>
	</r:field>
	<r:field fieldName="bill_year_month" label="账单年月" width="90px">
		<h:text/>
	</r:field>
	<r:field fieldName="bill_amount" label="账单金额" width="130px">
		<h:text/>
	</r:field>
</r:datacell>
</div>
</div>
</div>
 
<div style="margin-left: 0; margin-right: 0; width: 49%; float: right;">
<div class="button">
<div class="button_right">
<ul>
	<li class="d"><a onClick="javascript:deleteRel()">删除</a></li>
</ul>
 <div id="values_div3" style="width:100%;height:200px; margin-top:5px;">
<r:datacell id="celllist3"
	queryAction="/FAERP/BillSalaryRelAction.do?cmd=queryForSalaryDel"
	paramFormId="form" width="100%" height="350px"
	xpath="SalaryBatchDetail" readonly="true">
	<r:field allowModify="false" fieldName="id" sortAt="none"
		label="<input type='checkbox' name='checkall' value='' onclick='checkAllList3(this);' />"
		width="70px" onRefreshFunc="setCheckboxForCellList3">
	</r:field>
	<r:field fieldName="pay_name" label="工资发放名称" width="230px">
		<h:text />
	</r:field>
	<r:field fieldName="pay_year_month" label="工资所属年月" width="235px">
		<h:text />
	</r:field>
	<r:field fieldName="bill_year_month" label="薪资所属账单年月" width="235px">
		<h:text />
	</r:field>
	<r:field fieldName="tax_month" label=" 薪资报税年月 " width="335px">
		<h:text />
	</r:field>
</r:datacell>
</div>
</div>
</div>
</div>
 -->
</form>
</body>
</html>
<script language="javascript">
	jQuery(function(){
		 $id("celllist1").isQueryFirst = false;
   		 //$id("celllist2").isQueryFirst = false;
   		 //$id("celllist3").isQueryFirst = false;
	});
	
</script>