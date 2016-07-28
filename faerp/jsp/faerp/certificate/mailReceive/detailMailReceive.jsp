<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="rayoo.certificate.mailReceive.vo.MailReceiveVO"%>
<html>
<fmt:bundle basename="rayoo.certificate.mailReceive.mailReceive_resource_zh" prefix="rayoo.certificate.mailReceive.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
  <title>
  <fmt:message key="mailReceive"/>
  </title>
  <script language="javascript"><!--
    //保存
    function save_onClick(){  //保存
        var url;
            var  code = jQuery("#edit_id").val();
            if (code){
                url="<%=request.getContextPath()%>/MailReceiveAction.do?cmd=updateMailReceive";
            }else{
               url="<%=request.getContextPath()%>/MailReceiveAction.do?cmd=insertMailReceive";
          }
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
  <%
   MailReceiveVO beanVo = (MailReceiveVO)request.getAttribute("bean");
                     if (beanVo == null){
                         beanVo=new MailReceiveVO();
                     }
                     %>
  <form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="statusCellValues" id="statusCellValues">
    <input type="hidden" name="materiaCellValues" id="materiaCellValues">
    <div id="right" style="height: 140px;">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='mailReceive'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_x" style="height: 150px;">
    <div id="ccChild1"     class="box_xinzeng" style="height: 150px;">
      <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
	          <td class="td_1"  width="25%"><fmt:message key='type'/></td>
	          <td class="td_2 " width="45%">
	            <%=BaseDataHelper.getNameByCode("MAIL_RECEIVE_TYPE", beanVo.getType()) %> </td>
	          <td class="td_1"  width="15%"><fmt:message key='name'/></td>
	          <td class="td_2 " width="15%">
              ${bean.name}
	          </td> 
	          </tr>
	          <tr>
	          <td class="td_1"  width="25%"><fmt:message key='mail'/></td>
              <td class="td_2 "  colspan="3"> 
                ${bean.mail}
             </tr>
      </table>
    </div>
    <div>
    
    </div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
      <input type="button" class="icon_2" value='<fmt:message key="close"/>'  onClick="javascript:cancel_onClick()"/>
    </div>
  </form>
</fmt:bundle>
</body>
</html>
