<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ page import="rayoo.finance.receivable.MyUtils" %>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>
<% 
String CurrentTimestamp=MyUtils.Timestamp2String(MyUtils.getCurrentTimestamp(), MyUtils.DEFAULT_DATE);
request.setAttribute("CurrentTimestamp", CurrentTimestamp);
%>
<body style="overflow: hidden">
<form name="form" method="post" id="form">
<input type="hidden" name="ids" id="ids" value="${param.bill_ids }">
<input type="hidden" name="type" id="type" value="${param.type }">
<div class="box_2" style="margin-top: 10px">
  <div style=" text-align:center; vertical-align:middle;"><fmt:message key='title_setDate'/><span class="td_2">
        <w:date format="yyyy-MM-dd" id="create_date" name="create_date"  value="${requestScope.CurrentTimestamp}" width="70px"/>
  </span></div>
  <div class="xz_button">
    <input type="button" class="icon_2" value="<fmt:message key='button_confirm'/>" onclick="saveData();" />
 <input name="button1" type="button" class="icon_2" value="<fmt:message key='button_cancel'/>" onclick="window.close();"/>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">
    function saveData() {
           var v_date=jQuery("#create_date_input").val();
           var ids = document.getElementById("ids").value;
           var type = document.getElementById("type").value;
           if(v_date== null || v_date==""){
                alert("<fmt:message key='alert_create_date_input'/>");
                return;
           } 
           if(type=="rengling"){    
           		/*jQuery.getJSON("/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateucherClaim&incoming_id=" + ids +"&vtype="+encodeURI("转")+"&vtitle="+encodeURI("转账凭证")+"&buztype=0&voucher_gs=010&date="+v_date,{},   function(json){
	           		if(json.lists!=null&&json.lists!="")
		            {        
		                window.close(); //关闭
		            	window.open(encodeURI('infoPage.jsp?info='+json.lists),'', 'height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');
		            }
           		});*/
           		window.close(); //关闭
           		window.open('<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=batchCreateucherClaim&incoming_id='+ids+'&vtype='+encodeURI("转")+'&vtitle='+encodeURI("转账凭证")+'&buztype=0&voucher_gs=010&date='+v_date,'','height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');									
           }else if(type=="renglinghongchong"){
                window.close(); //关闭
                window.open('<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=batchCreateHongChongucherClaim&incoming_id='+ids+'&vtype='+encodeURI("转")+'&vtitle='+encodeURI("转账凭证")+'&buztype=0&voucher_gs=010&date='+v_date,'','height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');      
           }else if(type=="zhangdan"){
                /*jQuery.getJSON("/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids=" + ids +"&vtype="+encodeURI("转")+"&vtitle="+encodeURI("转账凭证")+"&buztype=0&date="+v_date,{},   function(json){
                	if(json.lists!=null&&json.lists!="")
		            {        
		                window.close(); //关闭
		            	window.open(encodeURI('infoPage.jsp?info='+json.lists),'', 'height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');
		            }
                });*/
                window.close(); //关闭
                window.open('<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids='+ids+'&vtype='+encodeURI("转")+'&vtitle='+encodeURI("转账凭证")+'&buztype=0&date='+v_date,'','height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');
           }else if(type=="daokuanfabu"){
           		/*jQuery.getJSON("/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateucherIncoming&incoming_id=" + ids +"&vtype="+encodeURI("收")+"&vtitle="+encodeURI("收款凭证")+"&buztype=0&voucher_gs=002&date="+v_date,{},   function(json){
           			if(json.lists!=null&&json.lists!="")
		            {        
		                window.close(); //关闭
		            	window.open(encodeURI('infoPage.jsp?info='+json.lists),'', 'height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');
		            }
                });*/
                window.close(); //关闭
				window.open('<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=batchCreateucherIncoming&incoming_id='+ids+'&vtype='+encodeURI("收")+'&vtitle='+encodeURI("收款凭证")+'&buztype=0&voucher_gs=002&date='+v_date,'','height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');                
           }
    }
</script>
</fmt:bundle>