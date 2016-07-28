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
	<div class="box_xinzeng" style="height: 300px">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
    <td width="50%" class="td_1">费用主项ID：</td>
			<td width="50%" class="td_2">
			     <input id="parent_id" name="parent_id" value="${param.parent_id}" style="width: 60%" data-placeholder="--请选择--"  />     
			</td>
			
		</tr>
		<tr>
		    <td class="td_1"><font color="red">*</font>&nbsp;费用类型：</td>
            <td class="td_2">
	            <select id="col_type" name="col_type">
												<option value="">请选择</option>
												<option value="0">信息字段</option>
												<option value="1">服务产品</option>
												<option value="2">其它产品</option>
												<option value="3">动态列</option>
												<option value="4">公式</option>
										</select>
            </td>
    </tr>
  <tr>
    <td class="td_1"><font color="red">*</font>&nbsp;费用名称：</td>
    <td class="td_2">
   		<input id="col_name" name="col_name" value="${param.col_name}" style="width: 60%" data-placeholder="--请选择--"  />
    </td>
    </tr>
    <tr>
    	<td class="td_1"><font color="red">*</font>&nbsp;名称英文：</td>
    	<td class="td_2">
   			<input id="col_name_en" name="col_name_en" value="${param.col_name_en}" style="width: 60%" data-placeholder="--请选择--"  />
    	</td>
    </tr>
    
     <tr>
    	<td class="td_1"><font color="red">*</font>&nbsp;费用编号：</td>
    	<td class="td_2">
   			<input id="col_code" name="col_code" value="${param.col_code}" style="width: 60%" data-placeholder="--请选择--"  />
    	</td>
    </tr>
     <tr>
    	<td class="td_1"><font color="red">*</font>&nbsp;是否固定项：</td>
    	<td class="td_2">
   			<select id="is_fixed" name="is_fixed">
												<option value="">请选择</option>
												<option value="0">固定项</option>
												<option value="1">配置项</option>
										</select>
    	</td>
    </tr>
     <tr>
    	<td class="td_1"><font color="red">*</font>&nbsp;是否合计项：</td>
    	<td class="td_2">
   			<select id="is_total" name="is_total">
												<option value="">请选择</option>
												<option value="0">合计项</option>
												<option value="1">非合计项</option>
										</select>
    	</td>
    </tr>
    

  </table>
<div class="xz_button">
 <input name="button" type="button" class="icon_2" onclick="saveBaseColumn()" value="保存" />
</div>
</div>
</form>
</body>
<script type="text/javascript">
jQuery(function(){
	jQuery("#is_total").val('${param.is_total }');
	jQuery("#is_fixed").val('${param.is_fixed }');
	jQuery("#col_type").val('${param.col_type }');
});

function saveBaseColumn(){
	var parent_id = $id("parent_id").value;
	var col_type = $id("col_type").value;
	var col_name = $id("col_name").value;
	var col_name_en = $id("col_name_en").value;
	var col_code = $id("col_code").value;
	var is_fixed = $id("is_fixed").value;
	var is_total = $id("is_total").value;
	 if(col_type==""||col_name==""||col_name_en==""||is_fixed==""||is_total==""||col_code==""){
		alert("*项为必填字段!");
		return;
	} 
	var data = parent_id+","+col_type+","+col_name+","+col_name_en+","+col_code+","+is_fixed+","+is_total+","+'${param.billColId }';
	jQuery.ajax({
        type : "post",
        url : "<%=request.getContextPath()%>/BillTemplateConfigAction.do?cmd=saveBaseCol&data=" 
    		+ encodeURIComponent(data),
        dataType : "html",
        success : function(data) {
                    alert(data);
               		 window.close();
          }
   });
	
}


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

function save(){
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

