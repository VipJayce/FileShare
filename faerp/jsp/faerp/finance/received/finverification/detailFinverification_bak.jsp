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
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>核销明细</title>
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
        writeTableTopFesco('实收详细信息','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    
    <div class="ringht_s">
       <div class="social_tab">
           <div style="margin-top:10px;" class="xz_title">到款信息</div>
           <div class="box_3">
           <table  width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1">到款编号</td>
               <td class="td_2">${bean.inc_code }</td>
               <td class="td_1">到款日期</td>
               <td class="td_2"><fmt:formatDate value="${bean.inc_date }" pattern="yyyy-MM-dd"/></td>
             </tr>
             <tr>
               <td class="td_1">到款额</td>
               <td class="td_2"><label id="inc_amout"><fmt:formatNumber value="${bean.inc_amout}" pattern="###,###,###,###.##"  minFractionDigits="2"/></label>
                  <input type="hidden" id="inc_amout_h" name="inc_amout_h" value="${bean.inc_amout}"/>
               </td>
               <td class="td_1">到款银行</td>
               <td class="td_2">
                    <bean:define id="inc_bank" name="bean" property="inc_bank"/>
                    <%=BaseDataHelper.getNameByCode("BANK",String.valueOf(inc_bank))%>
               </td>
             </tr>
            <tr>
               <td class="td_1">上传时间</td>
               <td class="td_2"><fmt:formatDate value="${bean.upload_date }" pattern="yyyy-MM-dd"/></td>
               <td class="td_1">上传人</td>
               <td class="td_2">
                    <bean:define id="create_user" name="bean" property="upload_user_id"/>
                    <%=OrgHelper.getPartyVoByID(create_user.toString()) == null ? "" : OrgHelper.getPartyVoByID(create_user.toString()).getName()%>
                </td>
             </tr>
             <tr>
               <td class="td_1">最近认领时间</td>
               <td class="td_2"><fmt:formatDate value="${bean.last_claim_date }" pattern="yyyy-MM-dd"/></td>
               <td class="td_1">认领人</td>
               <td class="td_2">${bean.last_claim_user_name }</td>
             </tr>
             <tr>
               <td class="td_1">认领金额</td>
               <td class="td_2"><fmt:formatNumber value="${bean.last_claim_amount}" pattern="###,###,###,###.##"  minFractionDigits="2"/></td>
               <td class="td_1">认领备注</td>
               <td class="td_2">${bean.last_claim_desc }</td>
             </tr>
             <tr>
               <td class="td_1">认领状态</td>
               <td class="td_2">
                    <bean:define id="claim_status_bd" name="bean" property="claim_status_bd"/>
                    <%=BaseDataHelper.getNameByCode("CLAIM_STATUS_BD",String.valueOf(claim_status_bd))%>
               </td>
               <td class="td_1">未认领金额</td>
               <td class="td_2" id="td_unc">
                    <label id="un_claim_amout"><fmt:formatNumber value="${bean.un_claim_amout}" pattern="###,###,###,###.##"  minFractionDigits="2"/></label>
                </td>
             </tr>
             <tr>
               <td class="td_1">到款客户名称</td>
               <td class="td_2">${bean.inc_cust_name }</td>
               <td class="td_1">客户成本中心</td>
               <td class="td_2">${bean.cost_center_name}</td>
             </tr>
             <tr>
               <td class="td_1">认领费用账期</td>
               <td class="td_2">${bean.bill_year_month }</td>
               <td class="td_1"></td>
               <td class="td_2"></td>
             </tr>
          </table>
        </div>
    
        <div>
            <div style="margin-top:15px;" class="xz_title">已使用的预收款明细表</div>
            <div style="padding: 0 0 8 8;">
                <r:datacell 
                id="datacell1"
                paramFormId="datacell_formid"
                queryAction="/FAERP/FinverificationAction.do?cmd=findData1"
                width="96%"
                height="100px"
                xpath="FinverificationVo"
                readonly="true"
                pageSize="-1"
                >
               
              <r:field fieldName="inc_date" label="到账日期" allowModify="false">
                <w:date format="yyyy-MM-dd"/>
              </r:field>
              <r:field fieldName="inc_amout" label="到账金额">
              </r:field>
              <r:field fieldName="balance_amount" label="预收金额">
              </r:field>
              <r:field fieldName="ver_amount" label="上次核销">
              </r:field>
            </r:datacell>
            </div>
        </div>
        
        <div>
            <div style="margin-top:10px;" class="xz_title">应收列表</div>
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
              <r:field fieldName="bill_year_month" label="应收年月" width="80"></r:field>
              <r:field fieldName="bill_amount" label="应收金额" width="80"></r:field>
              <r:field fieldName="verification_amount" label="已收金额" width="80"></r:field>
              <r:field fieldName="rate_odds" label="小额调整" width="80"></r:field>
              <r:field fieldName="rate_amount" label="汇差" width="80"></r:field>
              <r:field fieldName="outstanding_amount" label="余额" width="80"></r:field>
              <r:field fieldName="bill_type_bd" label="应收类型" width="100">
                <d:select dictTypeId="BILL_TYPE_BD"/>
              </r:field>
              <r:field fieldName="user_name" label="客服" width="100"></r:field>
              <r:field fieldName="adjust_desc" label="认领备注" width="270"></r:field>
            </r:datacell>
            </div>
        </div>
        
        <div>
            <div style="margin-top:10px;" class="xz_title">认领明细拆分</div>
            <!--   动态表头  -->
            <div style="padding: 0 0 8 8;">
                <r:datacell 
                    id="datacell3"
                    paramFormId="datacell_formid"
                    queryAction="/FAERP/FinverificationAction.do?cmd=findData3&bill_id=${bean.bill_id}&verid=${verification_id }"
                    width="96%"
                    height="200px"
                    xpath="itemVo"
                    >
                    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                    <r:field fieldName="emp_name" label="姓名"></r:field>
                    <r:field fieldName="service_year_month" label="服务年月"></r:field>
                    <logic:iterate name="titleList" id="smalltitles" scope="request" indexId="indexs">
                      <c:choose>
                          <c:when test="${smalltitles[0] == 1 }">
                              <logic:iterate name="smalltitles" id="title" scope="page">
                                 <c:if test="${fn:contains(title, '_amount') }">
                                    <r:field fieldName="${title }" label="${smalltitles[8] }"></r:field>
                                 </c:if>
                              </logic:iterate>
                          </c:when>
                           <c:otherwise>
                              <r:field fieldName="${smalltitles[1] }" label="${fn:substring(smalltitles[2], 4, fn:length(smalltitles[2]))}"></r:field>
                           </c:otherwise>
                       </c:choose>
                    </logic:iterate>
                </r:datacell>
            </div>
       </div>
       
       <div>
           <div class="xz_title" style="margin-top:10px;">一次收费项目</div>
           <div style="padding: 0 0 8 8;">
                <r:datacell id="celllist1"
                queryAction="/FAERP/FinbillAction.do?cmd=queryBillOther&bill_id=${requestScope.bill_id}"
                paramFormId="datacell_formid" 
                width="96%"
                height="100px"
                xpath="BillOthersVo" readonly="true">
                
                <r:field fieldName="charge_item_bd" label="项目名称" width="150px">
                    <d:select dictTypeId="CHARGE_ITEM_BD"/>
                </r:field>
                <r:field fieldName="amount" label="金额" width="150px">
                </r:field>
                <r:field fieldName="charge_desc" label="备注" width="150px">
                    <h:text />
                </r:field>
                <r:field fieldName="last_update_date" label="时间" width="150px">
                    <w:date format="yyyy-MM-dd"/>
                </r:field>
                </r:datacell>
                </div>
              </div>
       </div>
       <div class="foot_button">
          <input onclick="javascript:window.close();" type="button" class="foot_icon_1" value="关闭"/>
        </div>
       
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

