<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.ppssasalarydata.vo.PpssasalarydataVo" %>
<%@ page import="rayoo.pps.ppssasalarydata.util.IPpssasalarydataConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IPpssasalarydataConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IPpssasalarydataConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	PpssasalarydataVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/PpssasalarydataAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/PpssasalarydataAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/pps/ppssasalarydata/insertPpssasalarydata.jsp";
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
		form.action="<%=request.getContextPath()%>/PpssasalarydataAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/PpssasalarydataAction.do">
<input type="hidden" name="cmd" value="">
 
 
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
			<td align="right">email_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="email_time_from" id="email_time_from" inputName="email_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('email_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="email_time_to" id="email_time_to" inputName="email_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('email_time_to','<venus:base/>/');"/>
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
				<input type="text" class="text_field" name="def1" inputName="def1" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def2</td>
			<td align="left">
				<input type="text" class="text_field" name="def2" inputName="def2" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def3</td>
			<td align="left">
				<input type="text" class="text_field" name="def3" inputName="def3" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def4</td>
			<td align="left">
				<input type="text" class="text_field" name="def4" inputName="def4" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def5</td>
			<td align="left">
				<input type="text" class="text_field" name="def5" inputName="def5" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_valid</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">note</td>
			<td align="left">
				<input type="text" class="text_field" name="note" inputName="note" maxLength="2000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">old_id</td>
			<td align="left">
				<input type="text" class="text_field_half" name="old_id_from" inputName="old_id" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="old_id_to" inputName="old_id" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pps_sa_batch_id</td>
			<td align="left">
				<input type="text" class="text_field" name="pps_sa_batch_id" inputName="pps_sa_batch_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pps_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="pps_user_id" inputName="pps_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def6</td>
			<td align="left">
				<input type="text" class="text_field" name="def6" inputName="def6" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def7</td>
			<td align="left">
				<input type="text" class="text_field" name="def7" inputName="def7" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def8</td>
			<td align="left">
				<input type="text" class="text_field" name="def8" inputName="def8" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def9</td>
			<td align="left">
				<input type="text" class="text_field" name="def9" inputName="def9" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def10</td>
			<td align="left">
				<input type="text" class="text_field" name="def10" inputName="def10" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def11</td>
			<td align="left">
				<input type="text" class="text_field" name="def11" inputName="def11" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def12</td>
			<td align="left">
				<input type="text" class="text_field" name="def12" inputName="def12" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def13</td>
			<td align="left">
				<input type="text" class="text_field" name="def13" inputName="def13" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def14</td>
			<td align="left">
				<input type="text" class="text_field" name="def14" inputName="def14" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def15</td>
			<td align="left">
				<input type="text" class="text_field" name="def15" inputName="def15" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def16</td>
			<td align="left">
				<input type="text" class="text_field" name="def16" inputName="def16" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def17</td>
			<td align="left">
				<input type="text" class="text_field" name="def17" inputName="def17" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def18</td>
			<td align="left">
				<input type="text" class="text_field" name="def18" inputName="def18" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def19</td>
			<td align="left">
				<input type="text" class="text_field" name="def19" inputName="def19" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def20</td>
			<td align="left">
				<input type="text" class="text_field" name="def20" inputName="def20" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def21</td>
			<td align="left">
				<input type="text" class="text_field" name="def21" inputName="def21" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def22</td>
			<td align="left">
				<input type="text" class="text_field" name="def22" inputName="def22" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def23</td>
			<td align="left">
				<input type="text" class="text_field" name="def23" inputName="def23" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def24</td>
			<td align="left">
				<input type="text" class="text_field" name="def24" inputName="def24" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def25</td>
			<td align="left">
				<input type="text" class="text_field" name="def25" inputName="def25" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def26</td>
			<td align="left">
				<input type="text" class="text_field" name="def26" inputName="def26" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def27</td>
			<td align="left">
				<input type="text" class="text_field" name="def27" inputName="def27" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def28</td>
			<td align="left">
				<input type="text" class="text_field" name="def28" inputName="def28" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def29</td>
			<td align="left">
				<input type="text" class="text_field" name="def29" inputName="def29" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def30</td>
			<td align="left">
				<input type="text" class="text_field" name="def30" inputName="def30" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def31</td>
			<td align="left">
				<input type="text" class="text_field" name="def31" inputName="def31" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def32</td>
			<td align="left">
				<input type="text" class="text_field" name="def32" inputName="def32" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def33</td>
			<td align="left">
				<input type="text" class="text_field" name="def33" inputName="def33" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def34</td>
			<td align="left">
				<input type="text" class="text_field" name="def34" inputName="def34" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def35</td>
			<td align="left">
				<input type="text" class="text_field" name="def35" inputName="def35" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def36</td>
			<td align="left">
				<input type="text" class="text_field" name="def36" inputName="def36" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def37</td>
			<td align="left">
				<input type="text" class="text_field" name="def37" inputName="def37" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def38</td>
			<td align="left">
				<input type="text" class="text_field" name="def38" inputName="def38" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def39</td>
			<td align="left">
				<input type="text" class="text_field" name="def39" inputName="def39" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def40</td>
			<td align="left">
				<input type="text" class="text_field" name="def40" inputName="def40" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def41</td>
			<td align="left">
				<input type="text" class="text_field" name="def41" inputName="def41" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def42</td>
			<td align="left">
				<input type="text" class="text_field" name="def42" inputName="def42" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def43</td>
			<td align="left">
				<input type="text" class="text_field" name="def43" inputName="def43" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def44</td>
			<td align="left">
				<input type="text" class="text_field" name="def44" inputName="def44" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def45</td>
			<td align="left">
				<input type="text" class="text_field" name="def45" inputName="def45" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def46</td>
			<td align="left">
				<input type="text" class="text_field" name="def46" inputName="def46" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def47</td>
			<td align="left">
				<input type="text" class="text_field" name="def47" inputName="def47" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def48</td>
			<td align="left">
				<input type="text" class="text_field" name="def48" inputName="def48" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def49</td>
			<td align="left">
				<input type="text" class="text_field" name="def49" inputName="def49" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def50</td>
			<td align="left">
				<input type="text" class="text_field" name="def50" inputName="def50" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def51</td>
			<td align="left">
				<input type="text" class="text_field" name="def51" inputName="def51" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def52</td>
			<td align="left">
				<input type="text" class="text_field" name="def52" inputName="def52" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def53</td>
			<td align="left">
				<input type="text" class="text_field" name="def53" inputName="def53" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def54</td>
			<td align="left">
				<input type="text" class="text_field" name="def54" inputName="def54" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def55</td>
			<td align="left">
				<input type="text" class="text_field" name="def55" inputName="def55" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def56</td>
			<td align="left">
				<input type="text" class="text_field" name="def56" inputName="def56" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def57</td>
			<td align="left">
				<input type="text" class="text_field" name="def57" inputName="def57" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def58</td>
			<td align="left">
				<input type="text" class="text_field" name="def58" inputName="def58" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">def59</td>
			<td align="left">
				<input type="text" class="text_field" name="def59" inputName="def59" maxLength="50"/>
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
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClickTo="javascript:simpleQuery_onClick()">
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
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"department_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"department_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"department_id")%>">
           	</a>	
       
			 department_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pay_year_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pay_year_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pay_year_month")%>">
           	</a>	
       
			 pay_year_month</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"stop_flag")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"stop_flag")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"stop_flag")%>">
           	</a>	
       
			 stop_flag</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_verify")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_verify")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_verify")%>">
           	</a>	
       
			 is_verify</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_postpone")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_postpone")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_postpone")%>">
           	</a>	
       
			 is_postpone</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_email")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_email")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_email")%>">
           	</a>	
       
			 is_email</th>
			<th>
							
				 	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"email_time")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"email_time")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"email_time")%>">
           	</a>	
       
			email_time</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"email_user")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"email_user")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"email_user")%>">
           	</a>	
       
			 email_user</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"email_remarks")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"email_remarks")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"email_remarks")%>">
           	</a>	
       
			 email_remarks</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def1")%>">
           	</a>	
       
			 def1</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def2")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def2")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def2")%>">
           	</a>	
       
			 def2</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def3")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def3")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def3")%>">
           	</a>	
       
			 def3</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def4")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def4")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def4")%>">
           	</a>	
       
			 def4</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def5")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def5")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def5")%>">
           	</a>	
       
			 def5</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_valid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_valid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_valid")%>">
           	</a>	
       
			 is_valid</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"note")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"note")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"note")%>">
           	</a>	
       
			 note</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"old_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"old_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"old_id")%>">
           	</a>	
       
			 old_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pps_sa_batch_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pps_sa_batch_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pps_sa_batch_id")%>">
           	</a>	
       
			 pps_sa_batch_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pps_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pps_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pps_user_id")%>">
           	</a>	
       
			 pps_user_id</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def6")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def6")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def6")%>">
           	</a>	
       
			 def6</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def7")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def7")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def7")%>">
           	</a>	
       
			 def7</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def8")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def8")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def8")%>">
           	</a>	
       
			 def8</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def9")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def9")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def9")%>">
           	</a>	
       
			 def9</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def10")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def10")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def10")%>">
           	</a>	
       
			 def10</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def11")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def11")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def11")%>">
           	</a>	
       
			 def11</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def12")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def12")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def12")%>">
           	</a>	
       
			 def12</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def13")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def13")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def13")%>">
           	</a>	
       
			 def13</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def14")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def14")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def14")%>">
           	</a>	
       
			 def14</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def15")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def15")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def15")%>">
           	</a>	
       
			 def15</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def16")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def16")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def16")%>">
           	</a>	
       
			 def16</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def17")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def17")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def17")%>">
           	</a>	
       
			 def17</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def18")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def18")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def18")%>">
           	</a>	
       
			 def18</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def19")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def19")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def19")%>">
           	</a>	
       
			 def19</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def20")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def20")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def20")%>">
           	</a>	
       
			 def20</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def21")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def21")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def21")%>">
           	</a>	
       
			 def21</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def22")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def22")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def22")%>">
           	</a>	
       
			 def22</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def23")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def23")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def23")%>">
           	</a>	
       
			 def23</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def24")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def24")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def24")%>">
           	</a>	
       
			 def24</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def25")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def25")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def25")%>">
           	</a>	
       
			 def25</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def26")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def26")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def26")%>">
           	</a>	
       
			 def26</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def27")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def27")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def27")%>">
           	</a>	
       
			 def27</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def28")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def28")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def28")%>">
           	</a>	
       
			 def28</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def29")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def29")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def29")%>">
           	</a>	
       
			 def29</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def30")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def30")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def30")%>">
           	</a>	
       
			 def30</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def31")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def31")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def31")%>">
           	</a>	
       
			 def31</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def32")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def32")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def32")%>">
           	</a>	
       
			 def32</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def33")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def33")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def33")%>">
           	</a>	
       
			 def33</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def34")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def34")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def34")%>">
           	</a>	
       
			 def34</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def35")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def35")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def35")%>">
           	</a>	
       
			 def35</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def36")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def36")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def36")%>">
           	</a>	
       
			 def36</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def37")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def37")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def37")%>">
           	</a>	
       
			 def37</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def38")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def38")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def38")%>">
           	</a>	
       
			 def38</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def39")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def39")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def39")%>">
           	</a>	
       
			 def39</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def40")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def40")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def40")%>">
           	</a>	
       
			 def40</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def41")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def41")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def41")%>">
           	</a>	
       
			 def41</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def42")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def42")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def42")%>">
           	</a>	
       
			 def42</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def43")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def43")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def43")%>">
           	</a>	
       
			 def43</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def44")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def44")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def44")%>">
           	</a>	
       
			 def44</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def45")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def45")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def45")%>">
           	</a>	
       
			 def45</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def46")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def46")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def46")%>">
           	</a>	
       
			 def46</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def47")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def47")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def47")%>">
           	</a>	
       
			 def47</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def48")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def48")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def48")%>">
           	</a>	
       
			 def48</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def49")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def49")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def49")%>">
           	</a>	
       
			 def49</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def50")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def50")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def50")%>">
           	</a>	
       
			 def50</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def51")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def51")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def51")%>">
           	</a>	
       
			 def51</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def52")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def52")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def52")%>">
           	</a>	
       
			 def52</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def53")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def53")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def53")%>">
           	</a>	
       
			 def53</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def54")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def54")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def54")%>">
           	</a>	
       
			 def54</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def55")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def55")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def55")%>">
           	</a>	
       
			 def55</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def56")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def56")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def56")%>">
           	</a>	
       
			 def56</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def57")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def57")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def57")%>">
           	</a>	
       
			 def57</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def58")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def58")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def58")%>">
           	</a>	
       
			 def58</th>
			<th>
				
			  	<a href="/FAERP/PpssasalarydataAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"def59")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"def59")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"def59")%>">
           	</a>	
       
			 def59</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="department_id"/>   </td>
			
			<td><bean:write name="data" property="pay_year_month"/>   </td>
			
			<td><bean:write name="data" property="stop_flag"/>   </td>
			
			<td><bean:write name="data" property="is_verify"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="is_postpone"/>   </td>
			
			<td><bean:write name="data" property="is_email"/>   </td>
			
			<td><bean:write name="data" property="email_time"/>   </td>
			<td><bean:write name="data" property="email_user"/>   </td>
			
			<td><bean:write name="data" property="email_remarks"/>   </td>
			
			<td><bean:write name="data" property="def1"/>   </td>
			
			<td><bean:write name="data" property="def2"/>   </td>
			
			<td><bean:write name="data" property="def3"/>   </td>
			
			<td><bean:write name="data" property="def4"/>   </td>
			
			<td><bean:write name="data" property="def5"/>   </td>
			
			<td><bean:write name="data" property="is_valid"/>   </td>
			
			<td><bean:write name="data" property="note"/>   </td>
			
			<td><bean:write name="data" property="old_id"/>   </td>
			
			<td><bean:write name="data" property="pps_sa_batch_id"/>   </td>
			
			<td><bean:write name="data" property="pps_user_id"/>   </td>
			
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
			
			<td><bean:write name="data" property="def28"/>   </td>
			
			<td><bean:write name="data" property="def29"/>   </td>
			
			<td><bean:write name="data" property="def30"/>   </td>
			
			<td><bean:write name="data" property="def31"/>   </td>
			
			<td><bean:write name="data" property="def32"/>   </td>
			
			<td><bean:write name="data" property="def33"/>   </td>
			
			<td><bean:write name="data" property="def34"/>   </td>
			
			<td><bean:write name="data" property="def35"/>   </td>
			
			<td><bean:write name="data" property="def36"/>   </td>
			
			<td><bean:write name="data" property="def37"/>   </td>
			
			<td><bean:write name="data" property="def38"/>   </td>
			
			<td><bean:write name="data" property="def39"/>   </td>
			
			<td><bean:write name="data" property="def40"/>   </td>
			
			<td><bean:write name="data" property="def41"/>   </td>
			
			<td><bean:write name="data" property="def42"/>   </td>
			
			<td><bean:write name="data" property="def43"/>   </td>
			
			<td><bean:write name="data" property="def44"/>   </td>
			
			<td><bean:write name="data" property="def45"/>   </td>
			
			<td><bean:write name="data" property="def46"/>   </td>
			
			<td><bean:write name="data" property="def47"/>   </td>
			
			<td><bean:write name="data" property="def48"/>   </td>
			
			<td><bean:write name="data" property="def49"/>   </td>
			
			<td><bean:write name="data" property="def50"/>   </td>
			
			<td><bean:write name="data" property="def51"/>   </td>
			
			<td><bean:write name="data" property="def52"/>   </td>
			
			<td><bean:write name="data" property="def53"/>   </td>
			
			<td><bean:write name="data" property="def54"/>   </td>
			
			<td><bean:write name="data" property="def55"/>   </td>
			
			<td><bean:write name="data" property="def56"/>   </td>
			
			<td><bean:write name="data" property="def57"/>   </td>
			
			<td><bean:write name="data" property="def58"/>   </td>
			
			<td><bean:write name="data" property="def59"/>   </td>
			
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
	if(request.getAttribute(IPpssasalarydataConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPpssasalarydataConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
