<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.bill.billmodify.billmodify_resource" prefix="rayoo.finance.bill.billmodify.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='title_billmodify'/></title>
	<script language="javascript" src="<venus:base/>/jsp/faerp/finance/bill/billmodify/billmodifypage.js"></script>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='title_billmodify'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='billmodify_search'/></div> </td>
        <td width="85"/>
        <td width="196"/>
        <td width="143"/>
        <td width="240"/>
    </tr>
    <tr>
        <td align="right"><fmt:message key='customer_code'/></td>
        <td align="left">
            <w:lookup
                id="lk_cust"
                lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                messagekey="choose_cust" height="450" width="610" style="width:180px" readonly="true"/>
           <input type="hidden" name="cust_id" id="cust_id">
        </td>
        <td align="right"><fmt:message key='cost_center'/></td>
        <td align="left">
        <r:comboSelect id="cost_center_id" name="cost_center_id"
            queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name"
            valueField="id"
            xpath="CostcenterVo"
            width="203" messagekey="please_select">
        </r:comboSelect>
        </td>
        <td width="100" align="right"><fmt:message key='bill_year_month'/></td>
        <td width="213" align="left">
            <input type="text" class="text_field" id="bill_year_month" name="bill_year_month" inputName="应收年月" maxLength="50" value=""/>
        </td>
    </tr>
    <tr>
        <td align="right"><fmt:message key='applyfortime'/></td>
            <td align="left">
            <w:date format="yyyy-MM-dd" name="applyfortime_from" id="applyfortime_from" width="70px"/><fmt:message key='applyfortime_to'/>
            <w:date format="yyyy-MM-dd" name="applyfortime_to" id="applyfortime_to" width="70px"/>
        </td>
        <td align="right"><fmt:message key='applyforusername'/></td>
        <td align="left">
            <input type="text" class="text_field" id="applyforusername" name="applyforusername" maxLength="50" value=""/>
        </td>
        <td align="right"><fmt:message key='bill_type_bd'/></td>
        <td align="left">
            <d:select  name="bill_type_bd" id="bill_type_bd" dictTypeId="FB_BILL_TYPE_BD" nullLabel="--请选择--"/>
        </td>
    </tr>
    <tr>
        <td align="right"><fmt:message key='approvetime'/></td>
            <td align="left">
            <w:date format="yyyy-MM-dd" name="approvetime_from" width="70px"/><fmt:message key='approvetime_to'/>
            <w:date format="yyyy-MM-dd" name="approvetime_to" width="70px"/>
        </td>
        <td align="right"><fmt:message key='approveusername'/></td>
        <td align="left">
            <input type="text" class="text_field" id="approveusername" name="approveusername" maxLength="50" value=""/>
        </td>
         <!-- td align="right">审批状态</td>
        <td align="left">
        	<d:select  name="approve_bd" id="approve_bd" dictTypeId="BILL_APPR_STATUS" nullLabel="--请选择--"/>
        </td> -->
         <td align="right">
            <input name="button_ok2" id="btnquery" class="icon_1" type="button"
				value='<fmt:message key="button_query"/>'>
        </td>
    </tr>
    
    </table>
</div>


<div class="button">
    <div class="button_right">
        <!--<ul>
            <li class="b_1"><a href="javascript:void(0);" onclick="list2item();">修改明细</a></li>
        </ul>
        -->
        <input class="b_1" type="button"   value="<fmt:message key='button_xgmx'/>"  <au:authorityBtn code="xgzd_xgmx" type="1"/>  onClick="list2item();">
    </div>
    <div class="clear"></div>
</div>
<!-- BillmodifyVo -->
<div style="padding: 5 0 8 8;">
        <r:datacell 
        id="datacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/BillmodifyAction.do?cmd=queryAll4DataCell"
        width="98%"
        height="318px"
        xpath="FinbillVo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="cust_code" messagekey="customer_code" sortAt="server">
      </r:field>
      <r:field fieldName="cust_name" messagekey="customer_name" width="190px" sortAt="server">
      </r:field>
      <r:field fieldName="cost_center_name" messagekey="cost_center" width="205px">
      </r:field>
      <r:field fieldName="bill_year_month" messagekey="bill_year_month">
      </r:field>
      <r:field fieldName="version" messagekey="version">
      </r:field>
      <r:field fieldName="bill_amount" messagekey="bill_amount" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="verification_amount" messagekey="verification_amount" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="adjust_amout" messagekey="adjust_amout" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="rate_odds" messagekey="rate_odds" width="80px">
                <h:text />
            </r:field>
			<r:field fieldName="outstanding_amount" messagekey="outstanding_amount" width="80px">
				<h:text />
			</r:field>
			<r:field fieldName="bill_gather_status_bd" messagekey="bill_gather_status_bd" width="100px">
				<d:select dictTypeId="GATHER_STATUS_BD" ></d:select>
			</r:field>
			<r:field fieldName="bill_invoice_status_bd" messagekey="bill_invoice_status_bd" width="100px">
				<d:select dictTypeId="INVOICE_STATUS_BD" ></d:select>
			</r:field>
			<r:field fieldName="bill_type_bd" messagekey="bill_type_bd_" width="100px">
				<d:select dictTypeId="FB_BILL_TYPE_BD"></d:select>
			</r:field>
			
      		<r:field fieldName="bill_type_bd" messagekey="bill_type_bd" allowModify="false">
        		<d:select dictTypeId="FB_BILL_TYPE_BD"></d:select>
      		</r:field>
			<r:field fieldName="applyfortime" messagekey="applyfortime" width="100px">
			</r:field>
			<r:field fieldName="applyforusername" messagekey="applyforusername" width="100px">
			</r:field>
      		<r:field fieldName="approve_bd" messagekey="approve_bd" width="100px">
				<d:select dictTypeId="BILL_APPR_STATUS"></d:select>
			</r:field>
			<r:field fieldName="approvetime" messagekey="approvetime" width="100px">
			</r:field>
			<r:field fieldName="approveusername" messagekey="approveusername" width="100px">
			</r:field>
    </r:datacell>
</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script>
    if (${msg != null } && ${msg != "" }) {
        alert('${msg}');
    }

    
    window.setInterval("requestActionForSession()",600000);
    
    function requestActionForSession(){
    	 var _url = " <%=request.getContextPath() %>/FinbillAction.do?cmd=requestActionForSession&date=" +new Date();
               _$.ajax({
            		type : "post",
                    url : _url, 
                    dataType : "html" ,
          			success : function (data) {
                       
                    }
        });

}

    
_$(document).ready(function() {
        $id("datacell").isQueryFirst = false;
});

</script>
