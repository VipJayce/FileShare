<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%
      String loadData = request.getParameter("loadData");
      request.setAttribute("loadData",loadData);
%>
<script type="text/javascript">
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";

//格式化页面显示金额 add by sqp2013年12月9日 
function toformatnumber(value,entity,rowNo,cellNo){
    return formatNumber(value,"#,###.00'");
}
</script>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.refundinfo.refundinfo_resource" prefix="rayoo.salary.refundinfo.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_refundbatch'/></title>
</head>

<body>

      <div id="bg" class="xz_xixi1">
        <div id="font1" class="xz_tab1" onclick="changeTab('dc_refund_add');"
        onMouseDown="setTab001Syn(1);toggleDiv(1);document.getElementById('bg').className='xz_xixi1'"><fmt:message key='title_xz_xixi1'/></div>
        <div id="font2" class="xz_tab2" onclick="changeTab('dc_refund_add2');"
        onMouseDown="setTab001Syn(2);toggleDiv(2);document.getElementById('bg').className='xz_xixi2'"><fmt:message key='title_xz_xixi2'/></div>
        <div id="font3" class="xz_tab3" onclick="changeTab('dc_refund');" 
        onMouseDown="setTab001Syn(3);toggleDiv(3);document.getElementById('bg').className='xz_xixi3'"><fmt:message key='title_xz_xixi3'/></div>
        <div id="font4" class="xz_tab4" onclick="changeTab('dc_refund_qry');"
        onMouseDown="setTab001Syn(4);toggleDiv(4);document.getElementById('bg').className='xz_xixi4'"><fmt:message key='title_xz_xixi4'/></div>
        
      </div>
      <!-- 添加退票重发TAB页 -->
      <div id="TabCon1">
            <div class="box_tab">
              <form id="form_refund_add" action="">
              <input type="hidden" name="cmd" id="h_cmd"/>
              <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                <tr>
                  <td class="td_1"><fmt:message key='customer_code'/></td>
                  <td class="td_2"><input name="customer_code" class="sText" /></td>
                  <td class="td_1"><fmt:message key='customer_name'/></td>
                  <td class="td_2">
                   <w:lookup name="customer_name" onReturnFunc="rtnFunc" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="810"/>
                    <input type="hidden" name="customer_id" id="h_customer_id"/>
                    <input type="hidden" name="h_customer_code" id="h_customer_code"/>
                  </td>
                  <td class="td_1"><fmt:message key='servers_user'/></td>
                  <td class="td_2">
                  	<r:comboSelect id="combo_cs" name="servers_user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_select" />
                  </td>
                </tr>
                <tr>
                  <td class="td_1"><fmt:message key='refund_amount'/></td>
                  <td class="td_2">
                    <input id="refund_amount_f" name="refund_amount_f" class="sText_1"/>
                    <input id="refund_amount_t" name="refund_amount_t" class="sText_1" />
                  </td>
                  <td class="td_1"><fmt:message key='refund_date'/></td>
                  <td class="td_2">
                    <w:date allowInput="false" id="w_from" name="refund_date_f" format="yyyy-MM-dd" 
                      style="width:75px;"/>
	                <w:date allowInput="false" id="w_to" name="refund_date_t" format="yyyy-MM-dd" 
	                  style="width:75px;"/>
                  </td>
                  <td class="td_1"><fmt:message key='emp_name'/></td>
                  <td class="td_2">
                    <input name="emp_name" class="sText" />
                  </td>
                </tr>
                <tr>
                  <td class="td_1"><fmt:message key='emp_name'/><fmt:message key='refund_state_bd_'/></td>
                  <td class="td_2">
                    <select class="sSelect" name="refund_state_bd">
	                   <option value=""><fmt:message key='please_select'/></option> 
	                   <option selected="true" value="0"><fmt:message key='refund_state_bd_0'/></option>
	                   <option value="1"><fmt:message key='refund_state_bd_1'/></option>
	                   <option value="2"><fmt:message key='refund_state_bd_2'/></option>
                    </select>
                  </td>
                  <td class="td_1"><fmt:message key='refund_name'/></td>
                  <td class="td_2"><input name="refund_name" class="sText" id="t_refund_name"/></td>
                  <td class="td_1">&nbsp;</td>
                  <td class="td_2"><input onclick="doQuery('dc_refund_add')" type="button" class="icon_1" value="查询" /></td>
                </tr>
              </table>
              <div class="button">
                <div class="button_right">
                  <!--<ul>
                    <li class="c"><a href="javascript:void(0);" onclick="addRefund()">添加</a></li>
                    <li class="e"><a href="javascript:void(0);" onclick="showImportWin()">导入</a></li>
                    -->
                    <input type="hidden" id="attackAddressInput" name="attach_address"/>
                    <input type="hidden" id="attachNameInput" name="attachNameInput"/><!--
                    <li class="d"><a href="javascript:void(0);" onclick="delRefund()">删除</a></li>
                  </ul>
                  -->
                  <input class="xz" type="button"   value="<fmt:message key='button_downImpTemp'/>"  onClick="downImpTemp();">
                  <input class="c" type="button"   value="<fmt:message key='button_add'/>"  <au:authorityBtn code="tpcf_add" type="1"/>  onClick="addRefund();">
                  <input class="e_1" type="button"   value="<fmt:message key='button_import'/>"  <au:authorityBtn code="tpcf_imp" type="1"/>  onClick="showImportWin();">
                  <input class="d" type="button"   value="<fmt:message key='button_delete'/>"  <au:authorityBtn code="tpcf_del" type="1"/>  onClick="delRefund();">
                  <input class="e" type="button"   value="<fmt:message key='button_export'/>"  <au:authorityBtn code="tpcf_exp" type="1"/>  onClick="exportRefund_plus();">
                </div>
                <div class="clear"></div>
              </div>
            </form>
         	</div>
         	</div>
         	
         	<div id="div_dc_1">
            <r:datacell id="dc_refund_add" 
                queryAction="/FAERP/RefundInfoAction.do?cmd=simpleQuery"
                submitAction=""
                width="100%"
                height="300px"
                paramFormId="form_refund_add"
                submitXpath="RefundInfoVo" 
                pageSize="100"
                xpath="RefundInfoVo">
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field fieldName="id" 
              label="<input type='checkbox' name='checkall' onclick='chk_all1(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox1">
              </r:field>
              <r:field sortAt="none" fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field sortAt="none" fieldName="customer_name" messagekey="customer_name" width="200px">
              </r:field>
              <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name">
              </r:field>
              <r:field sortAt="none" fieldName="servers_user" messagekey="servers_user">
              </r:field>
              <r:field fieldName="refund_code" messagekey="refund_code" >
              </r:field>
              <r:field fieldName="refund_amount" messagekey="refund_amount"  onRefreshFunc="toformatnumber">
              </r:field>
              <r:field sortAt="none" fieldName="refund_cause" messagekey="refund_cause" width="150px">
              </r:field>
              <r:field sortAt="none" fieldName="refund_type" messagekey="refund_type"  allowModify="false">
                <h:select name="list_refund_type" property="refund_type">
                   <h:option value="1" label="工资类"></h:option>
                   <h:option value="0" label="报销类"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="refund_name" messagekey="refund_name" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_num" messagekey="refund_num"  width="150px">
              </r:field>
              <r:field sortAt="none" fieldName="refund_state_bd" messagekey="refund_state_bd_" allowModify="false">
                <h:select name="list_refund_state_bd" property="refund_state_bd">
                   <h:option value="0" label="未申请"></h:option>
                   <h:option value="1" label="待补发"></h:option>
                   <h:option value="2" label="已补发"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="create_date" messagekey="create_date" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_date" messagekey="refund_date" >
              </r:field>
              <r:field sortAt="none" fieldName="re_pay_time" messagekey="re_pay_time" >
              </r:field>
              <r:field sortAt="none" fieldName="remarks" messagekey="remarks" width="200px">
              </r:field>
            </r:datacell> 
        	</div>
        	<!-- 添加退票重发TAB页 福利类-->
      <div id="TabCon2" style="display:none;">
            <div class="box_tab">
              <form id="form_refund_add2" action="" method="post">
              <input type="hidden" name="cmd" id="h_cmd2"/>
              <input type="hidden" name="ids" id="h_ids"/>
              <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                <tr>
                  <td class="td_1"><fmt:message key='customer_code'/></td>
                  <td class="td_2"><input name="customer_code" class="sText" /></td>
                  <td class="td_1"><fmt:message key='customer_name'/></td>
                  <td class="td_2">
                   <w:lookup name="customer_name" onReturnFunc="rtnFunc2" id="lk_cust2" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="810"/>
                    <input type="hidden" name="customer_id" id="h_customer_id2"/>
                    <input type="hidden" name="h_customer_code" id="h_customer_code2"/>
                  </td>
                  <td class="td_1"><fmt:message key='servers_user'/></td>
                  <td class="td_2">
                  	<r:comboSelect id="combo_cs3" name="servers_user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_select"/>
                  </td>
                </tr>
                <tr>
                  <td class="td_1"><fmt:message key='refund_amount'/></td>
                  <td class="td_2">
                    <input id="refund_amount_f2" name="refund_amount_f" class="sText_1"/>
                    <input id="refund_amount_t2" name="refund_amount_t" class="sText_1" />
                  </td>
                  <td class="td_1"><fmt:message key='refund_date'/></td>
                  <td class="td_2">
                    <w:date allowInput="false" id="w_from2" name="refund_date_f" format="yyyy-MM-dd" 
                      style="width:75px;"/>
	                <w:date allowInput="false" id="w_to2" name="refund_date_t" format="yyyy-MM-dd" 
	                  style="width:75px;"/>
                  </td>
                  <td class="td_1"><fmt:message key='emp_name'/></td>
                  <td class="td_2">
                    <input name="emp_name" id="emp_name" class="sText" />
                  </td>
                </tr>
                <tr>
                  <td class="td_1"><fmt:message key='refund_state_bd'/></td>
                  <td class="td_2">
                    <select class="sSelect" name="refund_state_bd">
	                   <option value=""><fmt:message key='please_select'/></option> 
	                   <option selected="true" value="0"><fmt:message key='refund_state_bd_0'/></option>
	                   <option value="1"><fmt:message key='refund_state_bd_1'/></option>
	                   <option value="2"><fmt:message key='refund_state_bd_2'/></option>
                    </select>
                  </td>
                   <td class="td_1"><fmt:message key='refund_name'/></td>
                  <td class="td_2"><input name="refund_name" class="sText" id="t_refund_name"/></td>
                  <td class="td_1">&nbsp;</td>
                  <td class="td_2"><input onclick="doQuery('dc_refund_add2')" type="button" class="icon_1" value="查询" /></td>
                </tr>
              </table>
              <div class="button">
                <div class="button_right">
                  已选中:
                  <span id="tab2_tip_1">
                      0
                  </span>
                  &nbsp;生成总人数:
                  <span id="tab2_tip_2">
                      0
                  </span>
                  &nbsp;生成总金额:
                  <span id="tab2_tip_3">
                      0
                  </span>
                  &nbsp;
                  <!--<ul>
                    <li class="c"><a href="javascript:void(0);" onclick="addRefund()">添加</a></li>
                    <li class="e"><a href="javascript:void(0);" onclick="showImportWin()">导入</a></li>
                    
                    <input type="hidden" id="attackAddressInput2" name="attach_address"/>
                    <input type="hidden" id="attachNameInput2" name="attachNameInput"/><!--
                    <li class="d"><a href="javascript:void(0);" onclick="delRefund()">删除</a></li>
                  </ul>
                  -->
                  <input class="xz" type="button"   value="<fmt:message key='button_downImpTemp'/>"  onClick="downImpTemp();">
                  <input class="c" type="button"   value="<fmt:message key='button_add'/>"  <au:authorityBtn code="tpcf_add" type="1"/>  onClick="addRefund(2);">
                  <input class="e_1" type="button"   value="<fmt:message key='button_import'/>"  <au:authorityBtn code="tpcf_imp" type="1"/>  onClick="showImportWin();">
                  <input class="d" type="button"   value="<fmt:message key='button_delete'/>"  <au:authorityBtn code="tpcf_del" type="1"/>  onClick="delRefund(2);">
                   <input class="zf" type="button"   value="<fmt:message key='button_ff'/>"  <au:authorityBtn code="tpcf_ff" type="1"/>  onClick="repay_downline();">
                   <input class="e" type="button"   value="<fmt:message key='button_export'/>"  <au:authorityBtn code="tpcf_imp" type="1"/>  onclick="expRefund();">
                   <input class="tb" style="margin-left: 65px;" type="button"   value="<fmt:message key='button_bh'/>"  <au:authorityBtn code="tpcf_add" type="1"/>  onClick="refundReject();">
                </div>
                <div class="clear"></div>
              </div>
            </form>
         	</div>
         	</div>
         	
         	<div id="div_dc_2"  style="display:none;">
            <r:datacell id="dc_refund_add2" 
                queryAction="/FAERP/RefundInfoAction.do?cmd=simpleQuery2"
                submitAction=""
                width="100%"
                height="300px"
                paramFormId="form_refund_add2"
                submitXpath="RefundInfoVo" 
                pageSize="100"
                xpath="RefundInfoVo">
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field fieldName="id" 
              label="<input type='checkbox' name='checkall' onclick='chk_all4(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox4">
              </r:field>
              <r:field sortAt="none" fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field sortAt="none" fieldName="customer_name" messagekey="customer_name" width="200px">
              </r:field>
              <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name">
              </r:field>
              <r:field sortAt="none" fieldName="servers_user" messagekey="servers_user">
              </r:field>
              <r:field fieldName="refund_code" messagekey="refund_code" >
              </r:field>
              <r:field fieldName="refund_amount" messagekey="refund_amount" onRefreshFunc="toformatnumber">
              </r:field>
              <r:field sortAt="none" fieldName="refund_cause" messagekey="refund_cause"  width="150px">
              </r:field>
              <r:field sortAt="none" fieldName="refund_type" messagekey="refund_type"  allowModify="false">
                <h:select name="list_refund_type" property="refund_type">
                   <h:option value="1" label="工资类"></h:option>
                   <h:option value="0" label="报销类"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="refund_name" messagekey="refund_name" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_num" messagekey="refund_num" width="150px">
              </r:field>
              <r:field sortAt="none" fieldName="refund_state_bd" messagekey="refund_state_bd_" allowModify="false">
                <h:select name="list_refund_state_bd" property="refund_state_bd">
                   <h:option value="0" label="未申请"></h:option>
                   <h:option value="1" label="待补发"></h:option>
                   <h:option value="2" label="已补发"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="create_date" messagekey="create_date" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_date" messagekey="refund_date" >
              </r:field>
              <r:field sortAt="none" fieldName="re_pay_time" messagekey="re_pay_time" >
              </r:field>
              <r:field sortAt="none" fieldName="remarks" messagekey="remarks" width="200px">
              </r:field>
            </r:datacell> 
        	</div>
      <!-- 退票重发TAB页 -->
      <div id="TabCon3" style="display:none;">
            <div class="box_tab">
              <form id="form_refund" action="" method="post">
              <input type="hidden" name="cmd" id="h_cmd3"/>
              <!-- 默认展示待补发的 -->
              <input type="hidden" name="refund_state_bd" id="h_refund_state_bd" value="1"/>
              <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                <tr>
                  <td class="td_1"><fmt:message key='icbc'/></td>
                  <td class="td_2"><input id = "icbc" class="xText_bttm" style="text-align:center;" /></td>
                  <td class="td_1"><fmt:message key='cmb'/></td>
                  <td class="td_2"><input id = "cmb" class="xText_bttm" style="text-align:center;" /></td>
                  <td class="td_1"><fmt:message key='other_cmb'/></td>
                  <td class="td_2"><input id = "other" class="xText_bttm" style="text-align:center;" /></td>
                </tr>
                <tr>
                  <td class="td_1"><fmt:message key='fail'/></td>
                  <td class="td_2"><input id = "fail" class="xText_bttm" style="text-align:center;" /></td>
                  <td class="td_1"><fmt:message key='total_num'/></td>
                  <td class="td_2"><input id = "total_num" class="xText_bttm" style="text-align:center;" /></td>
                  <td class="td_1"><fmt:message key='total_amount'/></td>
                  <td class="td_2"><input id = "total_amount" class="xText_bttm" style="text-align:center;" /></td>
                </tr>
              </table>
              <div class="button">
                <div class="button_right">
                  <!--<ul>
                    <li class="g_1"><a onclick="createEbank()" href="javascript:void(0);">生成网银</a></li>
                    <li class="zf"><a onclick="repay()" href="javascript:void(0);">发放</a></li>
                    <li class="e"><a onclick="exportRefund()" href="javascript:void(0);">导出</a></li>
                  </ul>
                  -->
                  <input class="g_1" type="button"   value="<fmt:message key='button_scwy'/>"  <au:authorityBtn code="tpcf_scwy" type="1"/>  onClick="createEbank();">
                <input class="zf" type="button"   value="<fmt:message key='button_ff'/>"  <au:authorityBtn code="tpcf_ff" type="1"/>  onClick="repay();">
                <input class="e" type="button"   value="<fmt:message key='button_export'/>"  <au:authorityBtn code="tpcf_exp" type="1"/>  onClick="exportRefund();">
                <input class="tb" style="margin-left: 65px;" type="button"   value="<fmt:message key='button_bh'/>"  <au:authorityBtn code="tpcf_add" type="1"/>  onClick="refundReject3();">
                </div>
                <div class="clear"></div>
              </div>
              </form>
         	</div>
         	</div>
         	<div id="div_dc_3" style="display:none;">
            <r:datacell id="dc_refund" 
                queryAction="/FAERP/RefundInfoAction.do?cmd=simpleQuery&loadData=${loadData }"
                submitAction=""
                width="100%"
                height="300px"
                paramFormId="form_refund"
                submitXpath="RefundInfoVo" 
                pageSize="100"
                xpath="RefundInfoVo">
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field fieldName="id" 
              label="<input type='checkbox' name='checkall' onclick='chk_all2(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox2">
              </r:field>
              <r:field sortAt="none" fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field sortAt="none" fieldName="customer_name" messagekey="customer_name">
              </r:field>
              <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name">
              </r:field>
              <r:field sortAt="none" fieldName="servers_user" messagekey="servers_user">
              </r:field>
              <r:field sortAt="none" fieldName="create_date" messagekey="create_date" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_date" messagekey="refund_date" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_amount" messagekey="refund_amount"  onRefreshFunc="toformatnumber" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_cause" messagekey="refund_cause" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_type" messagekey="refund_type"  allowModify="false">
                <h:select name="list_refund_type" property="refund_type">
                   <h:option value="1" label="工资类"></h:option>
                   <h:option value="0" label="报销类"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="refund_code" messagekey="refund_code" >
              </r:field>
              <r:field sortAt="none" fieldName="re_pay_time" messagekey="re_pay_time" >
              </r:field>
              <r:field sortAt="none" fieldName="remarks" messagekey="remarks" width="200px">
              </r:field>
            </r:datacell>
            <div class="box_tab">
            <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
            	<input type="hidden" name="refund_batch_id" id="refund_batch_id"/>
            	<tr>
            	  <td class="td_2">
            	  <fmt:message key='refund_batch_code'/><input id="refund_batch_code" name="refund_batch_code" class="sText"/>
                  <input id="btn_down_icbc" onclick="downEbankfile(1)" type="button" class="icon_3" value="<fmt:message key='button_down_icbc'/>" />
                  <input id="btn_down_cmb" onclick="downEbankfile(2)" type="button" class="icon_3" value="<fmt:message key='button_down_cmb'/>" />
		            <input id="btn_down_abc" onclick="downEbankfile(3)" type="button" class="icon_3" value="下载农行" />
		            <input id="btn_down_ccb" onclick="downEbankfile(4)" type="button" class="icon_3" value="下载建行" />
		            <input id="btn_down_pufa" onclick="downEbankfile(5)" type="button" class="icon_3" value="下载浦发" />
                  </td>
                </tr>
            </table>
            </div> 
        	</div>
      <!-- 补发查询TAB页 -->
      <div id="TabCon4" style="display:none;">
            <div class="box_tab">
              <form id="form_refund_qry" action="" method="post">
              <input type="hidden" name="batchId" id="h_batchId_ebank"/>
          	  <input type="hidden" name="bankType" id="h_bankType_ebank"/>
              <input type="hidden" name="cmd" id="h_cmd4"/>
              <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
                <tr>
                  <td class="td_1"><fmt:message key='customer_code'/></td>
                  <td class="td_2"><input name="customer_code" class="sText" /></td>
                  <td class="td_1"><fmt:message key='customer_name'/></td>
                  <td class="td_2">
                   <w:lookup name="customer_name" onReturnFunc="rtnFunc_qry" id="lk_cust_qry" 
                   lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="600"/>
                    <input type="hidden" name="customer_id" id="h_customer_id_qry"/>
                  </td>
                  <td class="td_1"><fmt:message key='emp_name'/></td>
                  <td class="td_2">
                    <input name="emp_name" class="sText" />
                  </td>
                  
                </tr>
                <tr>
                  <td class="td_1"><fmt:message key='refund_amount'/></td>
                  <td class="td_2">
                    <input id="refund_amount_f_qry" name="refund_amount_f" class="sText_1"/>
                    <input id="refund_amount_t_qry" name="refund_amount_t" class="sText_1" />
                  </td>
                  <td class="td_1"><fmt:message key='refund_date'/></td>
                  <td class="td_2">
                    <w:date allowInput="false" id="w_from_qry" name="refund_date_f" format="yyyy-MM-dd" 
                      style="width:75px;"/>
                    <w:date allowInput="false" id="w_to_qry" name="refund_date_t" format="yyyy-MM-dd" 
                      style="width:75px;"/>
                  </td>
                  <td class="td_1"><fmt:message key='servers_user'/></td>
                  <td class="td_2">
                  <r:comboSelect id="combo_cs2" name="servers_user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_select"/>
                  </td>
                </tr>
                <tr>
                  <td class="td_1"><fmt:message key='refund_batch_code'/></td>
                  <td class="td_2">
                    <input name="refund_batch_code" class="sText" />
                  </td>
                  <td class="td_1"><fmt:message key='refund_state_bd_'/></td>
                  <td class="td_2">
                    <select class="sSelect" name="refund_state_bd">
                       <option selected="true" value="1"><fmt:message key='refund_state_bd_1'/></option>
                       <option value="2"><fmt:message key='refund_state_bd_2'/></option>
                    </select>
                  </td>
                  <td class="td_1"><fmt:message key='refund_code'/></td>
                  <td class="td_2"><input name="refund_code" class="sText" /></td>
                </tr>
                <tr>
                  <td class="td_1"><fmt:message key='refund_name'/></td>
                  <td class="td_2"><input name="refund_name" class="sText" id="t_refund_name"/></td>
                  <td class="td_1"></td>
                  <td class="td_2"></td>
                  <td class="td_1">&nbsp;</td>
                  <td class="td_2"><input onclick="doQuery('dc_refund_qry')" type="button" class="icon_1" value="<fmt:message key='button_search'/>" /></td>
                </tr>
              </table>
              </form>
         	</div>
         	</div>
         	
         	<div id="div_dc_4" style="display:none;">
            <r:datacell id="dc_refund_qry" 
                queryAction="/FAERP/RefundInfoAction.do?cmd=simpleQuery"
                submitAction=""
                width="100%"
                height="300px"
                paramFormId="form_refund_qry"
                submitXpath="RefundInfoVo" 
                pageSize="100"
                xpath="RefundInfoVo">
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field fieldName="refund_batch_id" 
              label="<input type='checkbox' onclick='chk_all3(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox3"/>
              <r:field sortAt="none" fieldName="refund_batch_code" messagekey="refund_batch_code" >
              </r:field>
              <r:field sortAt="none" fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field sortAt="none" fieldName="customer_name" messagekey="customer_name">
              </r:field>
              <r:field sortAt="none" fieldName="servers_user" messagekey="servers_user">
              </r:field>
              <r:field sortAt="none" fieldName="refund_amount" messagekey="refund_amount"  onRefreshFunc="toformatnumber">
              </r:field>
              <r:field sortAt="none" fieldName="refund_cause" messagekey="refund_cause" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_type" messagekey="refund_type" allowModify="false">
                <h:select name="list_refund_type" property="refund_type">
                   <h:option value="1" label="工资类"></h:option>
                   <h:option value="0" label="报销类"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="refund_code" messagekey="refund_code" >
              </r:field>
              <r:field sortAt="none" fieldName="refund_state_bd" messagekey="refund_state_bd_" allowModify="false">
                <h:select name="list_refund_state_bd" property="refund_state_bd">
                   <h:option value="0" label="未申请"></h:option>
                   <h:option value="1" label="待补发"></h:option>
                   <h:option value="2" label="已补发"></h:option>
                </h:select>
              </r:field>
              <r:field sortAt="none" fieldName="create_date" messagekey="create_date" >
              </r:field>
              <r:field sortAt="none" fieldName="re_pay_time" messagekey="re_pay_time" >
              </r:field>
              <r:field sortAt="none" fieldName="remarks" messagekey="remarks" width="200px">
              </r:field>
            </r:datacell> 
          	</div>
      
