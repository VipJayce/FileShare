<%@ page contentType="text/html; charset=UTF-8" %>
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
	
	taskMenu1 = new TaskMenu("元数据管理");
	item11 = new TaskMenuItem("表管理","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/MetadataAction.do?cmd=queryTables'");
	item12 = new TaskMenuItem("表间关系管理","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/MetadataAction.do?cmd=queryRelation'");
	item13 = new TaskMenuItem("元数据导入","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/datatrans/tables_list.jsp'");
	item14 = new TaskMenuItem("数据导出","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/datatrans/export.jsp'");
		
	taskMenu1.add(item11);
	taskMenu1.add(item12);
	taskMenu1.add(item13);
	taskMenu1.add(item14);
	taskMenu1.init();

	taskMenu2 = new TaskMenu("基础数据管理");
	item21 = new TaskMenuItem("基础数据管理","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/basedata/baseDataTypeList.jsp'");
	taskMenu2.add(item21);
	taskMenu2.init();
	
	taskMenu3 = new TaskMenu("控制数据管理");
	item31 = new TaskMenuItem("界面视图管理","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/controldata/viewList.jsp'");
	item32 = new TaskMenuItem("动态功能管理","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/controldata/moduleList.jsp'");
	item33 = new TaskMenuItem("自定义查询管理","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/controldata/queryModuleList.jsp'");
	item34 = new TaskMenuItem("动态功能菜单","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/controldata/menuFrame.jsp'");
	taskMenu3.add(item31);
	taskMenu3.add(item32);
	taskMenu3.add(item33);
	taskMenu3.add(item34);
	taskMenu3.init();

	taskMenu4 = new TaskMenu("静态代码生成");
	item41 = new TaskMenuItem("代码生成管理","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/codegen/codegenMgr.jsp'");
	item42 = new TaskMenuItem("静态代码生成","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/codegen/codegen.jsp'");
	item43 = new TaskMenuItem("静态功能菜单","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/codegen/funcTree.jsp'");
	taskMenu4.add(item41);
	taskMenu4.add(item42);
	taskMenu4.add(item43);
	taskMenu4.init();
	
	taskMenu5 = new TaskMenu("案例库");
	item51 = new TaskMenuItem("案例菜单","<%=request.getContextPath()%>/images/dd/item.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/dd/scenario/common/funcTree.jsp'");
	taskMenu5.add(item51);
	taskMenu5.init();

	//Menu set over//
}
</script>
</head>
</html>