<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle
	basename="rayoo.finance.bill.billcenter.billcenter_resource_zh"
	prefix="rayoo.finance.bill.billcenter.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>账单批量操作管理</title>
	</head>
	<body>
	<form name="form" method="post" id="form">
	<div id="right"><script language="javascript">
        writeTableTopFesco("<fmt:message key='title_billgenerate'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
	<div class="ringht_s">
	<table width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<div class="zbox">
			<div class="xz_title">账单批量操作</div>
			<!--表格1-->
			<div class="box_3">
			<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
				<tr>
					<td class="td_1"><fmt:message key='create_type'/></td>
					<td class="td_2" >
						<select id="create_type" style="width:200px" name="create_type" onchange="do_ex()">
                            <option value="1" selected="selected">成本中心</option><!-- 成本中心-->
                            <option value="2" >客户</option><!-- 客户-->
                            <option value="3">客户组</option><!-- 客户组-->
                            <option value="4">客服</option><!-- 客服-->
                      	</select>
					</td>
					<td class="td_1"></td>
					<td class="td_2"></td>
				</tr>
				<tr>
                    <!-- 账单年月 -->
                    <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='billyearmonth'/></td>
                    <td class="td_2">
                       <input type="text" class="text_field" id="billYearMonth" name="bill_year_month" inputName="账单年月" maxLength="50" value="" />
                    </td>
                    <!-- 账单类型 -->
                    <td class="td_1"><span class="style_required_red">* </span><fmt:message key='bill_type_bd'/></td>
                    <td class="td_2">
                        <d:select dictTypeId="BILL_TYPE_BD" id="bill_type_bd" name="bill_type_bd" 
                                  style="width:200px" nullLabel="--请选择--" filterOp="in" filterStr="1,2,3" />
                    </td>
                </tr>
                <!-- 成本中心 -->
				<tr id="typeCBZX">
				    <td class="td_1"><span class="style_required_red">* </span><fmt:message key='customer_name'/></td>
                    <td class="td_2">
                        <w:lookup readonly="true"  id="lk_cust"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="choose_cust"  height="450" width="610" style="width:183px" />
                        <input id="cust_id" name="cust_id" type="hidden">
                        <input id="cust_code" name="cust_code" type="hidden">
                        <input id="cust_name" name="cust_name" type="hidden"/>
                    </td>
		            <td class="td_1">
		            	<div id="tdCBZXDesc">
		            		<span class="style_required_red">* </span><fmt:message key='cost_center_decs'/>
		            	</div>
		            </td>
		            <td class="td_2">
		            	<div id="tdCBZXSelect">
				            <r:comboSelect id="cost_center_id" name="cost_center_id"
				                queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
				                textField="cost_center_name"
				                valueField="id"
				                xpath="CostcenterVo"
				                width="200" messagekey="please_select">
				            </r:comboSelect>
		            	</div>
		            </td>
                </tr>
                <!-- 客服 -->
                <tr style="display:none;" id="typeKEFU">
                    <td class="td_1"><span class="style_required_red">* </span><fmt:message key='customer_service'/></td>
                    <td class="td_2">  
                       <r:comboSelect id="customer_service" name="customer_service1" queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                			textField="name" valueField="partyid" xpath="Partyrelation" width="200" messagekey="please_select" />
                     </td>
                     <td class="td_1"></td>
                     <td class="td_2"></td>
                </tr>
                <!-- 客户组 -->
                <tr style="display:none;" id="typeKEHUZU">
                	<td class="td_1" ><span class="style_required_red">* </span>所属客户组</td>
                    <td class="td_2">
		              <r:comboSelect id="cust_group" name="cust_group" queryAction="/FAERP/Cust_groupAction.do?cmd=queryListCustname"
		              textField="cust_group_name" valueField="cust_group_code" xpath="Cust_groupVo" width="200" messagekey="please_select"/> 
                    </td>
                    <td class="td_1"></td>
                    <td class="td_2"></td>
                </tr>
                <!-- 操作按钮 -->
                <tr class="td_1">
	                <td  align="right" colspan="2">
	                 	<input  id="generatebutton"  class="foot_icon_3" type="button"   value="批量生成"  <au:authorityBtn code="zdplsc_exp" type="1"/>  onClick="generateBill_onClick();">
		            </td>
		            <td align="left" colspan="2">
	                 	<input  id="downloadbutton"  class="foot_icon_3" type="button"   value="批量下载"  <au:authorityBtn code="zdplxz_exp" type="1"/>  onClick="downloadBill_onClick();">
		            </td>
                </tr>
			</table>
			</div>
			</div>
			</td>
		</tr>
	</table>
</fmt:bundle>
</body>
</html>
<script>
	//客户查询
	$id("lk_cust").onReturnFunc = function (returnValue){
	    var lookup = $id("lk_cust");
	    lookup.value = returnValue[0];
	    _$("#cust_id").val(returnValue[0]);
	    _$("#cust_code").val(returnValue[1]);
	    _$("#cust_name").val(returnValue[2]);
	    lookup.displayValue = returnValue[2];
	    $id("cost_center_id").addParam("cust_id", returnValue[0]);
	    $id("cost_center_id").loadData();
	    $id("cost_center_id").refresh();
	    return false;
	}
	_$(document).ready(function() {
		document.getElementById("billYearMonth").value = getNowFormatDate();
	});
	/********************************选择生成方式***************************************/
    function do_ex(){
	   var type=document.getElementById("create_type").value;
       if(type==1){//成本中心
         document.getElementById("typeCBZX").style.display="inline";//显示成本中心行
         document.getElementById("typeKEFU").style.display="none";//隐藏客服
         document.getElementById("typeKEHUZU").style.display="none";//隐藏客户组
         document.getElementById("tdCBZXDesc").style.display="inline";//显示成本中心提示
         document.getElementById("tdCBZXSelect").style.display="inline";//显示成本中心
       }else if(type==2){//客户
    	 document.getElementById("typeCBZX").style.display="inline";//显示成本中心行
         document.getElementById("typeKEFU").style.display="none";//隐藏客服
         document.getElementById("typeKEHUZU").style.display="none";//隐藏客户组
         document.getElementById("tdCBZXDesc").style.display="none";//隐藏成本中心提示
         document.getElementById("tdCBZXSelect").style.display="none";//隐藏成本中心
       }else if(type==3){//客户组
    	 document.getElementById("typeCBZX").style.display="none";//隐藏成本中心行
         document.getElementById("typeKEFU").style.display="none";//显示客服
         document.getElementById("typeKEHUZU").style.display="inline";//隐藏客户组
       }else if(type==4){//客服
    	 document.getElementById("typeCBZX").style.display="none";//隐藏成本中心行
         document.getElementById("typeKEFU").style.display="inline";//隐藏客服
         document.getElementById("typeKEHUZU").style.display="none";//显示客户组
       }
    }
	//批量生成
	function generateBill_onClick(){
		var create_type=document.getElementById("create_type").value;//生成方式
		var bill_type_bd=document.getElementById("bill_type_bd").value;//账单类型
	    var billYearMonth=document.getElementById("billYearMonth").value;//账单年月
	    var action="<%=request.getContextPath()%>/FinbillAction.do?cmd=generateBatchBill";
	    var myAjax = new Ajax(action);
	    myAjax.addParam("create_type",create_type);
	    myAjax.addParam("bill_type_bd",bill_type_bd);
	    myAjax.addParam("billYearMonth",billYearMonth);
	    if(bill_type_bd==""){
	        alert("请选择账单类型！");
	        return;
	    }
	    if(billYearMonth==""){
	        alert("请输入账单年月！");
	        return;
	    }
	    if (validDate(billYearMonth) == null) {
	        alert("输入错误，请输入'yyyyMM'六位数字格式");
	        return;
	    }
	    if(create_type==1){//成本中心
	        var cust_id = document.getElementById("cust_id").value;//客户id
	        var cust_code = document.getElementById("cust_code").value;//客户code
	        var cost_center_id = document.getElementById("cost_center_id").value;//成本中心id
	        var cost_center_name = $id("cost_center_id").getText();//成本中心名称
	        if(cust_id==""){
		        alert("请选择客户！");
		        return;
		    }
	        if(cost_center_id==""){
		        alert("请选择成本中心！");
		        return;
		    }
	        myAjax.addParam("cust_id",cust_id);
	        myAjax.addParam("cust_code",cust_code);
	        myAjax.addParam("cost_center_id",cost_center_id);
	        myAjax.addParam("cost_center_name",cost_center_name);
	    }else if(create_type==2){//客户
	        var cust_id = document.getElementById("cust_id").value;//客户id
	        var cust_code = document.getElementById("cust_code").value;//客户code
	        var cust_name = document.getElementById("cust_name").value;//客户id
	        if(cust_id==""){
		        alert("请选择客户！");
		        return;
		    }
	        myAjax.addParam("cust_id",cust_id);
	        myAjax.addParam("cust_code",cust_code);
	        myAjax.addParam("cust_name",cust_name);
	    }else if(create_type==3){//客户组
	        var cust_group = document.getElementById("cust_group").value;//客户组
	        var cust_group_name = $id("cust_group").getText() ;//客服名称
	        if(cust_group == ""){
		        alert("请选择客户组！");
		        return;
		    }
	        myAjax.addParam("cust_group",cust_group);
	        myAjax.addParam("cust_group_name",cust_group_name);
	    }else if(create_type==4){//客服
	    	var cust_service = $id("customer_service").getValue() ;//客服
	    	var cust_service_man = $id("customer_service").getText() ;//客服名称
	        if(cust_service_man == ""){
		        alert("请选择客服！");
		        return;
		    }
	        myAjax.addParam("customer_service",cust_service);
	        myAjax.addParam("cust_service_man",cust_service_man);
	    }else{
	    	alert("请选择生成方式！");
	    	return;
	    }
	    myAjax.submit();
	    var returnNode = myAjax.getResponseXMLDom();
	    if( returnNode ) {
           var flag = ""+myAjax.getProperty("returnValue");
           var msg = ""+myAjax.getProperty("returnMessage");
           alert(msg);
	    }
	}
	//批量下载账单
	function downloadBill_onClick(){
		var create_type=document.getElementById("create_type").value;//生成方式
		var bill_type_bd=document.getElementById("bill_type_bd").value;//账单类型
	    var billYearMonth=document.getElementById("billYearMonth").value;//账单年月
	    var action="<%=request.getContextPath()%>/FinbillAction.do?cmd=downLoadBatchBill";
	    var myAjax1 = new Ajax(action);
	    myAjax1.addParam("create_type",create_type);
	    myAjax1.addParam("bill_type_bd",bill_type_bd);
	    myAjax1.addParam("billYearMonth",billYearMonth);
	    if(bill_type_bd==""){
	        alert("请选择账单类型！");
	        return;
	    }
	    if(billYearMonth==""){
	        alert("请输入账单年月！");
	        return;
	    }
	    if (validDate(billYearMonth) == null) {
	        alert("输入错误，请输入'yyyyMM'六位数字格式");
	        return;
	    }
	    if(create_type==1){//成本中心
	        var cust_id = document.getElementById("cust_id").value;//客户id
	        var cust_code = document.getElementById("cust_code").value;//客户code
	        var cost_center_id = document.getElementById("cost_center_id").value;//成本中心id
	        var cost_center_name = $id("cost_center_id").getText();//成本中心名称
	        if(cust_id==""){
		        alert("请选择客户！");
		        return;
		    }
	        if(cost_center_id==""){
		        alert("请选择成本中心！");
		        return;
		    }
	        myAjax1.addParam("cust_id",cust_id);
	        myAjax1.addParam("cust_code",cust_code);
	        myAjax1.addParam("cost_center_id",cost_center_id);
	        myAjax1.addParam("cost_center_name",cost_center_name);
	    }else if(create_type==2){//客户
	        var cust_id = document.getElementById("cust_id").value;//客户id
	        var cust_code = document.getElementById("cust_code").value;//客户code
	        var cust_name = document.getElementById("cust_name").value;//客户id
	        if(cust_id==""){
		        alert("请选择客户！");
		        return;
		    }
	        myAjax1.addParam("cust_id",cust_id);
	        myAjax1.addParam("cust_code",cust_code);
	        myAjax1.addParam("cust_name",cust_name);
	    }else if(create_type==3){//客户组
	        var cust_group = document.getElementById("cust_group").value;//客户组
	        var cust_group_name = $id("cust_group").getText() ;//客服名称
	        if(cust_group == ""){
		        alert("请选择客户组！");
		        return;
		    }
	        myAjax1.addParam("cust_group",cust_group);
	        myAjax1.addParam("cust_group_name",cust_group_name);
	    }else if(create_type==4){//客服
	    	var cust_service = $id("customer_service").getValue() ;//客服
	    	var cust_service_man = $id("customer_service").getText() ;//客服名称
	        if(cust_service_man == ""){
		        alert("请选择客服！");
		        return;
		    }
	        myAjax1.addParam("customer_service",cust_service);
	        myAjax1.addParam("cust_service_man",cust_service_man);
	    }else{
	    	alert("请选择生成方式！");
	    	return;
	    }
	    myAjax1.submit();
	    var returnNode = myAjax1.getResponseXMLDom();
	    if( returnNode ) {
           var flag = ""+myAjax1.getProperty("returnValue");
           var msg = ""+myAjax1.getProperty("returnMessage");
           if(flag == "false"){
        	   alert(msg);
           }
       	   if(flag == "true"){
       		   var texts = msg.split("@");
       		   var isZip = texts[2];
       		   if("1" == isZip){
	       		   form.action="<%=request.getContextPath()%>/FinbillAction.do?cmd=downLoadBatchBillZip&excelName="+texts[0]+"&batch_name="+ texts[1] ;
       		   }else{
	       		   form.action="<%=request.getContextPath()%>/FinbillAction.do?cmd=downLoadBill&excelName="+texts[0]+"&batch_name="+ texts[1] ;
       		   }
               form.submit();
               form.action="";
       	   }
	    }
	}
	
	//验证输入日期格式yyyyMM
    function validDate(date) {
        var reg = /^\b[1-3]\d{3}(0[1-9]|1[0-2])$/;
        return flg = date.match(reg);
    }
	
  	//日期格式话：yyyyMM
    function getNowFormatDate() {
        var date = new Date();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        var currentdate = date.getFullYear() + month;
        return currentdate;
    }
</script>
