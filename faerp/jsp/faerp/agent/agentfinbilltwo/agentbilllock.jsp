<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>锁定账单</title>
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
		 	alert("请选择您要操作的账单！");
		 	return;
		}
		var confirmStr = null;
		 if(val == 1){
		 	confirmStr = "确定要锁定下列所选账单吗？";
		 }else if(val == 0){
		 	confirmStr = "确定要解锁下列所选账单吗？";
		 }
		 if(confirm(confirmStr)){
		    flag = true;
	   	}
	   	if(flag){
	   	 var urlstr="/FAERP/AgentFinBillTwoAction.do?cmd=lockBill&ids=" + ids+"&lock="+val;
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
	
	function rtnFuncAgent(arg){
        var lookup = $id("agent_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
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
	    returnStr =  "<input   type='checkbox' name='checkbox1' id='checkboxId' value=" + entity.getProperty("id") + ">";
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
	//end
	function queryall(){
		$id("celllist1").addParam("customer_id",$id("customer_id").value);
     	$id("celllist1").addParam("cost_center_id",$id("cost_center_id").getValue());
     	$id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
     	$id("celllist1").addParam("agent_id",$id("agent_id").value);
        $id("celllist1").loadData();
        $id("celllist1").refresh();
	}
	
	function Reset(){
        $id("customer_id").value=null;
        $id("agent_id").value=null;
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
	  <div class=" right_title">锁定账单</div>
	</div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        <td width="85"/>
        <td width="196"/>
        <td width="143">    </td>
          <td width="240"/>
        </tr>
        <tr>
            <td align="right">客户名称</td>
            <td align="left">
                <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
                    id="customer_id" name="customer_id" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                    dialogTitle="选择客户"  height="450" width="610" style="width:180px" />
            </td>
            <td align="right">成本中心</td>
            <td align="left">
            <r:comboSelect id="cost_center_id" name="cost_center_id"
			            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
			            width="190" nullText="--请选择--">
            </r:comboSelect>
        
            </td>
            <td width="100" align="right">账单年月</td>
            <td width="213" align="left">
            <input type="text" class="text_field" id="bill_year_month" name="bill_year_month" inputName="账单年月" maxLength="50" value=""/>
            </td>
        </tr>
        
        <tr>
            <td align="right">供应商</td>
            <td align="left"><div><w:lookup onReturnFunc="rtnFuncAgent" readonly="true" id="agent_id" name="agent_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" dialogTitle="选择供应商" height="500" width="700" style="width:180px">
                </w:lookup></div></td>
              <td>&nbsp;</td>
                <td/>
                <input name="button_ok2" class="icon_1"   type="button" value='查询' onClick="javascript:queryall()">
                  <input name="button_reset2" class="icon_1" type="reset" onclick="javascript:Reset();">
        </tr>
</table>
  
  </div>
    <!--查询 end-->
    <!--按钮--><!--按钮 end-->
    <!--表格 -->
    <div style="padding: 5 0 0 8">
          <input type="button" name="lock" id="lock"  value="锁定" class="icon_1" onclick="locked(1)" />
          <input type="button" name="unlock" id="unlock"   value="解锁" class="icon_1" onclick="locked(0)" />
    </div>
    <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/AgentFinBillTwoAction.do?cmd=queryForBillLock"
			paramFormId="datacell_formid" width="99%" height="318px"
			xpath="AgentFinBillTwoVo" readonly="true">
			<r:field allowModify="false" fieldName="id" sortAt="none"
				label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
				width="70px" onRefreshFunc="setCheckboxStatus">
			</r:field>
			<r:field fieldName="agent_name" label="供应商名称"  width="150px">
                <h:text />
            </r:field>
            <r:field fieldName="agent_code" label="供应商编号">
                <h:text />
            </r:field>
			<r:field fieldName="cust_name" label="公司名称" width="150px">
				<h:text />
			</r:field>
			<r:field fieldName="cust_code" label="客户唯一号">
				<h:text />
			</r:field>
			<r:field fieldName="cost_center_name" label="成本中心" width="180px">
				<h:text />
			</r:field>
			<r:field fieldName="bill_lock_status_bd" label="锁定状态">
				<h:select name="bill_lock_status_bd_1" property="bill_lock_status_bd">
                   <h:option value="0" label="未锁定"></h:option>
                   <h:option value="1" label="锁定"></h:option>
                </h:select>
			</r:field>
			<r:field fieldName="bill_amount" label="总金额">
				<h:text />
			</r:field>
			<r:field fieldName="bill_year_month" label="账单年月">
                <h:text />
            </r:field>
			<r:field fieldName="bill_type_bd" label="账单类型">
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
</html>
