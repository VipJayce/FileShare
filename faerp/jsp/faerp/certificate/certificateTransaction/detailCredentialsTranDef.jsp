<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle
	basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh"
	prefix="rayoo.certificate.certificateTransaction.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
	<title><fmt:message key="credentialsType_maintenance" /></title>
	<script language="javascript">
 //办理证件类别、办理证件小类联动
   function findType(){
        var credentials_type_id = document.getElementById('credentials_type_id');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('credentials_type_bd').value;
        if(type_bd == null || type_bd==''){
            return;
        }
         jQuery.getJSON("<venus:base/>/CertificateTransactionAction.do?cmd=findCredentialsType&date="+new Date()+"",{"type_bd":type_bd},  function(json){
          for(var i = 0; i < json.saia.length; i++){
           var id=json.saia[i].id ;
           var name =json.saia[i].credentialsName;
           addAt(credentials_type_id,name,id,1);
            }
        });  
    }
    //为select添加option
      function addAt(selectCtl,optionValue,optionText,position){
         var userAgent = window.navigator.userAgent;
        if (userAgent.indexOf("MSIE") > 0) {
             var option = document.createElement("option");
             option.innerText = optionValue;
             option.value = optionText;
             selectCtl.insertBefore(option, selectCtl.options[position]);
         }else{
        selectCtl.insertBefore(new Option(optionValue, optionText), selectCtl.options[position]);
        }
    } 
    //公司选择框后续处理方法
    function rtnFuncCompany(arg){
        var lookup = $id("company_id");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#companyNumber").text(arg[1]);
        return false;
    }
    //公共校验
    function vailFormCommon()
    {
     var  companyAccount = document.getElementById("companyAccount").value;
                    if(companyAccount==null || companyAccount==""){
                        alert("请输入帐号");
                        return false;
                      }
                       var  companyAccountPassword = document.getElementById("companyAccountPassword").value;
                    if(companyAccountPassword==null || companyAccountPassword==""){
                        alert("请输入密码");
                        return false;
                      }
                       var  acceptance = document.getElementById("acceptance").value;
                    if(acceptance==null || acceptance==""){
                        alert("请选择受理点");
                        return false;
                      }
                       var  companyLinkman = document.getElementById("companyLinkman").value;
                    if(companyLinkman==null || companyLinkman==""){
                        alert("请输入公司联系人");
                        return false;
                      }
    }
    
    //校验
    function vailform(){
     var  code = jQuery("#edit_id").val();
		    if(code)
		    {         
		               save_onClick();
		              return;
		    }
			jQuery.ajax({
			               url: '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataTranDef&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize()),true),
			               type: 'POST',
			               dataType: 'html',
			               async: false,
			               timeout: 10000,
			                    success: function(data){
			                        if(data=='true'){
				                        var  companyNumber = jQuery("#companyNumber").text();
					                    if(companyNumber==null || companyNumber==""){
					                        alert("请选择公司");
					                        return false;
					                      }
					                       var  credentials_type_bd = document.getElementById("credentials_type_bd").value;
					                    if(credentials_type_bd==null || credentials_type_bd==""){
					                        alert("请选择证件类型");
					                        return false;
					                      }
					                       var  credentials_type_id =document.getElementById("credentials_type_id").value;
					                    if(credentials_type_id==null || credentials_type_id==""){
					                        alert("请选择证件小类");
					                        return false;
					                      }
			                             save_onClick();
			                          }
			                       else
			                       {
			                         alert("该类证件定义已存在");
			                       }
			                   }
			               });        
        return true;
    }
    //保存
    function save_onClick(){  //保存
                  if(!vailFormCommon())
                      {
                        return;
                      }
            var  code = jQuery("#edit_id").val();
            var url;
            if(code){
                  url= '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=updateTranDef&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true));
            }
            else
            {
                   url= '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=insertTranDef&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true));
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
        writeTableTopFesco("<fmt:message key='credentialsType_maintenance'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
     boolean isModify = false;
     String acceptance = "";
     rayoo.certificate.certificateTransaction.vo.CertifiCateTranInfoDef beanVo = (rayoo.certificate.certificateTransaction.vo.CertifiCateTranInfoDef) request.getAttribute("bean");
     if (beanVo == null) {
         isModify = true;
     } else {
         acceptance = beanVo.getAcceptance();
     }
 %>
	<div class="ringht_x" style="height: 150px;">
	<div id="ccChild1" class="box_xinzeng" style="height: 150px;">
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="25%"><fmt:message key='companyName' /></td>
			<td class="td_2 " width="25%">
                            ${bean.companyName}
			</td>
			<td class="td_1" width="25%"><fmt:message key='companyNumber' /></td>
			<td class="td_2 " width="25%" id="companyNumber">
                     ${bean.companyNumber}
             </td>
		</tr>
		<tr>
			<td class="td_1" width="25%"><fmt:message
				key='credentials_type_bd' /></td>
			<td class="td_2 " width="25%">
					<%=BaseDataHelper.getNameByCode("CREDENTIALS_TYPE", beanVo.getCredentialsTypeBdID())%>
		     </td>
			<td class="td_1" width="25%"><fmt:message key='credentials_name' /></td>
			<td class="td_2 " width="25%">
                            ${bean.credentialsTypeName}
			</td>
		</tr>
		<tr>
			<td class="td_1" width="25%"><fmt:message key='companyAccount' /></td>
			<td class="td_2 " width="25%">${bean.companyAccount}</td>
			<td class="td_1" width="25%"><fmt:message
				key='companyAccountPassword' /></td>
			<td class="td_2 " width="25%">${bean.companyAccountPassword}
			</td>
		</tr>
		<tr>
			<td class="td_1" width="25%"><fmt:message key='acceptance' /></td>
			<td class="td_2 " width="25%"><%=BaseDataHelper.getNameByCode( "ACCEPTANCE", acceptance)%>
			</td>
			<td class="td_1" width="25%"><fmt:message key='companyLinkman' /></td>
			<td class="td_2 " width="25%">${bean.companyLinkman}</td>
		</tr>
	</table>
	</div>
	<div></div>
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
	 <input type="button" 	class="icon_2" value='<fmt:message key="go_back"/>'	onClick="javascript:cancel_onClick()" /></div>
	</form>
</fmt:bundle>
</body>
</html>
