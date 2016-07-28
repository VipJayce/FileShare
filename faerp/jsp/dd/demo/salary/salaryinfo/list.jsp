<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%
	String condition = (String) request.getAttribute("condition");
	if(condition==null) {
		condition = "";
	}
%>
<link href="<venus:base/>/css/dd/gap-edittable-css.jsp" type="text/css" rel="stylesheet" charset='UTF-8'>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdddemo/interface/SalaryInfoService.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<title>列表模板</title>
<script>
	var detailView ='<%=request.getParameter("detailView")%>';
	var tableView ='<%=request.getParameter("tableView")%>';
	var queryView ='<%=request.getParameter("queryView")%>';
	var toolView ='<%=request.getParameter("toolView")%>';
	var moduleName ='<%=request.getParameter("moduleName")%>';
	//定义翻页行为
	PageVoJs.prototype.action = getActionMap;
	//创建翻页对象
	var pageVo  = new PageVoJs();
	//设置默认排序方式
	pageVo.setOrderStr("");
	//pageVo.setPageSize(15);
	
	var actionType = "default";
	function getActionMap(){
		if(actionType == "default"){
			query_data('<%=request.getParameter("tableView")%>',"");
		}else{
			getQueryCondition();
		}
	}
	
	function queryAll(){
		pageVo.initAction();
	}
	
	function query_onClick(){
		actionType = "query";
		pageVo.initAction();
	}
	
	function reset_onClick(){
		jQuery("#ccChild0").clearForm();
	}
	
	function getQueryCondition(){
		SalaryInfoService.getViewVo($("query_code").value,function(data){
		//alert(dwr.util.toDescriptiveString(data, 4));
		var fields=null;
		if(null!=data) fields = data.fields;
		
		    var condition ="";
			if(null!=fields&&fields.length>0){
				for( var i=0;i<fields.length;i++){
					var fieldVo = fields[i];
					//不考虑未启用的字段
					if (fieldVo.status=="0"){
						continue;
					}
					//不考虑不显示的字段
					if (fieldVo.display=="0"){
						continue;
					}	
					if (fieldVo.columnName!=""&&null!=$(fieldVo.name)) {//非虚拟字段
						var value;
						if(fieldVo.displayType==9)
						{
						//alert(dwr.util.toDescriptiveString(document.getElementsByName(fieldVo.name),4))
							value = getRadioValue(document.getElementsByName(fieldVo.name));
						}
						else
						{
							value = $name(fieldVo.name).value;
						}
						if(value!=null && trim(value)!=""&&trim(value)!='null' && fieldVo.displayType != 12 && fieldVo.displayType != 13) {
							condition += " and "+fieldVo.columnName+" like '%"+value+"%' ";
						}
						if(fieldVo.displayType == 12 || fieldVo.displayType == 13){
								var value1 = document.getElementById("id" + fieldVo.id + "_1").value;
								var value2 = document.getElementById("id" + fieldVo.id + "_2").value;
								if(value1 != "" && value2 != ""){
									condition += " and " + fieldVo.columnName + " >= '" + value1 +"'";
									condition += " and " + fieldVo.columnName + " <= '" + value2 +"'";
								}else if(value1 != ""){
									condition += " and " + fieldVo.columnName + " < '"+ value1 +"'";
								}else if(value2 != ""){
									condition += " and " + fieldVo.columnName + " > '" + value2 +"'";
								}
							}
					}
				}
				query_data('<%=request.getParameter("tableView")%>',condition);
				}
		});
	}
	
	function trim (str)
	{
	    return str.replace(/(^\s*)|(\s*$)/g, '');
	}
	
	function query_data(code,condition){
	   var isCheckable = false;
	   if(document.getElementById("isCheckable") != null && document.getElementById("isCheckable").value == 1){isCheckable=true;}
		SalaryInfoService.query(code,condition,isCheckable,document.getElementById("dispStyle").value ,pageVo.getOrderSortStr(),pageVo,function(data){getMapResult(data,code)});
	}
	
	function calculate(){
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("请选择一条记录!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("只能选择一条记录!")
	  		return;
		}
		form.action = "<venus:base/>/SalaryInfoAction.do?cmd=calculate&ids=" + ids + "&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
		form.submit();
	}
	
	function audit(){
				var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("请选择一条记录!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("只能选择一条记录!")
	  		return;
		}
		form.action = "<venus:base/>/SalaryInfoAction.do?cmd=audit&ids=" + ids + "&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
		form.submit();
	}


	function toModify_onClick() { 
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("请选择一条记录!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("只能选择一条记录!")
	  		return;
		}
		form.action="<%=request.getContextPath()%>/SalaryInfoAction.do?cmd=find4update&id=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
		form.submit();
	}
	function toDelete_onClick(){  
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert("请选择记录!")
			return;
		}
		if(confirm("是否彻底删除该数据？")) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/SalaryInfoAction.do?cmd=delete&ids=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
	    	form.submit();
		}
	}

	function toAdd_onClick() {  //到增加记录页面
		window.location="<venus:base/>/jsp/dd/demo/salary/salaryinfo/edit.jsp?moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
	}
	function toRefresh_onClick(){  //刷新本页
		query_onClick();
	}
	
	function toZoom_onClick(){  //查看数据
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("请选择一条记录!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("只能选择一条记录!")
	  		return;
		}
    	form.action="<%=request.getContextPath()%>/SalaryInfoAction.do?cmd=find4zoom&id=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
    	form.submit();
	}
	
	function isNumber(str){
			//如果为空，则通过校验
	    if(str == "")
	        return true;
	    if(/^(-?)(d+)$/.test(str))
	        return true;
	    else
	        return false;
	}
	
	function isDouble(str){
		//如果为空，则通过校验
	    if(str == "")
	        return true;
	    //如果是整数，则校验整数的有效性
	    if(str.indexOf(".") == -1)
	    {
	        if(checkIsInteger(str) == true)
	            return true;
	        else
	            return false;
	    }
	    else
	    {
	        if(/^(-?)(d+)(.{1})(d+)$/g.test(str))
	            return true;
	        else
	            return false;
	    }
	}
	function isAmt(str){
		return true;
	}
	//实现排序行为。这里为ajax方式，也可以使用action提交的方式。
	function sortOrder(obj,orderStr)
	{
			pageVo.sortOrder(obj,orderStr);
	}

</script>
</head>
<body onload="queryAll();">
<script language="javascript">
	writeTableTop(moduleName,'<venus:base/>/');
</script>

<form name="form" method="post" action="">
	<input type="hidden" name="query_code" value='<%=request.getParameter("queryView")%>' />
	<input type="hidden" name="table_code" value='<%=request.getParameter("tableView")%>' />
<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			按条件查询
		</td>
		<td>
		<table align="right">
		<input type="button" name="Submit" class="button_ellipse" value="查询" onClick="javascript:query_onClick();">
		<input type="button" name="Reset" class="button_ellipse" value="清空" onClick="javascript:reset_onClick();">
		</table>
		</td>
	</tr>
</table>
</div>
<div id="ccChild0"> 
	<dd:queryView code='<%=request.getParameter("queryView")%>'/>
</div>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;明细表格
		</td>
		<td><dd:toolBarView code='<%=request.getParameter("toolView")%>'/></td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<dd:tableView code='<%=request.getParameter("tableView")%>' pageable='true' checkable='true' dispStyle='0'/>
</div>
<div id='dialogPanel'>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>