</body>
<script type="text/javascript">

jQuery(function(){
    //$id("dc_refund_add").isQueryFirst = false;
    //$id("dc_refund").isQueryFirst = false;
    $id("dc_refund_qry").isQueryFirst = false;
    
    // 魏佳新增 -- 判断是否为通过首页提醒跳转过来的请求，如果是则直接点位到“退票重发”标签页
    if("${loadData}" == "true"){
        $id("dc_refund_add").isQueryFirst = false;
        $id("dc_refund_add2").isQueryFirst = false;
        $id("dc_refund_qry").isQueryFirst = false;
        
        //魏佳新增，添加首页提醒跳转过来后只查询工资类数据
        //$id("dc_refund").addParam("loadData","${loadData}");
        
        jQuery("#div_dc_1").hide();
        jQuery("#div_dc_2").hide();
        jQuery("#div_dc_3").show();
        jQuery("#div_dc_4").hide();
        document.getElementById('bg').className='xz_xixi3'
        document.getElementById("TabCon1").style.display="none";
        document.getElementById("TabCon2").style.display="none";
        document.getElementById("TabCon3").style.display="block";
        document.getElementById("TabCon4").style.display="none";
        document.getElementById("font1").style.color="#000000";
        document.getElementById("font2").style.color="#000000";
        document.getElementById("font3").style.color="#FFFFFF";
        document.getElementById("font4").style.color="#000000";
    }
});
//datacell 选中一行返回entity
function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
    if(!obj){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    return obj;
}

