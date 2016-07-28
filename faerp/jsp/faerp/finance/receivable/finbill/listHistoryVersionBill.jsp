<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_queryhistorybill'/></title>
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
    	alert(all);
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
     	$id("celllist1").addParam("bill_gather_status_bd",$id("bill_gather_status_bd").options[$id("bill_gather_status_bd").selectedIndex].value);
        $id("celllist1").addParam("bill_type_bd",$id("bill_type_bd").options[$id("bill_type_bd").selectedIndex].value);
     	$id("celllist1").addParam("max",$id("max").value);
     	$id("celllist1").addParam("min",$id("min").value);
     	$id("celllist1").addParam("is_createvoucher",$id("is_createvoucher").value);
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
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    var bill_id = entity.getValue("id");
    //    
    if (bill_id) {
        //w为窗口宽度，h为高度
        var w = 1250;
        var h = 600;
        var l = 70;//(screen.width - w) / 2;
        var t = 70;//(screen.height - h) / 2;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
        var url = "/FAERP/FinbillAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
        window.open(url, 'newwindow', s);
        //window.location.href = "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
    }
    /*
    _$.ajax({
        type : "post",
        url : "/FAERP/BillmodifyAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
            if (data!=""&&data=="此账单无明细，数据可能异常。") {
                alert("<fmt:message key='data_error'/>");
            } else {
                if (bill_id) {
                    //w为窗口宽度，h为高度
                    var w = 1250;
                    var h = 600;
                    var l = 70;//(screen.width - w) / 2;
                    var t = 70;//(screen.height - h) / 2;
                    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
                    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
                    var url = "/FAERP/FinbillAction.do?cmd=list2item4approval2&bill_id=" + bill_id;
                    window.open(url, 'newwindow', s);
                    //window.location.href = "/BillmodifyAction.do?cmd=list2item&bill_id=" + bill_id;
                }
            }
        }
    });
    */
}	
/**
 * 选择一条记录到明细修改页面
 */
