<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.*" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@ page import="rayoo.system.securityproduct.vo.SecurityproductVo" %>
<%@ page import="rayoo.system.securityproduct.util.ISecurityproductConstants" %>
<%@ page import="rayoo.system.securityproductitem.vo.SecurityproductitemVo" %>
<%@ page import="rayoo.system.securityproductitem.util.ISecurityproductitemConstants" %>
<jsp:useBean id="productaction" class="rayoo.system.product.action.ProductAction" scope="page" />
<jsp:useBean id="numutils" class="rayoo.tool.NumUtils" scope="page" />
<%  //取出本条记录
	SecurityproductVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SecurityproductVo)request.getAttribute(ISecurityproductConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/SecurityproductAction.do?cmd=queryAll&backFlag=true";
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

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
          <td width="19%" class="td_1" >省市</td>
		  <td width="20%" class="td_2" >
		  <faerp:cityViewTag attribute="city_id" beanname="bean"/>
		  </td>
		  <td width="18%" class="td_1" >社保公积金产品</td>
		  <td width="19%" class="td_2" >
		  <%= (resultVo.getProduct_id()!=null&&resultVo.getProduct_id()!="") ? productaction.getProductNameByID(resultVo.getProduct_id().toString()) : ""%>
		  </td>
		  <td width="12%" class="td_1" >社保产品比例名称</td>
		  <td width="12%" class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_name())%></td>
		  </tr>
		<tr>
		  <td class="td_1" >公司比例</td>
		  <td class="td_2" >
		  <%=numutils.valueFormatPercent(resultVo.getE_ratio().toString()) %>
		  </td>
		  <td class="td_1" >个人比例</td>
		  <td class="td_2" >
		  <%=numutils.valueFormatPercent(resultVo.getP_ratio().toString()) %>
		  </td>
		  <td class="td_1" >公司附加比例</td>
		  <td class="td_2" >
		  <%=numutils.valueFormatPercent(resultVo.getE_add_ratio().toString()) %>
		  </td>
		  </tr>
		<tr>
		  <td class="td_1" >个人附加比例</td>
		  <td class="td_2" >
		  <%=numutils.valueFormatPercent(resultVo.getP_add_ratio().toString()) %>
		  </td>
		  <td class="td_1" >公司舍入原则</td>
		  <td class="td_2" ><%=BaseDataHelper.getNameByCode("E_CACULATE_TYPE_BD",RmStringHelper.prt(resultVo.getE_caculate_type_bd()))%></td>
		  <td class="td_1" >个人舍入原则</td>
		  <td class="td_2" ><%=BaseDataHelper.getNameByCode("P_CACULATE_TYPE_BD",RmStringHelper.prt(resultVo.getP_caculate_type_bd()))%></td>
		  </tr>
		<tr>
		  <td class="td_1" >公司精度</td>
		  <td class="td_2" ><%=BaseDataHelper.getNameByCode("E_PRECISION_BD",RmStringHelper.prt(resultVo.getE_precision_bd()))%></td>
		  <td class="td_1" >个人精度</td>
		  <td class="td_2" ><%=BaseDataHelper.getNameByCode("P_PRECISION_BD",RmStringHelper.prt(resultVo.getP_precision_bd()))%></td>
		  <td class="td_1" >公司奇偶限限定</td>
		  <td class="td_2" ><%=BaseDataHelper.getNameByCode("E_PARITY_BD",RmStringHelper.prt(resultVo.getE_parity_bd()))%></td>
		  </tr>
		<tr>
		  <td class="td_1" >个人奇偶限限定</td>
		  <td class="td_2" ><%=BaseDataHelper.getNameByCode("P_PARITY_BD",RmStringHelper.prt(resultVo.getP_parity_bd()))%></td>
		  <td class="td_1" >收费频率</td>
		  <td class="td_2" ><%=BaseDataHelper.getNameByCode("CHARGE_FREQUENCY_BD",RmStringHelper.prt(resultVo.getCharge_frequency_bd()))%></td>
		  <td class="td_1" >年缴费月</td>
		  <td class="td_2" ><%=RmStringHelper.prt(resultVo.getYearly_pay_month())%></td>
		  </tr>
		<tr>
		  <td class="td_1" >是否超上下限</td>
		  <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_outstrip_limit_bd()))%></td>
		  <td class="td_1" >创建人</td>
		  <td class="td_2" ><%=OrgHelper.getPartyVoByID(resultVo.getCreate_user()).getName()%></td>
		  <td class="td_1" >创建日期</td>
		  <td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreate_date(), 10)%></td>
		  </tr>
		<tr>
		  <td class="td_1" >产品说明</td>
		  <td colspan="5" class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_explanation())%></td>
		  </tr>
		<tr>
		  <td class="td_1" >备注</td>
		  <td colspan="5" class="td_2" ><%=RmStringHelper.prt(resultVo.getRemark())%></td>
		  </tr>
		
	</table>
</div>
<%
if(((List)request.getAttribute("securityproductitem")).size()>0){ %>
 <div id="values_div" class="box_xinzeng_table" style="margin-left:10px;"> 
<table  id="tab" width="100%" cellspacing="0"  class="datagrid1">
<tr>
            <th>起始月</th>
            <th>终止月</th>
            <th>企业固定基数</th>
            <th>个人固定基数</th>
            <th>社会平均工资</th>
            <th>个人最高基数</th>
            <th>个人最低基数</th>
            <th>企业最高基数</th>
            <th>企业最低基数</th>
            </tr>
            <logic:iterate     name="securityproductitem"  id="data" scope="request" indexId="indexs">
                    <tr id="tr<bean:write name="data" property="id"/>">
                        <td><bean:write name="data" property="start_month"/></td>
                        <td><bean:write name="data" property="end_month"/></td>
                        <td><bean:write name="data" property="company_fixed_radix"/></td>
                        <td><bean:write name="data" property="personal_fixed_radix"/></td>
                        <td><bean:write name="data" property="social_average_salary"/></td>
                        <td><bean:write name="data" property="personal_top_radix"/></td>
                        <td><bean:write name="data" property="personal_low_base"/></td>
                        <td><bean:write name="data" property="company_top_radix"/></td>
                        <td><bean:write name="data" property="company_low_radix"/></td>
                        </tr>
            </logic:iterate>
</table>
</div>
<%} %>
  	
 <%
if(((List)request.getAttribute("securitygrouprelbeans")).size()>0){ %> 	
<div  class="box_xinzeng_table" style="margin-left:10px;"> 
<table   id="tab1" width="100%" cellspacing="0"  class="datagrid1">
<tr>
     <th width="96%" align="left">所属社保组</th>
<td width="5%">
        <logic:iterate     name="securitygrouprelbeans"  id="relbeans" scope="request" indexId="indexs">
        <bean:define id="securitygroupid" name="relbeans" property="security_group_id"/>
        <tr id="tr1<bean:write name="relbeans" property="id"/>">
            <td><select  name="pb_security_group_id"> 
            <logic:iterate     name="securitygroupbeans"  id="groupbeans" scope="request" indexId="indexs">
            <bean:define id="securitygroup_id" name="groupbeans" property="id"/>
            <option value='<bean:write name="groupbeans" property="id"/>' <%if(securitygroup_id.equals(securitygroupid))out.print(" selected "); %>><bean:write name="groupbeans" property="group_name"/></option>
            </logic:iterate>
            </select>
            </td>
        </tr>
        </logic:iterate>
</table>
</div>
<%} %>

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
