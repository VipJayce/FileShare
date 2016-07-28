<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%@ page import="rayoo.employeepost.empinfo.employee.util.IEmployeeConstants" %>
<%  //取出本条记录
	EmployeeVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (EmployeeVo)request.getAttribute(IEmployeeConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	
	String isHaveBadRecord = resultVo.getIs_have_bad_record(); //是否有不良记录
	String isCareObject = resultVo.getIs_care_object(); //是否市级保健对象
	String isDeformityArmy = resultVo.getIs_deformity_army(); //是否伤残军人
	String reg=request.getParameter("flag");
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empinfo.employee.employee_resource" prefix="rayoo.employeepost.empinfo.employee.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
    function back_onClick(reg){  //返回列表页面
        var opener = window.opener;
        if (opener){
            window.close();
            return;
        }
       if("${backType}" == 'has'){
            datacell_formid.action="<%=request.getContextPath()%>/CertificateItemAction.do?cmd=detailForHas&empId=${empId}";
       }else if("${backType}" == 'check'){
           datacell_formid.action="<%=request.getContextPath()%>/CertificateItemAction.do?cmd=checkCertificate&empId=${empId}";
       }else{
           datacell_formid.action="<%=request.getContextPath()%>/FaerpEmployeeAction.do?cmd=queryAll";
       }
        datacell_formid.submit();
    }
    
</script>
</head>
<body>
 
<form name="datacell_formid" method="post" id="datacell_formid">
	<div id="right">
	<div class="right_title_bg">
     <div class=" right_title"><fmt:message key="emp_info"/></div>
     </div>
     <div style="float: right;"><fmt:message key="last_update_user"/>： <%=RmStringHelper.prt(resultVo.getLast_update_user_id())%>&nbsp;&nbsp;&nbsp;<fmt:message key="last_update_date"/>： <%=RmStringHelper.prt(resultVo.getLast_update_date(),10)%></div>
	<div class="ringht_s">    
	<div id="ccChild0" class="box_3">
	
	<div class="xz_title"><fmt:message key="info"/></div>
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td width="16%" class="td_1"><fmt:message key="emp_code1"/>：</td>
			<td width="18%" class="td_2">
			     <input type="text" class="text_field" inputName="雇员编号" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>" readonly="readonly" />
			</td>
			<td width="16%" class="td_1"><fmt:message key="employee_name"/>：</td>
			<td width="18%" class="td_2">
			     <input type="text" class="text_field" inputName="员工姓名" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>" readonly="readonly" />
			</td>
			<td width="16%" class="td_1"><fmt:message key="emp_sex"/>：</td>
			<td width="16%" class="td_2">
			     <input type="text" class="text_field" inputName="性别" value="<%=BaseDataHelper.getNameByCode("EMP_SEX",RmStringHelper.prt(resultVo.getEmp_sex()))%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="is_foreigner"/>：</td>
			<td class="td_2">
<!--			     <input type="text" class="text_field" inputName="是否外国人" value="<%=BaseDataHelper.getNameByCode("IS_FOREIGNER",RmStringHelper.prt(resultVo.getIs_foreigner()))%>" readonly="readonly" />-->
			</td>
			<td class="td_1"><fmt:message key="country"/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" value="${bean.country_name }" readonly="readonly" />
            </td>
			<td class="td_1"><fmt:message key="province_id"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="省市" value="<faerp:cityViewTag  beanname="bean" attribute="province_bd" />"  readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="nationality"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="民族" value="<%=RmStringHelper.prt(resultVo.getNationality())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="credentials_type"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="证件类型" value="<%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="id_card"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="证件号码" value="<%=RmStringHelper.prt(resultVo.getId_card())%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="birthday"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="生日" value="<%=RmStringHelper.prt(resultVo.getBirth_date(), 10)%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="pocicy"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="政治面貌" value="<%=BaseDataHelper.getNameByCode("POCICY_BD",RmStringHelper.prt(resultVo.getPocicy_bd()))%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="education"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="教育程度" value="<%=BaseDataHelper.getNameByCode("EDUCATION_BD",RmStringHelper.prt(resultVo.getEducation_bd()))%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="contact_tel1"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="联系电话" value="<%=RmStringHelper.prt(resultVo.getContact_tel1())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="tel"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="手机" value="<%=RmStringHelper.prt(resultVo.getMobile())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="email"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="电子邮件" value="<%=RmStringHelper.prt(resultVo.getEmail())%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="address1"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="联系地址" value="<%=RmStringHelper.prt(resultVo.getAddress())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="resident_code"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="户籍编号" value="<%=RmStringHelper.prt(resultVo.getResident_code())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="postal_code"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="邮政编码" value="<%=RmStringHelper.prt(resultVo.getPostal_code())%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="resident_type"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="户口类别" value="<%=BaseDataHelper.getNameByCode("RESIDENT_TYPE_BD",RmStringHelper.prt(resultVo.getResident_type_bd()))%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="resident_address"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="户口所在地" value="<%=RmStringHelper.prt(resultVo.getResident_addresss())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="insurence_address"/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="家财投保地址" value="<%=RmStringHelper.prt(resultVo.getInsurence_address())%>" readonly="readonly" />
            </td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="marriage_status"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="婚姻状况" value="<%=BaseDataHelper.getNameByCode("MARRIAGE_STATUS_BD",RmStringHelper.prt(resultVo.getMarriage_status_bd()))%>" readonly="readonly" />
			</td>			
		    <td class="td_1"><fmt:message key="language_type"/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="外语语种" value="<%=BaseDataHelper.getNameByCode("LANGUAGE_TYPE_BD",RmStringHelper.prt(resultVo.getLanguage_type_bd()))%>" readonly="readonly" />
            </td>
			<td class="td_1"><fmt:message key="language_level"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="外语等级" value="<%=BaseDataHelper.getNameByCode("LANGUAGE_LEVEL_BD",RmStringHelper.prt(resultVo.getLanguage_level_bd()))%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="archive_card"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="存档卡" value="<%=RmStringHelper.prt(resultVo.getArchive_card())%>" readonly="readonly" />
			</td>			
			<td class="td_1"><fmt:message key="internal_code1"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="内部编号" value="<%=RmStringHelper.prt(resultVo.getInternal_code())%>" readonly="readonly" />
			</td>
			<td class="td_1" ><fmt:message key="is_incompleteinfo"/>:</td>
            <td class="td_2" >
            <input type="text" class="text_field" inputName="是否信息不全" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_incompleteinfo()))%>" readonly="readonly" />

		</tr>	
