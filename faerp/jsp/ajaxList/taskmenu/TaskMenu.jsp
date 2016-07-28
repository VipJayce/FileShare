<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLEncoder" %>

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
	//TaskMenu.setScrollbarEnabled(true);
	//TaskMenu.setAutoBehavior(false);
	
	///////////////////////////////////////////
	taskMenu2 = new TaskMenu("Html组件");
	item21 = new TaskMenuItem("表单限制输入","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/validate.jsp'");
	item22 = new TaskMenuItem("双列表选取","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/doublemultipleselect.jsp'");
	item23 = new TaskMenuItem("下拉选择框多选","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/multipleselect.jsp'");
	item24 = new TaskMenuItem("单选框,复选框取值","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/getValueFromRadioOrCheckbox.jsp'");
	item25 = new TaskMenuItem("录入帮助","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/googlesuggest.jsp'");		
	item26 = new TaskMenuItem("级联菜单","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/cascademenu.jsp'");
	item27 = new TaskMenuItem("Tab控件","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/tabManagement.jsp'");
	taskMenu2.add(item21);
	taskMenu2.add(item22);
	taskMenu2.add(item23);
	taskMenu2.add(item24);
	taskMenu2.add(item25);
	taskMenu2.add(item26);
	taskMenu2.add(item27);
	taskMenu2.init();


	////////////////////////////////////////
	taskMenu3 = new TaskMenu("单表组件");
	
	//item31= new TaskMenuItem("Table控件","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
	//	"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/flexigrid.jsp'");
	item32 = new TaskMenuItem("单表显示","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/singletable/IntegratedMode/formsubmit.jsp'");
	item33 = new TaskMenuItem("单表表格动态编辑","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/singletable/IntegratedMode/singletable.jsp'");	
	item34 = new TaskMenuItem("单表排序分页","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/singletable/IntegratedMode/newtable.jsp'");
	item35 = new TaskMenuItem("单表页面动态编辑表","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/singletable/IndependentMode/index.jsp'");
	item36 = new TaskMenuItem("Ext表格控件","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/ext/list.jsp'");
		
	//taskMenu3.add(item31);
	taskMenu3.add(item32);
	taskMenu3.add(item33);
	taskMenu3.add(item34);
	taskMenu3.add(item35);
	taskMenu3.add(item36);
	taskMenu3.init();
	taskMenu3._close();

 	///////////////////////////////////////////
	taskMenu4 = new TaskMenu("主子表组件");	
	item41 = new TaskMenuItem("事务分别提交","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/SingleSubmitAction.do?cmd=queryAllOrders'");
	item42 = new TaskMenuItem("事务统一提交","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/masterdetailtable/unfiedSubmit/masterlist.jsp'");
	taskMenu4.add(item41);
	taskMenu4.add(item42);
	taskMenu4.init();
	taskMenu4._close();
	
	 	///////////////////////////////////////////
	taskMenu5 = new TaskMenu("树型组件");	
	item51 = new TaskMenuItem("动态树显示","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/tree.jsp'");
	item52 = new TaskMenuItem("动态树编辑-数据源是DB","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/tree/dynamictreeFormDB.jsp'");
	item53 = new TaskMenuItem("动态树编辑-数据源是XML","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/tree/dynamictreeFormXML.jsp'");
	item54 = new TaskMenuItem("可以拖拉的树型结构","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/dragAndDropOfTree.jsp'");
	item55 = new TaskMenuItem("可以多选的树型结构","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/multipleselecttree.jsp'");
	taskMenu5.add(item51);
	taskMenu5.add(item52);
	taskMenu5.add(item53);
	taskMenu5.add(item54);
	taskMenu5.add(item55);
	taskMenu5.init();
	taskMenu5._close();
	
	taskMenu6 = new TaskMenu("其他功能");	
	item61 = new TaskMenuItem("提示框","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/alertbox.jsp'");
	item62 = new TaskMenuItem("确认框","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/confirmbox.jsp'");
	item63 = new TaskMenuItem("对话输入框","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/promptbox.jsp'");
	item64 = new TaskMenuItem("参照页面","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/reference.jsp'");
	item610 = new TaskMenuItem("Portlets控件","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/portlets.jsp'");
	item65 = new TaskMenuItem("层的收放动画效果","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/jquery/slideUpOrDownDiv.jsp'");
	item66 = new TaskMenuItem("后台数据校验","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/validate.jsp'");
	item67 = new TaskMenuItem("局部刷新","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/localrefresh.jsp'");	
	item68 = new TaskMenuItem("反向更新","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/reverseajax.jsp'");	
	item69 = new TaskMenuItem("延迟加载","<%=request.getContextPath()%>/images/ajaxList/button_fc1.gif",
		"parent.window.frames[1].location.href='<%=request.getContextPath()%>/jsp/ajaxList/loaddelay.jsp'");
	taskMenu6.add(item61);
	taskMenu6.add(item62);
	taskMenu6.add(item63);
	taskMenu6.add(item64);
	taskMenu6.add(item610);
	taskMenu6.add(item65);
	taskMenu6.add(item66);
	taskMenu6.add(item67);
	taskMenu6.add(item68);
	taskMenu6.add(item69);
	taskMenu6.init();
	taskMenu6._close();
	//Menu set over//
}
</script>
</head>
</html>