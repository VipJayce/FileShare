<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*"%>
<%@ page import="rayoo.sales.agent.vo.AgentVo"%>
<%@ page import="rayoo.sales.agent.util.IAgentConstants"%>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%  //取出本条记录
	AgentVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (AgentVo)request.getAttribute(IAgentConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	String remark = request.getAttribute("remark")==null ? "" : request.getAttribute("remark").toString();
%>
<html>
<fmt:bundle basename="rayoo.salse.agent.agent_resource" prefix="rayoo.salse.agent.">
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

	<div id="right">
	<div class="ringht_s">

	<div id="ccChild0" class="box_3">
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td width="20%" class="td_1"><fmt:message key='agent_code'/>：</td>
			<td width="29%" class="td_2"><input type="text"
				class="text_field" inputName="供应商编号"
				value="<%=RmStringHelper.prt(resultVo.getAgent_code())%>"
				validate="notNull;" readonly="readonly" /></td>
			<td width="20%" class="td_1"><fmt:message key='agent_name'/>：</td>
			<td width="31%" class="td_2"><input type="text"
				class="text_field" inputName="供应商名称"
				value="<%=RmStringHelper.prt(resultVo.getAgent_name())%>"
				validate="notNull;" readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='agent_en_name'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="供应商英文名称"
				value="<%=RmStringHelper.prt(resultVo.getAgent_en_name())%>"
				readonly="readonly" /></td>
			<td class="td_1"><fmt:message key='agent_type'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="供应商类型"
				value="<%=BaseDataHelper.getNameByCode("AGENT_TYPE",RmStringHelper.prt(resultVo.getAgent_type()))%>"
				readonly="readonly" /></td>
		</tr>
		<!-- <tr>
			<td class="td_1"><fmt:message key='city_id'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="城市"
				value="<faerp:cityViewTag  beanname="bean" attribute="city_id"/>"
				readonly="readonly" /></td>  
		</tr> -->
		<tr>
			<td class="td_1"><fmt:message key='tax_registration_number'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="税务登记号"
				value="<%=RmStringHelper.prt(resultVo.getTax_registration_number())%>"
				readonly="readonly" /></td>
			<td class="td_1"><fmt:message key='contact_dept'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="联系部门"
				value="<%=RmStringHelper.prt(resultVo.getContact_dept())%>"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='contact_person'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="联系人"
				value="<%=RmStringHelper.prt(resultVo.getContact_person())%>"
				readonly="readonly" /></td>
			<td class="td_1"><fmt:message key='contact_tel1'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="联系电话1"
				value="<%=RmStringHelper.prt(resultVo.getContact_tel1())%>"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='contact_tel2'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="联系电话2"
				value="<%=RmStringHelper.prt(resultVo.getContact_tel2())%>"
				readonly="readonly" /></td>
			<td class="td_1">EMAIL：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="EMAIL"
				value="<%=RmStringHelper.prt(resultVo.getEmail())%>"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='fax'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="传真"
				value="<%=RmStringHelper.prt(resultVo.getFax())%>"
				readonly="readonly" /></td>
			<td class="td_1"><fmt:message key='contact_address'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="联系地址"
				value="<%=RmStringHelper.prt(resultVo.getContact_address())%>"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='zip_code'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="邮编"
				value="<%=RmStringHelper.prt(resultVo.getZip_code())%>"
				readonly="readonly" /></td>
			<td class="td_1"><fmt:message key='reckoning_address1'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="帐单地址1"
				value="<%=RmStringHelper.prt(resultVo.getReckoning_address1())%>"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='reckoning_address_code1'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="帐单地址邮编1"
				value="<%=RmStringHelper.prt(resultVo.getReckoning_zip_code1())%>"
				readonly="readonly" /></td>
			<td class="td_1">开户名：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="开户名"
				value="<%=RmStringHelper.prt(resultVo.getReckoning_address2())%>"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='reckoning_address_code2'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="帐单地址邮编2"
				value="<%=RmStringHelper.prt(resultVo.getReckoning_zip_code2())%>"
				readonly="readonly" /></td>
			<td class="td_1"><fmt:message key='bank1'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="开户银行1"
				value="<%=RmStringHelper.prt(resultVo.getBank1())%>"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='bank_account1'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="银行帐户1"
				value="<%=RmStringHelper.prt(resultVo.getBank_account1())%>"
				readonly="readonly" /></td>
			<td class="td_1"><fmt:message key='bank2'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="开户银行2"
				value="<%=RmStringHelper.prt(resultVo.getBank2())%>"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='bank_account2'/>：</td>
			<td class="td_2"><input type="text" class="text_field" inputName="银行帐户2"
				value="<%=RmStringHelper.prt(resultVo.getBank_account2())%>"
				readonly="readonly" /></td>
			<td class="td_1"><fmt:message key='corporation'/>：</td>
            <td class="td_2"><input type="text" class="text_field" inputName="法人"
                value="<%=RmStringHelper.prt(resultVo.getCorporation())%>"
                readonly="readonly" />
             </td>
			<!-- <td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>-->
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='remark'/>：</td>
			<td colspan="3" class="td_2"><textarea style="width: 742px"
				rows="2" inputName="备注" readonly="readonly"><%=remark%></textarea>
			</td>
		</tr>
	</table>
	</div>

	<div class="foot_button"><input type="button" class="foot_icon_1"
		value='<fmt:message key='close'/>'
		onclick="javascript:back_onClick();" /></div>

	</div>
	<input type="hidden" name="id"
		value="<%=RmStringHelper.prt(resultVo.getId())%>"></div>

	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>