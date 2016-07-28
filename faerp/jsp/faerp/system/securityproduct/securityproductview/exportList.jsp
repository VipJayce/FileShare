<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@ page import="java.util.*"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.system.securityproduct.vo.SecurityAllVo"%>
<%@ page
	import="rayoo.system.securityproduct.util.ISecurityproductConstants"%>
<jsp:useBean id="productaction"
	class="rayoo.system.product.action.ProductAction" scope="page" />
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<style type="text/css">
.box {
	border: 1px solid #c5dbe2;
	margin: 5px 10px 0px 10px;
	width: 98%;
	overflow-x: scroll;
	white-space: nowrap;
	overflow-y: scroll;
	height: 280px;
	Scrollbar-Highlight-Color: #fafafa;
	Scrollbar-Shadow-Color: #e8e8e8;
	Scrollbar-3Dlight-Color: #e4e4e4;
	scrollbar-dark-shadow-color: #7dc0e3;
}
</style>
	<script language="javascript">

    function simpleQuery_onClick(){  //简单的模糊查询
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }

    function readAndUpdate(){
       var city_id=document.getElementById("city_id").value;
       var product_id=document.getElementById("product_id").value;
        document.datacell_formid.action="<%=request.getContextPath()%>/SecurityproductAction.do?cmd=exportToExcel&city_id="+city_id+"&product_id="+product_id;
        document.datacell_formid.submit();
    }

