<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm."  >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>查询账单</title>
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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script language="JavaScript" src="../../scripts/common.js"></script>
<script type="text/javascript">
<!-- siqp添加 复选框-->
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
    
        function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }



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
     	$id("celllist1").addParam("agent_id",$id("agent_id").value);
        $id("celllist1").loadData();
        $id("celllist1").refresh();
	}
	
/**
 * 选择一条记录到明细审批页面
 */
function list2approvalItem() {
    var ids = findSelections("temp","id"); 
    if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
    if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }      
	    var bill_id = ids;
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

    function rtnFuncAgent(arg){
        var lookup = $id("agent_id");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }

    function Reset(){
        $id("customer_id").value=null;
        $id("agent_id").value=null;
    }
    
_$(document).ready(function() {
        $id("celllist1").isQueryFirst = false;
});
/************************支付申请*****************************/
    function apply_pay(){
    var ids = findSelections("temp","id");
     if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
  //校验所选账单是否被确认
    var check_int=0;
    var check_info=""; 
    var check_payinfo=""
      for(var i =0 ;i<ids.length;i++){
                var entity =$id("celllist1").dataset.findEntity("id",ids[i]); 
                if(entity.getValue("is_agent_confirm")!='3'){
                 check_int++;
                }
                if(entity.getValue("approve_bd")=='2'){
                check_info='有修改审批中的账单，不能申请支付';
                }
                if(entity.getValue("is_pay")=='1'){
                check_payinfo="有账单已经在支付，不能重复申请!";
                }
        }
        if(check_info!=""){
            alert(check_info);
            return;
        }else if(check_payinfo!=""){
        alert(check_payinfo);
            return;
        }
        else{
        if(check_int!=0){
        alert("所选账单中有"+check_int+"条账单信息供应商没有确认，无法申请支付！");
        return;
            }
        }
       var bill_id = ids;
         var url = "/FAERP/AgentFinBillTwoAction.do?cmd=toApplyPage&bill_id=" + bill_id;
         window.open(url,'','height=400px,width=950,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=全国供应商账单申请支付');
	}
/*****************************************提交确认*************************************************/
function to_confirm(){
    var ids = findSelections("temp","id");
    var check_info=""; 
     if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
         for(var i =0 ;i<ids.length;i++){
                var entity =$id("celllist1").dataset.findEntity("id",ids[i]); 
                if(entity.getValue("is_agent_confirm")=='2' || entity.getValue("is_agent_confirm")=='3'){
                check_info="存在已经提交确认的账单，请重新选择!";
                }
        }
         if(check_info!=""){
            alert(check_info);
            return;
        }else{
           _$.ajax({
            type : "post",
            url : "/FAERP/AgentFinBillTwoAction.do?cmd=to_confirm&bill_id=" + ids,
            dataType : "html",
            success : function(data) {
                if (data==null || data == "") {
                    alert("提交确认失败！");
                } else {
                    alert("提交确认成功！");
                    queryall();
                }
            }
        });
        }
}
</script>
</head>
<body>
<form name="form" action="" method="post"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">查询账单</div>
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
    <td>供应商</td>
    <td><div><w:lookup onReturnFunc="rtnFuncAgent" readonly="true" id="agent_id" name="agent_id" lookupUrl="faerp/common/sales/listCustomerGetByID.jsp" dialogTitle="选择供应商" height="500" width="700" style="width:170px">
                </w:lookup></div></td>
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
        <input class="b_1" type="button"   value="查看明细"    onClick="list2approvalItem();">
        <input class="b_1" type="button"   value="支付申请"    onClick="apply_pay();">
         <input class="g_1" type="button"   value="提交确认"    onClick="to_confirm();">
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/AgentFinBillTwoAction.do?cmd=queryForAgentBillList"
			paramFormId="datacell_formid" width="99%" height="318px"
			xpath="AgentFinBillTwoVo" readonly="true" pageSize="50"
			>
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"></r:field>
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
			<r:field fieldName="is_agent_confirm" label="供应商是否确认">
               <d:select dictTypeId="is_agent_confirm"></d:select>
            </r:field>
            <r:field fieldName="is_pay" label="账单是否在支付">
               <d:select dictTypeId="TrueOrFalse"></d:select>
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
    </fmt:bundle>
</body>
</html>
