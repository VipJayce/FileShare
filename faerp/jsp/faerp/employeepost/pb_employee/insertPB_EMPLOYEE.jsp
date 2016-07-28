<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.pb_employee.vo.PB_EMPLOYEEVo" %>
<%@ page import="rayoo.employeepost.pb_employee.util.IPB_EMPLOYEEConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	PB_EMPLOYEEVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPB_EMPLOYEEConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (PB_EMPLOYEEVo)request.getAttribute(IPB_EMPLOYEEConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/PB_EMPLOYEEAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/PB_EMPLOYEEAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/PB_EMPLOYEEAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_1" >cust_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cust_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cust_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >company_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="company_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >emp_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_code" inputName="emp_code" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >emp_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_name" inputName="emp_name" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >emp_sex</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_sex" inputName="emp_sex" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_foreigner</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_foreigner" inputName="is_foreigner" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >province_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="province_bd" inputName="province_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >nationality</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="nationality" inputName="nationality" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >id_card_type_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="id_card_type_bd" inputName="id_card_type_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >id_card</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="id_card" inputName="id_card" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >birth_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="birth_date" id="birth_date" inputName="birth_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('birth_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pocicy_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pocicy_bd" inputName="pocicy_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >education_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="education_bd" inputName="education_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >tel</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="tel" inputName="tel" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >mobile</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="mobile" inputName="mobile" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >email</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="email" inputName="email" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >address</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="address" inputName="address" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_code" inputName="resident_code" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >postal_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="postal_code" inputName="postal_code" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_type_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_type_bd" inputName="resident_type_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_addresss</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_addresss" inputName="resident_addresss" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >marriage_status_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="marriage_status_bd" inputName="marriage_status_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >child_case</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="child_case" inputName="child_case" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >language_type_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="language_type_bd" inputName="language_type_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >language_level_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="language_level_bd" inputName="language_level_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >archive_card</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="archive_card" inputName="archive_card" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_have_bad_record</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_have_bad_record" inputName="is_have_bad_record" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >internal_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="internal_code" inputName="internal_code" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address1</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_address1" inputName="resident_address1" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address2</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_address2" inputName="resident_address2" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address3</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_address3" inputName="resident_address3" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address4</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_address4" inputName="resident_address4" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address5</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_address5" inputName="resident_address5" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address6</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="resident_address6" inputName="resident_address6" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >insurence_address</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="insurence_address" inputName="insurence_address" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >health_status_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="health_status_bd" inputName="health_status_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >deformity_type_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="deformity_type_bd" inputName="deformity_type_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >medicare_type_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="medicare_type_bd" inputName="medicare_type_bd" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_care_object</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_care_object" inputName="is_care_object" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >family_member_card_no</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="family_member_card_no" inputName="family_member_card_no" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_national_service</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_national_service" inputName="is_national_service" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >join_army_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="join_army_date" id="join_army_date" inputName="join_army_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('join_army_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >retire_army_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="retire_army_date" id="retire_army_date" inputName="retire_army_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('retire_army_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_deformity_army</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_deformity_army" inputName="is_deformity_army" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >tech_grade</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="tech_grade" inputName="tech_grade" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >tech_award_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="tech_award_date" id="tech_award_date" inputName="tech_award_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('tech_award_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >profession_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="profession_name" inputName="profession_name" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >profession_level</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="profession_level" inputName="profession_level" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >profession_award_unit</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="profession_award_unit" inputName="profession_award_unit" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >profession_award_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="profession_award_date" id="profession_award_date" inputName="profession_award_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('profession_award_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >begin_work_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="begin_work_date" id="begin_work_date" inputName="begin_work_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('begin_work_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">emp_desc</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="emp_desc" inputName="emp_desc" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="last_update_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >tech_award_unit</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="tech_award_unit" inputName="tech_award_unit" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >emp_status</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_status" inputName="emp_status" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
		</tr>
	</table>
 

            
   
   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