</script>
	</head>
	<body>

	<form name="datacell_formid" method="post" id="datacell_formid">
	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-size: 14px;">
		<tr>
			<td width="175" style="padding-top: 0;">
			<div class="search_title">查询条件</div></td>
			<td align="right">省市&nbsp;&nbsp;</td>
            <td align="left">
             <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
            </td>
			<!--
			<td width="150" align="right">省市:</td>
			<td width="180" align="left"><faerp:cityTag tagname="city_id"
				hasSearchTag="true" /></td>
			<td width="150" align="right">社保公积金产品:</td>
			<td width="180" align="left"><faerp:securityGroupSelectTag
				beanname="product_id" attribute="product_id" /></td>
			-->
			<td align="right">社保公积金产品&nbsp;&nbsp;</td>
            <td align="left">
            <r:comboSelect id="product_id" name="product_id"
                       queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       nullText="请选择" />
            </td><!--
			<td align="right">年月&nbsp;&nbsp;</td>
			<td align="left"><input type="text"
				class="text_field" name="month" id="month" inputName="产品" maxLength="9.5" /></td>
		-->
		<td colspan="3"><input name="button_ok" class="icon_1"
                type="button" value='<fmt:message key="query"/>'
                onClick="javascript:simpleQuery_onClick()"> <input
                name="button_reset" class="icon_1" type="button"
                value='<fmt:message key="reset"/>'
                onClick="javascript:this.form.reset()"></td>
            <td />
		</tr>
		<!--<tr>
		     <td />
			<td />
			<td />
			<td colspan="3"><input name="button_ok" class="icon_1"
				type="button" value='<fmt:message key="query"/>'
				onClick="javascript:simpleQuery_onClick()"> <input
				name="button_reset" class="icon_1" type="button"
				value='<fmt:message key="reset"/>'
				onClick="javascript:this.form.reset()"></td>
			<td />
		</tr>
	--></table>
	</div>
	<div class="button">
	<div class="button_right">
	<ul>
		<li class="e"><a href="#" onClick="javascript:readAndUpdate()">导出</a></li>
	</ul>
	</div>
	<div class="clear"></div>
	</div>
	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction="/FAERP/SecurityproductAction.do?cmd=queryAllexport_1"
		width="98%" height="320px" xpath="SecurityAllVo"
		paramFormId="datacell_formid">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="city_id" label="城市" width="80px"
			allowModify="false">
			<r:comboSelect id="countryList" name="city_id1"
				queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
				textField="city_name" valueField="id" xpath="PB_CITYVo"
				width="150px" nullText="请选择" />
		</r:field>
		<r:field fieldName="product_id" width="100px" label="社保公积金产品"
			allowModify="false">
			<r:comboSelect id="product_id1" name="product_id1"
				queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
				textField="product_name" valueField="id" xpath="ProductVo"
				width="200px" nullText="请选择" />
		</r:field>
		<r:field fieldName="product_name" label="社保产品比例名称" width="150px">
		</r:field>
		<r:field fieldName="e_ratio" label="公司比例">
		</r:field>
		<r:field fieldName="p_ratio" label="个人比例">
		</r:field>
		<r:field fieldName="e_add_ratio" label="公司附加金额" width="120px">
		</r:field>
		<r:field fieldName="p_add_ratio" label="个人附加金额" width="120px">
		</r:field>
		<r:field fieldName="e_caculate_type_bd" label="公司舍入原则"
			allowModify="false">
			<d:select dictTypeId="E_CACULATE_TYPE_BD"
				extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="p_caculate_type_bd" label="个人舍入原则"
			allowModify="false">
			<d:select dictTypeId="P_CACULATE_TYPE_BD"
				extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="e_precision_bd" label="公司精度" allowModify="false">
			<d:select dictTypeId="E_PRECISION_BD"
				extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="p_precision_bd" label="个人精度" allowModify="false">
			<d:select dictTypeId="P_PRECISION_BD"
				extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="charge_frequency_bd" label="收费频率" allowModify="false" width="150px">
			<d:select dictTypeId="CHARGE_FREQUENCY_BD"
				extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="yearly_pay_month" label="年缴费月">
		</r:field>
		<r:field fieldName="start_month" label="起始月">
		</r:field>
		<r:field fieldName="end_month" label="终止月">
		</r:field>
		<r:field fieldName="company_fixed_radix" label="企业固定基数">
		</r:field>
		<r:field fieldName="personal_fixed_radix" label="个人固定基数">
		</r:field>
		<r:field fieldName="social_average_salary" label="社会平均工资">
		</r:field>
		<r:field fieldName="personal_top_radix" label="个人最高基数">
		</r:field>
		<r:field fieldName="personal_low_base" label="个人最低基数">
		</r:field>
		<r:field fieldName="company_top_radix" label="企业最高基数">
		</r:field>
		<r:field fieldName="company_low_radix" label="企业最低基数">
		</r:field>


	</r:datacell></div>



	<!--
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr><siqp注>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"id")%>">
            </a>比例大编码
            </th>
            
            <th><a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"item_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"item_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"item_id")%>">
            </a>    
       
             比例小编码</th>

            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"city_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"city_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"city_id")%>">
            </a>省市
            </th>
            
            <th><a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_id")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_id")%>">
            </a>    
       
             社保公积金产品</th>

            <th>
                
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"product_name")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"product_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"product_name")%>">
            </a>    
       
             社保产品比例名称</th>
            <th>
                
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_ratio")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_ratio")%>">
            </a>    
       
             公司比例</th>
            <th>
                
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_ratio")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_ratio")%>">
            </a>    
       
             个人比例</th>
            <th>
                
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_add_ratio")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_add_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_add_ratio")%>">
            </a>    
       
             公司附加比例</th>
            <th>
                
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_add_ratio")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_add_ratio")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_add_ratio")%>">
            </a>    
       
             个人附加比例</th>
            <th>
                    
                    <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_caculate_type_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_caculate_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_caculate_type_bd")%>">
            </a>    
       
     公司舍入原则</th>
        <th>
                    
                    <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_caculate_type_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_caculate_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_caculate_type_bd")%>">
            </a>    
       
     个人舍入原则</th>
        <th>
                    
                    <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"e_precision_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"e_precision_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"e_precision_bd")%>">
            </a>    
       
     公司精度</th>
        <th>
                    
                    <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"p_precision_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"p_precision_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"p_precision_bd")%>">
            </a>    
       
     个人精度</th>
     
        <th>
                    
                    <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"charge_frequency_bd")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"charge_frequency_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"charge_frequency_bd")%>">
            </a>    
       
     收费频率</th>
        <th>
                
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"yearly_pay_month")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"yearly_pay_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"yearly_pay_month")%>">
            </a>    
       
             年缴费月</th>
             
             <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"start_month")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"start_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"start_month")%>">
            </a>    
             起始月</th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"end_month")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"end_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"end_month")%>">
            </a>    
             终止月</th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_fixed_radix")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_fixed_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_fixed_radix")%>">
            </a>    
             企业固定基数</th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"personal_fixed_radix")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"personal_fixed_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"personal_fixed_radix")%>">
            </a>    
       
             个人固定基数</th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"social_average_salary")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"social_average_salary")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"social_average_salary")%>">
            </a>    
       
             社会平均工资</th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"personal_top_radix")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"personal_top_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"personal_top_radix")%>">
            </a>    
             个人最高基数</th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"personal_low_base")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"personal_low_base")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"personal_low_base")%>">
            </a>    
             个人最低基数</th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_top_radix")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_top_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_top_radix")%>">
            </a>    
             企业最高基数</th>
            <th>
                <a href="/FAERP/SecurityproductAction.do?cmd=queryAllexport&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_low_radix")%>">
                <img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_low_radix")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_low_radix")%>">
            </a>    
             企业最低基数</th>
            </tr>
            </tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
        <tr><td>
            <faerp:cityViewTag beanname="data" attribute="city_id"/>
            <input type="hidden" id="cityid<bean:write name="data" property="id"/>" name="cityid<bean:write name="data" property="id"/>" value="<bean:write name="data" property="city_id"/>">
            </td>
            <td>&nbsp;
            <bean:define id="product_id" name="data" property="product_id"/>
            <%= (product_id!=null&&product_id!="") ? productaction.getProductNameByID(product_id.toString()) : ""%>  
            </td>
            <td>
            <bean:write name="data" property="product_name"/>  
             </td>
            <td><bean:write name="data" property="e_ratio"/>   </td>
            <td><bean:write name="data" property="p_ratio"/>   </td>
            <td><bean:write name="data" property="e_add_ratio"/>   </td>
            <td><bean:write name="data" property="p_add_ratio"/>   </td>
            <td>&nbsp;
            <bean:define id="e_caculate_type_bd" name="data" property="e_caculate_type_bd"/>
            <%=BaseDataHelper.getNameByCode("E_CACULATE_TYPE_BD",String.valueOf(e_caculate_type_bd))%>
            </td>       
            <td>&nbsp;
            <bean:define id="p_caculate_type_bd" name="data" property="p_caculate_type_bd"/>
            <%=BaseDataHelper.getNameByCode("P_CACULATE_TYPE_BD",String.valueOf(p_caculate_type_bd))%>
            </td>       
            <td>&nbsp;
            <bean:define id="e_precision_bd" name="data" property="e_precision_bd"/>
            <%=BaseDataHelper.getNameByCode("E_PRECISION_BD",String.valueOf(e_precision_bd))%>
            </td>       
            <td>&nbsp;
            <bean:define id="p_precision_bd" name="data" property="p_precision_bd"/>
            <%=BaseDataHelper.getNameByCode("P_PRECISION_BD",String.valueOf(p_precision_bd))%>
            </td>
                 
            <td>&nbsp;
            <bean:define id="charge_frequency_bd" name="data" property="charge_frequency_bd"/>
            <%=BaseDataHelper.getNameByCode("CHARGE_FREQUENCY_BD",String.valueOf(charge_frequency_bd))%>
            </td>       
            <td><bean:write name="data" property="yearly_pay_month"/>   </td>
            <td align="center"><bean:write name="data" property="start_month"/>&nbsp;</td>
            <td align="center"><bean:write name="data" property="end_month"/>&nbsp;</td>
            <td align="center"><bean:write name="data" property="company_fixed_radix"/>&nbsp;</td>
            <td align="center"><bean:write name="data" property="personal_fixed_radix"/>&nbsp;</td>
            <td align="center"><bean:write name="data" property="social_average_salary"/>&nbsp;</td>
            <td align="center"><bean:write name="data" property="personal_top_radix"/>&nbsp;</td>
            <td align="center"><bean:write name="data" property="personal_low_base"/>&nbsp;</td>
            <td align="center"><bean:write name="data" property="company_top_radix"/>&nbsp;</td>
            <td align="center"><bean:write name="data" property="company_low_radix"/>&nbsp;</td>         
             
            </tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 --></form>
	</div>
	</div>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
