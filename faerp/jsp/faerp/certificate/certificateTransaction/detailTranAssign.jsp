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
.eos-time-container div{padding-left:0px!important;}
</style>
<html>
<body>
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
    function radioHandle(){
     var  code = jQuery("#edit_id").val();
     if(code)
     {
        var radioValue=jQuery("#assignType").val;
        jQuery("[type=\"radio\"][value=\""+radioValue+"\"]").click();
     }    
    }
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
        var dateFrom =$id("create_date_from").value;
        var dateTo =$id("create_date_to").value;
        dateFrom = dateFrom.replace(/-/g, "/");  
        dateTo = dateTo.replace(/-/g, "/");   
        dateFrom=new Date(Date.parse(dateFrom));
        dateFrom.setSeconds(0);
        dateTo=new Date(Date.parse(dateTo));
        dateTo.setSeconds(0);
         if(dateTo<dateFrom){
        alert("起始日期不能大于截至日期");
         return false;
        }
       return true;
    }
    
    //校验
    function vailform(){
     var  code = jQuery("#edit_id").val();
                
                       save_onClick();
                      return;
            
            jQuery.ajax({
                           url: '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataOutReg&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize()),true),
                           type: 'POST',
                           dataType: 'html',
                           async: false,
                           timeout: 10000,
                                success: function(data){
                                    if(data=='true'){
                                        save_onClick();
                                      }
                                   else
                                   {
                                     alert("与已知外出时间段重叠");
                                   }
                               }
                           });        
    }
    //保存
    function save_onClick(){  //保存
          
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
                                    if(data=='true'){
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
    <body onload="radioHandle();">
    <form name="form" method="post" id="datacell_formid"><input
        type="hidden" name="id" id="edit_id" value="${bean.id}"> <input
        type="hidden" name="statusCellValues" id="statusCellValues"> <input
        type="hidden" name="materiaCellValues" id="materiaCellValues">
        <input type="hidden" name="assignType" id="assignType"> 
    <div id="right" style="height: 140px;"><script
        language="javascript">
        writeTableTopFesco("<fmt:message key='certificateTranAssign'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
    session = request.getSession(false);
     rayoo.certificate.certificateTransaction.vo.CertificateTranAssignVO beanVo = (rayoo.certificate.certificateTransaction.vo.CertificateTranAssignVO ) request.getAttribute("bean");
 %>
    <div class="ringht_x" style="height: 160px;">
    <div id="ccChild1" class="box_xinzeng" style="height: 160px;">
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="30%"><fmt:message key='personnelCategory' /></td>
            <td class="td_2" id="personnelCategory" colspan="70">
              ${bean.personnelCategory}
            </td>
        </tr>
        <tr>
            <td class="td_1" width="30%"><fmt:message key='Specialist' /></td>
            <td class="td_2 " colspan="70">
              ${bean.certificateSpecialistName}
            </td>
        </tr>
        <tr id="customerTr">
           <td class="td_1" width="30%"><fmt:message key='customerName' /></td>
           <td class="td_2 " colspan="70">
             ${bean.customerName}
           </td>
        </tr>
        <tr>
           <td class="td_1" width="30%"><fmt:message key='customerNumber' /></td>
           <td class="td_2 " colspan="70" id="customerNumber">${bean.customerNumber}
           </td>
        </tr>
    </table>
    </div>
    <div></div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
    <input type="button"
        class="icon_2" value='<fmt:message key="go_back"/>'
        onClick="javascript:cancel_onClick()" /></div>
    </form>
</fmt:bundle>
</body>
</html>
