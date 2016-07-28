<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List,java.util.Iterator" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="gap.rm.project.dictionary.rmdictionarytype.vo.RmDictionaryTypeVo" %>
<%@ page import="gap.rm.project.dictionary.rmdictionarytype.util.IRmDictionaryTypeConstants" %>
<%
	String inputType = String.valueOf(request.getAttribute("inputType"));
	if(inputType == null || inputType.length() == 0 || (!"checkbox".equals(inputType) && !"radio".equals(inputType))) {
		inputType = "radio";		
	}
	//取出List
	List resultList = null;  //定义结果列表的List变量
	if(request.getAttribute(IRmDictionaryTypeConstants.REQUEST_BEANS_VALUE) != null) {  //如果request中的beans不为空
		resultList = (List)request.getAttribute(IRmDictionaryTypeConstants.REQUEST_BEANS_VALUE);  //赋值给resultList
	}
	Iterator itResult = null;  //定义访问List变量的迭代器
	if(resultList != null) {  //如果List变量不为空
		itResult = resultList.iterator();  //赋值迭代器
	}
	RmDictionaryTypeVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中国网通（集团）有限公司河北省分公司企业信息门户</title>
<script language="javascript">
	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = checkboxName;  //通过name取出所有的checkbox
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
	function queryReference_onClick(){  //简单的模糊查询
		form.queryCondition.value = buildQueryCondition();  //获得组合后的查询条件的字符串描述
    	form.action="<%=request.getContextPath()%>/RmDictionaryTypeAction.do?cmd=queryReference";
    	form.submit();
  	}
	function queryAll_onClick(){  //查询全部数据列表
		form.queryCondition.value = '';
		form.action="<%=request.getContextPath()%>/RmDictionaryTypeAction.do?cmd=queryReference";
		form.submit();
	}
	function refresh_onClick(){  //刷新本页
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
		

		pushCondition(qca, "type_keyword");
				
		pushCondition(qca, "name");
				
		pushCondition(qca, "remark");
				
		pushCondition(qca, "code");
				
		pushCondition(qca, "parent_code");
				
		pushCondition(qca, "total_code");
				

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

<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td valign="middle">&nbsp;<input name="button_queryAll" class="button_ellipse" type="button" value="查询全部"  onClick="javascript:queryAll_onClick()">		
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
					<td align="right">类型关键字</td>
					<td align="left">
						<input type="text" class="text_field" name="type_keyword" inputName="类型关键字" maxLength="200"/>
					</td>
					<td align="right"></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="right">字典类型名称</td>
					<td align="left">
						<input type="text" class="text_field" name="name" inputName="字典类型名称" maxLength="200"/>
					</td>
					<td align="right"></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="right">备注</td>
					<td colspan="3" align="left">
						<textarea class="textarea_limit_words" cols="60" rows="5" id="remark" maxLength="500" name="remark"></textarea>
					</td>
				</tr>
				<tr>
					<td align="right">自身编码</td>
					<td align="left">
						<input type="text" class="text_field" name="code" inputName="自身编码" maxLength="500"/>
					</td>
					<td align="right"></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="right">父栏目编码</td>
					<td align="left">
						<input type="text" class="text_field" name="parent_code" inputName="父栏目编码" maxLength="500"/>
					</td>
					<td align="right"></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="right">完全编码</td>
					<td align="left">
						<input type="text" class="text_field" name="total_code" inputName="完全编码" maxLength="500"/>
					</td>
					<td align="right"></td>
					<td align="left"></td>
				</tr>
				<tr>
			<td/>
			<td/>
			<td/>
			<td><input name="button_ok" class="button_ellipse" type="button" value="确定" onClickTo="javascript:queryReference_onClick()"></td>
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
					<td class="td_hand" onClick="javascript:refresh_onClick();"><img src="<%=request.getContextPath()%>/images/icon/refresh.gif" class="div_control_image">刷新</td>
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
				<bean:define id="rmValue" name="rmBean" property="type_keyword"/>
				<bean:define id="rmDisplayName" name="rmBean" property="type_keyword"/>
				<input type="<%="checkbox".equals(inputType)?"checkbox":""%><%="radio".equals(inputType)?"radio":""%>" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>" />
			</layout:collectionItem>
			
			<layout:collectionItem width="5%"  title="序" style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>"/>
			</layout:collectionItem>
			
<layout:collectionItem width="10%" title="类型关键字" property="type_keyword" sortable="true"/>
		<layout:collectionItem width="10%" title="字典类型名称" property="name" sortable="true"/>
		<layout:collectionItem width="10%" title="备注" property="remark" sortable="true"/>
		<layout:collectionItem width="10%" title="自身编码" property="code" sortable="true"/>
		<layout:collectionItem width="10%" title="父栏目编码" property="parent_code" sortable="true"/>
		<layout:collectionItem width="10%" title="完全编码" property="total_code" sortable="true"/>
		</layout:collection>
		
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>

<input type="hidden" name="id" value="">
<input type="hidden" name="queryCondition" value="">
<input type="hidden" name="inputType" value="<%=inputType%>">
</form>

</body>
</html>
<%  //表单回写
	if(request.getAttribute(IRmDictionaryTypeConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的bean不为空
		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IRmDictionaryTypeConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
		out.print("writeBackMapToForm();\n");  //输出执行回写方法
		out.print("</script>");  //输出script的声明结束
	}
%>
