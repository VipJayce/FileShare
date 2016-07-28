<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<style type="text/css">
.eos-time-container div {
	padding-left: 0px !important;
}
</style>
<html>
<fmt:bundle
	basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh"
	prefix="rayoo.certificate.certificateTransaction.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
	<title><fmt:message key="certificateTranAssign" /></title>
	<script language="javascript">
      jQuery(document).ready(function(){     
            jQuery("#personnelCategory").change(function(){
            var lookup = $id("certificateSpecialistID");
            lookup.lookupUrl = "/CertificateTransactionAction.do?cmd=getCertificateSpecialistPage&personnelCategory=" + jQuery(this).val();            
       });
       
    });
    //选择框后续处理方法
    function rtnFunc(arg)
    {
      var lookup = $id("certificateSpecialistID");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
        return false;
    }
    function rtnFuncCustomer(arg){
        var lookup = $id("customerID");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#customerNumber").text(arg[1]);
        return false;
    }
    function rtnFuncCustomerServicesDep(arg)
    {
     var lookup = $id("customerServicesDepID");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        return false;
    }
    
    function showCustomer()
    {
        jQuery("#customerTr").show().next().show();
        jQuery("#customerServicesDepTr").hide();
    }
     function showCustomerServiceDep()
    {
        jQuery("#customerTr").hide().next().hide();
        jQuery("#customerServicesDepTr").show();
    }
    //公共校验
    function vailFormCommon()
    { 
            var certificateSpecialistID= document.getElementById("certificateSpecialistID").value;
          if(certificateSpecialistID==null || certificateSpecialistID==""){
          alert("请选择证件办理专员");
          return false;
        }
        return true;
    }
    
    //校验
    function vailform(){
     var  code = jQuery("#edit_id").val();
                         
            if(code) {
                     save_onClick();
	        }else{
	                  var customerID= document.getElementById("customerID").value;
	                      if(customerID==null || customerID=="")
	                      {
		                      alert("请选择客户"); 
		                      return false;
	                       }
	                        jQuery.ajax({
	                                 url: '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataTranAssign',
	                                 type: 'POST',
	                                 dataType: 'html',
	                                 data:encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize()),true),
	                                 async: false,
	                                 timeout: 10000,
	                                      success: function(data){
	                                       data=eval("("+data+")");
                                             if(data.status=='true'){
	                                             save_onClick();
	                                         }else{
	                                           if(data.personnelCategory=='0'){
	                                               alert("该公司已指派证件办理专员");
	                                           }
	                                           if(data.personnelCategory=='1'){
	                                               alert("该公司已指派接单客服");
	                                        }
	                                   }
	                                }
	                            });        
                     }
    }
    //保存
    function save_onClick(){  //保存
            if (!vailFormCommon())
            {
                return;
            }
            var  code = jQuery("#edit_id").val();
            var url;
            if(code){
                  url= '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=updateTranAssign&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true));
            }
            else
            {
                   url= '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=insertTranAssign&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true));
            }
                jQuery.ajax({
                           url:url,
                           type: 'POST',
                           dataType: 'html',
                           async: false,
                           timeout: 10000,
                                success: function(data){
                                    data=eval("("+data+")");
                                    if(data.status=='true'){
                                            returnValue = ["0"];
                                            window.close();
                                            window.opener.insertcallBack(returnValue);
                                   }
                                   else{
                                               returnValue = ["2"];
                                               window.close();
                                               window.opener.insertcallBack(returnValue);
                                   }
                               }
                           });      
    }
    
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
   </script>
	</head>
	<body>
	<form name="form" method="post" id="datacell_formid"><input
		type="hidden" name="id" id="edit_id" value="${bean.id}"> <input
		type="hidden" name="statusCellValues" id="statusCellValues"> <input
		type="hidden" name="materiaCellValues" id="materiaCellValues">
	<input type="hidden" id="assignType" value="${bean.assignType}">
	<div id="right" style="height: 140px;"><script
		language="javascript">
        writeTableTopFesco("<fmt:message key='certificateTranAssign'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
     session = request.getSession(false);
     rayoo.certificate.certificateTransaction.vo.CertificateTranAssignVO beanVo = (rayoo.certificate.certificateTransaction.vo.CertificateTranAssignVO) request.getAttribute("bean");
 %>
	<div class="ringht_x" style="height: 160px;">
	<div id="ccChild1" class="box_xinzeng" style="height: 160px;">
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr id="customerTr">
			<td class="td_1" width="30%"><span class="style_required_red">*</span><fmt:message key='customerName' /></td>
			<td class="td_2 " colspan="70"><c:if test="<%=beanVo==null %>">
				<w:lookup name="customerID" allowInput="false"
					onReturnFunc="rtnFuncCustomer" id="customerID"
					lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1"
					messagekey="choose_customer" height="440" width="580"
					style="width:270px" displayValue="${bean.customerName}"
					value="${bean.customerID}" />
			</c:if> <c:if test="<%=beanVo!=null %>">
                ${bean.customerName}
           </c:if></td>
		</tr>
		<tr>
			<td class="td_1" width="30%"><span class="style_required_red">*</span><fmt:message key='customerNumber' /></td>
			<td class="td_2 " colspan="70" id="customerNumber">${bean.customerNumber}
			</td>
		</tr>
		
		<tr>
            <td class="td_1" width="30%"><span class="style_required_red">*</span><fmt:message  key='personnelCategory' /></td>
            <td class="td_2 " colspan="70"><c:if test="<%=beanVo==null %>">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("personnelCategory", -1, "PERSONNEL_CATEGORY", "", " id='personnelCategory' ", false)%>
            </c:if> 
            <c:if test="<%=beanVo!=null %>">
                ${bean.personnelCategory}
           </c:if></td>
        </tr>
		
		<tr>
			<td class="td_1" width="30%"><span class="style_required_red">*</span><fmt:message
				key='Specialist' /></td>
			<td class="td_2 " colspan="70"><w:lookup
				name="certificateSpecialistID" allowInput="false"
				onReturnFunc="rtnFunc" id="certificateSpecialistID"
				lookupUrl="/CertificateTransactionAction.do?cmd=getCertificateSpecialistPage"
				messagekey="choose_certificateSpecialist" height="440" width="600"
				style="width:170px" displayValue="${bean.certificateSpecialistName}"
				value="${bean.certificateSpecialistID}" /></td>
		</tr>
	</table>
	</div>
	<div></div>
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
	<input type="button" class="icon_2" value='<fmt:message key="save"/>'
		onClick="javascript:vailform()" /> <input type="button"
		class="icon_2" value='<fmt:message key="go_back"/>'
		onClick="javascript:cancel_onClick()" /></div>
	</form>
</fmt:bundle>
</body>
</html>
