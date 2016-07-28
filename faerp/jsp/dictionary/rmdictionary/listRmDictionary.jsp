<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.util.Iterator" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="gap.rm.project.dictionary.rmdictionary.vo.RmDictionaryVo" %>
<%@ page import="gap.rm.project.dictionary.rmdictionary.util.IRmDictionaryConstants" %>
<%  //取出List
	List resultList = null;  //定义结果列表的List变量
	if(request.getAttribute(IRmDictionaryConstants.REQUEST_BEANS_VALUE) != null) {  //如果request中的beans不为空
		resultList = (List)request.getAttribute(IRmDictionaryConstants.REQUEST_BEANS_VALUE);  //赋值给resultList
	}
	Iterator itResult = null;  //定义访问List变量的迭代器
	if(resultList != null) {  //如果List变量不为空
		itResult = resultList.iterator();  //赋值迭代器
	}
	RmDictionaryVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中国网通（集团）有限公司河北省分公司企业信息门户</title>
<script language="javascript">

	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
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
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("请选择一条记录!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("只能选择一条记录!")
	  		return;
		}
		form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=find&id=" + ids;
		form.submit();
	}  

	function physicalDeleteMulti_onClick(){  //从多选框逻辑删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert("请选择记录!")
			return;
		}
		if(confirm("是否逻辑删除该数据？")) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=physicalDeleteMulti&ids=" + ids;
	    	form.submit();
		}
	}

	function deleteMulti_onClick(){  //从多选框逻辑删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert("请选择记录!")
			return;
		}
		if(confirm("是否逻辑删除该数据？")) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=deleteMulti&ids=" + ids;
	    	form.submit();
		}
	}
	function enableMulti_onClick(){  //从多选框逻辑启用多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert("请选择记录!")
			return;
		}
		if(confirm("是否逻辑启用该数据？")) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=enableMulti&ids=" + ids;
	    	form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		form.action = "<%=request.getContextPath()%>/jsp/tools/support/dictionary/rmdictionary/insertRmDictionary.jsp";
		form.submit();
	}
	function simpleQuery_onClick(){  //简单的模糊查询
		form.queryCondition.value = buildQueryCondition();  //获得组合后的查询条件的字符串描述
    	form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=simpleQuery";
    	form.submit();
  	}
	function queryAll_onClick(){  //查询全部数据列表
		form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=queryAll";
		form.submit();
	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
	function detail_onClick(thisId){  //实现转到详细页面
		form.id.value = thisId;  //赋值thisId给隐藏值id
		form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=detail";
		form.submit();
	}
	function checkAllList_onClick(thisObj){  //全选，全不选
		if(thisObj.checked) {  //如果选中
			selectAllRows('template');  //全选checkbox
		} else {
			unSelectAllRows('template');  //全不选checkbox
		}
	}
	function buildQueryCondition() {  //构建简单查询
		var queryCondition = "";  //定义组合后的查询条件的字符串变量
		var qca = new Array();  //定义查询条件的数组变量,每一个可能的查询条件会被压入这个数组


		pushCondition(qca, "type_keyword", "='", "'");
				
		pushCondition(qca, "data_key");
				
		pushCondition(qca, "data_value");
				
		pushCondition(qca, "order_code");
				
		pushCondition(qca, "remark");
				

		if(qca.length >= 1) {  //如果有效的查询条件大于1
			queryCondition += " " + qca[0] + " ";  //组装第1个查询条件
		}
		for(var i=1; i<qca.length; i++) {  //从第2个开始循环查询条件
			queryCondition += " and " + qca[i] + " ";  //组装第2个以后的查询条件
		}
		//alert(queryCondition);  //测试显示组合后的查询条件的字符串描述
		return queryCondition;
	}
	function getRowHiddenId() {  //从事件取得本行的id
		var thisA = event.srcElement;  //定义事件来源对象
		var thisTr = thisA.parentElement.parentElement;  //定义本行的tr对象
		var thisHidden = getObjectByNameRecursive(thisTr, "hiddenId");  //从thisTr递归的取出name是hiddenId的对象
		if(thisHidden != undefined && thisHidden != null) {  //如果thisHidden不为空
			return thisHidden.value;
		} else {
			return null;
		}
	}
	function getObjectByNameRecursive(thisObj, thisName) {  //从thisObj递归的取出name是thisName的对象
		var rtHiddenInput = null;  //定义返回的变量
		for(var i=0; i<thisObj.childNodes.length; i++) {  //循环thisObj的字节点
			var tempObj = thisObj.childNodes[i];  //定义当前临时节点
			if(tempObj.signName == thisName) {  //如果当前临时节点的name等于thisName
				rtHiddenInput = tempObj;  //当前临时节点就是返回的对象
				break;  //完成了目标对象的查询,退出循环
			} else {
				rtHiddenInput = getObjectByNameRecursive(tempObj, thisName);  //递归的找自己的子节点
				if(rtHiddenInput != null) {  //如果返回值不为空
					break;  //完成了目标对象的查询,退出循环
				}
			}
		}
		return rtHiddenInput;
	}
</script>
</head>
<body class="referencePage">
<script language="javascript">
	var isChildTablePage = false;
	if(parent != null && parent.childTableTabsDiv != null) {
		isChildTablePage = true;
	}
	if(!isChildTablePage) {
		writeTableTop('列表页面','<%=request.getContextPath()%>/');  //显示本页的页眉
	}
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td>
			<input name="button_queryAll" class="button_ellipse" type="button" value="查询全部"  onClick="javascript:queryAll_onClick()">		
		</td>
	</tr>
</table>   

<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;按条件查询
		</td>
	</tr>
</table>
</div>

<div id="ccChild0">
<table class="table_div_content">
<tr><td>
	<table class="table_noFrame" width="100%">
		<tr>
			<td width="15%" align="right">数据关键字</td>
			<td width="25%" align="left">
				<input type="text" class="text_field" name="data_key" inputName="数据关键字" maxLength="200"/>
			</td>
			<td width="15%" align="right">数据值</td>
			<td width="45%" align="left">
				<input type="text" class="text_field" name="data_value" inputName="数据值" maxLength="200"/>
			</td>
		</tr>
		<tr>
			<td align="right">排序编码</td>
			<td align="left">
				<input type="text" class="text_field" name="order_code" inputName="排序编码" maxLength="500"/>
			</td>
			<td align="right"></td>
			<td align="left"><input name="button_ok" class="button_ellipse" type="button" value="确定" onClickTo="javascript:simpleQuery_onClick()"></td>
		</tr>		
	</table>

</td></tr>
</table>
</div>
					
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;明细表格
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="td_hand" title="新增" onClick="javascript:toAdd_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image">新增</td>
					<td class="td_hand" title="物理删除" style="width:70px;" onClick="javascript:physicalDeleteMulti_onClick();" ><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image">物理删除</td>
					<td class="td_hand" title="逻辑删除" style="width:70px;" onClick="javascript:deleteMulti_onClick();" ><img src="<%=request.getContextPath()%>/images/icon/disable.bmp" class="div_control_image">逻辑删除</td>
					<td class="td_hand" title="逻辑启用" style="width:70px;" onClick="javascript:enableMulti_onClick();" ><img src="<%=request.getContextPath()%>/images/icon/enable.bmp" class="div_control_image">逻辑启用</td>
					<td class="td_hand" title="修改" onClick="javascript:findCheckbox_onClick();"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image">修改</td>
					<td class="td_hand" title="刷新" onClick="javascript:refresh_onClick();"><img src="<%=request.getContextPath()%>/images/icon/refresh.gif" class="div_control_image">刷新</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content2">
	<tr>
		<td>
		<layout:collection name="beans" id="rmBean" styleClass="listCss" width="99%" indexId="orderNumber" align="center" sortAction="0">
			
			<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="rmDisplayName" name="rmBean" property="id"/>
				<input type="checkbox" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="5%"  title="序" style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>"/>
			</layout:collectionItem>
			


		<layout:collectionItem width="10%" title="类型关键字" property="type_keyword" sortable="true"/>
		<layout:collectionItem width="10%" title="数据关键字" property="data_key" sortable="true"/>
		<layout:collectionItem width="10%" title="数据值" property="data_value" sortable="true"/>
		<layout:collectionItem width="10%" title="排序编码" property="order_code" sortable="true"/>
		
		<layout:collectionItem width="10%" title="可用状态" property="usable_status" sortable="true">
			<bean:define id="rmValue" name="rmBean" property="usable_status"/>
			<%=gap.rm.project.RmGlobalReference.get("RM_USABLE_OR_NOT", rmValue)%>
		</layout:collectionItem>
		
		<%="<a onClick='javascript:detail_onClick(getRowHiddenId())'>"%>
		<layout:collectionItem width="10%" title="备注" property="remark" sortable="true"/>
		<%="</a>"%>
		</layout:collection>
		</td>
	</tr>
</table>
</div>

<input type="hidden" name="id" value="">
<input type="hidden" name="isPrint" value="">
<input type="hidden" name="queryCondition" value="">
<input type="hidden" name="type_keyword" value="">
</form>
<script language="javascript">
	if(!isChildTablePage) {
		writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	}
</script>
</body>
</html>
<%  //表单回写
	if(request.getAttribute(IRmDictionaryConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的bean不为空
		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IRmDictionaryConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
		out.print("writeBackMapToForm();\n");  //输出执行回写方法
		out.print("</script>");  //输出script的声明结束
	}
%>
	
