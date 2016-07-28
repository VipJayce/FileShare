<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List"%>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%@ page import="rayoo.employeepost.empinfo.employee.util.IEmployeeConstants" %>
<%  //取出本条记录
    EmployeeVo resultVo = null;  //定义一个临时的vo<fmt:message key='detailEmployee0000'/>
    resultVo = (EmployeeVo)request.getAttribute(IEmployeeConstants.REQUEST_BEAN);  //从request<fmt:message key='detailEmployee0001'/>vo, <fmt:message key='detailEmployee0002'/>resultVo
    
    String isHaveBadRecord = resultVo.getIs_have_bad_record(); //是否有不良记录
    String isCareObject = resultVo.getIs_care_object(); //是否市级保健对象
    String isDeformityArmy = resultVo.getIs_deformity_army(); //是否伤残军人
%>
<%@page import="rayoo.employeepost.empinfo.empsibling.vo.EmpsiblingVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.detailEmployee_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工<fmt:message key='detailEmployee0004'/></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
       window.close();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
    <div id="right">
    <div class="ringht_s">

    <div id="ccChild0" class="box_3">
    <div class="xz_title"><fmt:message key='detailEmployee0004'/></div>
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td width="16%" class="td_1"><fmt:message key='detailEmployee0006'/>：</td>
            <td width="18%" class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0006'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>" readonly="readonly" />
            </td>
            <td width="16%" class="td_1"><fmt:message key='detailEmployee0008'/>：</td>
            <td width="18%" class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0008'/>" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>" readonly="readonly" />
            </td>
            <td width="16%" class="td_1"><fmt:message key='detailEmployee0010'/>：</td>
            <td width="16%" class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0010'/>" value="<%=BaseDataHelper.getNameByCode("EMP_SEX",RmStringHelper.prt(resultVo.getEmp_sex()))%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='detailEmployee0012'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0012'/>" value="<%=BaseDataHelper.getNameByCode("IS_FOREIGNER",RmStringHelper.prt(resultVo.getIs_foreigner()))%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0013'/></td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0014'/>" value="<faerp:cityViewTag  beanname="bean" attribute="province_bd" />"  readonly="readonly"/>
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0016'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0016'/>" value="<%=RmStringHelper.prt(resultVo.getNationality())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='detailEmployee0018'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0018'/>" value="<%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0020'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0020'/>" value="<%=RmStringHelper.prt(resultVo.getId_card())%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0022'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0022'/>" value="<%=RmStringHelper.prt(resultVo.getBirth_date(), 10)%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='detailEmployee0024'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0024'/>" value="<%=BaseDataHelper.getNameByCode("POCICY_BD",RmStringHelper.prt(resultVo.getPocicy_bd()))%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0026'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0026'/>" value="<%=BaseDataHelper.getNameByCode("EDUCATION_BD",RmStringHelper.prt(resultVo.getEducation_bd()))%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0028'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0028'/>" value="<%=RmStringHelper.prt(resultVo.getContact_tel1())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='detailEmployee0030'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0030'/>" value="<%=RmStringHelper.prt(resultVo.getMobile())%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0032'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0032'/>" value="<%=RmStringHelper.prt(resultVo.getEmail())%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0034'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0034'/>" value="<%=RmStringHelper.prt(resultVo.getAddress())%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='detailEmployee0036'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0036'/>" value="<%=RmStringHelper.prt(resultVo.getResident_code())%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0038'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0038'/>" value="<%=RmStringHelper.prt(resultVo.getPostal_code())%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0040'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0040'/>" value="<%=BaseDataHelper.getNameByCode("RESIDENT_TYPE_BD",RmStringHelper.prt(resultVo.getResident_type_bd()))%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='detailEmployee0042'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0042'/>" value="<%=RmStringHelper.prt(resultVo.getResident_addresss().equals("null")?"":resultVo.getResident_addresss())%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0044'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0044'/>" value="<%=BaseDataHelper.getNameByCode("MARRIAGE_STATUS_BD",RmStringHelper.prt(resultVo.getMarriage_status_bd()))%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0045'/></td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0046'/>" value="<%=BaseDataHelper.getNameByCode("LANGUAGE_TYPE_BD",RmStringHelper.prt(resultVo.getLanguage_type_bd()))%>" readonly="readonly" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='detailEmployee0048'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0048'/>" value="<%=BaseDataHelper.getNameByCode("LANGUAGE_LEVEL_BD",RmStringHelper.prt(resultVo.getLanguage_level_bd()))%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0050'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0050'/>" value="<%=RmStringHelper.prt(resultVo.getArchive_card())%>" readonly="readonly" />
            </td>
            <td class="td_1"><fmt:message key='detailEmployee0051'/></td>
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
            <td class="td_1"><fmt:message key='detailEmployee0053'/>：</td>
            <td class="td_2">
                 <input type="text" class="text_field" inputName="<fmt:message key='detailEmployee0053'/>" value="<%=RmStringHelper.prt(resultVo.getInternal_code())%>" readonly="readonly" />
            </td>
            <td class="td_2">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
            <td colspan="2" class="td_2">&nbsp;</td>
            </tr>
    </table>
    
    

    

    </div>
    <input type="hidden" name="id"
        value="<%=RmStringHelper.prt(resultVo.getId())%>"></div>

    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>
