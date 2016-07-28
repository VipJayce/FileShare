<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.security.socialaccountpvd.vo.SocialaccountpvdVo" %>
<%@ page import="rayoo.customerservice.security.socialaccountpvd.util.ISocialaccountpvdConstants" %>
<%  //取出本条记录
	SocialaccountpvdVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SocialaccountpvdVo)request.getAttribute(ISocialaccountpvdConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="rayoo.customerservice.security.socialaccountpvd.socialaccountpvd_resource" prefix="rayoo.customerservice.security.socialaccountpvd.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        window.close();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
<!-- -->
<!--	-->
<!--       <div id="right">-->
<!--		<div class="right_title_bg">-->
<!--	 <div class=" right_title">	<fmt:message key="detail_page"/>-->
<!--	 </div>-->
<!--	 </div>-->
<!--    	<div class="ringht_s">-->
<!-- -->

<!--<div id="ccParent0" class="box_3"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

--><div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	<input type="hidden" name="group_type" value="${param.group_type}">
    <input type="hidden" name="security_type" value="${param.security_type}">
		<tr>
		      <td class="td_1" ><fmt:message key="ss_fund_group"/>：</td>
              <td class="td_2" ><%=RmStringHelper.prt(resultVo.getGroup_name())%></td>
			<td class="td_1" ><fmt:message key="security_unit_id"/>：</td>
			<td class="td_2" >
			                              <faerp:SoialunitViewTag  beanname="" attribute="" defaultValue="<%=RmStringHelper.prt(resultVo.getSocial_unit_id())%>"/>
			</td>
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
            <td class="td_1" ><fmt:message key="hire_unit"/>：</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_unit())%></td>
            <td class="td_1"><fmt:message key="cust_passwords"/>：</td>
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


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="emp_entry"/>关闭'  onclick="javascript:back_onClick();" />
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
