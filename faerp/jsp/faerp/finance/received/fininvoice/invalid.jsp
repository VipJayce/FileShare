<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script language="JavaScript" src="../../scripts/common.js"></script>
<fmt:bundle basename="rayoo.finance.received.fininvoice.fininvoice_resource" prefix="rayoo.finance.received.fininvoice.">
<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript">
function cancel_onClick() {
    	window.close();
    }
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body style="overflow: hidden">
<form name="form" method="post" id="form">
<input id="id" name="fin_invoice_id" type="hidden"  value="${param.id}" />
<input id="invoice_type_select" name="invoice_type_select" type="hidden"  value="${param.invoice_type_select}" />
<input id="nobill" name="nobill" type="hidden"  value="${param.nobill}" />
<div class="box_2" style="margin-top: 10px">
  <div style=" text-align:left; margin-top: 15px;margin-left: 90px;">
        <div>
	        <span style="font:14px/100% arial,宋体b8b\4f53;color:#000000">作废发票编号：</span>
	        <input type="text" id="invalid_invoice_code" name="invalid_invoice_code" class="text_field" />
        </div>  
  </div>
  <div style=" text-align:left; margin-top: 15px;margin-left: 104px;">
    <div>
        <span style="color: red">*</span><span  style="font:14px/100% arial,宋体b8b\4f53;color:#000000"><fmt:message key='cancel_reason'/>：</span>
    </div>
    <div style="margin-left: 90px;margin-top: -20px;">
        <textarea name="cancel_reason" rows="9" style="width:205px; height:100px;" id="cancel_reason"></textarea>
    </div>
  </div>
  
  <div class="xz_button">
    <input type="button" class="icon_2" value="<fmt:message key='confirm'/>" onclick="saveData();" />
    <input type="button" class="icon_2" value="<fmt:message key='cancel'/>" onclick="cancel_onClick();"/>
  </div>
</div>
</form>
</body>
</html>
<script language="javascript">
    function saveData() {
	    if(jQuery("#cancel_reason").val()==null || jQuery("#cancel_reason").val()==""){
	        alert("请输入作废原因！");
	        return;
	    }
         var param = jQuery("#form").serialize();
         var url="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=InvalidInvoice&"+param;
         jQuery.post(url,function(data){
               if(data){
                   if(data!="1"){
                        alert("<fmt:message key='alert_error'/>");
                        return;
                   }
               }
         });
         window['returnValue'] = ['<fmt:message key='alert_success'/>'];
         window.close(); //关闭
    }
</script>
</fmt:bundle>