//选择客户
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    //jQuery("#h_customer_id").val(arg[0]);
    $id("h_customer_code").value = arg[1];
    return false;
}
//选择客户
function rtnFunc2(arg){
    var lookup = $id("lk_cust2");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    //jQuery("#h_customer_id").val(arg[0]);
    $id("h_customer_code2").value = arg[1];
    return false;
}
//选择客服
function rtnFuncCS(arg){
    var lookup = $id("lk_cs");
    lookup.value = arg[1];
    lookup.displayValue = arg[1];
    jQuery("#h_servers_user_id").val(arg[0]);        
    return false;
}
//选择客服
function rtnFuncCS2(arg){
    var lookup = $id("lk_cs2");
    lookup.value = arg[1];
    lookup.displayValue = arg[1];
    jQuery("#h_servers_user_id2").val(arg[0]);        
    return false;
}
//选择客户
function rtnFunc_qry(arg){
    var lookup = $id("lk_cust_qry");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    //jQuery("#h_customer_id_qry").val(arg[0]);        
    return false;
}
//选择客服
function rtnFuncCS_qry(arg){
    var lookup = $id("lk_cs_qry");
    lookup.value = arg[1];
    lookup.displayValue = arg[1];
    jQuery("#h_servers_user_id_qry").val(arg[0]);        
    return false;
}
//查询
function doQuery(datacell){
    jQuery("input[name='checkall']").each(function(){
        jQuery(this).attr("checked",false)
    });
    if(datacell == 'dc_refund_add'){
    	v1 = $id("refund_amount_f").value;
    	v2 = $id("refund_amount_t").value;
    	if(checkMoney(v1,v2)){
    		$id(datacell).reload();
    	}
    }else if(datacell == 'dc_refund_qry'){
    	v1 = $id("refund_amount_f_qry").value;
    	v2 = $id("refund_amount_t_qry").value;
    	if(checkMoney(v1,v2)){
    		$id(datacell).reload();
    	}
    }else if(datacell == 'dc_refund_add2'){
    	v1 = $id("refund_amount_f2").value;
    	v2 = $id("refund_amount_t2").value;
    	if(checkMoney(v1,v2)){
    		$id(datacell).reload();
    	}
    }else{
    	$id(datacell).reload();
    }
    
}
//验证金额有效性
function checkMoney(f,t){
    if((f && !isDecimal(f)) || (t && !isDecimal(t))){
        alert("<fmt:message key='alert_isDecimal'/>");
        return false;
    }
    return true;
}
//显示一列chkbox
function showchkbox1(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id1' value='" + entity.getProperty("id") + "' />";
}

