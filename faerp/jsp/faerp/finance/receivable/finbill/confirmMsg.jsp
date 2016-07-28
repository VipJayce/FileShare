<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<html>
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
<script type="text/javascript">
	var bill_id = window.dialogArguments   ;

	function sendSubmit(obj){
		
		if(obj == 0){
			var reason = $id("reason").value;
			if(reason == null || reason == "" ){
				alert("<fmt:message key='alert_apply_detail'/>");
				return;
			}
			var fin_invoice_id=null;
			var loginid="<%=LoginHelper.getPartyId(request)%>";
			   DWREngine.setAsync(false);//数据同步
			   var template_id = "${param.template_id}";
			   //alert("${param.template_id}");
		        WfCommonAjax.saveInvoiceDate("${param.bill_id}","${param.v_bill_id}","${param.pb_cost_center_id}", "${param.invoice_desc}","${param.invoice_amount}","${param.invoice_type}", loginid,template_id,"${param.small_amount}","${param.receipt_title}",function(reData){
		             if(reData!=null){
		                 var arr = reData.split(",");
		                 fin_invoice_id=arr[2];
		                 //alert("fin_invoice_id="+fin_invoice_id);
		                 //alert(arr[1]);
		             }else{
                         window.close();
		             }
		         });
		         
		         
	            var _url = "<%=request.getContextPath()%>/FininvoiceAction.do?cmd=submitApproval&fin_invoice_id=" + fin_invoice_id;
	            jQuery.ajax({
	                type : "post",
	                url : _url,
	                data : jQuery('form').serialize(),
	                dataType : "html",
	                success : function(data) {
	                        alert(data);
	                        alert(window.parent.name);
	                        //window.parent.location.reload();
	                        //window.opener.parent.location.reload();
	                        //window.opener.location.reload();
	                        window.parent.close();
	                        window.close();
	                    }
	             });
	    
	        /*
		    //需要生成红冲凭证账单的ID
	         var v_bill_id="${param.v_bill_id}";
	         if(v_bill_id!=null && v_bill_id!=""){
	                createBillVoucher(v_bill_id);
	         }
	         */
		    //window.parent.location.reload();
		    window.parent.close();
            window.close();
		}else{
		    //window.parent.location.reload();
		    window.parent.close();
			window.close();
		}
	}
	
	
	
	
	
	
	     //生成红冲凭证
     function createBillVoucher(bill_ids) {
               var _now =CurentDate();
               //var v_date=arg[0];//制单日期
               var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids=" + bill_ids +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_type=hongchong";
               turl=turl+"&date="+_now;  
               //alert("turl======"+turl);
               turl = encodeURI(turl);
               jQuery.ajax({
               url: turl,
               type: 'GET',
               dataType: 'html',
               async: false,
               timeout: 10000,
               error: function(text){
                       alert(text);
                       return  null;
                   },
               success: function(text){
                       alert(text);
                       //$id("celllist1").reload();
               }
           });  
 
 }
 
 
 function CurentDate(){
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分
        var clock = year + "-";
        if(month < 10)
            clock += "0";
        clock += month + "-";
        if(day < 10)
            clock += "0";
        clock += day + "";
        return(clock); 
    } 
    
</script>	
	</head>
	<body>

	<form name="form1" method="post" id="form1" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<textarea rows="10" cols="35" id="reason" name="reason"></textarea>
		<input type="button" class="foot_icon_1" value="<fmt:message key='button_submit'/>" onclick="sendSubmit(0)">
		<input type="button" class="foot_icon_1" value="<fmt:message key='button_cancel'/>" onclick="sendSubmit(1)">
	</table>
	</form>
</fmt:bundle>
</body>
</html>