<% if((resultVo.getCompany_id())!=null&&(resultVo.getCompany_id()).equals(IEmployeeConstants.COMPANY_ID_HZ)) {%>
       
        <tr>
                <td class="td_1" >户口性质</td>
                <td class="td_2 ">
	                <input type="text" class="text_field" inputName="户口性质" value="<%=BaseDataHelper.getNameByCode("RESIDENT_PROPERTY_BD",RmStringHelper.prt(resultVo.getResident_property_bd()))%>" readonly="readonly" />
	            </td>
	            <td class="td_2" colspan="4"></td>
	   </tr> 
<%}%>
                

        

	</table>
	
	<p></p>
	<div class="xz_title"><fmt:message key="address_manually_split_account"/></div>
	<table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td width="16%" class="td_1"><fmt:message key="resident_address1"/>：</td>
			<td width="18%" class="td_2">
			     <input type="text" class="text_field" inputName="区、县" value="<%=RmStringHelper.prt(resultVo.getResident_address1())%>" readonly="readonly" />
			</td>
			<td width="16%" class="td_1"><fmt:message key="resident_address2"/>：</td>
			<td width="18%" class="td_2">
			     <input type="text" class="text_field" inputName="街道、乡、镇" value="<%=RmStringHelper.prt(resultVo.getResident_address2())%>" readonly="readonly" />
			</td>
			<td width="16%" class="td_1"><fmt:message key="resident_address3"/>：</td>
			<td width="16%" class="td_2">
			     <input type="text" class="text_field" inputName="路" value="<%=RmStringHelper.prt(resultVo.getResident_address3())%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="resident_address4"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="弄、村" value="<%=RmStringHelper.prt(resultVo.getResident_address4())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="resident_address5"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="号" value="<%=RmStringHelper.prt(resultVo.getResident_address5())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="resident_address6"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="室、队" value="<%=RmStringHelper.prt(resultVo.getResident_address6())%>" readonly="readonly" />
			</td>
		</tr>
	</table>
	
	<p></p>
	</div>
	<div class="xz_title"><fmt:message key="sib_info"/></div>
	<div style="padding: 8 0 8 8;" >
        <r:datacell 
            id="datacell1"
            paramFormId="datacell_formid"
            queryAction="/FAERP/FaerpEmployeeAction.do?cmd=searchEmpSiblingData&emp_id=${emp_id}"
            width="99%"
            height="300px"
            xpath="EmpsiblingVo"
            readonly="true"
            pageSize="-1"
            >
          <r:field fieldName="sib_name" messagekey="name">
            <h:text/>
          </r:field>
          <r:field fieldName="sib_relation" messagekey="sib_relation">
            <d:select dictTypeId="SIB_RELATION" />
          </r:field>
          <r:field fieldName="sib_id_card_num" messagekey="id_card" width="180px">
            <h:text/>
          </r:field>
          <r:field fieldName="sib_id_card_type_bd" messagekey="id_card_type" width="130px">
            <d:select dictTypeId="ID_CARD_TYPE_BD" />
          </r:field>
          <r:field fieldName="sib_sex_bd" messagekey="emp_sex">
            <d:select dictTypeId="EMP_SEX" />
          </r:field>
          <r:field fieldName="sib_birthday" messagekey="sib_birthday" width="130px">
           <w:date format="yyyy-MM-dd"/>
          </r:field>
          <r:field fieldName="sib_desc" messagekey="remark" width="220px">
            <h:text/>
          </r:field>
        </r:datacell>
    </div>  
	
	<p></p>
	<div class="box_3">
	<div class="xz_title"><fmt:message key="add_info"/></div>
	<table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><fmt:message key="health_status"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="健康状况" value="<%=BaseDataHelper.getNameByCode("HEALTH_STATUS_BD",RmStringHelper.prt(resultVo.getHealth_status_bd()))%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="deformity_type"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="残疾类型" value="<%=BaseDataHelper.getNameByCode("DEFORMITY_TYPE_BD",RmStringHelper.prt(resultVo.getDeformity_type_bd()))%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="medicare_type"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="医疗保障类别" value="<%=BaseDataHelper.getNameByCode("MEDICARE_TYPE_BD",RmStringHelper.prt(resultVo.getMedicare_type_bd()))%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="is_care_object"/>：</td>
			<%if(isCareObject!=null&&isCareObject.equals("1")) {%>
            <td class="td_2">
                 <input type='checkbox' name="is_care_object" checked="checked" disabled="disabled"/>
            </td>
            <%}else{ %>
            <td class="td_2">
                 <input type='checkbox' name=""is_care_object"" disabled="disabled"/>
            </td>
            <%} %>
			<td class="td_1"><fmt:message key="family_member_card_no"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="家属劳保卡号" value="<%=RmStringHelper.prt(resultVo.getFamily_member_card_no())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="is_national_service"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="兵役状况" value="<%=BaseDataHelper.getNameByCode("IS_NATIONAL_SERVICE",RmStringHelper.prt(resultVo.getIs_national_service()))%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="join_army_date"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="参军日期" value="<%=RmStringHelper.prt(resultVo.getJoin_army_date(), 10)%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="retire_army_date"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="转业日期" value="<%=RmStringHelper.prt(resultVo.getRetire_army_date(), 10)%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="is_care_object1"/>：</td>
			<%if(isDeformityArmy!=null&&isDeformityArmy.equals("1")) {%>
            <td class="td_2">
                 <input type='checkbox' name="is_care_object" checked="checked" disabled="disabled"/>
            </td>
            <%}else{ %>
            <td class="td_2">
                 <input type='checkbox' name=""is_care_object"" disabled="disabled"/>
            </td>
            <%} %>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="tech_grade"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="专业技术职称" value="<%=BaseDataHelper.getNameByCode("TECH_GRADE",RmStringHelper.prt(resultVo.getTech_grade()))%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="tech_award_unit"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="职称发证单位" value="<%=RmStringHelper.prt(resultVo.getTech_award_unit())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="tech_award_date"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="职称发证日期" value="<%=RmStringHelper.prt(resultVo.getTech_award_date(), 10)%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="profession_name"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="职业工种名称" value="<%=RmStringHelper.prt(resultVo.getProfession_name())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="profession_level"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="职业工种等级" value="<%=RmStringHelper.prt(resultVo.getProfession_level())%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="profession_award_unit"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="职业工种发证单位" value="<%=RmStringHelper.prt(resultVo.getProfession_award_unit())%>" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="profession_award_date"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="职业工种发证日期" value="<%=RmStringHelper.prt(resultVo.getProfession_award_date(), 10)%>" readonly="readonly" />
			</td>
			<td class="td_1"><fmt:message key="begin_work_date"/>：</td>
			<td class="td_2">
			     <input type="text" class="text_field" inputName="首次参加工作日期" value="<%=RmStringHelper.prt(resultVo.getBegin_work_date(), 10)%>" readonly="readonly" />
			</td><td class="td_1"><fmt:message key="is_have_bad_record"/>：</td>
            <%if(isHaveBadRecord!=null&&isHaveBadRecord.equals("1")) {%>
            <td class="td_2">
                 <input type='checkbox' name="is_have_bad_record" checked="checked" disabled="disabled"/>
            </td>
            <%}else{ %>
            <td class="td_2">
                 <input type='checkbox' name="is_have_bad_record" disabled="disabled"/>
            </td>
            <%} %>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="remark"/>：</td>
			<td colspan="5" class="td_2">
			     <textarea rows="4" name="remark" style="width:350px" readonly="readonly" inputName="备注"><%=RmStringHelper.prt(resultVo.getEmp_desc())%></textarea>
			</td>
		</tr>
	</table>
	</div>

	<div class="foot_button">
	   <input type="button" class="foot_icon_1" value="<fmt:message key="go_back"/>" onclick="javascript:back_onClick(<%=reg %>);" />
	</div>

	</div>
	<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">
	</div>

	</form>
</fmt:bundle>
</body>
</html>
