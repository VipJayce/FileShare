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
<html>
<fmt:bundle
    basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh"
    prefix="rayoo.certificate.certificateTransaction.">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <title><fmt:message key="outworkerReg" /></title>
    <script language="javascript"><!--
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
        writeTableTopFesco("<fmt:message key='outworkerReg'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
    session = request.getSession(false);
    String name = LoginHelper.getLoginName(request);//获得用户姓名
     rayoo.certificate.certificateTransaction.vo.OutRegVo beanVo = (rayoo.certificate.certificateTransaction.vo.OutRegVo ) request.getAttribute("bean");
     java.text.DateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
 %>
    <div class="ringht_x" style="height: 150px;">
    <div id="ccChild1" class="box_xinzeng" style="height: 150px;">
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="30%"><fmt:message key='outworker' /></td>
            <td class="td_2 " colspan="70">
                <%=beanVo.getOutworkerName()%>
            </td>
        </tr>
        <tr>
             <td class="td_1" width="30%"><fmt:message key='outTimeRange' /></td>
          <td class="td_2 " colspan="70">
            <%=sdf.format(beanVo.getCreateDateFrom())%>&nbsp;&nbsp;至&nbsp;&nbsp;<%=sdf.format(beanVo.getCreateDateTo())%>
          </td>
        </tr>
        <tr>
             <td class="td_1" width="30%">
             </td>
           <td class="td_2 " colspan="70">
                    
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
