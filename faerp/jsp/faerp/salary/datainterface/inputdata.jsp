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
    <td width="50%" class="td_1"><fmt:message key='pay_name'/></td>
    <td width="50%" class="td_2"><input type="text" value="" class="xText" id="pay_name" name="pay_name" style="width:215"/></td>
    </tr>
  <tr>
    <td class="td_1"><fmt:message key='pay_year_month'/></td>
    <td class="td_2">
    <input type="text" class="text_field" name="pay_year_month" id="pay_year_month" value="${requestScope.strdate}" inputName="应发年月" maxLength="6" style="width:215" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>(201301)
    </td>
    </tr>
  <tr>
    <td class="td_1"><fmt:message key='bill_year_month'/></td>
    <td class="td_2">
    <input type="text" class="text_field" name="bill_year_month" id="bill_year_month" value="${requestScope.strdate}" inputName="账单年月" maxLength="6" style="width:215" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>(201301)
    </td>
    </tr>
  <tr>
    <td class="td_1"><fmt:message key='tax_month'/></td>
    <td class="td_2">
    <input type="text" class="text_field" name="tax_month" id="tax_month" value="${requestScope.strdate}" inputName="计税年月" maxLength="6" style="width:215" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>(201301)
    </td>
    </tr>
  <tr>
    <td class="td_1"><fmt:message key='is_unite_tax'/></td>
    <td class="td_2"><input name="is_unite_tax" id="is_unite_tax" type="checkbox" value="checkbox" checked="checked"  /></td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='attachNameInput'/></td>
    <td class="td_2">
               <input type="text" id="attachNameInput" class="text_field_reference_readonly" id="attachNameInput" name="attachNameInput" inputName="附件地址" value="" hiddenInputId="attach_name"/>
               <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
               <input type="hidden" id="attackAddressInput" name="attach_address" value="">
    </td>
  </tr>
  </table>
<div class="xz_button">
 <input type="submit" name="submitid" id="submitid" class="icon_2"  value="<fmt:message key='button_input_data'/>" /> 
 <input name="button" type="button" class="icon_2" onclick="javascript:closewin() ;" value="<fmt:message key='button_close'/>" />
</div>
</div>
</form>
</body>
<script type="text/javascript"><!--
	/*var _now = new Date();
	var y =  _now.getFullYear()+"";
	var m = _now.getMonth()+1+"";
	if(m.length == 1){
		m = "0" + m;
	}
	var ym = y + m;
	$id("pay_year_month").value = ym;
	$id("bill_year_month").value = ym;
	$id("tax_month").value = ym;*/
    //关闭窗口
    function closewin(){
        window.close() ;
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
        
        
        if(checkData("${param.salary_class_id}")){
            alert("<fmt:message key='alert_unconfirm'/>");
            //window.close();
            return false ;
        }
       
        document.getElementById("submitid").disabled="false";
        return true ;
   }
   

        function checkData(salary_class_id){
         var url="<%=request.getContextPath()%>/SalarybatchAction.do?cmd=CheckDateBySa_class_id&salary_class_id="+salary_class_id;
         url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
         var flags=true;
              jQuery.ajax({
              url: url,
              type: 'GET',
              dataType: 'html',
              async: false,
              timeout: 10000,
              error: function(){
                  alert("<fmt:message key='alert_system_err'/>");
                  return;
              },
              success: function(text){
                  if(text!=null){
                          if(text=="false"){
                             flags=false;
                          }
                  }
              }
              });
              return flags;
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
    
    //消息
    if (${msg != null } && ${msg != "" }) {
        alert('${msg}');
        document.getElementById("submitid").disabled="true";
        var rst = new Array();
        rst.push("${batchId}");
        rst.push("${pay_name}");
        window.returnValue = rst;
        window.close();
    }
</script>

</fmt:bundle>
</html>

