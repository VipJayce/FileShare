<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.finance.outbill.pbcustomer.vo.PbcustomerVo" %>
<%@ page import="rayoo.finance.outbill.pbcustomer.util.IPbcustomerConstants" %>
<%  //取出本条记录
	PbcustomerVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (PbcustomerVo)request.getAttribute(IPbcustomerConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/PbcustomerAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >company_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_simple_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_simple_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_en_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_en_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_property：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_property())%></td>
		</tr>
		<tr>
			<td class="td_1" >country_area：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCountry_area())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_type())%></td>
		</tr>
		<tr>
			<td class="td_1" >contact_person：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContact_person())%></td>
		</tr>
		<tr>
			<td class="td_1" >contact_address：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContact_address())%></td>
		</tr>
		<tr>
			<td class="td_1" >zip_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getZip_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >tel_phone1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTel_phone1())%></td>
		</tr>
		<tr>
			<td class="td_1" >tel_phone2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTel_phone2())%></td>
		</tr>
		<tr>
			<td class="td_1" >fax：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFax())%></td>
		</tr>
		<tr>
			<td class="td_1" >email：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmail())%></td>
		</tr>
		<tr>
			<td class="td_1" >bank：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBank())%></td>
		</tr>
		<tr>
			<td class="td_1" >bank_account：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBank_account())%></td>
		</tr>
		<tr>
			<td class="td_1" >film_ticket_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFilm_ticket_type())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_zhongliang：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_zhongliang())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_sale_achievement：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_sale_achievement())%></td>
		</tr>
		<tr>
			<td class="td_1" >sale_achievement_remarks：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSale_achievement_remarks())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_account_limit：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_account_limit())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_service：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_service())%></td>
		</tr>
		<tr>
			<td class="td_1" >agree_on_receive_money_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAgree_on_receive_money_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >receive_money_month：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getReceive_money_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_import_client：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_import_client())%></td>
		</tr>
		<tr>
			<td class="td_1" >well_being_deal_with：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getWell_being_deal_with())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_physical_examination：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_physical_examination())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_beforehand_voucher：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_beforehand_voucher())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_remittance_error：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_remittance_error())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_fixed_pay_later：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_fixed_pay_later())%></td>
		</tr>
		<tr>
			<td class="td_1" >invest_total_sum：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInvest_total_sum())%></td>
		</tr>
		<tr>
			<td class="td_1" >register_money：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRegister_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >ceo_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCeo_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >ceo_en_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCeo_en_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >ceo_county：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCeo_county())%></td>
		</tr>
		<tr>
			<td class="td_1" >ceo_birthday：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCeo_birthday(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >registered_capital：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRegistered_capital())%></td>
		</tr>
		<tr>
			<td class="td_1" >manage_start_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getManage_start_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >manage_end_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getManage_end_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >registered_total_sum：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRegistered_total_sum())%></td>
		</tr>
		<tr>
			<td class="td_1" >undertake_company：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getUndertake_company())%></td>
		</tr>
		<tr>
			<td class="td_1" >invest_company：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInvest_company())%></td>
		</tr>
		<tr>
			<td class="td_1" >corporation：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCorporation())%></td>
		</tr>
		<tr>
			<td class="td_1" >business_scope：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBusiness_scope())%></td>
		</tr>
		<tr>
			<td class="td_1" >invest_adress：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInvest_adress())%></td>
		</tr>
		<tr>
			<td class="td_1" >organization_number：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOrganization_number())%></td>
		</tr>
		<tr>
			<td class="td_1" >trade_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTrade_type())%></td>
		</tr>
		<tr>
			<td class="td_1" >company_webadress：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_webadress())%></td>
		</tr>
		<tr>
			<td class="td_1" >remarks：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRemarks())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_situation：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_situation())%></td>
		</tr>
		<tr>
			<td class="td_1" >bad_record：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBad_record())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_swhtyj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_swhtyj())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_hkxyyj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_hkxyyj())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_zzjgdmzfyj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_zzjgdmzfyj())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_yyzzfyj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_yyzzfyj())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_wspzzsfyj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_wspzzsfyj())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_htpsb：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_htpsb())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_bjdpsb：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_bjdpsb())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_sprzrymd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_sprzrymd())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_simple_create_user：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_simple_create_user())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_simple_create_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_simple_create_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_simple_remarks：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_simple_remarks())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_valid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_del：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >contract_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >handover_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHandover_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_char：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_char())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_quotation：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_quotation())%></td>
		</tr>
		<tr>
			<td class="td_1" >other_info：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOther_info())%></td>
		</tr>
		<tr>
			<td class="td_1" >attached_accu_item_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAttached_accu_item_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >create_user_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreate_user_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >code_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCode_type())%></td>
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