function list2item() {
	
    var dc = $id("celllist1");
    var entity = dc.getActiveEntity();
    if(!entity){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    var bill_id = entity.getValue("id");
    _$.ajax({
        type : "post",
        url : "/FAERP/FinbillAction.do?cmd=checklist2item&bill_id=" + bill_id,
        dataType : "html",
        success : function(data) {
        	if (data) {
        		alert(data);
        	} else {
                if (bill_id) {
                    window.location.href = "/FAERP/FinbillAction.do?cmd=list2item&bill_id=" + bill_id;
                }
        	}
        }
    });
}

_$(document).ready(function() {
        $id("celllist1").isQueryFirst = false;
});

//列表导出
  function exportBillToExcel(){
       form.action="<%=request.getContextPath()%>/FinbillAction.do?cmd=exportBillToExcel&flag=1";
       form.submit();
  }

</script>
</head>
<body>
<form name="form" action="" method="post"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key='title_queryhistorybill'/></div>
	</div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
            <td width="138" rowspan="5" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
          
            <td width="76"/>
            <td width="281"/>
              <td width="78">    </td>
                <td width="270"/>
        </tr>
  <tr>
   <td class="td_1"><fmt:message key='select_customer'/></td>
		<td class="td_2">
		<div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
			id="customer_id" name="customer_id" property="customer_id"
			displayProperty="customer_name"
			lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
			messagekey="select_customer" height="450" width="610" style="width:172px"  /></div>
		</td>
		<td class="td_1"><fmt:message key='cost_center'/></td>
		<td align="left"><r:comboSelect id="cost_center_id"
			name="cost_center_id"
			queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			textField="cost_center_name" valueField="id" xpath="CostcenterVo"
		 width="190" messagekey="please_select">
		</r:comboSelect></td>
        <td width="54"><fmt:message key='bill_year_month'/></td>
    <td width="212"><input type="text" value="" class="sText"
			id="bill_year_month" name="bill_year_month" /></td>
  </tr>
  <tr>
    <td><fmt:message key='bill_amount'/>(>)</td>
    <td><input type="text" value="" class="sText" id="min"/></td>
    <td><fmt:message key='bill_amount'/>(<)</td>
    <td><input type="text" value="" class="sText" id="max"/></td>
	    <td width="54"><fmt:message key='bill_type_bd'/></td>
     <td align="left">
		  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bill_type_bd", -1,"FB_BILL_TYPE_BD",  request.getAttribute("bill_type_bd") == null ? "" : String.valueOf(request.getAttribute("bill_type_bd")),"inputName='应收类型'  style='width:190px' id='bill_type_bd'", false)%>
	</td>
  </tr>
  <tr>
    <td><fmt:message key='bill_gather_status_bd'/></td>
    <td align="left">
		<%=gap.rm.tools.helper.RmJspHelper.getSelectField( "bill_gather_status_bd", -1,"GATHER_STATUS_BD", request.getAttribute("bill_gather_status_bd") == null ? "" : String.valueOf(request.getAttribute("bill_gather_status_bd")), "inputName='实收状态'  style='width:190px' id='bill_gather_status_bd'", false)%>
   </td>
    <td align="left">是否已生成红冲凭证</td>
	<td align="left">
	   <select name="is_createvoucher" id="is_createvoucher" style="width: 190px;">
	     <option value="" selected="selected">--请选择--</option>
	     <option value="1">是</option>
	     <option value="0" >否</option>
	  </select>
	</td>
    <td>&nbsp;</td>
    <td><div align="center">
      <input type="button" class="icon_1" value="<fmt:message key='button_query'/>" onClick="queryall()"/>
     <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key='button_reset'/>' onClick="javascript:this.form.reset();">
    </div></td>
  </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right">
        <ul>
           <li class="b_1"><a href="javascript:void(0);" onClick="list2approvalItem()"><fmt:message key='button_ckmx'/></a></li>
           <li class="b_1"><a href="javascript:void(0);" onClick="exportBillToExcel();"> 列表导出</a></li>
        </ul>
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 0 0 8 8;">
       	<r:datacell id="celllist1"
			queryAction="/FAERP/FinbillAction.do?cmd=queryForBillList&flag=1"
			paramFormId="datacell_formid" width="99%" height="318px"
			xpath="FinbillVo" readonly="true">
			<r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<r:field fieldName="cust_code" messagekey="customer_code" width="70px">
				<h:text />
			</r:field>
			<r:field fieldName="cust_name" messagekey="customer_name" width="170px">
				<h:text />
			</r:field>
			<r:field fieldName="cost_center_name" messagekey="cost_center" width="170px">
				<h:text />
			</r:field>
			<r:field fieldName="bill_year_month" messagekey="bill_year_month" width="70px">
				<h:text />
			</r:field>
			<r:field fieldName="version" messagekey="version" width="50px">
				<h:text />
			</r:field>
			<r:field fieldName="validity" messagekey="validity" width="80px">
            </r:field>
			<r:field fieldName="bill_amount" messagekey="bill_amount" width="90px">
				<h:text />
			</r:field>
			<r:field fieldName="bill_gather_status_bd" messagekey="bill_gather_status_bd" width="100px">
                <d:select dictTypeId="GATHER_STATUS_BD" />
			</r:field>
			<r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="100px">
                <d:select dictTypeId="BILL_TYPE_BD" />
			</r:field>
			<r:field fieldName="voucher_status" messagekey="voucher_status" width="90px">
                <d:select dictTypeId="VOUCHER_STATUS"></d:select>
            </r:field>  
            <r:field fieldName="is_createvoucher"  width="120px" messagekey="is_createvoucher"  onRefreshFunc="process_is_createvoucher" >
            </r:field>
            <r:field fieldName="voucher_ym" messagekey="voucher_ym" width="90px">
            </r:field>
            <r:field fieldName="hongchongvoucher_ym" label="红冲凭证号" width="90px">
            </r:field>
			<r:field fieldName="create_date" messagekey="create_date" width="140px">
				<w:date format="yyyy-MM-dd HH:mm:ss" />
			</r:field>
			<r:field fieldName="create_user_name" messagekey="create_user_name" width="100px">
				<h:text />
			</r:field>
			<r:field fieldName="closed_date" messagekey="closed_date" width="90px">
				<w:date format="yyyy-MM-dd" />
			</r:field>
		</r:datacell>
		</div>
		</div>
    <!--表格 end-->
    <!--翻页 --><!--翻页 end-->
    </div>
</form>
</body>
</fmt:bundle>
<script language="javascript">
function process_is_createvoucher(value,entity,rowNo,cellNo){
    var result = "";
    if(value=="1"){
        result = "是";
    }else if(value=="0"){
        result = "否";
    }
    return result;
}
</script>
</html>
