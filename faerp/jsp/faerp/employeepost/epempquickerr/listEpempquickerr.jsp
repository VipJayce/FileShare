<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@page import="gap.authority.helper.LoginHelper"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title>
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
    
    function export_submit(){
	        $id("datacell_formid").submit() ;
    }
    
     function queryall(){
        $id("celllist1").loadData();
        $id("celllist1").refresh();
    }
    function resetstr(){
    	window.resetstr() ;
    }
</script>
</head>
<body>
<form name="datacell_formid" id="datacell_formid" action="<%=request.getContextPath()%>/EpempquickerrAction.do?cmd=exportEmpPostQuickErr" method="post"> 
<input type="hidden" name="cmd" value="">
<input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
<input type="hidden" name="company_id" id="company_id" value="<%=LoginHelper.getLoginVo(request).getCompany_id()%>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">E化报入职异常信息</div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
            <td width="138" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
          
            <td width="76"/>
            <td width="281"/>
              <td width="78">    </td>
                <td width="270"/>
        </tr>
  <tr>
  <td align="left">客户</td>
    <td align="left">
     <div><w:lookup onReturnFunc="rtnFuncCustomer" readonly="true"
            id="customer_id" name="customer_id" property="customer_id"
            displayProperty="customer_name"
            lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
            title="客户" height="450" width="610" style="width:172px"  /></div>
    
    </td>
    <td align="left">客户编号</td>
    <td align="left"><input type="text" value="" class="sText" id="customer_code" name="customer_code" /></td>
  	<td  align="left" >成本中心</td>
  	<td  align="left" >
  	<r:comboSelect id="cost_center_id"
            name="cost_center_id"
            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name" valueField="id" xpath="CostcenterVo"
         width="190" messagekey="please_select">
        </r:comboSelect>
    </td>
  <tr>
  <td align="left">员工姓名</td>
    <td align="left">
    <input type="text" value="" class="sText" id="emp_name" name="emp_name" />
    </td>
    <td align="left">唯一号</td>
    <td align="left"><input type="text" value="" class="sText" id="emp_code" name="emp_code" /></td>
  	<td  align="left" >城市</td>
  	<td  align="left" ><input type="text" value="" class="sText" id="city_name" name="city_name" /></td>
  <tr>
  	<td  align="right" colspan="6">
        <input type="button" class="icon_1" value="<fmt:message key='button_query'/>" onClick="queryall()"/>
        <input name="button_reset2" class="icon_1" type="reset" value="<fmt:message key='button_reset'/>" onclick="resetstr()" />
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
  </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--表格 -->
    <div class="button">
      <div class="button_right" style="width: 99%;">
        <input class="e" type="button"   value="导出"    onClick="export_submit();">
      </div>
      <div class="clear"></div>
    </div>
       <div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
        <r:datacell id="celllist1"
            queryAction="/FAERP/EpempquickerrAction.do?cmd=simpleQuery"
            paramFormId="datacell_formid" width="99%" height="318px"
            xpath="EpempquickerrVo" readonly="true" pageSize="100">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field fieldName="cust_code" messagekey="customer_code" width="100px">
            </r:field>
            <r:field fieldName="cust_name" messagekey="customer_name" width="170px">
            </r:field>
            <r:field fieldName="cost_center_name" messagekey="cost_center" width="170px">
            </r:field>
            <r:field fieldName="emp_code" label="唯一号" width="100px">
            </r:field>
            <r:field fieldName="emp_name" label="姓名" width="100px">
            </r:field>
            <r:field fieldName="city_name" label="城市" width="100px">
            </r:field>
            <r:field fieldName="contract_type" label="合同类型" width="100px">
            </r:field>
            <r:field fieldName="error_msg" label="异常原因" width="200px">
            </r:field>
            <r:field fieldName="create_date" label="同步时间" width="140px">
                <w:date format="yyyy-MM-dd HH:mm:ss" />
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
</html>
