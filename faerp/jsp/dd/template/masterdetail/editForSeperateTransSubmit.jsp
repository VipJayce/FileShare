<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd"%>
<%@ include file="/jsp/include/global.jsp"%>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<%@ page import="venus.pub.util.VoHelper"%>
<%@ page import="venus.frames.i18n.util.LocaleHolder"%>
<link href="<venus:base/>/css/tabbar/tabbar.css" type="text/css"
	rel="stylesheet">
<script type="text/javascript" src="<venus:base/>/css/tabbar/tabbar.js"></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwrdd/interface/MasterDetailTemplateAjax.js'></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<%@ include file="/jsp/dd/include/jquery.jsp" %>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-page.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<script type="text/javascript"
	src="<venus:base/>/js/dd/controldata/view.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
<%
    //判断是否为修改页面
    boolean isModify = false;
    if (request.getParameter("isModify") != null) {
		isModify = true;
    }
    String condition = (String) request.getAttribute("condition");
    if (condition == null) {
		condition = "";
    }
    String primary = (String) request.getAttribute("primary");
    if (primary == null) {
		primary = "";
    }
    String primary_value = (String) request
		    .getAttribute("primary_value");
    if (primary_value == null) {
		primary_value = "";
    }
%>
<title><%=isModify ? LocaleHolder.getMessage("gap.dd.common.modify_template") : LocaleHolder.getMessage("gap.dd.common.add_template")%></title>
<script>
	jQuery.noConflict();
	webPath='<%=request.getContextPath()%>';	
	var detailView ='<%=request.getParameter("detailView")%>';
	var tableView ='<%=request.getParameter("tableView")%>';
	var queryView ='<%=request.getParameter("queryView")%>';
	var moduleName ='<%=request.getParameter("moduleName")%>';
	var handleState='<%=isModify?"update":"insert"%>';
	var curTab;
	//定义翻页行为
	PageVoJs.prototype.action = getActionMap;
	//创建翻页对象
	var pageVo  = new PageVoJs();
	function getActionMap(){
		//loadDelay("<venus:base/>","viewBody");//更新表数据时延时等待图片显示
		var tableViewForDetail=curTab.substring(curTab.indexOf("#")+1);		
		query_data(tableViewForDetail);
	}
	function query_data(detailTableView){
		MasterDetailTemplateAjax.queryForSeperateTransSubmit(detailTableView,tableView,document.getElementById("primary_value").value,pageVo,function(data){getMapResult(data,detailTableView)});
	}
	function fillTable(data){
		var detailViewForDetail=curTab.substring(0,curTab.indexOf("#"));
		var tableViewForDetail=curTab.substring(curTab.indexOf("#")+1);		
		dataTable=document.getElementById(tableViewForDetail);
	    dataTable.outerHTML = data;
	} 
	function queryAll(){
		pageVo.initAction();
	}
	function submit_onClick(){  //主表编辑提交
		if(checkAllForms()){
			MasterDetailTemplateAjax.getViewVo(detailView,function(data){
					var fields=null;
					if(null!=data) fields = data.fields;
					var m={"sessionId":"<%=request.getSession().getId()%>","handleState":handleState,"detailView":detailView,"moduleName":moduleName}; 
					var detailMap={};
					detailMap["<%=primary%>"]=document.getElementById("primary_value").value;
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
										value = getRadioValue(document.getElementsByName(fieldVo.name));
									}
									else
									{
										value = document.getElementById(fieldVo.name).value;
									}
									if(value!=null && trim(value)!=""&&trim(value)!='null') {
										detailMap[fieldVo.name]=value;
										
									}
								}
							}
					}
					MasterDetailTemplateAjax.executeMasterForSingleSubmit(m,detailMap,function(data){
						//window.location.href="/web/jsp/dd/template/masterdetail/list.jsp?moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView;
						alert('<fmt:message key="template.mastertable_operation_success"></fmt:message>');
						handleState="update";
						document.getElementById("primary_value").value=data;
					});
				});
    	}
    }
	function trim (str)
	{
	    return str.replace(/(^\s*)|(\s*$)/g, '');
	}
	function findSelections(checkboxName, idName) {  //从子表列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				ids.push(elementCheckbox[i].value);  //加入选中的checkbox
			}
		}
		return ids;
	}
	function toAdd_onClick(){//跳转到子表新增页面
		if(document.getElementById("primary_value").value==""){
			alert('<fmt:message key="template.pls_input_mastertable_info"></fmt:message>');
			return;
		}
		var detail = getDetail();
		detail.sessionId =  "<%=request.getSession().getId()%>";
		detail.state = "insert";
		var detailDiv=document.getElementById("d"+curTab);
		var detailViewForDetail=curTab.substring(0,curTab.indexOf("#"));
		var tableViewForDetail=curTab.substring(curTab.indexOf("#")+1);
		detail.serial = jQuery('#'+tableViewForDetail+' table').find('tr').length;
		var obj = window.showModalDialog("<venus:base/>/jsp/dd/template/masterdetail/detaileditfromdatabase.jsp?masterIdKey="+document.getElementById("primary_value").value+"&handleSort=database&masterTableView="+tableView+"&detailView="+detailViewForDetail+"&tableView="+tableViewForDetail,[detail],'dialogHeight:350px;dialogWidth:450px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
		if(obj == null || obj == undefined ){
			return;
		}
		queryAll();
	}
	function toModify_onClick(){//跳转到子表修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="common.select_one_data"></fmt:message>')
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="common.only_select_one_data"></fmt:message>')
	  		return;
		}
		var detail = getDetail();
		detail.sessionId =  "<%=request.getSession().getId()%>";
		detail.state = "update";
		//获取选中行的序号
		var detailViewForDetail=curTab.substring(0,curTab.indexOf("#"));
		var tableViewForDetail=curTab.substring(curTab.indexOf("#")+1);		
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var tableElement=elementCheckbox[0].parentNode.parentNode.parentNode;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				var trElement = elementCheckbox[i].parentNode.parentNode;
				num = trElement.rowIndex;
				detail.serial = trElement.cells[1].innerText;
				break;
			}
		}
			MasterDetailTemplateAjax.find4updateFromDatabase(detailViewForDetail,ids[0],function(data){//moduleName
				var detail_primary=data.primary;
				var detail_primary_value=data.primary_value;
				var detail_condition=data.condition;
				var obj = window.showModalDialog("<venus:base/>/jsp/dd/template/masterdetail/detaileditfromdatabase.jsp?id="+ids+"&masterIdKey="+document.getElementById("primary_value").value+"&handleSort=database&masterTableView="+tableView+"&detailView="+detailViewForDetail+"&tableView="+tableViewForDetail+"&isModify=1&primary="+detail_primary+"&primary_value="+detail_primary_value+"&condition="+detail_condition,[detail],'dialogHeight:350px;dialogWidth:450px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
				//调用changeRow("productBody",cellObjects,num);方法给子表列表添加行数据。
				if(obj == null || obj == undefined ){
					return;
				}
				queryAll();
			});
	
	}
	function toDelete_onClick(){//删除子表数据
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="common.message_select_data"></fmt:message>')
			return;
		}
		if(confirm('<fmt:message key="whether_to_delete_the_data_completely"  bundle="${applicationResources}"></fmt:message>')) {  //如果用户在确认对话框按"确定"
			var detailViewForDetail=curTab.substring(0,curTab.indexOf("#"));
			var tableViewForDetail=curTab.substring(curTab.indexOf("#")+1);		
			var m={"sessionId": "<%=request.getSession().getId()%>","state":"delete","handleSort":"database","handleState":"delete","detailView":detailViewForDetail,"masterTableView":tableView}; 
			var elementCheckbox = document.getElementsByName("checkbox_template");
			var tableElement;
			for(var i=elementCheckbox.length-1;i>=0;i--){
				if(elementCheckbox[i].checked) {
					var trElement = elementCheckbox[i].parentNode.parentNode;
					m["KEYVALUE"] = elementCheckbox[i].value;
					m["serial"] = trElement.cells[1].innerText;
					MasterDetailTemplateAjax.executeDetail(m,null,function(data)
					{
						queryAll();
					});	//此处将来可改进成批量删除
					
				}
			}
		}
	}
	//构建给子表修改页面传递信息类
	function getDetail(){
		var detail= {
			sessionId:"",
			state:"",//操作状态位
			serial:""//序号
		} ;
		return detail;
	}
	//点击tab时候触发
	function onTabChange(tabId)
	{
		curTab=tabId;
		if(curTab!='mainTab')
			queryAll();
	}
	
	function goBack(){
		/*MasterDetailTemplateAjax.removeCache("<%=request.getSession().getId()%>",function(data){
			history.go(-1);
		});*/
		history.go(-1);
	}
	
	/**
	 * 功能描述：填充指定表的tbody内容
	 * 参数描述：tableId -- 指定的表对象id 
	 *					  cellObjects -- 要填充到行内单元格的对象数据集;
	 *					  num -- 要填充的行数;
	 */  
	function insertEndRow(cellObjects){
		var tableViewForDetail=curTab.substring(curTab.indexOf("#")+1);
	    alert(dwr.util.toDescriptiveString(tableViewForDetail, 2));				
		var tbodyObj =  jQuery("table[id="+tableViewForDetail+'] table')[0];
		var rowObj1= tbodyObj.insertRow(tbodyObj.rows.length);
		insertCell(tbodyObj,rowObj1,cellObjects);
	}
	
	/**
	 * 功能描述：对指定表的指定行的单元格填充数据
	 * 参数描述：tableObj -- 指定的表对象 
	 *					  rowObj -- 指定的行对象;
	 *					  cells -- 要填充到行内单元格的对象数据集;
	 */    
	function insertCell(tableObj,rowObj,cells){
		rowObj.className="listCss";
		var irow=tableObj.rows;
		var icell;
		if(rowObj.rowIndex==1){
			tableEle = tableObj.parentNode;
			if(tableEle.getElementsByTagName("thead").length>0){
			var theadObj = tableEle.getElementsByTagName("thead");
				icell = theadObj[0].rows[0].cells;
			}else{
				icell = tableEle.rows[0].cells;
			}
		}else{
			icell=tableObj.rows[0].cells;
		}
		for(i=0;i<icell.length;i++){
			rowObj.insertCell();
		}
		for(var i=0;i<icell.length;i++){
			if(i<1){
				rowObj.cells[i].style.textAlign="center";
			}
			//<img src="<venus:base/>/images/ajaxList/blank.gif" width="40" height="1"><br>这段代码为了禁止tb内容折行显示
			i==1?rowObj.cells[i].innerHTML='<img src="<venus:base/>/images/ajaxList/blank.gif" width="40" height="1"><br>'+rowObj.rowIndex : rowObj.cells[i].innerHTML=cells[i];
		}
	}
	/**
	 * 功能描述：填充指定表的tbody内容
	 * 参数描述：tableId -- 指定的表对象id 
	 *					  cellObjects -- 要填充到行内单元格的对象数据集;
	 *					  num -- 要填充的行数;
	 */  
	function changeRow(cellObjects,num){
	   // alert(dwr.util.toDescriptiveString(rowObj1, 2));		
		var tableViewForDetail=curTab.substring(curTab.indexOf("#")+1);
		var tbodyObj =  jQuery('#'+tableViewForDetail+' table table')[0];
		var rowObj1= tbodyObj.rows[num];
		changeCell(rowObj1,cellObjects);
	}
	/**
	 * 功能描述：对指定表的指定行的单元格填充数据
	 * 参数描述：tableObj -- 指定的表对象 
	 *					  rowObj -- 指定的行对象;
	 *					  cells -- 要填充到行内单元格的对象数据集;
	 */    
	function changeCell(rowObj,cells){
		for(var i=0;i<rowObj.cells.length;i++){
			if(i>=2){
				rowObj.cells[i].innerHTML=cells[i];
			}
		}
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<%=isModify ? LocaleHolder.getMessage("gap.dd.common.modify_template") : LocaleHolder.getMessage("gap.dd.common.add_template")%>','<venus:base/>/');
</script>
<div id='dmainTab' class='HackBox' style='display: block'>
<form name="form" method="post"><input type="hidden"
	name="primary" value="<%=primary%>"> <input type="hidden"
	id="primary_value" name="primary_value" value="<%=primary_value%>"> <input
	type="hidden" name="sessionId"
	value="<%=request.getSession().getId()%>">

<table class="table_noframe">
	<tr>
		<td valign="middle"><input name="button_save" type="button"
			class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>'
			onClick="javascript:submit_onClick();"> <input
			name="button_cancel" type="button" class="button_ellipse" value='<fmt:message key="return"  bundle="${applicationResources}"></fmt:message>'
			onClick="javascript:goBack();"></td>
	</tr>
</table>

<dd:editView code='<%=request.getParameter("detailView")%>'
	condition="<%=condition%>" /> <input type="hidden" name="detail_code"
	value='<%=request.getParameter("detailView")%>' /></form>
</div>

<div id="ccChild1">
<table class="table_div_content">
	<tr>
		<td>
		<%
		    out.print(request.getAttribute("detailsListHTML"));
		%>
		</td>
	</tr>
</table>
</div>
<script language="javascript">
	document.getElementById('cnt').appendChild(document.getElementById('dmainTab'));
	writeTableBottom('<venus:base/>/');
</script>
</fmt:bundle>
</body>
</html>
<%
    //表单回写
    if (request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map) request
			.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
    }
%>