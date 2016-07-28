<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.security.socialaccountcust.vo.SocialaccountcustVo" %>
<%@ page import="rayoo.customerservice.security.socialaccountcust.util.ISocialaccountcustConstants" %>
<%  //取出本条记录
	SocialaccountcustVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SocialaccountcustVo)request.getAttribute(ISocialaccountcustConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="rayoo.customerservice.security.socialaccountcust.socialaccountcust_resource" prefix="rayoo.customerservice.security.socialaccountcust.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="cust_ss_fund_account"/></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
         window.close();
    }
</script>
</head>
<body>
 
<form id="datacell_formid" name="form" method="post">
<div id="ccParent0" class="box_3">
    <div id="ccChild0" class="box_3">
	<input type="hidden" name="group_type" value="${param.group_type}">
    <input type="hidden" name="security_type" value="${param.security_type}">
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	   <tr>
            <td class="td_1" ><fmt:message key="ss_fund_group"/>：</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getGroup_name())%></td>
            <c:choose>
            <c:when test="${param.group_type==2}">
                <td class="td_1" ><fmt:message key="paying_bank"/>：</td>
                <td class="td_2" ><%=RmStringHelper.prt(resultVo.getPaying_bank())%></td>
            </c:when>
            <c:when test="${param.group_type!=2}">
                <td class="td_1" ></td>
                <td class="td_2" ></td>
            </c:when>
          </c:choose>
        </tr>
		<tr>
			<td class="td_1" ><fmt:message key="cust_code"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_code())%></td>
			<td class="td_1" ><fmt:message key="cust_name"/>：</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_name())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="account"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAccounts())%></td>
			<td class="td_1" ><fmt:message key="open_unit"/>：</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getOpen_unit())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="open_unit_account"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOpen_unit_accounts())%></td>
			<td class="td_1"><fmt:message key="is_fesco_pay"/>：</td>
            <td class="td_2"><%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_fesco_pay()))%></td>
		</tr>
		<tr>
            <td class="td_1" ><fmt:message key="hire_unit"/>：</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_unit())%></td>
            <td class="td_1"><fmt:message key="cust_password"/>：</td>
            <td class="td_2"> <%=RmStringHelper.prt(resultVo.getCust_password())%></td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="is_fesco_pay"/>：</td>
            <td class="td_2">
                  <c:choose>
		            <c:when test="${resultVo.getEmp_code_type()==0}">客户方编号</c:when>
		            <c:when test="${resultVo.getEmp_code_type()==1}">唯一号 </c:when>
		          </c:choose>
            </td>
        </tr>
	</table>
</div>
<div class="clear"></div>
<div style="margin:10px">
    <r:datacell
            id="dcListIndustryType"
            paramFormId="datacell_formid"
            queryAction="/FAERP/InjuryRatesRecordAction.do?cmd=findInjuryRecords?security_id=<%=RmStringHelper.prt(resultVo.getId())%>"
            width="99%"
            height="319px"
            xpath="InjuryRatesRecordVo"
            pageSize="100">
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <!--2016-06-02  by zhouxiaolong  更改错误字段   begin  -->
        <r:field fieldName="industry_id" messagekey="industry_id" width="250px;"/>
        <!--2016-06-02  by zhouxiaolong  更改错误字段   end  -->
        <r:field fieldName="source_type" messagekey="source_type" width="250px;"/>
        <r:field fieldName="base_rates" messagekey="base_rates" width="250px;"/>
        <r:field fieldName="float_rates" messagekey="float_rates" width="280px;"/>
        <r:field fieldName="injury_rates" messagekey="injury_rates" width="280px;"/>
        <r:field fieldName="valid_start_yearmonth" messagekey="valid_start_yearmonth" width="280px;"/>
        <r:field fieldName="valid_end_yrearmonth" messagekey="valid_end_yrearmonth" width="280px;"/>
    </r:datacell>
</div>
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="close"/>'  onclick="javascript:back_onClick();" />
</div>
</div><input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>"></div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
