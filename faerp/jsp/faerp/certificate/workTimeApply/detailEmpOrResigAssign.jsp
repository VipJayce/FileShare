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
<fmt:bundle	basename="rayoo.certificate.workTimeApply.workTimeApply_resource_zh"	prefix="rayoo.certificate.workTimeApply.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
	<title><fmt:message key="empOrResigAssign" /></title>
	<script language="javascript">
    //选择框后续处理方法
    function rtnFunc(arg)
    {
      var lookup = $id("empOrResigSpecialistID");
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
            var certificateSpecialistID= document.getElementById("empOrResigSpecialistID").value;
          if(certificateSpecialistID==null || certificateSpecialistID==""){
          alert("请选择用退工专员");
          return false;
        }
        return true;
    }
    
    //校验
    function vailform(){
     var  code = jQuery("#edit_id").val();
                
                     
            if(code)
	            {
	                   save_onClick();
	              }
            else
                 {
	                  var customerID= document.getElementById("customerID").value;
	                      if(customerID==null || customerID=="")
	                      {
		                      alert("请选择客户");
		                      return false;
	                       }
	                        jQuery.ajax({
	                                 url: '<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=vailDataEmploymentOrResignationAssign',
	                                 type: 'POST',
	                                 dataType: 'html',
	                                 data:encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize()),true),
	                                 async: false,
	                                 timeout: 10000,
	                                      success: function(data){
	                                          if(data=='true')
	                                          {
	                                             save_onClick();
	                                            }
	                                         else
	                                         {
	                                           alert("该公司已指派用退工专员");
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
                  url= '<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=updateEmploymentOrResignationAssign&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true));
            }
            else
            {
                   url= '<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=insertEmploymentOrResignationAssign&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true));
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
	<body>
	<form name="form" method="post" id="datacell_formid"><input
		type="hidden" name="id" id="edit_id" value="${bean.id}"> <input
		type="hidden" name="statusCellValues" id="statusCellValues"> <input
		type="hidden" name="materiaCellValues" id="materiaCellValues">
	<div id="right" style="height: 140px;"><script
		language="javascript">
        writeTableTopFesco("<fmt:message key='empOrResigAssign'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
     session = request.getSession(false);
    rayoo.certificate.workTimeApply.vo.EmploymentOrResignationAssignVO beanVo = (rayoo.certificate.workTimeApply.vo.EmploymentOrResignationAssignVO) request.getAttribute("bean");
 %>
	<div class="ringht_x" style="height: 160px;">
	<div id="ccChild1" class="box_xinzeng" style="height: 160px;">
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
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
		<tr>
			<td class="td_1" width="30%"><fmt:message
				key='empOrResigSpecialist' /></td>
			<td class="td_2 " colspan="70">${bean.empOrResigSpecialistName}</td>
		</tr>
	</table>
	</div>
	<div></div>
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'	onClick="javascript:cancel_onClick()" /></div>
	</form>
</fmt:bundle>
</body>
</html>
