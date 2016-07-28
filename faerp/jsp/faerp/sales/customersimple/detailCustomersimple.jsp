<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.sales.customersimple.vo.CustomersimpleVo" %>
<%@ page import="rayoo.sales.customersimple.util.ICustomersimpleConstants" %>
<%@page import="gap.authority.helper.OrgHelper"%>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
	CustomersimpleVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (CustomersimpleVo)request.getAttribute(ICustomersimpleConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.null2Nothing(resultVo);  //把vo中的每个值过滤
    String orgname = request.getAttribute("orgname") == null?"":request.getAttribute("orgname").toString();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<fmt:bundle basename="rayoo.salse.customersimple.customersimple_resource" prefix="rayoo.salse.customersimple.">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/CustomersimpleAction.do?cmd=queryAll&backFlag=false";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">	
<div id="right">
<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
            <td class="td_1" width="30%"><span class="style_required_red">* </span><fmt:message key="customer_code"/></td>
            <td class="td_2 " width="20%">
                <input type="text" class="text_field" disabled="disabled" value="<%=RmStringHelper.prt(resultVo.getCustomer_code())%>" />
            </td>
            <td class="td_1" width="30%"><span class="style_required_red">* </span><fmt:message key="customer_name"/></td>
            <td class="td_2 " width="20%">
                <input type="text" class="text_field"  disabled="disabled"  value="<%=RmStringHelper.prt(resultVo.getCustomer_name())%>" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="contract_type"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled"  value="<%=BaseDataHelper.getNameByCode("CUSTOMER_CONTRACT",resultVo.getContract_type_bd()) %>"  />
            </td>
            <td class="td_1" ><fmt:message key="customer_char"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("CUSTOMER_CUSTCHAR",resultVo.getCustomer_char())%>"/>        
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="customer_service_name"/></td>
            <td class="td_2 ">
               <input type="text" class="text_field"  disabled="disabled" value="<%=resultVo.getCustomer_service_name()%>"/>
            </td>
            <td class="td_1" ><fmt:message key="handover_date"/></td>
            <td class="td_2">
                <input type="text" class="text_field"  disabled="disabled" value="<%=resultVo.getHandover_date()==null?"":sdf.format(resultVo.getHandover_date()) %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_swhtyj"/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_swhtyj()) %>"/>
            </td>
            <td class="td_1" ><fmt:message key="is_hkxyyj"/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_hkxyyj()) %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_zzjgdmzfyj"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_zzjgdmzfyj()) %>"/>
            </td>
            <td class="td_1" ><fmt:message key="is_yyzzfyj"/></td>
            <td class="td_2 ">
                  <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_yyzzfyj()) %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_wspzzsfyj"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_wspzzsfyj()) %>"/>
            </td>
            <td class="td_1" ><fmt:message key="is_htpsb"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_htpsb()) %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_bjdpsb"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_bjdpsb()) %>"/>
            </td>
            <td class="td_1" ><fmt:message key="is_quotation"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_quotation()) %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_sprzrymd"/></td>
            <td class="td_2 ">
                 <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getIs_sprzrymd()) %>"/>
            </td>
            <td class="td_1" ><fmt:message key="attached_accu_item"/></td>
            <td class="td_2" ><input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("TrueOrFalse",resultVo.getAttached_accu_item_bd()) %>"/></td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="other_info"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled" value="<%=BaseDataHelper.getNameByCode("CUSTOMER_OTHERINFO",resultVo.getOther_info()) %>"/>
            </td>
            <td class="td_1" ><fmt:message key="trade_type"/></td>
            <td class="td_2 ">
                 <r:comboSelect id="trade_type1" disabled="true" name="trade_type" queryAction="/FAERP/CustomerAction.do?cmd=queryIndustryTypeData"
              textField="name" valueField="id" xpath="CustomerSelectVo" width="200px" value="${bean.trade_type}"  messagekey="please_choose"  />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="customer_simple_create_user"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field"  disabled="disabled" value="<%= OrgHelper.getPartyVoByID(resultVo.getCustomer_simple_create_user()).getName()%>"/>
            </td>
            <td class="td_1" ><fmt:message key="customer_simple_create_date"/></td>
            <td class="td_2">
                <input type="text" class="text_field"  disabled="disabled" value="<%=resultVo.getCustomer_simple_create_date()==null?"":resultVo.getCustomer_simple_create_date().toString().substring(0,10) %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="customer_simple_remarks"/></td>
            <td class="td_2" >
                <input type="text" class="text_field"  disabled="disabled" value="<%=resultVo.getCustomer_simple_remarks() %>"/>
            </td>
            <td class="td_1"></td>
            <td class="td_2" >             
            </td>
        </tr>
	</table>
</div>


  	
 <div class="mx_button" style="text-align: center;padding-top:10px;">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:window.close();" />
</div>

<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
