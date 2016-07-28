<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>账单确认</title>
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
	var _jQuery = window.jQuery, _$ = window.$;
	jQuery.noConflict();
	function rtnFuncCustomer(arg){
    	var lookup = $id("customer_id");
    	lookup.value = arg[0];
    	lookup.displayValue = arg[2];
    	$id("cost_center_id").addParam("cust_id", arg[0]);
       	$id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
    	return false;
	}

	function queryall(){
		$id("celllist1").addParam("customer_id",$id("customer_id").value);
     	$id("celllist1").addParam("cost_center_id",$id("cost_center_id").getValue());
     	$id("celllist1").addParam("bill_year_month",$id("bill_year_month").value);
     	$id("celllist1").addParam("bill_gather_status_bd",$id("bill_gather_status_bd").options[$id("bill_gather_status_bd").selectedIndex].value);
        $id("celllist1").addParam("bill_type_bd",$id("bill_type_bd").options[$id("bill_type_bd").selectedIndex].value);
     	$id("celllist1").addParam("max",$id("max").value);
     	$id("celllist1").addParam("min",$id("min").value);
     	$id("celllist1").addParam("approve_bd",$id("approve_bd").value);
        $id("celllist1").loadData();
        $id("celllist1").refresh();
	}
	
/**
 * 选择一条记录到明细审批页面
 */
function list2approvalItem() {
	var dc = $id("celllist1");
	    var entity = dc.getActiveEntity();
	    if(!entity){
	        alert("请先选择一条记录");
	        return ;
	    }
	    var bill_id = entity.getValue("id");
	    _$.ajax({
	        type : "post",
	        url : "/FAERP/AgentFinBillTwoAction.do?cmd=checklist2item&bill_id=" + bill_id,
	        dataType : "html",
	        success : function(data) {
	            if (data!=""&&data=="此账单无明细，数据可能异常。") {
	                alert(data);
	            } else {
	                if (bill_id) {
	                    //w为窗口宽度，h为高度
	                    var w = 1250;
	                    var h = 600;
	                    var l = 70;//(screen.width - w) / 2;
	                    var t = 70;//(screen.height - h) / 2;
	                    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
	                    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
	                    var url = "/FAERP/AgentFinBillTwoAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
	                    window.open(url, 'newwindow', s);
	                }
	            }
	        }
	    });
	}
	
	/**
	 * 选择一条记录确认账单
	 */
	function confirmBill(){
	    var dc = $id("celllist1");
        var entity = dc.getActiveEntity();
        if(!entity){
            alert("请先选择一条记录");
            return ;
        }
        var bill_id = entity.getValue("id");
        var is_agent_confirm = entity.getValue("is_agent_confirm");
        if(is_agent_confirm!="3"){
        _$.ajax({
            type : "post",
            url : "/FAERP/AgentFinBillTwoAction.do?cmd=confirmBill&bill_id=" + bill_id,
            dataType : "html",
            success : function(data) {
                if (data==null || data == "") {
                    alert("账单确认失败！");
                } else {
                    alert("账单确认成功！");
                    queryall();
                }
            }
        });
        }else{
        alert("该账单已经确认!");
        return;
        }
	}

    function Reset(){
        $id("customer_id").value=null;
    }
    
_$(document).ready(function() {
        $id("celllist1").isQueryFirst = false;
});

/***********************退回操作*********************************/
    function BacktoErp(){
        var dc = $id("celllist1");
        var entity = dc.getActiveEntity();
        if(!entity){
            alert("请先选择一条记录");
            return ;
        }
        var bill_id = entity.getValue("id");
        var is_pay=entity.getValue("is_pay");
       if(is_pay=='0'){
        _$.ajax({
            type : "post",
            url : "/FAERP/AgentFinBillTwoAction.do?cmd=backtoerp&bill_id=" + bill_id,
            dataType : "html",
            success : function(data) {
                if (data==null || data == "") {
                    alert("账单退回失败！");
                } else {
                    alert("账单退回成功！");
                    queryall();
                }
            }
        });
          }else{
            alert("账单已经在支付，不能退回!");
            return;
        }
    }

