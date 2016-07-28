<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%
String mailSend =  request.getAttribute("mailSend").toString();
String mailText =  request.getAttribute("mailText").toString();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>签证办理发送邮件</title>
<script language="javascript">
   function send_onClick(){
        alert();
       var returnAry = new Array();
        returnAry[0] = document.getElementById('sendName').value;
        returnAry[1] = document.getElementById('mailSend').value;
        returnAry[2] = document.getElementById('mailText').innerHTML;
        window.returnValue=returnAry;
        window.close();
   }
</script>
</head>
<body>
<form name="form" method="post" action="<%=request.getContextPath()%>/CredentialsAction.do">
<input type="hidden" name="cmd" value="updateNoComplete">
 <input type="hidden" name="backFlag" id="backFlag" value="false">
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_1" width="15%"><fmt:message key="send_name" />：</td>
            <td class="td_2" width="85%">
                <input type="text" class="text_field" id="sendName" name="sendName" value="<%=mailSend %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" width="15%"><fmt:message key="e_mail" />：</td>
            <td class="td_2" width="85%">
                <input type="text" class="text_field" id="mailSend" name="mailSend" value="<%=mailSend %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" width="15%"><fmt:message key="e_mail_content" />：</td>
            <td class="td_2" width="85%">
                <textarea class="textarea_limit_words" cols="80" rows="5" id="mailText" name="mailText" inputName="邮件内容" maxLength="1000"><%=mailText %></textarea>                
              </td>
        </tr>
    </table>
</div>
 <div class="mx_button" align="center">
    <input type="button" class="icon_2" value='<fmt:message key="send" />' onClick="javascript:send_onClick();"/>
 </div>
 </form>
 </fmt:bundle>
</body>
</html>