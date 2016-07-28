<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.finance.receivable.MyUtils" %>
<%@ page import="java.sql.Timestamp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%
	String strdate = MyUtils.Timestamp2String(new Timestamp(System
			.currentTimeMillis()), MyUtils.YEARANDMONTH);
	request.setAttribute("strdate", strdate);
	
	Object rst = request.getAttribute("rst");
	Object bc_qg = request.getAttribute("batch_code_qg");
	String msg = "";
	if(rst != null){
		int[] result = (int[])rst;
		int success = result[0];
		int failed = result[1];
		String code = (bc_qg==null? "":bc_qg.toString());
		msg = "导入完成！成功数据 "+success+" 条，"+"失败数据 "+failed+" 条，全国委托户批次号："+code;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.datainterface.datainterface_resource" prefix="rayoo.salary.datainterface.">
<head>
<title><fmt:message key='dateinterface'/></title>
<script language="javascript">
	jQuery(function(){
		//返回导入结果
		var imp_msg = "<%=msg%>";
		if(imp_msg != ""){
			alert(imp_msg);
		}
	});
	
	function toDownLoad_onclick(){
	    var url="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=downLoadExcel";
	    url=url+"&random="+Math.random();
        formImp.action=url;
        formImp.submit();
    }
    //提交验证
   function insert_submit(){
        
        var pay_name = $id("pay_name").value ;
        if(pay_name == null||pay_name==''){
            alert("<fmt:message key='alert_pay_name'/>") ;
            return false ;
        }
        var pay_year_month = $id("pay_year_month").value ;
        
        if(pay_year_month == null||pay_year_month==''){
            alert("<fmt:message key='alert_pay_year_month'/>") ;
            return false ;
        }
        if(!check_pay_ym(pay_year_month)){
        	alert("<fmt:message key='alert_pay_year_month_err'/>");
        	return false;
        }
        var bill_year_month = $id("bill_year_month").value ;
        
        if(bill_year_month == null||bill_year_month==''){
            alert("<fmt:message key='alert_bill_year_month'/>") ;
            return false ;
        }
        if(!check_pay_ym(bill_year_month)){
        	alert("<fmt:message key='alert_bill_year_month_err'/>");
        	return false ;
        }
        var tax_month = $id("tax_month").value ;
        if(tax_month == null||tax_month==''){
            alert("<fmt:message key='alert_tax_month'/>") ;
            return false ;
        }
        if(!check_pay_ym(tax_month)){
        	alert("<fmt:message key='alert_tax_month_err'/>");
        	return false ;
        }
        var attackAddressInput = $id("attackAddressInput").value ;
        if(attackAddressInput == null||attackAddressInput==''){
            alert("<fmt:message key='alert_select_file'/>") ;
            return false ;
        }
        var attachNameInput = $id("attachNameInput").value;
        if(attachNameInput.indexOf(".xls")==-1){
            alert("<fmt:message key='alert_file_exl'/>") ;
            $id("attachNameInput").value="";
            $id("attackAddressInput").value=""
            return false ;
        }
       	$id("batchIds").value = "";
       	$id("h_pay_name").value = "";
        document.getElementById("submitid").disabled="false";
        return true ;
   }
    
   //验证年月
   function check_pay_ym(str){
   	var p = /^[12]\d{3}(0\d|1[0-2])$/;
   	if(!p.test(str)){
   		return false;
   	}
   	return true;
   }
    
    //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2;
        var t = (screen.height - h) / 2;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    }
    //导出问题数据
    function viewFailData(){
    	var batchIds = $id("batchIds").value; 
    	var pay_name = $id("h_pay_name").value;
    	url="<%=request.getContextPath()%>/jsp/faerp/salary/datainterface/faildata.jsp?batchIds="+batchIds+"&pay_name="+pay_name;
	    showModalCenter(url, window, "", 800, 400, "<fmt:message key='button_output_err_data'/>");
    }
</script>
</head>
<body>

<form name="formImp" method="post"
	action="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=importQGData"
	onsubmit="return insert_submit();">
<input type="hidden" name="batchIds" id="batchIds" value="${batchIds }"/>
<input type="hidden" name="h_pay_name" id="h_pay_name" value="${h_pay_name }"/>
<div id="right">
<div class="box_xinzeng" style="height: 260px">
<table width="90%" border="0" align="center" cellpadding="0"
	cellspacing="1" bgcolor="#c5dbe2">
	<tr>
		<td class="td_1" style="width: 40%;"><fmt:message key='pay_name'/></td>
		<td class="td_2" style="width: 60%;"><input type="text" value=""
			class="xText" id="pay_name" name="pay_name" style="width: 215" /></td>
	</tr>
	<tr>
		<td class="td_1"><fmt:message key='pay_year_month'/></td>
		<td class="td_2"><input type="text" class="text_field"
			name="pay_year_month" id="pay_year_month"
			value="${requestScope.strdate}" inputName="应发年月" maxLength="6"
			style="width: 215" onkeyup="this.value=this.value.replace(/\D/g,'')"
			onafterpaste="this.value=this.value.replace(/\D/g,'')" />(201301)</td>
	</tr>
	<tr>
		<td class="td_1"><fmt:message key='bill_year_month'/></td>
		<td class="td_2"><input type="text" class="text_field"
			name="bill_year_month" id="bill_year_month"
			value="${requestScope.strdate}" inputName="账单年月" maxLength="6"
			style="width: 215" onkeyup="this.value=this.value.replace(/\D/g,'')"
			onafterpaste="this.value=this.value.replace(/\D/g,'')" />(201301)</td>
	</tr>
	<tr>
		<td class="td_1"><fmt:message key='tax_month'/></td>
		<td class="td_2"><input type="text" class="text_field"
			name="tax_month" id="tax_month" value="${requestScope.strdate}"
			inputName="计税年月" maxLength="6" style="width: 215"
			onkeyup="this.value=this.value.replace(/\D/g,'')"
			onafterpaste="this.value=this.value.replace(/\D/g,'')" />(201301)</td>
	</tr>
	<tr>
		<td class="td_1"><fmt:message key='is_unite_tax'/></td>
		<td class="td_2"><input name="is_unite_tax" id="is_unite_tax"
			type="checkbox" value="checkbox" checked="checked" /></td>
	</tr>
	<tr>
		<td class="td_1"><fmt:message key='attachNameInput'/></td>
		<td class="td_2"><input type="text" id="attachNameInput"
			class="text_field_reference_readonly" id="attachNameInput"
			name="attachNameInput" inputName="附件地址" value=""
			hiddenInputId="attach_name" /> <img class="refButtonClass"
			src="<%=request.getContextPath()%>/images/icon/reference.gif"
			onClick="javascript:UploadFileWindow();" /> <input type="hidden"
			id="attackAddressInput" name="attach_address" value=""></td>
	</tr>
</table>
<div class="xz_button">
<input class="icon_2" type="button" value="<fmt:message key='button_donwload'/>" onClick="toDownLoad_onclick();">
<input type="submit" name="submitid" id="submitid" class="icon_2" value="<fmt:message key='button_input_data'/>" />
<input class="icon_3" type="button" value="<fmt:message key='button_output_err_data'/>" onClick="viewFailData()">
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
