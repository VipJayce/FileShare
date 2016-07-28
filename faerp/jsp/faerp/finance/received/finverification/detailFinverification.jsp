<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%
//String claim_id = (String)request.getAttribute("claim_id");
//String verification_id = request.getAttribute("verification_id").toString();
%>
<html>
<fmt:bundle basename="rayoo.finance.received.finverification.finverification_resource" prefix="rayoo.finance.received.finverification.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_detail'/></title>
<script language="javascript">
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="claim_id" name="claim_id" value="${requestScope.claim_id}"/>
<input type="hidden" id="verification_id" name="verification_id" value="${requestScope.verification_id}"/>
<input type="hidden" id="bill_id" name="bill_id" value="${requestScope.bill_id}"/>
<input type="hidden" id="claim_id1" name="claim_id1" value=""/>
<div id="right">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='title_detail_info'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    
    <div class="ringht_s">
       <div class="social_tab">
           <div style="margin-top:10px;" class="xz_title"><fmt:message key='title_info'/></div>
           <div class="box_3">
           <table  width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1"><fmt:message key='inc_code'/></td>
               <td class="td_2">${bean.inc_code }</td>
               <td class="td_1"><fmt:message key='inc_date_from'/></td>
               <td class="td_2"><fmt:formatDate value="${bean.inc_date }" pattern="yyyy-MM-dd"/></td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key='inc_amout'/></td>
               <td class="td_2"><label id="inc_amout"><fmt:formatNumber value="${bean.inc_amout}" pattern="###,###,###,###.##"  minFractionDigits="2"/></label>
                  <input type="hidden" id="inc_amout_h" name="inc_amout_h" value="${bean.inc_amout}"/>
               </td>
               <td class="td_1"><fmt:message key='inc_bank'/></td>
               <td class="td_2">
                    <bean:define id="inc_bank" name="bean" property="inc_bank"/>
                    <%=BaseDataHelper.getNameByCode("BANK",String.valueOf(inc_bank))%>
               </td>
             </tr>
            <tr>
               <td class="td_1"><fmt:message key='upload_date'/></td>
               <td class="td_2"><fmt:formatDate value="${bean.upload_date }" pattern="yyyy-MM-dd"/></td>
               <td class="td_1"><fmt:message key='upload_user'/></td>
               <td class="td_2">
                    <bean:define id="create_user" name="bean" property="upload_user_id"/>
                    <%=OrgHelper.getPartyVoByID(create_user.toString()) == null ? "" : OrgHelper.getPartyVoByID(create_user.toString()).getName()%>
                </td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key='last_claim_date'/></td>
               <td class="td_2"><fmt:formatDate value="${bean.last_claim_date }" pattern="yyyy-MM-dd"/></td>
               <td class="td_1"><fmt:message key='last_claim_user_name'/></td>
               <td class="td_2">${bean.last_claim_user_name }</td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key='ver_amount'/></td>
               <td class="td_2"><fmt:formatNumber value="${bean.last_claim_amount}" pattern="###,###,###,###.##"  minFractionDigits="2"/></td>
               <td class="td_1"><fmt:message key='last_claim_desc'/></td>
               <td class="td_2">${bean.last_claim_desc }</td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key='claim_status_bd'/></td>
               <td class="td_2">
                    <bean:define id="claim_status_bd" name="bean" property="claim_status_bd"/>
                    <%=BaseDataHelper.getNameByCode("CLAIM_STATUS_BD",String.valueOf(claim_status_bd))%>
               </td>
               <td class="td_1"><fmt:message key='un_claim_amout'/></td>
               <td class="td_2" id="td_unc">
                    <label id="un_claim_amout"><fmt:formatNumber value="${bean.un_claim_amout}" pattern="###,###,###,###.##"  minFractionDigits="2"/></label>
                </td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key='inc_cust_name'/></td>
               <td class="td_2">${bean.inc_cust_name }</td>
               <td class="td_1"><fmt:message key='cost_center_name'/></td>
               <td class="td_2">${bean.cost_center_name}</td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key='bill_year_month'/></td>
               <td class="td_2">${bean.bill_year_month }</td>
               <td class="td_1"></td>
               <td class="td_2"></td>
             </tr>
          </table>
        </div>
    
        <div>
            <div style="margin-top:15px;" class="xz_title"><fmt:message key='xz_title'/></div>
            <div style="padding: 0 0 8 8;">
                <r:datacell 
                id="datacell1"
                paramFormId="datacell_formid"
                queryAction="/FAERP/FinverificationAction.do?cmd=findData1"
                width="96%"
                height="150px"
                xpath="FinverificationVo"
                readonly="true"
                pageSize="-1"
                >
               
              <r:field fieldName="inc_date" messagekey="inc_date"  width="100">
                <w:date format="yyyy-MM-dd"/>
              </r:field>
              <r:field fieldName="inc_amout" messagekey="inc_amout_" width="100">
              </r:field>
              <r:field fieldName="balance_amount" messagekey="balance_amount" width="100">
              </r:field>
              <r:field fieldName="ver_amount" messagekey="ver_amount_" width="100">
              </r:field>
            </r:datacell>
            </div>
        </div>
        
        <div>
            <div style="margin-top:10px;" class="xz_title"><fmt:message key='xz_title_1'/></div>
            <div style="padding: 0 0 8 8;">
                <r:datacell 
                id="datacell2"
                paramFormId="datacell_formid"
                queryAction="/FAERP/FinverificationAction.do?cmd=findData2&bill_id=${bean.bill_id}"
                width="96%"
                height="100px"
                xpath="FinbillVo"
                readonly="true"
                >
              <r:field fieldName="bill_year_month" messagekey="billyearmonth" width="90"></r:field>
              <r:field fieldName="bill_amount" messagekey="bill_amount" width="90"></r:field>
              <r:field fieldName="verification_amount" messagekey="verification_amount" width="90"></r:field>
              <r:field fieldName="rate_odds" messagekey="rate_odds" width="90"></r:field>
              <r:field fieldName="rate_amount" messagekey="rate_amount" width="90"></r:field>
              <r:field fieldName="outstanding_amount" messagekey="outstanding_amount" width="90"></r:field>
              <r:field fieldName="bill_type_bd" messagekey="bill_type_bd" width="100">
                <d:select dictTypeId="BILL_TYPE_BD"/>
              </r:field>
              <r:field fieldName="user_name" messagekey="user_name" width="100"></r:field>
            </r:datacell>
            </div>
        </div>
       </div>
       <div class="foot_button">
          <input onclick="javascript:window.close();" type="button" class="foot_icon_1" value="<fmt:message key='close'/>"/>
        </div>
       
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

