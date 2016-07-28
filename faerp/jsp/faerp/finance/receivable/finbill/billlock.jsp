<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>无标题文档</title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
.fex_row_top
 {
  top:expression(document.getElementById('div_top').scrollTop-2); 
     position:relative; 
     z-index:1;
     background-color: #DEE7FE;
 }
</style>
<script language="JavaScript" src="../../scripts/common.js"></script>
<script type="text/javascript">
	jQuery.noConflict();
	function locked(val){
		var flag = false;
		var ids = findSelections("checkbox1","id");
		if(ids == null){
		 	alert("<fmt:message key='alert_select_bill_record'/>");
		 	return;
		}
		
		var confirmStr = null;
		 if(val == 1){
		 	confirmStr = "<fmt:message key='alert_is_lock'/>";
		 }else if(val == 0){
		 	confirmStr = "<fmt:message key='alert_is_unlock'/>";
		 }
		 if(confirm(confirmStr)){
		    flag = true;
	   	}
	   	
	   	if(flag){
	   	 var urlstr="/FAERP/FinbillAction.do?cmd=lockBill&ids=" + ids+"&lock="+val;
	   	 urlstr=urlstr+"&_ts="+(new Date()).getTime(); 
	   	
	    jQuery.ajax({
        type : "post",
        url : urlstr,
        dataType : "html",
        success : function(data) {
	            if (data) {
		                alert(data);
		                $id("celllist1").addParam("customer_id",$id("customer_id").value);
		                $id("celllist1").addParam("cost_center_id",$id("cost_center_id").getValue());
		                $id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
		                $id("celllist1").reload();
		                $id("celllist1").refresh();
	            }
	        }
	    });

	   	/*
	   		jQuery.getJSON("/FAERP/FinbillAction.do?cmd=lockBill&ids=" + ids,{"lock":val},function(json){
				alert(json.returnString);
				$id("celllist1").addParam("customer_id",$id("customer_id").value);
     			$id("celllist1").addParam("cost_center_id",$id("cost_center_id").getValue());
     			$id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
		        $id("celllist1").reload();
		        $id("celllist1").refresh();
	        });
	        
	        */
	   	}
	}
	
	function rtnFuncCustomer(arg){
		
    	var lookup = $id("customer_id");
    	lookup.value = arg[0];
    	lookup.displayValue = arg[2];
    	$id("cost_center_id").addParam("cust_id", arg[0]);
       	$id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
    	return false;
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
	
	//datacell checkbox begin
	function setCheckboxStatus(value,entity,rowNo,cellNo){
	     var returnStr = "";
	    returnStr =  "<input   type='checkbox' name='checkbox1' id='checkboxId' value=" + entity.getProperty("id") + ">";
	    return returnStr;
	}
    function checkAllList(all){
    	//alert(all);
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
    
   
	//end
	
	function queryall(){
		$id("celllist1").addParam("customer_id",$id("customer_id").value);
     	$id("celllist1").addParam("cost_center_id",$id("cost_center_id").getValue());
     	$id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
        $id("celllist1").loadData();
        $id("celllist1").refresh();
	}
	
	
jQuery(document).ready(function() {
        $id("celllist1").isQueryFirst = false;
});
</script>
</head>
<body>
<form name="form" action="" method="post"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key='title_bill_lock'/></div>
	</div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">

  <table width="100%" border="0" cellspacing="0" cellpadding="0">

            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
          
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
        <tr>
            <td align="right"><fmt:message key='customer_name'/></td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
                    id="customer_id" name="customer_id" property="customer_id" displayProperty="customer_name"
                    lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                    messagekey="select_customer"  height="450" width="610" style="width:180px" />
            </td>
            <td align="right"><fmt:message key='cost_center_'/></td>
            <td align="left">
            <r:comboSelect id="cost_center_id" name="cost_center_id"
			            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
			            width="190" messagekey="please_select">
            </r:comboSelect>
        
            </td>
            <td width="100" align="right"><fmt:message key='bill_year_month'/></td>
            <td width="213" align="left">
            <input type="text" class="text_field" id="bill_year_month" name="bill_year_month" inputName="账单年月" maxLength="50" value=""/>
            </td>
        </tr>
        
        <tr>
            <td/>
            <td/>
              <td>&nbsp;</td>
                <td/>
                <input name="button_ok2" class="icon_1"   type="button" value="<fmt:message key='button_query'/>" onClick="javascript:queryall()">
                  <input name="button_reset2" class="icon_1" type="button" value="<fmt:message key='button_reset'/>" onClick="javascript:this.form.reset();">
        </tr>
</table>
  
  </div>
    <!--查询 end-->
    <!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div style="padding: 5 0 0 8">
          <input type="button" name="lock" id="lock" <au:authorityBtn code="sdzd_sd" type="1"/>  value="<fmt:message key='button_lock'/>" class="icon_1" onclick="locked(1)" />
          <input type="button" name="unlock" id="unlock" <au:authorityBtn code="sdzd_js" type="1"/>  value="<fmt:message key='button_unlock'/>" class="icon_1" onclick="locked(0)" />
    </div>
   
    <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/FinbillAction.do?cmd=queryForBillLock"
			paramFormId="datacell_formid" width="99%" height="318px"
			xpath="FinbillVo" readonly="true">
			<r:field allowModify="false" fieldName="id" sortAt="none"
				label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
				width="70px" onRefreshFunc="setCheckboxStatus">
			</r:field>
			<r:field fieldName="cust_name" messagekey="customer_name" width="230px">
				<h:text />
			</r:field>
			<r:field fieldName="cust_code" messagekey="customer_code" width="100px">
				<h:text />
			</r:field>
			<r:field fieldName="cost_center_name" messagekey="cost_center_" width="235px">
				<h:text />
			</r:field>
			<r:field fieldName="bill_lock_status_bd" messagekey="bill_lock_status_bd" width="135px">
				<h:select name="bill_lock_status_bd_1" property="bill_lock_status_bd">
                   <h:option value="0" label="未锁定"></h:option>
                   <h:option value="1" label="锁定"></h:option>
                </h:select>
			</r:field>
			<r:field fieldName="bill_amount" messagekey="bill_amount_" width="110px">
				<h:text />
			</r:field>
			<r:field fieldName="bill_year_month" messagekey="bill_year_month" width="110px">
                <h:text />
            </r:field>
			<r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="135px">
				<d:select dictTypeId="FB_BILL_TYPE_BD"></d:select>
			</r:field>
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
		</r:datacell>
		</div>
    <!--表格 end-->
    <!--翻页 -->
<!--翻页 end-->
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
