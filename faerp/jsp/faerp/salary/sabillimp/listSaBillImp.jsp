<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.salary.sabillimp.vo.SaBillImpVo" %>
<%@ page import="rayoo.salary.sabillimp.util.ISaBillImpConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISaBillImpConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISaBillImpConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SaBillImpVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/SaBillImpAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/SaBillImpAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/salary/sabillimp/insertSaBillImp.jsp";
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
		form.action="<%=request.getContextPath()%>/SaBillImpAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post" action="<%=request.getContextPath()%>/SaBillImpAction.do">
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
			<td align="right">sa_batch_id</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_batch_id" inputName="sa_batch_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sa_batch_code</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_batch_code" inputName="sa_batch_code" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">customer_id</td>
			<td align="left">
				<input type="text" class="text_field" name="customer_id" inputName="customer_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">file_name</td>
			<td align="left">
				<input type="text" class="text_field" name="file_name" inputName="file_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">file_path</td>
			<td align="left">
				<input type="text" class="text_field" name="file_path" inputName="file_path" maxLength="500"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">import_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="import_time_from" id="import_time_from" inputName="import_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('import_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="import_time_to" id="import_time_to" inputName="import_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('import_time_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">import_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="import_user_id" inputName="import_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_pasword</td>
			<td align="left">
				<input type="text" class="text_field" name="is_pasword" inputName="is_pasword" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">file_pwd</td>
			<td align="left">
				<input type="text" class="text_field" name="file_pwd" inputName="file_pwd" maxLength="250"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_differ_list</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_differ_list" inputName="emp_differ_list" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_differ_cause</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_differ_cause" inputName="emp_differ_cause" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sum_differ_list</td>
			<td align="left">
				<input type="text" class="text_field" name="sum_differ_list" inputName="sum_differ_list" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">sum_differ_cause</td>
			<td align="left">
				<input type="text" class="text_field" name="sum_differ_cause" inputName="sum_differ_cause" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">e_tax_list</td>
			<td align="left">
				<input type="text" class="text_field" name="e_tax_list" inputName="e_tax_list" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">e_fund_list</td>
			<td align="left">
				<input type="text" class="text_field" name="e_fund_list" inputName="e_fund_list" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">only_tax_list</td>
			<td align="left">
				<input type="text" class="text_field" name="only_tax_list" inputName="only_tax_list" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">alien_list</td>
			<td align="left">
				<input type="text" class="text_field" name="alien_list" inputName="alien_list" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">other_cause</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="other_cause_from" id="other_cause_from" inputName="other_cause"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('other_cause_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="other_cause_to" id="other_cause_to" inputName="other_cause"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('other_cause_to','<venus:base/>/');"/>
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
			
			<layout:collectionItem width="8%" title="sa_batch_id" property="sa_batch_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="sa_batch_code" property="sa_batch_code" sortable="true"/>
			
			<layout:collectionItem width="8%" title="customer_id" property="customer_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="file_name" property="file_name" sortable="true"/>
			
			<layout:collectionItem width="8%" title="file_path" property="file_path" sortable="true"/>
			
			<layout:collectionItem width="8%" title="import_time" property="import_time" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="import_time"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="import_user_id" property="import_user_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_pasword" property="is_pasword" sortable="true"/>
			
			<layout:collectionItem width="8%" title="file_pwd" property="file_pwd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="emp_differ_list" property="emp_differ_list" sortable="true"/>
			
			<layout:collectionItem width="8%" title="emp_differ_cause" property="emp_differ_cause" sortable="true"/>
			
			<layout:collectionItem width="8%" title="sum_differ_list" property="sum_differ_list" sortable="true"/>
			
			<layout:collectionItem width="8%" title="sum_differ_cause" property="sum_differ_cause" sortable="true"/>
			
			<layout:collectionItem width="8%" title="e_tax_list" property="e_tax_list" sortable="true"/>
			
			<layout:collectionItem width="8%" title="e_fund_list" property="e_fund_list" sortable="true"/>
			
			<layout:collectionItem width="8%" title="only_tax_list" property="only_tax_list" sortable="true"/>
			
			<layout:collectionItem width="8%" title="alien_list" property="alien_list" sortable="true"/>
			
			<layout:collectionItem width="8%" title="other_cause" property="other_cause" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="other_cause"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
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
	if(request.getAttribute(ISaBillImpConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISaBillImpConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