//全选
function chk_all1(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox[name='chk_id1']").attr("checked", true);
    } else {
        jQuery(":checkbox[name='chk_id1']").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox2(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id2' value='" + entity.getProperty("id") + "' />";
}

//全选
function chk_all2(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox[name='chk_id2']").attr("checked", true);
    } else {
        jQuery(":checkbox[name='chk_id2']").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox3(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id3' value='" + entity.getProperty("id") + "' />";
}

//全选
function chk_all3(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox[name='chk_id3']").attr("checked", true);
    } else {
        jQuery(":checkbox[name='chk_id3']").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox4(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id4' value='" + entity.getProperty("id") + "' onclick='tab2_tip_show();' hide_tip='"+entity.getProperty("id")+"_-_"+entity.getProperty("emp_name")+"_-_"+entity.getProperty("refund_amount")+"'/>";
}

//全选
function chk_all4(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox[name='chk_id4']").attr("checked", true);
    } else {
        jQuery(":checkbox[name='chk_id4']").attr("checked", false);
    }
    tab2_tip_show();
}

//添加退票重发
function addRefund(flag){
	var callback_func = "refresh_datacell"; 
	if(flag == 2){
		callback_func = "refresh_datacell2"; 
	}
    showModalCenter("<%=request.getContextPath()%>/jsp/faerp/salary/refundinfo/addRefund.jsp"
                       									,null,refresh_datacell,800,350,"<fmt:message key='button_xixi1'/>");                                                                                   
}
//添加退票重发回调函数，刷新DATACELL
function refresh_datacell(){
    $id("dc_refund_add").reload();
    $id("dc_refund_add2").reload();
}
//删除
function delRefund(flag){
	var chk_id = "chk_id1";
	var dc = "dc_refund_add";
	var ds = $id("dc_refund_add").dataset;
	
	//添加退票-报销TAB
    if(flag == 2){
    	var chk_id = "chk_id4";
    	var dc = "dc_refund_add2";
    	ds = $id("dc_refund_add2").dataset;
    }
    var check = 0;
    var ids = new Array();
    
    jQuery("input[name='"+chk_id+"']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value);
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("refund_state_bd");
            //待补发，已补发不允许删除
            if(state!=0){
            	check = -1;
            	var code = entity.getValue("refund_code");
            	alert("<fmt:message key='alert_refund_code_4'/>"+ code +"<fmt:message key='alert_refund_code_5'/>");
            	return false;
            }
        }
    });
    
    if(check == "-1"){
    	return;
    }
    
    len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    if(!confirm("<fmt:message key='alert_is_delete'/>")){
        return;
    }
    //alert(ids.join());
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=deleteMulti&ids="+ids.join(),function(data){
           if(data > 0){
            $id(dc).reload();
           }
    });
}
//点击TAB页初始化datacell数据
function changeTab(datacell){
    $id(datacell).reload();
}
//切换标签页
function toggleDiv(tabNo){
	switch(tabNo){
		case 1:
			jQuery("#div_dc_1").show();
			jQuery("#div_dc_2").hide();
			jQuery("#div_dc_3").hide();
			jQuery("#div_dc_4").hide();
			break;
		case 2:
			jQuery("#div_dc_2").show();
			jQuery("#div_dc_1").hide();
			jQuery("#div_dc_3").hide();
			jQuery("#div_dc_4").hide();
			break;
		case 3:
			jQuery("#div_dc_3").show();
			jQuery("#div_dc_1").hide();
			jQuery("#div_dc_2").hide();
			jQuery("#div_dc_4").hide();
			break;
		case 4:
			jQuery("#div_dc_4").show();
			jQuery("#div_dc_1").hide();
			jQuery("#div_dc_2").hide();
			jQuery("#div_dc_3").hide();
			break;
	}
}
function setTab001Syn ( i )
{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#FFFFFF";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#FFFFFF";
            document.getElementById("font3").style.color="#000000";
            document.getElementById("font4").style.color="#000000";
			break;
			case 3:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#FFFFFF";
			document.getElementById("font4").style.color="#000000";
			break;
			case 4:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#FFFFFF";
			break;
		}
}

