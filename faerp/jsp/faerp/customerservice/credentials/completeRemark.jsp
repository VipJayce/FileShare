<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%
String id = request.getAttribute("id").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title><fmt:message key="nocomplete_remark" /></title>
<script language="javascript">
    function save_onClick(){
        var remark = document.getElementById('complete_remark').innerHTML;
        if(remark == null || remark == '' ){
            alert('<fmt:message key="push_remark" />');
            return;
        }
        var returnAry = new Array();
        returnAry[0] = document.getElementById('id').value;
        returnAry[1] = document.getElementById('complete_remark').innerHTML;
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
            <td class="td_1" width="15%"><fmt:message key="remark" /></td>
            <td class="td_2" width="85%">
                <textarea class="textarea_limit_words" cols="60" rows="5" id="complete_remark" name="complete_remark" inputName="备注" maxLength="1000"></textarea>
                <input type="hidden" id="id" name="id" value="<%=id %>"/>
              </td>
        </tr>
    </table>
</div>
 <div class="mx_button" align="center">
    <input type="button" class="icon_2" value='<fmt:message key="save" />' onClick="javascript:save_onClick();"/>
 </div>
 </form>
</fmt:bundle>
</body>
</html>