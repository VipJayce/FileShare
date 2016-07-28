<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="rayoo.certificate.cardType.vo.CardTypeVO"%>
<html>
<fmt:bundle basename="rayoo.customerservice.credentialstype.credentialstype_resource" prefix="rayoo.customerservice.credentialstype.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
  <title>
  <fmt:message key="credentialsType"/>
  </title>
  <script language="javascript"><!--
  jQuery(document).ready(function(){
  if(jQuery("#edit_id").val()!=null&&jQuery("#edit_id").val()!=""&&jQuery("#mark").val()=="true")
  {
    jQuery("#credentialsTypeBd").prop("disabled",true);
  }
  if(jQuery("#credentialsTypeBd").val()=="0001"&&jQuery("#mark").val()=="true")
  {
    jQuery("#workInjuredCode").prop("readonly",true);
  }
  });
  function workInjuredLink()
  {
    if(jQuery("#credentialsTypeBd").val()=="0001")
    {
        jQuery("#workInjuredCode").prop("readonly",false);
    }
    else
    {
        jQuery("#workInjuredCode").prop("readonly",true);
        jQuery("#workInjuredCode").val("");
    }
  }
    //校验
    function vailform(){
        var credentialsTypeBd=document.getElementById("credentialsTypeBd").value;
          if(credentialsTypeBd==null || credentialsTypeBd==""){
	          alert("请选择大类");
	          return false;
	        }
        var credentialsName=document.getElementById("credentialsName").value;
        if(credentialsName==null || credentialsName==""){
              alert("请输入小类");
              return false;
            }
        return true;
    }
    
    //保存
    function save_onClick(){  //保存
        var url;
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                url="<%=request.getContextPath()%>/CardTypeAction.do?cmd=updateCardType";
            }else{
               url="<%=request.getContextPath()%>/CardTypeAction.do?cmd=insertCardType";
          }
          if(jQuery("#edit_id").val()!=null&&jQuery("#edit_id").val()!=""&&jQuery("#mark").val()=="true")
			  {
			     jQuery("#credentialsTypeBd").prop("disabled",false);
			  }
          jQuery.ajax({
                           url: '<%=request.getContextPath()%>/CardTypeAction.do?cmd=vailData&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize()),true),
                           type: 'POST',
                           dataType: 'html',
                           async: false,
                           timeout: 10000,
                                success: function(data){
                                    if(data=='true'){
                                         jQuery.ajax({
						                           url:url,
						                           type: 'POST',
						                           dataType: 'html',
						                           data:encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true)),
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
                                   else
                                   {
                                     alert("该类证件定义已存在");
                                   }
                               }
                           });     
       }
    }
    
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
    
    //删除服务手续项
    function delete_materia_row(){
        $id("datacell2").deleteRow();
    }
    
--></script>
  </head>
  <body>
  <form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="statusCellValues" id="statusCellValues">
    <input type="hidden" name="materiaCellValues" id="materiaCellValues">
    <input type="hidden" id="mark" value="${bean.mark}"/>
    <div id="right" style="height: 140px;">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='credentialsTypeDef'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_x" style="height: 150px;">
    <div id="ccChild1"     class="box_xinzeng" style="height: 150px;">
      <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
	          <td class="td_1"  width="25%"><fmt:message key='credentials_type_bd'/></td>
	          <td class="td_2 " width="25%"><%
	          rayoo.certificate.cardType.vo.CardTypeVO beanVo = (rayoo.certificate.cardType.vo.CardTypeVO)request.getAttribute("bean");
	                 String credentials_type_bd = "";
	                 if (beanVo != null){
	                     credentials_type_bd = String.valueOf(beanVo.getCredentialsTypeBd());
	                 }
	                 else
	                 {
	                     beanVo=new CardTypeVO();
	                 }
	                 %>
	            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("credentialsTypeBd", -1, "MATERIALS_DEFINE", credentials_type_bd, "id='credentialsTypeBd' onchange='workInjuredLink();'", false) %> </td>
	          <td class="td_1"  width="25%"><fmt:message key='credentials_name'/></td>
	          <td class="td_2 " width="25%">
	          <c:if test="${bean!=null&&bean.mark=='true'}">
	          <input type="text" class="text_field" name="credentialsName" maxLength="50" id="credentialsName" value="${bean.credentialsName}" readonly="readonly"/>
	          </c:if>
	          <c:if test="${bean==null||bean.mark=='false'}">
              <input type="text" class="text_field" name="credentialsName" maxLength="50" id="credentialsName" value="${bean.credentialsName}" />
              </c:if>
	          </td> 
	          </tr>
	          <tr>
	          <td class="td_1"  width="25%"><fmt:message key='continue'/></td>
              <td class="td_2 " width="25%"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("isContinue", -1, "TrueOrFalse", beanVo.getIsContinue(), "id='isContinue'", true) %></td> 
               <td class="td_1"  width="25%"><fmt:message key='workInjuredCode'/></td>
              <td class="td_2 " width="25%"> 
                <input type="text" class="text_field" name="workInjuredCode" maxLength="50" id="workInjuredCode" value="${bean.workInjuredCode}"/>
             </tr>
      </table>
    </div>
    <div>
    
    </div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
      <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:save_onClick()" />
      <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>
  </form>
</fmt:bundle>
</body>
</html>