var _t = null;
//打开文件上传对话框
function showImportWin(){
	//清空路径
	$id("attackAddressInput").value = "";
	//清除Interval
    window.clearInterval(_t);
    
    //w为窗口宽度，h为高度
    var w = 400;
    var h = 150;
    var l = (screen.width - w) / 2;
    var t = (screen.height - h) / 2;
    var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
    s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
    window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp',"<fmt:message key='title_import_refundbatch'/>",s);
    
    //每隔1秒执行函数impRefund
    _t = window.setInterval(impRefund,1000);
}
//导入退票重发回调函数
function impRefund(){
    _path = $id("attackAddressInput").value;
    if(_path){
    	showProgressBar();
        jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=importRefundinfo&attach_address="+_path,function(data){
          // if(data > 0){
           	hideProgressBar();
           	//清除Interval
           	window.clearInterval(_t);
           	$id("attackAddressInput").value = "";
           	alert(data);
            $id("dc_refund_add").reload();
            $id("dc_refund_add2").reload();
        //   }else{
        //   	hideProgressBar();
        //   	//清除Interval
        //   	window.clearInterval(_t);
       //    	$id("attackAddressInput").value = "";
       //    	alert("<fmt:message key='alert_import_fail'/>" + data);
       //    }
           //清除Interval
           window.clearInterval(_t);
        });
	    //清除Interval
	    window.clearInterval(_t);
    }
    
}
//生成网银
function createEbank(){
    
    ids = new Array();
    jQuery("input[name='chk_id2']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
        }
    });
    
    len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    //没有银行卡的不让生成网银
    var ds = $id("dc_refund").dataset;
    /*
    for(var i=0; i<ids.length; i++){
    	var vo = ds.findEntity("id",ids[i]);
    	if(!vo.getValue("account_num")){
    		alert("请先完善员工的银行卡信息！");
    		return;
    	}
    }*/
    if(!confirm("<fmt:message key='alert_is_ebank'/>")){
        return;
    }
    showProgressBar();
    //判断是否有生成过网银
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=queryIsCreateEBank&ids="+ids.join(),function(data){
           if(data){
	            if(data>0){
	               if(!confirm("选择的记录里有已经生成过网银的退票，是否继续生成！")){
	                   hideProgressBar();
	                   return;//否就不继续生成
	               }else{
	                    //是则继续生成网银
	                    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=createEbankfile&ids="+ids.join(),function(data){
				           if(data){
				            hideProgressBar();
				            alert("<fmt:message key='alert_ebank_complete'/>");
				            analyzeRst(data);
				           
				           }else{
				            hideProgressBar();
				            alert("<fmt:message key='alert_ebank_fail'/>");
				           }
				        });
	               }
	            }else{
	                //没有生成过网银则直接生成
	                jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=createEbankfile&ids="+ids.join(),function(data){
			           if(data){
			            hideProgressBar();
			            alert("<fmt:message key='alert_ebank_complete'/>");
			            analyzeRst(data);
			           
			           }else{
			            hideProgressBar();
			            alert("<fmt:message key='alert_ebank_fail'/>");
			           }
			        });
	            }
           }else{
	            hideProgressBar();
	            alert("<fmt:message key='alert_ebank_fail'/>");
	            return;
           }
    });
    
}
//解析返回结果信息
function analyzeRst(data){
    rst = data.split(",");
      
    if(rst.length >= 8){
        if (rst[8] == "null"){
	        $id("icbc").value = rst[0];
        }else{
            $id("icbc").value = rst[0] + " / " + rst[8] ;
        }
        
        if (rst[9] == "null"){
            $id("cmb").value = rst[1];
        }else{
            $id("cmb").value = rst[1] + " / " + rst[9] ;
        }
        
        $id("other").value = rst[2];
        $id("fail").value = rst[3];
        $id("total_num").value = rst[4];
        $id("total_amount").value = rst[5];
        $id("refund_batch_id").value = rst[6];
        $id("refund_batch_code").value = rst[7];
        
      //  alert("icbc.value"+$id("icbc").value);
        if(rst[0] > 0){
       
        	jQuery("#btn_down_icbc").removeAttr("disabled");
        }else{
          
        	jQuery("#btn_down_icbc").attr("disabled","disabled");
        }
        if( rst[1] > 0){
        	jQuery("#btn_down_cmb").removeAttr("disabled");
        }else{
        	jQuery("#btn_down_cmb").attr("disabled","disabled");
        }
    }
}
//退票重发TAB-发放
function repay(){
    
    ids = new Array();
    jQuery("input[name='chk_id2']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
        }
    });
    
    len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    //没有银行卡的不让生成网银
    var ds = $id("dc_refund").dataset;
    /*
    for(var i=0; i<ids.length; i++){
    	var vo = ds.findEntity("id",ids[i]);
    	if(!vo.getValue("account_num")){
    		alert("请先完善员工的银行卡信息！");
    		return;
    	}
    }*/
    if(!confirm("<fmt:message key='alert_is_ff'/>")){
        return;
    }
    //alert(ids.join());
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=repay&ids="+ids.join(),function(data){
           if(data != ""){
           showModalCenter(venusbase+"/RefundInfoAction.do?cmd=toRemark&code=" + data,null,"",200,100,"生成重发批次号");
            $id("dc_refund").reload();
           }
    });
}
//线下退票重发
function repay_downline(){
    var ds = $id("dc_refund_add2").dataset;
    ids = new Array();
    jQuery("input[name='chk_id4']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("refund_state_bd");
            if(state !=1 ){
            	alert("<fmt:message key='alert_select_status_1'/>");
            	ids = "-1";
            	return false;
            }
        }
    });
    
    if(ids == "-1"){
    	return;
    }
    len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    
    /*
    for(var i=0; i<ids.length; i++){
    	var vo = ds.findEntity("id",ids[i]);
    	if(!vo.getValue("account_num")){
    		alert("请先完善员工的银行卡信息！");
    		return;
    	}
    }*/
    if(!confirm("<fmt:message key='alert_is_ff'/>")){
        return;
    }
    //alert(ids.join());
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=repay&ids="+ids.join(),function(data){
           if(data != ""){
	            showModalCenter(venusbase+"/RefundInfoAction.do?cmd=toRemark&code=" + data,null,"",200,100,"生成重发批次号");
	            $id("dc_refund_add2").reload();
           }
    });
}
//导出
function exportRefund(){
    $id("form_refund").action = "<%=request.getContextPath()%>/RefundInfoAction.do";
    $id("h_cmd3").value="export";
    $id("form_refund").submit();
}

