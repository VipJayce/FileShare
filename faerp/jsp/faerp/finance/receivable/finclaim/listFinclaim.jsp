<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<fmt:bundle basename="rayoo.finance.receivable.finclaim.finclaim_resource" prefix="rayoo.finance.receivable.finclaim.">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_finclaim'/></title>
<%
Boolean financialFlag = (Boolean)request.getAttribute("financialFlag");
%>
<style type="text/css">
    .text_field_half {
        background-color: #FFFFFF;
        border: 1px solid #90B3CF;
        color: #163752;
        font-size: 9pt;
        height: 20px;
        margin-right: 5px;
        vertical-align: middle;
        width: 102px;
    }
</style>
<script language="javascript">
    var venusbase = "<%=request.getContextPath()%>";
    function queryData(){
           var inc_date_to_hid=_$("#inc_date_to_hid_input").val();
           //alert(inc_date_to_hid);
            if(inc_date_to_hid!=undefined&&inc_date_to_hid!=""){
            _$("#inc_date_to").val(inc_date_to_hid+" 12:59:59");
            }
            //alert(_$("#inc_date_to").val());
            $id("dcListIncoming").reload();
      }
</script>
<script language="javascript" src="<venus:base/>/jsp/faerp/finance/receivable/finclaim/listFinclaim.js"></script>
<script language="javascript" src="<venus:base/>/jsp/faerp/finance/receivable/finclaim/utils.js"></script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" ><!-- action="FinclaimAction.do?cmd=exportExcelFromIncoming" -->
<input type="hidden" name="financialFlag" id="financialFlag" value="<%=request.getAttribute("financialFlag") %>">
<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key='title_finclaim'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="132" rowspan="5" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
        <td width="85"/>
        <td width="196"/>
        <td width="143"/>
        <td width="85"/>
        <td width="85"/>
    </tr>
  <tr>
      <td align="right"><fmt:message key='inc_amout'/></td>
      <td align="left">
          <input type="text" class="text_field_half" name="inc_amout_from" style="width: 93px"/><fmt:message key='inc_date_to'/><input type="text" class="text_field_half" name="inc_amout_to" style="width: 93px"/>
      </td>
      <td align="right"><fmt:message key='inc_date'/></td>
      <td align="left"><input type="hidden" value="" id="inc_date_to" name="inc_date_to"/>
          <w:date id="inc_date_from" name="inc_date_from" format="yyyy-MM-dd" size="6" style="width: 78px"/><fmt:message key='inc_date_to'/><w:date id="inc_date_to_hid" name="inc_date_to_hid" format="yyyy-MM-dd" size="6" style="width: 78px"/>
      </td>
      <td align="right"><fmt:message key='last_claim_year_month'/></td>
      <td align="left">
          <input type="text" class="text_field" id="last_claim_year_month" name="last_claim_year_month"/><!-- 费用账期 -->
      </td>
  </tr>
  <tr>
  <c:if test="${financialFlag==true}"></c:if>
      <td align="right"><fmt:message key='claim_status_bd'/></td>
      <td align="left" <c:if test="${financialFlag==true}"> disabled="true"</c:if>>
         <d:select id="claim_status_bd" name="claim_status_bd" dictTypeId="CLAIM_STATUS_BD" value="1" nullLabel="-请选择-"></d:select>
      </td>
      <td align="right"><fmt:message key='is_claim_and_cancel'/></td>
      <td>
          <d:select dictTypeId="IS_CLAIM_AND_CANCEL" nullLabel="-请选择-" name="is_claim_and_cancel"></d:select>
      </td>
      <td align="right"><fmt:message key='inc_cust_name'/></td>
      <td align="left">
          <input type="text" class="text_field" name="inc_cust_name"/><!-- 到款公司名称 -->
      </td>
  </tr>
  <tr>
         <td align="right"><fmt:message key='voucher_status'/></td>
        <td >
        	<d:select name="voucher_status" dictTypeId="VOUCHER_STATUS" nullLabel="--请选择--" />
        </td>
        <td align="right"><fmt:message key='last_claim_user_name_'/></td>
        <td align="left">
        <r:comboSelect id="last_claim_user_id" name="last_claim_user_id"
                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_select" />
         </td>
         <td align="right">到款编号</td>
	     <td align="left">
	          <input type="text" class="text_field" name="inc_code" id="inc_code"/><!-- 到款公司名称 -->
	     </td>
  </tr>
  <tr>
  <c:if test="${financialFlag==true}">
      <td align="right"><fmt:message key="bill_whether_write_off"/></td>
      <td align="left">
          <d:select name="bill_whether_write_off" id="bill_whether_write_off" dictTypeId="TrueOrFalse" nullLabel="--请选择--" />
      </td>
    </c:if>
    <c:if test="${financialFlag==true}">
	   <td colspan="2" align="right">
	          <input name="button_ok" id="button_ok" class="icon_1"   type="button" value="<fmt:message key='button_query'/>">
	          <input type="button" class="icon_1" value="<fmt:message key='button_reset'/>" onClick="javascript:this.form.reset();queryData();">
	   </td>
	</c:if>
	<c:if test="${financialFlag!=true}">
	    <td colspan="4" align="right">
             <input name="button_ok" id="button_ok" class="icon_1"   type="button" value="<fmt:message key='button_query'/>">
             <input type="button" class="icon_1" value="<fmt:message key='button_reset'/>" onClick="javascript:this.form.reset();queryData();">
        </td>
	</c:if>
  </tr>
