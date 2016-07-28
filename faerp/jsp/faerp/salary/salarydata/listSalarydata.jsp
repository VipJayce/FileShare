<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.salary.salarydata.vo.SalarydataVo" %>
<%@ page import="rayoo.salary.salarydata.util.ISalarydataConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISalarydataConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISalarydataConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SalarydataVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/SalarydataAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/SalarydataAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/salary//salarydata/insertSalarydata.jsp";
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
		form.action="<%=request.getContextPath()%>/SalarydataAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/SalarydataAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">sa_batch_id</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_batch_id" inputName="sa_batch_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">sa_class_id</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_class_id" inputName="sa_class_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">sa_doc_id</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_doc_id" inputName="sa_doc_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_id" inputName="emp_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">department_id</td>
			<td align="left">
				<input type="text" class="text_field" name="department_id" inputName="department_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pay_year_month</td>
			<td align="left">
				<input type="text" class="text_field" name="pay_year_month" inputName="pay_year_month" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">stop_flag</td>
			<td align="left">
				<input type="text" class="text_field" name="stop_flag" inputName="stop_flag" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_verify</td>
			<td align="left">
				<input type="text" class="text_field" name="is_verify" inputName="is_verify" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_postpone</td>
			<td align="left">
				<input type="text" class="text_field" name="is_postpone" inputName="is_postpone" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_email</td>
			<td align="left">
				<input type="text" class="text_field" name="is_email" inputName="is_email" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emial_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="emial_time_from" id="emial_time_from" inputName="emial_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('emial_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="emial_time_to" id="emial_time_to" inputName="emial_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('emial_time_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">email_user</td>
			<td align="left">
				<input type="text" class="text_field" name="email_user" inputName="email_user" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">email_remarks</td>
			<td align="left">
				<input type="text" class="text_field" name="email_remarks" inputName="email_remarks" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def1</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def1_from" inputName="def1" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def1_to" inputName="def1" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def2</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def2_from" inputName="def2" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def2_to" inputName="def2" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def3</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def3_from" inputName="def3" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def3_to" inputName="def3" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def4</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def4_from" inputName="def4" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def4_to" inputName="def4" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def5</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def5_from" inputName="def5" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def5_to" inputName="def5" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def6</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def6_from" inputName="def6" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def6_to" inputName="def6" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def7</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def7_from" inputName="def7" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def7_to" inputName="def7" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def8</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def8_from" inputName="def8" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def8_to" inputName="def8" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def9</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def9_from" inputName="def9" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def9_to" inputName="def9" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def10</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def10_from" inputName="def10" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def10_to" inputName="def10" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def11</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def11_from" inputName="def11" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def11_to" inputName="def11" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def12</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def12_from" inputName="def12" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def12_to" inputName="def12" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def13</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def13_from" inputName="def13" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def13_to" inputName="def13" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def14</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def14_from" inputName="def14" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def14_to" inputName="def14" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def15</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def15_from" inputName="def15" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def15_to" inputName="def15" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def16</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def16_from" inputName="def16" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def16_to" inputName="def16" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def17</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def17_from" inputName="def17" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def17_to" inputName="def17" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def18</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def18_from" inputName="def18" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def18_to" inputName="def18" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def19</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def19_from" inputName="def19" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def19_to" inputName="def19" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def20</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def20_from" inputName="def20" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def20_to" inputName="def20" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def21</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def21_from" inputName="def21" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def21_to" inputName="def21" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def22</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def22_from" inputName="def22" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def22_to" inputName="def22" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def23</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def23_from" inputName="def23" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def23_to" inputName="def23" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def24</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def24_from" inputName="def24" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def24_to" inputName="def24" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def25</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def25_from" inputName="def25" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def25_to" inputName="def25" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def26</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def26_from" inputName="def26" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def26_to" inputName="def26" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def27</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def27_from" inputName="def27" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def27_to" inputName="def27" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def29</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def29_from" inputName="def29" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def29_to" inputName="def29" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def28</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def28_from" inputName="def28" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def28_to" inputName="def28" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def30</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def30_from" inputName="def30" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def30_to" inputName="def30" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def31</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def31_from" inputName="def31" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def31_to" inputName="def31" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def32</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def32_from" inputName="def32" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def32_to" inputName="def32" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def33</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def33_from" inputName="def33" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def33_to" inputName="def33" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def34</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def34_from" inputName="def34" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def34_to" inputName="def34" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def35</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def35_from" inputName="def35" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def35_to" inputName="def35" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def36</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def36_from" inputName="def36" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def36_to" inputName="def36" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def37</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def37_from" inputName="def37" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def37_to" inputName="def37" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def38</td>
			<td align="left">
				<input type="text" class="text_field_half" name="def38_from" inputName="def38" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="def38_to" inputName="def38" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">var1</td>
			<td align="left">
				<input type="text" class="text_field_half" name="var1_from" inputName="var1" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="var1_to" inputName="var1" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">var2</td>
			<td align="left">
				<input type="text" class="text_field_half" name="var2_from" inputName="var2" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="var2_to" inputName="var2" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">var3</td>
			<td align="left">
				<input type="text" class="text_field_half" name="var3_from" inputName="var3" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="var3_to" inputName="var3" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">var4</td>
			<td align="left">
				<input type="text" class="text_field_half" name="var4_from" inputName="var4" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="var4_to" inputName="var4" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">var5</td>
			<td align="left">
				<input type="text" class="text_field_half" name="var5_from" inputName="var5" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="var5_to" inputName="var5" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">var6</td>
			<td align="left">
				<input type="text" class="text_field_half" name="var6_from" inputName="var6" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="var6_to" inputName="var6" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">var7</td>
			<td align="left">
				<input type="text" class="text_field_half" name="var7_from" inputName="var7" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="var7_to" inputName="var7" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td/>
          
			<td/>
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	<td/>
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sa_batch_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sa_batch_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sa_batch_id")%>">
           	</a>	
       
			 sa_batch_id</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sa_class_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sa_class_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sa_class_id")%>">
           	</a>	
       
			 sa_class_id</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sa_doc_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sa_doc_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sa_doc_id")%>">
           	</a>	
       
			 sa_doc_id</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_id")%>">
           	</a>	
       
			 emp_id</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"department_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"department_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"department_id")%>">
           	</a>	
       
			 department_id</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pay_year_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pay_year_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pay_year_month")%>">
           	</a>	
       
			 pay_year_month</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"stop_flag")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"stop_flag")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"stop_flag")%>">
           	</a>	
       
			 stop_flag</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_verify")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_verify")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_verify")%>">
           	</a>	
       
			 is_verify</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_postpone")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_postpone")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_postpone")%>">
           	</a>	
       
			 is_postpone</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_email")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_email")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_email")%>">
           	</a>	
       
			 is_email</th>
			<th>
							
				 	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emial_time")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emial_time")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emial_time")%>">
           	</a>	
       
			emial_time</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"email_user")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"email_user")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"email_user")%>">
           	</a>	
       
			 email_user</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"email_remarks")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"email_remarks")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"email_remarks")%>">
           	</a>	
       
			 email_remarks</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def1")%>">
           	</a>	
       
			 def1</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def2")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def2")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def2")%>">
           	</a>	
       
			 def2</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def3")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def3")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def3")%>">
           	</a>	
       
			 def3</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def4")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def4")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def4")%>">
           	</a>	
       
			 def4</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def5")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def5")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def5")%>">
           	</a>	
       
			 def5</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def6")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def6")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def6")%>">
           	</a>	
       
			 def6</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def7")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def7")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def7")%>">
           	</a>	
       
			 def7</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def8")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def8")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def8")%>">
           	</a>	
       
			 def8</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def9")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def9")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def9")%>">
           	</a>	
       
			 def9</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def10")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def10")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def10")%>">
           	</a>	
       
			 def10</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def11")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def11")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def11")%>">
           	</a>	
       
			 def11</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def12")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def12")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def12")%>">
           	</a>	
       
			 def12</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def13")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def13")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def13")%>">
           	</a>	
       
			 def13</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def14")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def14")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def14")%>">
           	</a>	
       
			 def14</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def15")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def15")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def15")%>">
           	</a>	
       
			 def15</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def16")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def16")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def16")%>">
           	</a>	
       
			 def16</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def17")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def17")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def17")%>">
           	</a>	
       
			 def17</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def18")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def18")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def18")%>">
           	</a>	
       
			 def18</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def19")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def19")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def19")%>">
           	</a>	
       
			 def19</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def20")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def20")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def20")%>">
           	</a>	
       
			 def20</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def21")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def21")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def21")%>">
           	</a>	
       
			 def21</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def22")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def22")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def22")%>">
           	</a>	
       
			 def22</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def23")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def23")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def23")%>">
           	</a>	
       
			 def23</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def24")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def24")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def24")%>">
           	</a>	
       
			 def24</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def25")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def25")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def25")%>">
           	</a>	
       
			 def25</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def26")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def26")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def26")%>">
           	</a>	
       
			 def26</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def27")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def27")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def27")%>">
           	</a>	
       
			 def27</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def29")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def29")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def29")%>">
           	</a>	
       
			 def29</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def28")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def28")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def28")%>">
           	</a>	
       
			 def28</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def30")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def30")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def30")%>">
           	</a>	
       
			 def30</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def31")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def31")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def31")%>">
           	</a>	
       
			 def31</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def32")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def32")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def32")%>">
           	</a>	
       
			 def32</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def33")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def33")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def33")%>">
           	</a>	
       
			 def33</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def34")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def34")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def34")%>">
           	</a>	
       
			 def34</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def35")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def35")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def35")%>">
           	</a>	
       
			 def35</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def36")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def36")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def36")%>">
           	</a>	
       
			 def36</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def37")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def37")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def37")%>">
           	</a>	
       
			 def37</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def38")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def38")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def38")%>">
           	</a>	
       
			 def38</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"var1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"var1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"var1")%>">
           	</a>	
       
			 var1</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"var2")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"var2")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"var2")%>">
           	</a>	
       
			 var2</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"var3")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"var3")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"var3")%>">
           	</a>	
       
			 var3</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"var4")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"var4")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"var4")%>">
           	</a>	
       
			 var4</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"var5")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"var5")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"var5")%>">
           	</a>	
       
			 var5</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"var6")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"var6")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"var6")%>">
           	</a>	
       
			 var6</th>
			<th>
				
			  	<a href="/FAERP/SalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"var7")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"var7")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"var7")%>">
           	</a>	
       
			 var7</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td > <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="sa_batch_id"/>   </td>
			
			<td><bean:write name="data" property="sa_class_id"/>   </td>
			
			<td><bean:write name="data" property="sa_doc_id"/>   </td>
			
			<td><bean:write name="data" property="emp_id"/>   </td>
			
			<td><bean:write name="data" property="department_id"/>   </td>
			
			<td><bean:write name="data" property="pay_year_month"/>   </td>
			
			<td><bean:write name="data" property="stop_flag"/>   </td>
			
			<td><bean:write name="data" property="is_verify"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="is_postpone"/>   </td>
			
			<td><bean:write name="data" property="is_email"/>   </td>
			
			<td><bean:write name="data" property="emial_time"/>   </td>
			<td><bean:write name="data" property="email_user"/>   </td>
			
			<td><bean:write name="data" property="email_remarks"/>   </td>
			
			<td><bean:write name="data" property="def1"/>   </td>
			
			<td><bean:write name="data" property="def2"/>   </td>
			
			<td><bean:write name="data" property="def3"/>   </td>
			
			<td><bean:write name="data" property="def4"/>   </td>
			
			<td><bean:write name="data" property="def5"/>   </td>
			
			<td><bean:write name="data" property="def6"/>   </td>
			
			<td><bean:write name="data" property="def7"/>   </td>
			
			<td><bean:write name="data" property="def8"/>   </td>
			
			<td><bean:write name="data" property="def9"/>   </td>
			
			<td><bean:write name="data" property="def10"/>   </td>
			
			<td><bean:write name="data" property="def11"/>   </td>
			
			<td><bean:write name="data" property="def12"/>   </td>
			
			<td><bean:write name="data" property="def13"/>   </td>
			
			<td><bean:write name="data" property="def14"/>   </td>
			
			<td><bean:write name="data" property="def15"/>   </td>
			
			<td><bean:write name="data" property="def16"/>   </td>
			
			<td><bean:write name="data" property="def17"/>   </td>
			
			<td><bean:write name="data" property="def18"/>   </td>
			
			<td><bean:write name="data" property="def19"/>   </td>
			
			<td><bean:write name="data" property="def20"/>   </td>
			
			<td><bean:write name="data" property="def21"/>   </td>
			
			<td><bean:write name="data" property="def22"/>   </td>
			
			<td><bean:write name="data" property="def23"/>   </td>
			
			<td><bean:write name="data" property="def24"/>   </td>
			
			<td><bean:write name="data" property="def25"/>   </td>
			
			<td><bean:write name="data" property="def26"/>   </td>
			
			<td><bean:write name="data" property="def27"/>   </td>
			
			<td><bean:write name="data" property="def29"/>   </td>
			
			<td><bean:write name="data" property="def28"/>   </td>
			
			<td><bean:write name="data" property="def30"/>   </td>
			
			<td><bean:write name="data" property="def31"/>   </td>
			
			<td><bean:write name="data" property="def32"/>   </td>
			
			<td><bean:write name="data" property="def33"/>   </td>
			
			<td><bean:write name="data" property="def34"/>   </td>
			
			<td><bean:write name="data" property="def35"/>   </td>
			
			<td><bean:write name="data" property="def36"/>   </td>
			
			<td><bean:write name="data" property="def37"/>   </td>
			
			<td><bean:write name="data" property="def38"/>   </td>
			
			<td><bean:write name="data" property="var1"/>   </td>
			
			<td><bean:write name="data" property="var2"/>   </td>
			
			<td><bean:write name="data" property="var3"/>   </td>
			
			<td><bean:write name="data" property="var4"/>   </td>
			
			<td><bean:write name="data" property="var5"/>   </td>
			
			<td><bean:write name="data" property="var6"/>   </td>
			
			<td><bean:write name="data" property="var7"/>   </td>
			
			</tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(ISalarydataConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISalarydataConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