</script>
</head>
<body>
<form name="form" action="" method="post"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">账单确认</div>
	</div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
            <td width="138" rowspan="5" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td width="76"/>
            <td width="281"/>
              <td width="78">    </td>
                <td width="270"/>
        </tr>
  <tr>
   <td class="td_1">选择客户</td>
	<td class="td_2">
	<div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
		id="customer_id" name="customer_id"	lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
		dialogTitle="选择客户" height="450" width="610" style="width:172px"  /></div>
	</td>
		<td class="td_1">客户成本中心</td>
		<td align="left"><r:comboSelect id="cost_center_id" name="cost_center_id"
			queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			textField="cost_center_name" valueField="id" xpath="CostcenterVo" width="190" nullText="--请选择--">
		</r:comboSelect></td>
        <td width="54"> 账单年月</td>
    <td width="212"><input type="text" value="" class="sText" id="bill_year_month" name="bill_year_month" /></td>
  </tr>
  <tr>
    <td>账单金额(>)</td>
    <td><input type="text" value="" class="sText" id="min"/></td>
    <td>账单金额(<)</td>
    <td><input type="text" value="" class="sText" id="max"/></td>
	    <td width="54">账单类型</td>
     <td align="left">
		  <d:select name="bill_type_bd" id="bill_type_bd" dictTypeId="FB_BILL_TYPE_BD" nullLabel="--请选择--" style="width: 190px"/></td>
	</td>
  </tr>
  <tr>
    <td>实收状态</td>
    <td align="left">
		<d:select name="bill_gather_status_bd" id="bill_gather_status_bd" dictTypeId="GATHER_STATUS_BD" nullLabel="--请选择--" style="width: 190px"/></td>
   </td>
     <td align="left">审批状态</td>
        <td align="left">
        	<d:select  name="approve_bd" id="approve_bd" dictTypeId="BILL_APPR_STATUS" nullLabel="--请选择--" style="width:190px"/>
        </td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="button" class="icon_1" value="查询" onClick="queryall()"/>
     <input name="button_reset2" class="icon_1" type="reset" value='重置' onClick="javascript:Reset();">
    </div></td>
  </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right">
        <input class="b_1" type="button"   value="查看明细"   onClick="list2approvalItem();">
        <input class="g_1" type="button"   value="账单确认"  onClick="confirmBill();">
        <input class="g_1" type="button"   value="账单退回"  onClick="BacktoErp();">
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/AgentFinBillTwoAction.do?cmd=queryForConfirmAgentBillList"
			paramFormId="datacell_formid" width="99%" height="318px"
			xpath="AgentFinBillTwoVo" readonly="true" pageSize="50">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<r:field fieldName="agent_code" label="供应商编号">
                <h:text />
            </r:field>
            <r:field fieldName="agent_name" label="供应商名称">
                <h:text />
            </r:field>
			<r:field fieldName="cust_code" label="客户编号" >
				<h:text />
			</r:field>
			<r:field fieldName="cust_name" label="客户名称">
				<h:text />
			</r:field>
			<r:field fieldName="cost_center_name" label="客户成本中心">
				<h:text />
			</r:field>
			<r:field fieldName="bill_year_month" label="账单年月">
				<h:text />
			</r:field>
			<r:field fieldName="is_pay" label="是否支付">
			<d:select  dictTypeId="TrueOrFalse" disabled="true"/>
                <h:text />
            </r:field>
            <r:field fieldName="is_agent_confirm" label="供应商是否确认">
                <d:select dictTypeId="is_agent_confirm"></d:select>
            </r:field>
			<r:field fieldName="version" label="版本号" >
				<h:text />
			</r:field>
			<r:field fieldName="bill_amount" label="账单金额">
				<h:text />
			</r:field>
			<r:field fieldName="bill_gather_status_bd" label="实收状态">
                <d:select dictTypeId="GATHER_STATUS_BD" />
			</r:field>
			<r:field fieldName="bill_type_bd" label="账单类型" >
                <d:select dictTypeId="BILL_TYPE_BD" />
			</r:field>
			<r:field fieldName="create_date" label="生成时间">
				<w:date format="yyyy-MM-dd HH:mm:ss" />
			</r:field>
			<r:field fieldName="create_user_name" label="生成人" >
				<h:text />
			</r:field>
			<r:field fieldName="closed_date" label="结账日期">
				<w:date format="yyyy-MM-dd" />
			</r:field>
			<r:field fieldName="approve_bd" label="审核状态">
				<d:select dictTypeId="BILL_APPR_STATUS"></d:select>
			</r:field>
		</r:datacell>
		</div>
		</div>
    <!--表格 end-->
    <!--翻页 --><!--翻页 end-->
    </div>
</form>
</body>
</html>