function exportRefund_plus(){
    $id("form_refund_add").action = "<%=request.getContextPath()%>/RefundInfoAction.do";
    $id("h_cmd").value="exportPlus";
    $id("form_refund_add").submit();
}
//下载网银
function downEbankfile(bankType){
    var ids = $id("refund_batch_id").value;
    if(ids.length<=0){
    	alert("<fmt:message key='alert_refund_batch_null'/>");
    	return;
    }
    $id("h_batchId_ebank").value = ids;
    $id("h_bankType_ebank").value = bankType;
    $id("h_cmd4").value = "downEbankfile";
    var refund_batch_code = $id("refund_batch_code").value;
    $id("form_refund_qry").action = "<%=request.getContextPath()%>/RefundInfoAction.do?refund_batch_code="+refund_batch_code ;
    $id("form_refund_qry").submit();
}

//获得选中的记录
function getChkedRecord(){
	var ids = new Array();
    jQuery("input[name='chk_id3']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
        }
    });
    
    var len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return "";
    }
    return len;
}
//下载退票导入模板
function downImpTemp(){
	$id("h_cmd").value = "downImpTemp";
	$id("form_refund_add").action = "<%=request.getContextPath()%>/RefundInfoAction.do" ;
	$id("form_refund_add").submit();
}
/**
*退票导出
*/
function expRefund(){
	var ds = $id("dc_refund_add2").dataset;
    var ids = new Array();
    jQuery("input[name='chk_id4']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
        }
    });
    
    var len = ids.join();
    //根据查询条件导出
    if(len == 0){
    	$id("form_refund_add2").action = "<%=request.getContextPath()%>/RefundInfoAction.do";
    	$id("h_cmd2").value = "export2";
    }else{
    	$id("form_refund_add2").action = "<%=request.getContextPath()%>/RefundInfoAction.do";
    	$id("form_refund_add2").method = "post";
    	$id("h_cmd2").value = "exportChecked";
    	$id("h_ids").value = len;
    }
	
    $id("form_refund_add2").submit();
}
//驳回
function refundReject(){
    var _now = new Date();
    var ds = $id("dc_refund_add2").dataset;
	var ids = new Array();
    jQuery("input[name='chk_id4']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value);
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("refund_state_bd");
            if(state != 1){
            	//var code = entity.getValue("refund_code");
            	//var msg = code?"退票编号：" + code + " 已申请，请重新选择！":"选择的记录中有已经申请的，请重新选择！";
            	alert("<fmt:message key='alert_bh'/>");
            	ids = "-1";
            	return false;
            }
            
        }
    });
    if(ids == "-1"){
    	return;
    }
	len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=refundReject&ids="+ids.join()+"&apply_pay_time="+dateToString(_now),function(data){
           if(data > 0){
            alert("<fmt:message key='alert_bh_complete'/>");
            $id("dc_refund_add2").reload();
           }else if(data == 0){
           	//alert("驳回失败！");
           }
    });
}


