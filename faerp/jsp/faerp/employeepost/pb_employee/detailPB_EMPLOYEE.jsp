<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.pb_employee.vo.PB_EMPLOYEEVo" %>
<%@ page import="rayoo.employeepost.pb_employee.util.IPB_EMPLOYEEConstants" %>
<%  //取出本条记录
	PB_EMPLOYEEVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (PB_EMPLOYEEVo)request.getAttribute(IPB_EMPLOYEEConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/PB_EMPLOYEEAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 
	
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	<fmt:message key="detail_page"/>
	 </div>
	 </div>
    	<div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >cust_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >company_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_sex：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_sex())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_foreigner：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_foreigner())%></td>
		</tr>
		<tr>
			<td class="td_1" >province_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProvince_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >nationality：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getNationality())%></td>
		</tr>
		<tr>
			<td class="td_1" >id_card_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getId_card_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >id_card：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getId_card())%></td>
		</tr>
		<tr>
			<td class="td_1" >birth_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBirth_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >pocicy_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPocicy_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >education_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEducation_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >tel：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTel())%></td>
		</tr>
		<tr>
			<td class="td_1" >mobile：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMobile())%></td>
		</tr>
		<tr>
			<td class="td_1" >email：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmail())%></td>
		</tr>
		<tr>
			<td class="td_1" >address：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAddress())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >postal_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPostal_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_addresss：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_addresss())%></td>
		</tr>
		<tr>
			<td class="td_1" >marriage_status_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMarriage_status_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >child_case：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getChild_case())%></td>
		</tr>
		<tr>
			<td class="td_1" >language_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLanguage_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >language_level_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLanguage_level_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >archive_card：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getArchive_card())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_have_bad_record：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_have_bad_record())%></td>
		</tr>
		<tr>
			<td class="td_1" >internal_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInternal_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_address1())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_address2())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address3：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_address3())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address4：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_address4())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address5：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_address5())%></td>
		</tr>
		<tr>
			<td class="td_1" >resident_address6：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getResident_address6())%></td>
		</tr>
		<tr>
			<td class="td_1" >insurence_address：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInsurence_address())%></td>
		</tr>
		<tr>
			<td class="td_1" >health_status_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHealth_status_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >deformity_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDeformity_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >medicare_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMedicare_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_care_object：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_care_object())%></td>
		</tr>
		<tr>
			<td class="td_1" >family_member_card_no：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFamily_member_card_no())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_national_service：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_national_service())%></td>
		</tr>
		<tr>
			<td class="td_1" >join_army_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getJoin_army_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >retire_army_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRetire_army_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >is_deformity_army：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_deformity_army())%></td>
		</tr>
		<tr>
			<td class="td_1" >tech_grade：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTech_grade())%></td>
		</tr>
		<tr>
			<td class="td_1" >tech_award_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTech_award_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >profession_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProfession_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >profession_level：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProfession_level())%></td>
		</tr>
		<tr>
			<td class="td_1" >profession_award_unit：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProfession_award_unit())%></td>
		</tr>
		<tr>
			<td class="td_1" >profession_award_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProfession_award_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >begin_work_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBegin_work_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_desc：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_desc())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >tech_award_unit：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTech_award_unit())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_status：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_status())%></td>
		</tr>
		<tr>
			<td class="td_1" align="right"></td>
			<td class="td_2" align="left"></td>
		</tr>
	</table>
</div>


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
