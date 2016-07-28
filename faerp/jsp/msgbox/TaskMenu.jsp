<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<logic:notEmpty  name="local_in_sesson_key" scope="session">
    <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
</logic:notEmpty>
<fmt:setBundle basename="ApplicationResources" scope="application" var="applicationResources"/>
<fmt:setBundle basename="gap.message.message_resource" scope="application" var="applicationMessageResources"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=request.getContextPath()%>/js/common/TaskMenu.js"></script>
<link href="<venus:base/>/css/alex-css.jsp" type="text/css" rel="stylesheet" charset='UTF-8'>
<script>
var taskMenu1;
var taskMenu2;

var item1;
var item2;
var item3;
var item4;
var item5;
var item6;
var item7;
var item8;
TaskMenu.setStyle("<%=request.getContextPath()%>/css/Blue/blueStyle.css"); 

window.onload = function()
{
	TaskMenu.setHeadMenuSpecial(true);
	
	///////////////////////////////////////////
	taskMenu2 = new TaskMenu("<fmt:message key='gap.message.Station_messaging' bundle='${applicationMessageResources}' />");
	item21 = new TaskMenuItem("<fmt:message key='gap.message.Inbox' bundle='${applicationMessageResources}' />","<%=request.getContextPath()%>/images/icon/send.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/MessageAction.do?cmd=receivebox'");
	item22 = new TaskMenuItem("<fmt:message key='gap.message.Outbox' bundle='${applicationMessageResources}' />","<%=request.getContextPath()%>/images/icon/send.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/MessageAction.do?cmd=sendbox'");		
	item23 = new TaskMenuItem("<fmt:message key='gap.message.Text_messaging' bundle='${applicationMessageResources}' />","<%=request.getContextPath()%>/images/icon/send.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/msgbox/inbound/content.jsp'");		
	item24 = new TaskMenuItem("<fmt:message key='gap.message.SMS_Management' bundle='${applicationMessageResources}' />","<%=request.getContextPath()%>/images/icon/send.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/MessageAction.do?cmd=managebox'");		
	item25 = new TaskMenuItem("<fmt:message key='gap.message.Receive_new_messages' bundle='${applicationMessageResources}' />","<%=request.getContextPath()%>/images/icon/send.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/MessageAction.do?cmd=receivenew'");		
	item26 = new TaskMenuItem("<fmt:message key='gap.message.User_configuration_items' bundle='${applicationMessageResources}' />","<%=request.getContextPath()%>/images/icon/send.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/msgbox/manage/managePara.jsp'");	
	taskMenu2.add(item21);
	taskMenu2.add(item22);
	taskMenu2.add(item23);
	taskMenu2.add(item24);
	taskMenu2.add(item25);
	taskMenu2.add(item26);
	taskMenu2.init();

	//Menu set over//
}
</script>
</head>
</html>

