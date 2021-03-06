<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.authority.sample.employee.util.IEmployeeConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Personnel_management' bundle='${applicationAuResources}' /></title>
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
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		form.action="<%=request.getContextPath()%>/EmployeeAction.do?cmd=find&id=" + ids;
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert("<fmt:message key='gap.authority.Please_Select_Records' bundle='${applicationAuResources}' />!")
			return;
		}
		if(confirm("<fmt:message key='gap.authority.It_completely_remove_the_data_' bundle='${applicationAuResources}' />")) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/EmployeeAction.do?cmd=deleteMulti&ids=" + ids;
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
		form.action="<%=request.getContextPath()%>/EmployeeAction.do?cmd=simpleQuery";
    	form.submit();
  	}
	function queryAll_onClick(){  //查询全部数据列表
		form.action="<%=request.getContextPath()%>/EmployeeAction.do?cmd=queryAll";
		form.submit();
	}	
	function toAdd_onClick() {  //到增加记录页面
		window.location="<%=request.getContextPath()%>/jsp/authority/sample/employee/insertEmployee.jsp";
	}
	function refresh_onClick(){  //刷新本页
		window.location.reload();
	}
	function detail_onClick(thisId){  //实现转到详细页面
		form.id.value = thisId;  //赋值thisId给隐藏值id
		form.action="<%=request.getContextPath()%>/EmployeeAction.do?cmd=detail&isReadOnly=1";
		form.submit();
	}
	function checkAllList_onClick(thisObj){  //全选，全不选
		if(thisObj.checked) {  //如果选中
			selectAllRows('template');  //全选checkbox
		} else {
			unSelectAllRows('template');  //全不选checkbox
		}
	}
	function clean_onClick() {  //清空查询条件
		form.person_no.value = "";
		form.person_name.value = "";
		form.person_type.value = "";
		form.sex[0].checked = false;
		form.sex[1].checked = false;
	}
	function getRowHiddenId() {  //从事件取得本行的id
		var thisA = event.srcElement;  //定义事件来源对象
		var thisTr = thisA.parentElement.parentElement.parentElement;  //定义本行的tr对象
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
			if(jQuery(tempObj).attr("signName") == thisName) {  //如果当前临时节点的name等于thisName
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
	function view_onClick(){//查看详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		detail_onClick(ids);
	}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.List_pages' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;<fmt:message key='gap.authority.Conditional_Query' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>
<div id="ccChild0"> 
<table class="table_div_content">
	<tr>
		<td>
			<table class="table_noFrame" width="100%">
				<tr>
					<td width="15%" align="right"><fmt:message key='gap.authority.Staff_numbers' bundle='${applicationAuResources}' /></td>
					<td width="35%" align="left">
						<input type="text" class="text_field" validate="isSearch" name="person_no" inputName="<fmt:message key='gap.authority.Staff_numbers' bundle='${applicationAuResources}' />" maxLength="50"/>
					</td>
					<td width="15%" align="right"><fmt:message key='gap.authority.Staff_Type' bundle='${applicationAuResources}' /></td>
					<td width="35%" align="left">
						<input type="text" class="text_field" validate="isSearch" name="person_type" inputName="<fmt:message key='gap.authority.Staff_Type' bundle='${applicationAuResources}' />" maxLength="50"/>
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Name1' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="person_name" inputName="<fmt:message key='gap.authority.Name0' bundle='${applicationAuResources}' />" maxLength="50"/>
					</td>
					<td align="right"><fmt:message key='gap.authority.Sex' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="radio" name="sex" inputName="<fmt:message key='gap.authority.Sex0' bundle='${applicationAuResources}' />" value="1"><fmt:message key='gap.authority.Male' bundle='${applicationAuResources}' />
						<input type="radio" name="sex" inputName="<fmt:message key='gap.authority.Sex0' bundle='${applicationAuResources}' />" value="0"><fmt:message key='gap.authority.Female' bundle='${applicationAuResources}' />
					</td>
				</tr>
				<!--tr>
					<td align="right">英&nbsp;&nbsp;文&nbsp;名</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="english_name" inputName="英文名" maxLength="50"/>
					</td>
					<td align="right">电子邮件</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="email" inputName="电子邮件" maxLength="300"/>
					</td>
				</tr>
				<tr>
					<td align="right">移动电话</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="mobile" inputName="电话" maxLength="50"/>
					</td>
					<td align="right">固定电话</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="tel" inputName="电话" maxLength="50"/>
					</td>
				</tr>
				<tr>
					<td align="right">可用状态</td>
					<td align="left">
						<input type="radio" name="enable_status" inputName="启用状态" value="1">启用
						<input type="radio" name="enable_status" inputName="禁用状态" value="0">禁用
					</td>
					<td align="right">启用/禁用日期</td>
					<td align="left">
						<input type="text" class="text_field_half_reference_readonly" name="enable_date_from"/><img class="refButtonClass" src="<venus:base/>/images/09.gif" onClick="javascript:getYearMonthDay(enable_date_from,'<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="enable_date_to"/><img class="refButtonClass" src="<venus:base/>/images/09.gif" onClick="javascript:getYearMonthDay(enable_date_to,'<venus:base/>/');"/>
					</td>
				</tr>
				<tr>
					<td align="right">创建日期</td><td align="left">
						<input type="text" class="text_field_half_reference_readonly" name="create_date_from"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getYearMonthDay(create_date_from,'<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="create_date_to"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getYearMonthDay(create_date_to,'<venus:base/>/');"/>
					</td>
					<td align="right">修改日期</td>
					<td align="left">
						<input type="text" class="text_field_half_reference_readonly" name="modify_date_from"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getYearMonthDay(modify_date_from,'<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="modify_date_to"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getYearMonthDay(modify_date_to,'<venus:base/>/');"/>
					</td>
				</tr>
				<tr>
					<td align="right">邮编</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="postalcode" inputName="邮编" maxLength="50"/>
					</td>
					<td align="right">地址</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="address" inputName="地址" maxLength="300"/>
					</td>
				</tr>
				<tr>
					<td align="right">备注</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="remark" inputName="备注" maxLength="50"/>
					</td>
					<td align="right">备用字段1</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="column1" inputName="备用字段1" maxLength="300"/>
					</td>
				</tr>
				<tr>
					<td align="right">备用字段2</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="column2" inputName="备用字段2" maxLength="300"/>
					</td>
					<td align="right">备用字段3</td>
					<td align="left">
						<input type="text" class="text_field" validate="isSearch" name="column3" inputName="备用字段3" maxLength="300"/>
					</td>
				</tr-->
				<tr>
					<td align="right"></td>
					<td align="right"></td>
					<td align="right"></td>
					<td>
						<input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Inquiry' bundle='${applicationAuResources}' />" onClickTo="javascript:simpleQuery_onClick()">
						<input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Empty' bundle='${applicationAuResources}' />" onClick="javascript:clean_onClick()">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key='gap.authority.Details_Form' bundle='${applicationAuResources}' />
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Added' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key='gap.authority.Delete' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message key='gap.authority.Modify' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:view_onClick();"><img src="<venus:base/>/images/icon/view.gif" class="div_control_image"><fmt:message key='gap.authority.View' bundle='${applicationAuResources}' /></td>					
					<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<%=request.getContextPath()%>/images/icon/refresh.gif" class="div_control_image"><fmt:message key='gap.authority.Refresh' bundle='${applicationAuResources}' /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="table_div_content2" width="100%">
	<tr>
		<td>
		<layout:collection name="beans" id="rmBean" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0">
			<layout:collectionItem width="30" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="rmDisplayName" name="rmBean" property="id"/>
				<input type="checkbox" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="30"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>"/>
			</layout:collectionItem>
			<%="<a onDblClick='javascript:detail_onClick(getRowHiddenId())'>"%>
			<layout:collectionItem width="160" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Number") %>' property="person_no"/>
			<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Name0") %>' property="person_name"/>
			<layout:collectionItem width="40" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sex0") %>' style="text-align:center;">
			     <logic:notEmpty name="rmBean" property="sex">
				    <bean:define id="sex" name="rmBean" property="sex"/>
			        <%="1".equals(sex)?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Male"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Female")%>
			     </logic:notEmpty>
			</layout:collectionItem>
			<layout:collectionItem width="100" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Staff_Type") %>' property="person_type"/>
			<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.E_mail") %>' property="email"/>
			<layout:collectionItem width="140" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Created") %>'>
				<bean:define id="create_date" name="rmBean" property="create_date"/>
		    	<%=StringHelperTools.prt(create_date,19)%>
			</layout:collectionItem>
			<%="</a>"%>
			</layout:collection>
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>
<input type="hidden" name="id" value="">
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<%  //表单回写
	if(request.getAttribute(IEmployeeConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的bean不为空
		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute(IEmployeeConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
		out.print("writeBackMapToForm();\n");  //输出执行回写方法
		out.print("</script>");  //输出script的声明结束
	}
%>