</table>
</div>





<div id="ccParent1" class="button">
<input type="hidden" value="" id="incomingID" name="incomingID"/>
<div class="button_right" style="width:100%;">
  <!--<ul>
      <li class="c"><a>认领</a></li>
      <li class="f"><a>取消认领</a></li>
      <li class="e"><a>导出</a></li>
  </ul>

  <input class="c"  id="c_1" type="button"   value="认领"  <au:authorityBtn code="dkrl_rl" type="1"/>>
    -->

  <input class="c"  id="g_1" type="button"   value="<fmt:message key='button_rl'/>"  <au:authorityBtn code="dkrl_rl" type="1"/>>

  <input class="bl_2" type="button"   value="<fmt:message key='button_rlys'/>" onclick="showReceivable();" <au:authorityBtn code="dkrl_rlys" type="1"/>/>

  <input class="p_1" type="button" value="无账单认领开票" onclick="no_Bill_Claim(1);" <au:authorityBtn code="dkrl_wzdrl" type="1"/>/>
  <input class="p_1" type="button" value="无账单认领不开票" onclick="no_Bill_Claim(0);" <au:authorityBtn code="dkrl_wzdrl" type="1"/>/>
  <input class="p_1" type="button" value="解除财务锁定" <au:authorityBtn code="dkrl_unlock" type="1"/> id="unLockFin"/>
  <input class="p_1" type="button" value="财务锁定" <au:authorityBtn code="dkrl_lock" type="1"/> id="lockFin"/>

  <input class="f_1" id="f_1"  type="button"    value="<fmt:message key='button_qxrl'/>"  <au:authorityBtn code="dkrl_qxrl" type="1"/>>
  <input class="e"  id="exp" type="button"   value="<fmt:message key='button_exp'/>"  <au:authorityBtn code="dkrl_exp" type="1"/>>

  <input class="f_1" id="cancel_fin" type="button"   value="<fmt:message key='button_cancel_fin_claim'/>"  <au:authorityBtn code="cancel_fin" type="1"/>>
  <input class="bl_2" id="lock_list" type="button"   value="<fmt:message key='button_lock_list'/>" onclick="showLockFinIncoming();"  <au:authorityBtn code="view_lock" type="1"/>/>
  <input class="bl_2" type="button"   value="<fmt:message key='button_bill_lock_list'/>" onclick="showLockBill();"  <au:authorityBtn code="view_bill_lock" type="1"/>/>
  <input class="p_1"  id="v_invoice"  type="button"   value="核销无账单发票" onclick="verInvoice();" <au:authorityBtn code="dkrl_hxwzd" type="1"/>/>

</div>
<div class="clear"></div>
</div>

<div style="padding: 5px 0px 8px 8px;">
    <r:datacell
        id="dcListIncoming"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinclaimAction.do?cmd=queryAll"
        width="98%"
        height="319px"
        xpath="FININCOMINGVo"
        pageSize="100"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field allowModify="false" fieldName="chk"
                label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
                sortAt="none" width="30px">
                <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
        </r:field>
        <r:field fieldName="inc_code" messagekey="inc_code" width="100px;"/>
        <r:field fieldName="inc_date" messagekey="inc_date"  allowModify="false" width="100px;">
            <w:date format="yyyy-MM-dd"/>
        </r:field>
        <r:field fieldName="inc_cust_name" messagekey="inc_cust_name" width="250px;"/>
        <r:field fieldName="inc_amout" messagekey="inc_amout" width="80px;"/>
        <r:field fieldName="inc_bank" messagekey="inc_bank" allowModify="false" width="50px;">
            <d:select dictTypeId="BANK"/>
        </r:field>
        <r:field fieldName="upload_date" messagekey="upload_date" width="140" allowModify="false">
            <w:date format="yyyy-MM-dd HH:mm:ss"/>
        </r:field>
          <r:field fieldName="upload_desc" messagekey="upload_desc" width="140" allowModify="false">
        </r:field>
        <r:field fieldName="customer_code" messagekey="customer_code" width="100px;"/>
        <r:field fieldName="last_claim_cust_name" messagekey="last_claim_cust_name" width="250px;"/>
        <r:field fieldName="last_claim_year_month" messagekey="last_claim_year_month_"/>
        <r:field fieldName="is_claim_and_cancel" messagekey="is_claim_and_cancel" allowModify="false">
            <d:select dictTypeId="IS_CLAIM_AND_CANCEL"/>
        </r:field>
        <r:field fieldName="un_claim_amout" messagekey="un_claim_amout"/>
        <r:field fieldName="claim_status_bd" messagekey="claim_status_bd" allowModify="false">
            <d:select dictTypeId="CLAIM_STATUS_BD"/>
        </r:field>
        <r:field fieldName="last_claim_date" messagekey="last_claim_date" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
        </r:field>
        <r:field fieldName="last_claim_user_name" messagekey="last_claim_user_name_"/>
        <r:field fieldName="voucher_status" messagekey="voucher_status" width="90px">
         <d:select dictTypeId="VOUCHER_STATUS"/>
        </r:field>
        <r:field fieldName="voucher_ym" messagekey="voucher_ym" width="90px"/>
    </r:datacell>
</div>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">
    if(${msg != null && msg != ""}) {
        alert("${msg }");
    }
    _$(document).ready(function(){
        $id("dcListIncoming").isQueryFirst = false;
    });
</script>
</fmt:bundle>
