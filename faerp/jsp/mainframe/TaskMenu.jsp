<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.wf.adaptor.login.LoginControllerAdaptor" %>
<%@ page import="venus.frames.mainframe.util.Helper" %>
<%@ page import="java.net.URLEncoder" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=request.getContextPath()%>/js/common/TaskMenu.js"></script>
<script>
<!--
TaskMenu.setStyle("<%=request.getContextPath()%>/css/Blue/blueStyle.css"); 

window.onload = function()
{
	TaskMenu.setHeadMenuSpecial(true);
	//TaskMenu.setScrollbarEnabled(true);
	//TaskMenu.setAutoBehavior(false);

	//System Helper
	var taskMenu0 = new TaskMenu("System Helper");
//	item01 = new TaskMenuItem("菜单配置","<%=request.getContextPath()%>/images/alexmainframe/demo.gif","parent.window.frames[1].location.href='TaskMenu_Demo.jsp'");
	item02 = new TaskMenuItem("流程定义参考文档","<%=request.getContextPath()%>/images/alexmainframe/copy.gif","parent.window.frames[1].location.href='<%=request.getContextPath()%>/helper/defineFlow.ppt'");
	item03 = new TaskMenuItem("WorkFlow API","<%=request.getContextPath()%>/images/alexmainframe/copy.gif","parent.window.frames[1].location.href='<%=request.getContextPath()%>/helper/wapiDoc.rar'");
//	taskMenu0.add(item01);
	taskMenu0.add(item02);
	taskMenu0.add(item03);
//	taskMenu0.setBackground("<%=request.getContextPath()%>/images/alexmainframe/bg.gif");
	taskMenu0.init();
	taskMenu0._close();

	//流程运行
	var taskMenu2 = new TaskMenu("流程运行");
	item21 = new TaskMenuItem("发起流程","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/definesQuery.do?published=true'");
	item22 = new TaskMenuItem("督办监控","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryProcessInstanceAction.do?registerRelevantData=monitorQuery'");
	item23 = new TaskMenuItem("查询我的待办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false'");
	item24 = new TaskMenuItem("查询我的已办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true'");
//	item25 = new TaskMenuItem("查询我的中冶待办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
//		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?procName=<%=URLEncoder.encode("中冶","GBK")%>'");
//	item26 = new TaskMenuItem("查询我的中冶已办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
//		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?procName=<%=URLEncoder.encode("中冶","GBK")%>&done=true'");
	item27 = new TaskMenuItem("查询我的最终已办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?groupByInstMax=true&done=true'");
	item28 = new TaskMenuItem("动态查询我的待办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?procName=<%=URLEncoder.encode("相关数据查询","GBK")%>&registerRelevantData=relDataQuery'");
	item29 = new TaskMenuItem("动态查询我的已办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?procName=<%=URLEncoder.encode("相关数据查询","GBK")%>&done=true&registerRelevantData=relDataQuery'");
	item2a = new TaskMenuItem("动态查询我的最终已办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?procName=<%=URLEncoder.encode("相关数据查询","GBK")%>&groupByInstMax=true&done=true&registerRelevantData=relDataQuery'");
	item2b = new TaskMenuItem("查询我的超时待办任务","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/queryOverTimeTaskByPersonIDAction.do'");
	item2c = new TaskMenuItem("流程清理","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/workflow/procmanagement/proclearmanager.jsp'");
	taskMenu2.add(item21);
	taskMenu2.add(item22);
	taskMenu2.add(item23);
	taskMenu2.add(item24);
//	taskMenu2.add(item25);
//	taskMenu2.add(item26);
	taskMenu2.add(item27);
	taskMenu2.add(item28);
	taskMenu2.add(item29);
	taskMenu2.add(item2a);
	taskMenu2.add(item2b);
	taskMenu2.add(item2c);
	taskMenu2.init();
	
	//流程设计
	var taskMenu3 = new TaskMenu("流程设计");
	item31 = new TaskMenuItem("管理流程","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/definesQuery.do'");
	taskMenu3.add(item31);
	item32 = new TaskMenuItem("工作日历","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/workCalendarDefineAction.do'");
	taskMenu3.add(item32);
	taskMenu3.init();

	//表单设计
	var taskMenu4 = new TaskMenu("表单设计");
	item41 = new TaskMenuItem("管理表单","<%=request.getContextPath()%>/images/alexmainframe/api.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/formDesignList.do'");
	taskMenu4.add(item41);
	taskMenu4.init();

	//About
	var taskMenu5 = new TaskMenu("About");
	item51 = new TaskMenuItem("<B>Nucleus.Alexander WfMS</B>");
	item52 = new TaskMenuItem();
	item52.setLabel("当前版本 <b style='color:purple'>V2.5</b>");
	item53 = new TaskMenuItem("<center><B>"+"<%
		try{
			String loginInfo = 
				((LoginControllerAdaptor) Helper.getBean(LoginControllerAdaptor.ImplBeanName)).getOperID(request)
				+"<br>"+
				((LoginControllerAdaptor) Helper.getBean(LoginControllerAdaptor.ImplBeanName)).getOperName(request);
			out.print(loginInfo);
		}
		catch(Exception e){
			out.print("未登录");
		}
		%>"+"</B></center>");
	item54 = new TaskMenuItem("首页/登录","<%=request.getContextPath()%>/images/alexmainframe/demo.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/gapwf.jsp'");
	item55 = new TaskMenuItem("刷新登录","<%=request.getContextPath()%>/images/alexmainframe/demo.gif","location.reload()");
	taskMenu5.add(item51);
	taskMenu5.add(item52);
	taskMenu5.add(item53);
	taskMenu5.add(item54);
	taskMenu5.add(item55);
	taskMenu5.init();
	//Menu set over//
}
//-->
</script>
</head>
</html>