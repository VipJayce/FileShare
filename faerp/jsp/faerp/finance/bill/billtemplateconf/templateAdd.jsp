<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.finance.receivable.MyUtils" %>
<%@ page import="java.sql.Timestamp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.datainterface.datainterface_resource" prefix="rayoo.salary.datainterface.">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
</head>
<%
String strdate=MyUtils.Timestamp2String(new Timestamp(System.currentTimeMillis()), MyUtils.YEARANDMONTH);
request.setAttribute("strdate", strdate) ;
%>
<body>
<form name="form" method="post" action="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=inputInterfaceData" onsubmit="return insert_submit() ;">
<div id="right">
    <input  value="<%=request.getParameter("sa_inf_id") %>" type="hidden" id="sa_inf_id" name="sa_inf_id"/>
	<div class="box_xinzeng" style="height: 260px">
  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
    <td width="50%" class="td_1"><font color="red">*</font>&nbsp;客户名称</td>
			<td width="50%" class="td_2">
			     <w:lookup id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
		            messagekey="choose_cust" height="500" width="810" style="width:230px"/>
		 		<input type="hidden" id="custCode" name="custCode"  value=""/>      
		 		<input type="hidden" id="custName" name="custName"  value=""/>   
		 		<input type="hidden" id="customerId" name="customerId"  value=""/>         
			</td>
			
		</tr>
		<tr>
		    <td class="td_1">成本中心名称</td>
            <td class="td_2">
	            <r:comboSelect id="cost_center_id" name="cost_center_id"
	                queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
	                textField="cost_center_name"
	                valueField="id"
	                xpath="CostcenterVo"
	                width="210">
	            </r:comboSelect>
	            <input type="hidden" id="costCenterName" name="costCenterName"  value=""/>
            </td>
    </tr>
  <tr>
    <td class="td_1"><font color="red">*</font>&nbsp;模板类型</td>
    <td class="td_2">
   <select id="templateType" name="templateType" class="col-xs-12" data-placeholder="--请选择账单模板类型--">
												<option value=""></option>
												<option value="1">社保福利薪资</option>
												<option value="2">社保福利</option>
												<option value="3">薪资</option>
										</select>
    </td>
    </tr>

  </table>
<div class="xz_button">
 <input name="button" type="button" class="icon_2" onclick="config()" value="配置" />
</div>
</div>
</form>
</body>
<script type="text/javascript">
$id("lk_cust").onReturnFunc = function (returnValue){
   var lookup = $id("lk_cust");
    lookup.value = returnValue[2];
    lookup.displayValue = returnValue[2];
    $id("custCode").value = returnValue[1];
    $id("custName").value = returnValue[2];
    $id("customerId").value =  returnValue[0];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
};

function config(){
	 var rst = new Array();
	 var custCode = $id("custCode").value;
	 var custName = $id("custName").value;
	 var customerId = $id("customerId").value;
	 var costCenterId = $id("cost_center_id").getValue();
	 var costCenterName = $id("cost_center_id").getText();
	 var templateType = $id("templateType").value;
	 if(customerId==""||templateType==""){
		 alert("带*项必填！");
		 return;
	 }
     rst.push(custCode);
     rst.push(costCenterId);
     rst.push(templateType);
     rst.push(costCenterName);
     rst.push(custName);
     rst.push(customerId);
	 window.returnValue = rst;
	 window.close();
}









</script>

</fmt:bundle>
</html>