//退票重发驳回
function refundReject3(){
    var _now = new Date();
    var ds = $id("dc_refund").dataset;
    var ids = new Array();
    jQuery("input[name='chk_id2']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value);
            var entity = ds.findEntity("id",this.value);
            var state = entity.getValue("refund_state_bd");
            if(state != 1){
                alert("<fmt:message key='alert_bh'/>");
                ids = "-1";
                return false;
            }
            
        }
    });
    if(ids == "-1"){
        return;
    }
    len = ids.join();
    if(len == 0){
        alert("<fmt:message key='alert_select_record'/>");
        return;
    }
    jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=refundReject&ids="+ids.join()+"&apply_pay_time="+dateToString(_now),function(data){
           if(data > 0){
            alert("<fmt:message key='alert_bh_complete'/>");
            $id("dc_refund").reload();
           }else if(data == 0){
            //alert("驳回失败！");
           }
    });
}

//吴敬磊 2013-12-30
//动态计算选 中数据
function tab2_tip_show(id,name,amount){
    var record = 0;
    var nameStr = ",";
    var empCount = 0;
    var amount = "0";
    jQuery("input[name='chk_id4']").each(function(){
        if(jQuery(this).attr("checked")){
            var item = jQuery(this).attr("hide_tip").split("_-_");
            record++;
            amount = accAdd(amount,item[2]);
            if (nameStr.indexOf("," + item[1] + ",") == -1){
                empCount++;
                nameStr += item[1] + ",";
            }
        }
    });
    jQuery("#tab2_tip_1").html(record);
    jQuery("#tab2_tip_2").html(empCount);
    jQuery("#tab2_tip_3").html(amount);
}

function accAdd(arg1,arg2){   
	var r1,r2,m;   
	try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}   
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}   
	m=Math.pow(10,Math.max(r1,r2)); 
	return (arg1*m+arg2*m)/m;
}   
	
</script>
</fmt:bundle>
</html>
