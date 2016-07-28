<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.salary.salaryinterface.vo.SalaryinterfaceVo" %>
<%@ page import="rayoo.salary.salaryinterface.util.ISalaryinterfaceConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISalaryinterfaceConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISalaryinterfaceConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SalaryinterfaceVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
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
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/SalaryinterfaceAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/SalaryinterfaceAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/salary/salaryinterface/insertSalaryinterface.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/SalaryinterfaceAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post" action="<%=request.getContextPath()%>/SalaryinterfaceAction.do">
<input type="hidden" name="cmd" value="">
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;<fmt:message key="query_by_condition"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<tr><td>
	<table class="table_noFrame" width="100%">
		<tr>
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">salary_class_id</td>
			<td align="left">
				<input type="text" class="text_field" name="salary_class_id" inputName="salary_class_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">inf_name</td>
			<td align="left">
				<input type="text" class="text_field" name="inf_name" inputName="inf_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">inf_type</td>
			<td align="left">
				<input type="text" class="text_field" name="inf_type" inputName="inf_type" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">excel_col_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="excel_col_bd" inputName="excel_col_bd" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_name_col</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name_col" inputName="emp_name_col" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_indentify_col</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_indentify_col" inputName="emp_indentify_col" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">col_cust_identify</td>
			<td align="left">
				<input type="text" class="text_field" name="col_cust_identify" inputName="col_cust_identify" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">row_begin</td>
			<td align="left">
				<input type="text" class="text_field_half" name="row_begin_from" inputName="row_begin" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="row_begin_to" inputName="row_begin" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">row_end</td>
			<td align="left">
				<input type="text" class="text_field_half" name="row_end_from" inputName="row_end" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="row_end_to" inputName="row_end" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">last_import_id</td>
			<td align="left">
				<input type="text" class="text_field" name="last_import_id" inputName="last_import_id" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">remarks</td>
			<td align="left">
				<input type="text" class="text_field" name="remarks" inputName="remarks" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">last_update_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">last_update_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="last_update_date_from" id="last_update_date_from" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="last_update_date_to" id="last_update_date_to" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td/>
            <td>
                <input name="button_ok" class="button_ellipse" type="button" value='<fmt:message key="query"/>' onClickTo="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="button_ellipse" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
			<td/>
			<td/>
		</tr>
	</table>

</td></tr>
</table>
</div>
					
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="detail_table"/>
		</td>
		<td> 
			<table align="right">
				<tr>
					<td class="button_ellipse" onClick="javascript:detail_onClick();"><img src="<%=request.getContextPath()%>/images/icon/search.gif" class="div_control_image"><fmt:message key="view"/></td>
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="insert"/></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify"/></td>
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
		<layout:collection name="beans" id="rmBean" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0">
			
			<layout:collectionItem width="1%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="rmDisplayName" name="rmBean" property="id"/>
				<input type="checkbox" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="3%"  title="序" style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="company_id" property="company_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="salary_class_id" property="salary_class_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="inf_name" property="inf_name" sortable="true"/>
			
			<layout:collectionItem width="8%" title="inf_type" property="inf_type" sortable="true"/>
			
			<layout:collectionItem width="8%" title="excel_col_bd" property="excel_col_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="emp_name_col" property="emp_name_col" sortable="true"/>
			
			<layout:collectionItem width="8%" title="emp_indentify_col" property="emp_indentify_col" sortable="true"/>
			
			<layout:collectionItem width="8%" title="col_cust_identify" property="col_cust_identify" sortable="true"/>
			
			<layout:collectionItem width="8%" title="row_begin" property="row_begin" sortable="true"/>
			
			<layout:collectionItem width="8%" title="row_end" property="row_end" sortable="true"/>
			
			<layout:collectionItem width="8%" title="last_import_id" property="last_import_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="remarks" property="remarks" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_del" property="is_del" sortable="true"/>
			
			<layout:collectionItem width="8%" title="last_update_user_id" property="last_update_user_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="last_update_date" property="last_update_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="last_update_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			</layout:collection>
		
		<!-- 下边这句是翻页, 如果去掉就不带翻页了,同时注意Action中也要调整方法 -->
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(ISalaryinterfaceConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISalaryinterfaceConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
