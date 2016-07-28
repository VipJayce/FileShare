<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLEncoder" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=request.getContextPath()%>/js/common/TaskMenu.js"></script>
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
	//TaskMenu.setScrollbarEnabled(true);
	//TaskMenu.setAutoBehavior(false);
	
	///////////////////////////////////////////
	taskMenu2 = new TaskMenu("报表查询示例");
	//sample: xxxx.do?pstate=add&WF_SECTION=<%=URLEncoder.encode("行政类流程","GBK")%>&WF_PACKAGE=YourName
	item21 = new TaskMenuItem("报表查询示例a","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/ReportAction.do?cmd=queryReporta'");
	item22 = new TaskMenuItem("报表查询示例b","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/ReportAction.do?cmd=queryReportb'");		
	taskMenu2.add(item21);
	taskMenu2.add(item22);
	taskMenu2.init();


	////////////////////////////////////////
	taskMenu3 = new TaskMenu("报表模版示例");
	//sample: xxxx.do?pstate=add&WF_SECTION=<%=URLEncoder.encode("行政类流程","GBK")%>&WF_PACKAGE=YourName
	item31 = new TaskMenuItem("分组报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Grouping/CustomerListAfter.rptdesign'");
	item32 = new TaskMenuItem("图文混排报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Combination%20Chart/CustomerOrdersFinal.rptdesign'");		
	item33 = new TaskMenuItem("主从报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Sub%20Report/OrdersAfter.rptdesign'");		
	item34 = new TaskMenuItem("平行报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Parallel%20Report/EmployeeAfter.rptdesign'");		
	item35 = new TaskMenuItem("报表元素示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Report%20Elements/ProductLinesAfter.rptdesign'");		
	item36 = new TaskMenuItem("套打报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Gird%20Print/GirdPrint_report.rptdesign'");		
	item37 = new TaskMenuItem("向下钻取报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Drill%20to%20Details/OrderMasterAfter.rptdesign'");		
	item38 = new TaskMenuItem("动态查询报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Query%20Modification/OrderDetailsAfter.rptdesign'");		
	item39 = new TaskMenuItem("级联参数报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Cascaded%20Parameter%20Report/cascade.rptdesign'");		
	item310 = new TaskMenuItem("条件高亮报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Highlighting%20and%20Conditional%20Formatting/ProductListAfter.rptdesign'");		
	item311 = new TaskMenuItem("映射伪列及排序报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Mapping%20and%20Sorting/CustomerListAfteSorting.rptdesign'");		
	item312 = new TaskMenuItem("XML数据源报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/XML%20Data%20Source/XMLDS_After.rptdesign'");		
	item313 = new TaskMenuItem("脚本数据源报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/Scripted%20Data%20Source/ScriptedDatasourceExampleAfter.rptdesign'");		
	item314 = new TaskMenuItem("交叉报表示例","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/frameset?__report=WEB-INF/reports/CrossTab/CrossTab.rptdesign'");		
	taskMenu3.add(item31);
	taskMenu3.add(item32);
	taskMenu3.add(item33);
	taskMenu3.add(item34);
	taskMenu3.add(item35);
	taskMenu3.add(item36);
	taskMenu3.add(item37);
	taskMenu3.add(item38);
	taskMenu3.add(item39);
	taskMenu3.add(item310);
	taskMenu3.add(item311);
	taskMenu3.add(item312);
	taskMenu3.add(item313);
	taskMenu3.add(item314);
	taskMenu3.init();
	taskMenu3._close();
		
 	///////////////////////////////////////////
	taskMenu4 = new TaskMenu("报表解决方案");	
	item41 = new TaskMenuItem("基于ExcelUtils","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/report/xls/excelUtilsDemo.jsp'");
	item42 = new TaskMenuItem("基于JXLS","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/report/xls/jxlsDemo.jsp'");
	taskMenu4.add(item41);
	taskMenu4.add(item42);
	taskMenu4.init();

 	///////////////////////////////////////////
	taskMenu5 = new TaskMenu("报表文件管理");	
	item51 = new TaskMenuItem("报表文件管理","<%=request.getContextPath()%>/images/report/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/report/filemanage/listReportFile.jsp'");
	taskMenu5.add(item51);
	taskMenu5.init();
	//Menu set over//
}
</script>
</head>
</html>