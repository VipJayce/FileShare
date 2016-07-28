<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=request.getContextPath()%>/js/common/TaskMenu.js"></script>
<link href="<venus:base/>/css/alex-css.jsp" type="text/css" rel="stylesheet" charset='UTF-8'>
<script>
var taskMenu2;

TaskMenu.setStyle("<%=request.getContextPath()%>/css/Blue/blueStyle.css"); 

window.onload = function()
{
	TaskMenu.setHeadMenuSpecial(true);
	//TaskMenu.setScrollbarEnabled(true);
	//TaskMenu.setAutoBehavior(false);
	
	///////////////////////////////////////////
	taskMenu2 = new TaskMenu("预警平台");
	item21 = new TaskMenuItem("预警对象管理","<%=request.getContextPath()%>/images/icon/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/WarningObjectAction.do?cmd=queryAllWarningObjects'");
	item22 = new TaskMenuItem("预警模板管理","<%=request.getContextPath()%>/images/icon/button_fc1.gif",
        "parent.window.frames[1].location.href='<%=request.getContextPath()%>/WarningTemplateAction.do?cmd=queryAllWarningTemplates'");
        item23 = new TaskMenuItem("即时预警实例管理","<%=request.getContextPath()%>/images/icon/button_fc1.gif",
        "parent.window.frames[1].location.href='<%=request.getContextPath()%>/WarningInstanceEventTriggerAction.do?cmd=queryAll'");
    item24 = new TaskMenuItem("定时预警实例管理","<%=request.getContextPath()%>/images/icon/button_fc1.gif",
        "parent.window.frames[1].location.href='<%=request.getContextPath()%>/WarningInstanceTimeTriggerAction.do?cmd=queryAll'");
       item26 = new TaskMenuItem("预警信息管理","<%=request.getContextPath()%>/images/icon/button_fc1.gif",
        "parent.window.frames[1].location.href='<%=request.getContextPath()%>//WarningInfoAction.do?cmd=queryAllWarningInfos'");   
    
	taskMenu2.add(item21);
	taskMenu2.add(item22);
	taskMenu2.add(item23);
    taskMenu2.add(item24);
    taskMenu2.add(item26);
	taskMenu2.init();


	//Menu set over//
}
</script>
</head>
</html>
</fmt:bundle>