<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.pb_employee.vo.PB_EMPLOYEEVo" %>
<%@ page import="rayoo.employeepost.pb_employee.util.IPB_EMPLOYEEConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IPB_EMPLOYEEConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IPB_EMPLOYEEConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	PB_EMPLOYEEVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/PB_EMPLOYEEAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/PB_EMPLOYEEAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/pb_employee/insertPB_EMPLOYEE.jsp";
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
		form.action="<%=request.getContextPath()%>/PB_EMPLOYEEAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/PB_EMPLOYEEAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
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
			<td align="right">cust_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cust_code</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
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
			<td align="right">emp_code</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code" inputName="emp_code" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_name</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" inputName="emp_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_sex</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_sex" inputName="emp_sex" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_foreigner</td>
			<td align="left">
				<input type="text" class="text_field" name="is_foreigner" inputName="is_foreigner" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">province_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="province_bd" inputName="province_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">nationality</td>
			<td align="left">
				<input type="text" class="text_field" name="nationality" inputName="nationality" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">id_card_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="id_card_type_bd" inputName="id_card_type_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">id_card</td>
			<td align="left">
				<input type="text" class="text_field" name="id_card" inputName="id_card" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">birth_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="birth_date_from" id="birth_date_from" inputName="birth_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('birth_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="birth_date_to" id="birth_date_to" inputName="birth_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('birth_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pocicy_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="pocicy_bd" inputName="pocicy_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">education_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="education_bd" inputName="education_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">tel</td>
			<td align="left">
				<input type="text" class="text_field" name="tel" inputName="tel" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">mobile</td>
			<td align="left">
				<input type="text" class="text_field" name="mobile" inputName="mobile" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">email</td>
			<td align="left">
				<input type="text" class="text_field" name="email" inputName="email" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">address</td>
			<td align="left">
				<input type="text" class="text_field" name="address" inputName="address" maxLength="250"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_code</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_code" inputName="resident_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">postal_code</td>
			<td align="left">
				<input type="text" class="text_field" name="postal_code" inputName="postal_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_type_bd" inputName="resident_type_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_addresss</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_addresss" inputName="resident_addresss" maxLength="250"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">marriage_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="marriage_status_bd" inputName="marriage_status_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">child_case</td>
			<td align="left">
				<input type="text" class="text_field" name="child_case" inputName="child_case" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">language_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="language_type_bd" inputName="language_type_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">language_level_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="language_level_bd" inputName="language_level_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">archive_card</td>
			<td align="left">
				<input type="text" class="text_field" name="archive_card" inputName="archive_card" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_have_bad_record</td>
			<td align="left">
				<input type="text" class="text_field" name="is_have_bad_record" inputName="is_have_bad_record" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">internal_code</td>
			<td align="left">
				<input type="text" class="text_field" name="internal_code" inputName="internal_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_address1</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_address1" inputName="resident_address1" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_address2</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_address2" inputName="resident_address2" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_address3</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_address3" inputName="resident_address3" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_address4</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_address4" inputName="resident_address4" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_address5</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_address5" inputName="resident_address5" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">resident_address6</td>
			<td align="left">
				<input type="text" class="text_field" name="resident_address6" inputName="resident_address6" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">insurence_address</td>
			<td align="left">
				<input type="text" class="text_field" name="insurence_address" inputName="insurence_address" maxLength="250"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">health_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="health_status_bd" inputName="health_status_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">deformity_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="deformity_type_bd" inputName="deformity_type_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">medicare_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="medicare_type_bd" inputName="medicare_type_bd" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_care_object</td>
			<td align="left">
				<input type="text" class="text_field" name="is_care_object" inputName="is_care_object" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">family_member_card_no</td>
			<td align="left">
				<input type="text" class="text_field" name="family_member_card_no" inputName="family_member_card_no" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_national_service</td>
			<td align="left">
				<input type="text" class="text_field" name="is_national_service" inputName="is_national_service" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">join_army_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="join_army_date_from" id="join_army_date_from" inputName="join_army_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('join_army_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="join_army_date_to" id="join_army_date_to" inputName="join_army_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('join_army_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">retire_army_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="retire_army_date_from" id="retire_army_date_from" inputName="retire_army_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('retire_army_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="retire_army_date_to" id="retire_army_date_to" inputName="retire_army_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('retire_army_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_deformity_army</td>
			<td align="left">
				<input type="text" class="text_field" name="is_deformity_army" inputName="is_deformity_army" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">tech_grade</td>
			<td align="left">
				<input type="text" class="text_field" name="tech_grade" inputName="tech_grade" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">tech_award_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="tech_award_date_from" id="tech_award_date_from" inputName="tech_award_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('tech_award_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="tech_award_date_to" id="tech_award_date_to" inputName="tech_award_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('tech_award_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">profession_name</td>
			<td align="left">
				<input type="text" class="text_field" name="profession_name" inputName="profession_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">profession_level</td>
			<td align="left">
				<input type="text" class="text_field" name="profession_level" inputName="profession_level" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">profession_award_unit</td>
			<td align="left">
				<input type="text" class="text_field" name="profession_award_unit" inputName="profession_award_unit" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">profession_award_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="profession_award_date_from" id="profession_award_date_from" inputName="profession_award_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('profession_award_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="profession_award_date_to" id="profession_award_date_to" inputName="profession_award_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('profession_award_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">begin_work_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="begin_work_date_from" id="begin_work_date_from" inputName="begin_work_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('begin_work_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="begin_work_date_to" id="begin_work_date_to" inputName="begin_work_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('begin_work_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_desc</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_desc" inputName="emp_desc" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">last_update_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">last_update_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="last_update_date_from" id="last_update_date_from" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="last_update_date_to" id="last_update_date_to" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">tech_award_unit</td>
			<td align="left">
				<input type="text" class="text_field" name="tech_award_unit" inputName="tech_award_unit" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">emp_status</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_status" inputName="emp_status" maxLength="64"/>
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
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_id")%>">
           	</a>	
       
			 cust_id</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_code")%>">
           	</a>	
       
			 cust_code</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_name")%>">
           	</a>	
       
			 cust_name</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_code")%>">
           	</a>	
       
			 emp_code</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_name")%>">
           	</a>	
       
			 emp_name</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_sex")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_sex")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_sex")%>">
           	</a>	
       
			 emp_sex</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_foreigner")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_foreigner")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_foreigner")%>">
           	</a>	
       
			 is_foreigner</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"province_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"province_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"province_bd")%>">
           	</a>	
       
			 province_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"nationality")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"nationality")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"nationality")%>">
           	</a>	
       
			 nationality</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"id_card_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"id_card_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"id_card_type_bd")%>">
           	</a>	
       
			 id_card_type_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"id_card")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"id_card")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"id_card")%>">
           	</a>	
       
			 id_card</th>
			<th>
							
				 	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"birth_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"birth_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"birth_date")%>">
           	</a>	
       
			birth_date</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pocicy_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pocicy_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pocicy_bd")%>">
           	</a>	
       
			 pocicy_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"education_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"education_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"education_bd")%>">
           	</a>	
       
			 education_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"tel")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"tel")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"tel")%>">
           	</a>	
       
			 tel</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"mobile")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"mobile")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"mobile")%>">
           	</a>	
       
			 mobile</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"email")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"email")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"email")%>">
           	</a>	
       
			 email</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"address")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"address")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"address")%>">
           	</a>	
       
			 address</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_code")%>">
           	</a>	
       
			 resident_code</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"postal_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"postal_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"postal_code")%>">
           	</a>	
       
			 postal_code</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_type_bd")%>">
           	</a>	
       
			 resident_type_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_addresss")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_addresss")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_addresss")%>">
           	</a>	
       
			 resident_addresss</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"marriage_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"marriage_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"marriage_status_bd")%>">
           	</a>	
       
			 marriage_status_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"child_case")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"child_case")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"child_case")%>">
           	</a>	
       
			 child_case</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"language_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"language_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"language_type_bd")%>">
           	</a>	
       
			 language_type_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"language_level_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"language_level_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"language_level_bd")%>">
           	</a>	
       
			 language_level_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"archive_card")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"archive_card")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"archive_card")%>">
           	</a>	
       
			 archive_card</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_have_bad_record")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_have_bad_record")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_have_bad_record")%>">
           	</a>	
       
			 is_have_bad_record</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"internal_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"internal_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"internal_code")%>">
           	</a>	
       
			 internal_code</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_address1")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_address1")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_address1")%>">
           	</a>	
       
			 resident_address1</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_address2")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_address2")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_address2")%>">
           	</a>	
       
			 resident_address2</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_address3")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_address3")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_address3")%>">
           	</a>	
       
			 resident_address3</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_address4")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_address4")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_address4")%>">
           	</a>	
       
			 resident_address4</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_address5")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_address5")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_address5")%>">
           	</a>	
       
			 resident_address5</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"resident_address6")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"resident_address6")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"resident_address6")%>">
           	</a>	
       
			 resident_address6</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"insurence_address")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"insurence_address")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"insurence_address")%>">
           	</a>	
       
			 insurence_address</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"health_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"health_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"health_status_bd")%>">
           	</a>	
       
			 health_status_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"deformity_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"deformity_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"deformity_type_bd")%>">
           	</a>	
       
			 deformity_type_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"medicare_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"medicare_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"medicare_type_bd")%>">
           	</a>	
       
			 medicare_type_bd</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_care_object")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_care_object")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_care_object")%>">
           	</a>	
       
			 is_care_object</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"family_member_card_no")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"family_member_card_no")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"family_member_card_no")%>">
           	</a>	
       
			 family_member_card_no</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_national_service")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_national_service")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_national_service")%>">
           	</a>	
       
			 is_national_service</th>
			<th>
							
				 	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"join_army_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"join_army_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"join_army_date")%>">
           	</a>	
       
			join_army_date</th>
			<th>
							
				 	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"retire_army_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"retire_army_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"retire_army_date")%>">
           	</a>	
       
			retire_army_date</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_deformity_army")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_deformity_army")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_deformity_army")%>">
           	</a>	
       
			 is_deformity_army</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"tech_grade")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"tech_grade")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"tech_grade")%>">
           	</a>	
       
			 tech_grade</th>
			<th>
							
				 	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"tech_award_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"tech_award_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"tech_award_date")%>">
           	</a>	
       
			tech_award_date</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"profession_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"profession_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"profession_name")%>">
           	</a>	
       
			 profession_name</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"profession_level")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"profession_level")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"profession_level")%>">
           	</a>	
       
			 profession_level</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"profession_award_unit")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"profession_award_unit")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"profession_award_unit")%>">
           	</a>	
       
			 profession_award_unit</th>
			<th>
							
				 	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"profession_award_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"profession_award_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"profession_award_date")%>">
           	</a>	
       
			profession_award_date</th>
			<th>
							
				 	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"begin_work_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"begin_work_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"begin_work_date")%>">
           	</a>	
       
			begin_work_date</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_desc")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_desc")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_desc")%>">
           	</a>	
       
			 emp_desc</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"tech_award_unit")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"tech_award_unit")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"tech_award_unit")%>">
           	</a>	
       
			 tech_award_unit</th>
			<th>
				
			  	<a href="/FAERP/PB_EMPLOYEEAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"emp_status")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"emp_status")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"emp_status")%>">
           	</a>	
       
			 emp_status</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="cust_id"/>   </td>
			
			<td><bean:write name="data" property="cust_code"/>   </td>
			
			<td><bean:write name="data" property="cust_name"/>   </td>
			
			<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="emp_code"/>   </td>
			
			<td><bean:write name="data" property="emp_name"/>   </td>
			
			<td><bean:write name="data" property="emp_sex"/>   </td>
			
			<td><bean:write name="data" property="is_foreigner"/>   </td>
			
			<td><bean:write name="data" property="province_bd"/>   </td>
			
			<td><bean:write name="data" property="nationality"/>   </td>
			
			<td><bean:write name="data" property="id_card_type_bd"/>   </td>
			
			<td><bean:write name="data" property="id_card"/>   </td>
			
			<td><bean:write name="data" property="birth_date"/>   </td>
			<td><bean:write name="data" property="pocicy_bd"/>   </td>
			
			<td><bean:write name="data" property="education_bd"/>   </td>
			
			<td><bean:write name="data" property="tel"/>   </td>
			
			<td><bean:write name="data" property="mobile"/>   </td>
			
			<td><bean:write name="data" property="email"/>   </td>
			
			<td><bean:write name="data" property="address"/>   </td>
			
			<td><bean:write name="data" property="resident_code"/>   </td>
			
			<td><bean:write name="data" property="postal_code"/>   </td>
			
			<td><bean:write name="data" property="resident_type_bd"/>   </td>
			
			<td><bean:write name="data" property="resident_addresss"/>   </td>
			
			<td><bean:write name="data" property="marriage_status_bd"/>   </td>
			
			<td><bean:write name="data" property="child_case"/>   </td>
			
			<td><bean:write name="data" property="language_type_bd"/>   </td>
			
			<td><bean:write name="data" property="language_level_bd"/>   </td>
			
			<td><bean:write name="data" property="archive_card"/>   </td>
			
			<td><bean:write name="data" property="is_have_bad_record"/>   </td>
			
			<td><bean:write name="data" property="internal_code"/>   </td>
			
			<td><bean:write name="data" property="resident_address1"/>   </td>
			
			<td><bean:write name="data" property="resident_address2"/>   </td>
			
			<td><bean:write name="data" property="resident_address3"/>   </td>
			
			<td><bean:write name="data" property="resident_address4"/>   </td>
			
			<td><bean:write name="data" property="resident_address5"/>   </td>
			
			<td><bean:write name="data" property="resident_address6"/>   </td>
			
			<td><bean:write name="data" property="insurence_address"/>   </td>
			
			<td><bean:write name="data" property="health_status_bd"/>   </td>
			
			<td><bean:write name="data" property="deformity_type_bd"/>   </td>
			
			<td><bean:write name="data" property="medicare_type_bd"/>   </td>
			
			<td><bean:write name="data" property="is_care_object"/>   </td>
			
			<td><bean:write name="data" property="family_member_card_no"/>   </td>
			
			<td><bean:write name="data" property="is_national_service"/>   </td>
			
			<td><bean:write name="data" property="join_army_date"/>   </td>
			<td><bean:write name="data" property="retire_army_date"/>   </td>
			<td><bean:write name="data" property="is_deformity_army"/>   </td>
			
			<td><bean:write name="data" property="tech_grade"/>   </td>
			
			<td><bean:write name="data" property="tech_award_date"/>   </td>
			<td><bean:write name="data" property="profession_name"/>   </td>
			
			<td><bean:write name="data" property="profession_level"/>   </td>
			
			<td><bean:write name="data" property="profession_award_unit"/>   </td>
			
			<td><bean:write name="data" property="profession_award_date"/>   </td>
			<td><bean:write name="data" property="begin_work_date"/>   </td>
			<td><bean:write name="data" property="emp_desc"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="tech_award_unit"/>   </td>
			
			<td><bean:write name="data" property="emp_status"/>   </td>
			
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
	if(request.getAttribute(IPB_EMPLOYEEConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IPB_EMPLOYEEConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
