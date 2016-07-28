<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@ page import="rayoo.sales.customer.util.ICustomerConstants" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录 
	CustomerVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (CustomerVo)request.getAttribute(ICustomerConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.null2Nothing(resultVo);//把vo中的每个值过滤
%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<html>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

</head>
<body>
 
<form name="form" method="post">	
<div id="right">
 <div class="ringht_x">
<div id="ccParent0" class="box_3"> 
<div class="xz_title"><fmt:message key='basic_information'/></div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	   <tr>
            <td class="td_1" width="24%"><fmt:message key='customer_code'/>：</td>
            <td class="td_2" width="32%" >${bean.customer_code} </td>
            <td class="td_1" width="17%"><fmt:message key='customer_name'/>：</td>
            <td class="td_2" width="27%">${bean.customer_name}</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='customer_simple_name'/>：</td>
            <td class="td_2" >${bean.customer_simple_name }</td>
            <td class="td_1" ><fmt:message key='customer_en_name'/>：</td>
            <td class="td_2" >${bean.customer_en_name }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='customer_property'/>：</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("CUSTOMER_PROPERTY",resultVo.getCustomer_property()) %></td>
            <td class="td_1" ><fmt:message key='country_name'/>：</td>
            <td class="td_2" >${bean.country_name }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='customer_type'/>：</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("CUSTOMER_TYPE",resultVo.getCustomer_type()) %></td>
            <td class="td_1" ><fmt:message key='contact_person'/>：</td>
            <td class="td_2" >${bean.contact_person }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='contact_address'/>：</td>
            <td class="td_2" >${bean.contact_address}</td>
            <td class="td_1" ><fmt:message key='zip_code'/>：</td>
            <td class="td_2" >${bean.zip_code }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='tel_phone1'/>：</td>
            <td class="td_2" >${bean.tel_phone1 }</td>
            <td class="td_1" ><fmt:message key='tel_phone2'/>：</td>
            <td class="td_2" >${bean.tel_phone2}</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='fax'/>：</td>
            <td class="td_2" >${bean.fax }</td>
            <td class="td_1" >EMAIL：</td>
            <td class="td_2" >${bean.email }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='bank'/>：</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("BANK",resultVo.getBank())%></td>
            <td class="td_1" ><fmt:message key='bank_account'/>：</td>
            <td class="td_2" >${bean.bank_account }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='film_ticket_type'/>：</td>
            <td class="td_2" >${bean.film_ticket_type }</td>
            <td class="td_1" ><fmt:message key='is_zhongliang'/>：</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_zhongliang()) %></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='is_sale_achievement'/>：</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_sale_achievement()) %></td>
            <td class="td_1" ><fmt:message key='sale_achievement_remarks'/>：</td>
            <td class="td_2" >${bean.sale_achievement_remarks }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='customer_service_name'/>：</td>
            <td class="td_2" >${bean.customer_service_name }</td>
            <td class="td_1" ><fmt:message key='customer_sales_name'/>：</td>
            <td class="td_2" >${bean.customer_sales_name }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='cust_source'/></td>
            <td class="td_2" >
               <%
                rayoo.sales.customer.vo.CustomerIBDVo ibdBeanVo = (rayoo.sales.customer.vo.CustomerIBDVo)request.getAttribute("ibdBean");
                String cust_source = "";
                if (ibdBeanVo != null){
                    cust_source = String.valueOf(ibdBeanVo.getCust_source());
                }
                %>
                <%=BaseDataHelper.getNameByCode("CUST_SOURCE_BD",cust_source)%>
            </td>
            <td class="td_1" ><fmt:message key='ibd_sales'/></td>
            <td class="td_2" >${ibdBean.ibd_sales_name }</td>
        </tr>
         <tr>
            <td class="td_1" ><fmt:message key='is_salary_unconfirm_import'/>：</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_salary_unconfirm_import()) %></td>
            <td class="td_1" >集团户编号：</td>
            <td class="td_2" >${bean.group_family_prop_code }</td>
        </tr>
        <tr>
            <td class="td_1" >集团户名称：</td>
            <td class="td_2" >${bean.group_family_prop_name }</td>
            <td class="td_1" >集团户类型</td>
            <td class="td_2" >${bean.group_family_prop_type }</td>
        </tr>
	</table>
	
	 <p></p>
    <div class="xz_title"><fmt:message key='customer_information'/></div>
    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="22%"><fmt:message key='invest_total_sum'/>：</td>
            <td class="td_2" width="34%">${bean.invest_total_sum }</td>
            <td class="td_1" width="17%"><fmt:message key='register_money'/>：</td>
            <td class="td_2" width="27%">${bean.register_money }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='organization_number'/>：</td>
            <td class="td_2" >${bean.organization_number }</td>
            <td class="td_1" ><fmt:message key='ceo_en_name'/>：</td>
            <td class="td_2" >${bean.ceo_en_name }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='manage_start_date'/>：</td>
            <td class="td_2" ><fmt:formatDate value="${bean.manage_start_date }" pattern="yyyy-MM-dd"/> 
            </td>
            <td class="td_1" ><fmt:message key='manage_end_date'/>：</td>
            <td class="td_2" ><fmt:formatDate value="${bean.manage_end_date }" pattern="yyyy-MM-dd"/> </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='registered_capital'/>：</td>
            <td class="td_2" >${bean.registered_capital }</td>
            <td class="td_1" ><fmt:message key='registered_total_sum'/>：</td>
            <td class="td_2" >${bean.registered_total_sum }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='undertake_company'/>：</td>
            <td class="td_2" >${bean.undertake_company }</td>
            <td class="td_1" ><fmt:message key='invest_company'/>：</td>
            <td class="td_2" >${bean.invest_company }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='ceo_county'/>：</td>
            <td class="td_2" >${bean.ceo_county }</td>
            <td class="td_1" ><fmt:message key='ceo_birthday'/>：</td>
            <td class="td_2" ><fmt:formatDate value="${bean.ceo_birthday }" pattern="yyyy-MM-dd"/> </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='ceo_name'/>：</td>
            <td class="td_2" >${bean.ceo_name }</td>
            <td class="td_1" ><fmt:message key='corporation'/>：</td>
            <td class="td_2" >${bean.corporation }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='invest_adress'/>：</td>
            <td class="td_2" >${bean.invest_adress }</td>
            <td class="td_1" ><fmt:message key='business_scope'/>：</td>
            <td class="td_2" >${bean.business_scope }</td>
        </tr>
    </table>
    
    <p></p>
    
    <div class="xz_title">客户到款公司名称</div>
    <div id="incCustNameDiv">
	    <r:datacell id="datacell2"
	         queryAction="/FAERP/CustomerIncNameAction.do?cmd=searchCustIncName&cust_id=${bean.id}"
	         width="100%" height="128px" xpath="CustomerIncNameVo"
	         pageSize="1000"
	         paramFormId="datacell_formid">
	         <r:field width="0px" fieldName="id" label="id" allowModify="false"></r:field>
	         <r:field width="0px" fieldName="cust_id" label="cust_id" allowModify="false"></r:field>
	         <r:field width="300px" fieldName="inc_cust_name" label="<font style='color:#075587;'>到款公司名称</font>" allowModify="false">
	         </r:field>
	         <r:field width="100px" fieldName="create_user_name" label="<font style='color:#075587;'>创建人</font>"  allowModify="false">
	         </r:field>
	         <r:field width="100px" fieldName="create_date" label="<font style='color:#075587;'>创建时间</font>" allowModify="false">
	             <w:date format="yyyy-MM-dd HH:mm:ss"/>
	         </r:field>
	     </r:datacell>
     </div>
     
    <p></p>
    
   <div class="xz_title"><fmt:message key='extra_message'/></div>
   <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1" width="22%"><fmt:message key='industry_type_name'/>：</td>
            <td class="td_2" width="34%">${bean.industry_type_name }</td>
            <td class="td_1" width="17%"><fmt:message key='company_webadress'/>：</td>
            <td class="td_2" width="27%">${bean.company_webadress }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='remarks'/>：</td>
            <td colspan="3" class="td_2" >${bean.remarks }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='customer_situation'/>：</td>
            <td colspan="3" class="td_2" >${bean.customer_situation }</td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='bad_record'/>：</td>
            <td colspan="3" class="td_2" >${bean.bad_record }</td>
        </tr>
        <tr>
            <td class="td_1" >legal entity code：</td>
            <td colspan="3" class="td_2" >${bean.legal_entity_code }</td>
        </tr>
   </table>
</div>


<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">
</div>
</div>

</form>
</fmt:bundle>
</body>
</html>
