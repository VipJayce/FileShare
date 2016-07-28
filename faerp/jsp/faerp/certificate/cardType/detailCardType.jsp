<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
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
  <script language="javascript">
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
</script>
  </head>
  <body>
  <form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="statusCellValues" id="statusCellValues">
    <input type="hidden" name="materiaCellValues" id="materiaCellValues">
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
                     %>
                <%=BaseDataHelper.getNameByCode("MATERIALS_DEFINE",credentials_type_bd)%>
              <td class="td_1"  width="25%"><fmt:message key='credentials_name'/></td>
              <td class="td_2 " width="25%">${bean.credentialsName}
              </td> 
          </tr>
          <tr>
              <td class="td_1"  width="25%"><fmt:message key='continue'/></td>
              <td class="td_2 " width="25%"><%=BaseDataHelper.getNameByCode("TrueOrFalse",beanVo.getIsContinue()) %></td>
               <td class="td_1"  width="25%"><fmt:message key='workInjuredCode'/></td>
              <td class="td_2 " width="25%">${bean.workInjuredCode}</td> 
       
          </tr>
      </table>
    </div>
    <div>
    
    </div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
      <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>
  </form>
</fmt:bundle>
</body>
</html>
