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
<!-- 
    add by Mahone:
    注意，div_1和div_3中的参与计算的小额，汇差，核销等textbox的ID,NAME都一样
    这样做是为了只用一套js，后端java也只取一个name
 -->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>认领</title>
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
        
        function cancel_onClick(){  //取消后返回列表页面
		    form.action=venusbase+"/FinclaimAction.do?cmd=leftbar2list";
		    form.submit();
		}
    </script>
</head>
<body>
<form name="form" id="datacell_formid" method="post">
<div id="right">
    <div class="ringht_s">
     <div class="social_tab">
        <div class="box_3" style="margin-top:10px;">
           <table  width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1">到款编号<input type="hidden" value="${bean.id }" name="incoming_id"/>
               <input type="hidden" value="${requestScope.balanceAmount}" name="balanceAmount" id="balanceAmount"/>
               </td>
               <td class="td_2">${bean.inc_code }</td>
               <td class="td_1">到款日期</td>
               <td class="td_2"><fmt:formatDate value="${bean.inc_date }" pattern="yyyy-MM-dd"/></td>
             </tr>
             <tr>
               <td class="td_1">到款金额</td>
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
               <td class="td_2"><fmt:formatDate value="${bean.upload_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
               <td class="td_1">上传人</td>
               <td class="td_2">
                    <bean:define id="create_user" name="bean" property="upload_user_id"/>
                    <%=OrgHelper.getPartyVoByID(create_user.toString()) == null ? "" : OrgHelper.getPartyVoByID(create_user.toString()).getName()%>
                </td>
             </tr>
<tr>
               <td class="td_1">认领时间</td>
               <td class="td_2"><fmt:formatDate value="${finclaimVo.create_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
               <td class="td_1">认领人</td>
               <td class="td_2">
               <input type="hidden" value="${finclaimVo.id }" name="claim_id"/>
               <bean:define id="claim_user_id" name="finclaimVo" property="claim_user_id"/>
                    <%=OrgHelper.getPartyVoByID(claim_user_id.toString()) == null ? "" : OrgHelper.getPartyVoByID(claim_user_id.toString()).getName()%>
               </td>
             </tr>
             <tr>
               <td class="td_1">认领金额</td>
               <td class="td_2"><fmt:formatNumber value="${finclaimVo.claim_amount}" pattern="###,###,###,###.##"  minFractionDigits="2"/></td>
               <td class="td_1">认领备注</td>
               <td class="td_2">${finclaimVo.claim_desc }</td>
             </tr>
             <tr>
               <td class="td_1">认领状态</td>
               <td class="td_2">
                    <bean:define id="claim_status_bd" name="bean" property="claim_status_bd"/>
                    <%=BaseDataHelper.getNameByCode("CLAIM_STATUS_BD",String.valueOf(claim_status_bd))%>
               </td>
               <td class="td_1">认领费用账期</td>
               <td class="td_2" id="td_unc">
                <label id="un_claim_amout">${finclaimVo.claim_year_month}</label>
                </td>
             </tr>
             <tr>
               <td class="td_1">到款客户名称</td>
               <td class="td_2">${bean.inc_cust_name }</td>
               <td class="td_1"><span class="style_required_red">*</span>发票号</td>
               <td class="td_2"><input type="text" id="invoice_code" name="invoice_code" value="" class="text_field"></td>
             </tr>
             <tr>
               <td class="td_1">认领客户名称</td>
               <td class="td_2">${finclaimVo.last_claim_cust_name}</td><input type="hidden" id="cust_name" name="cust_name"  value="${finclaimVo.last_claim_cust_name}" />
               <td class="td_1"><span class="style_required_red">*</span>开票日期</td>
               <td class="td_2"><w:date format="yyyy-MM-dd" id="create_date" name="create_date"  value="${requestScope.CurrentTimestamp}" width="190px"/></td>
             </tr>
             
             <tr>
               <td class="td_1">开票金额</td>
               <td class="td_2"> <input type="text" id="invoice_amount" name="invoice_amount" value="${finclaimVo.claim_amount}"  readonly="readonly" class="text_field" maxLength="15" style="width:250px;"></td>
               <td class="td_1">发票状态</td><input type="hidden" id="type_bd" name="type_bd"  value="3" />
               <td class="td_2"><input name="type_bd1" type="radio" id="type_bd1" value="3" checked="checked" disabled="disabled">
	            实收<input type="radio" name="type_bd1"  value="2" disabled="disabled"> 预开
                </td>
             </tr>
             
             <tr>
               <td class="td_1">开票备注</td>
               <td class="td_2" colspan="4"> <textarea id="inv_desc" style="width:650px; height:40px;" class="xText_d" rows="3" name="inv_desc"></textarea></td>
             </tr>

          </table>
         </div>
     </div>
     </div>
     </div>

      <div class="foot_button">
      <input type="button" value="保存开票信息" class="foot_icon_3" onclick="subclaim();">
      <input type="button" class="foot_icon_1" value="返回"  onclick="javascript:cancel_onClick();" />
      </div>
</form>
</body>
</html>
<script language="javascript">

function cancel_onClick() {
    window.close();
}
function subclaim() {
         //invoice_code
         var invoice_code = _$("#invoice_code").val();
         var create_date = _$("#create_date_input").val();
         
         if(invoice_code==""){
                 alert("发票号不能为空！");
                  _$("#invoice_code").focus();
                  return;
          }
          
         if(create_date==""){
                 alert("开票日期不能为空！");
                  _$("#create_date_input").focus();
                 return;
          }
       
	    var param = jQuery("#datacell_formid").serialize();
		var _url = "<%=request.getContextPath()%>/FininvoiceAction.do?cmd=noBillFininvoice&_ts="+(new Date()).getTime(); 
            _$.ajax({
                type : "post",
                url : _url,
                data : param,
                dataType : "html",
                success : function(data) {
		                if(data=="1"){
		                alert("操作成功！");
		                }else{
		                alert("操作失败！");
		                }
		                window.close();
                }
            });

	}
 
function isDateString(sDate) {
    if (sDate.length > 6 || sDate.length < 5) {
        return false;
    }
    var mp = /\d{4}\d{1,2}/;
    var matchArray = sDate.match(mp);
    if (matchArray == null)
        return false;
    var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    var iaDate = new Array(3);
    var year, month, day;
    year = sDate.substring(0, 4);
    year = parseFloat(year)
    month = sDate.substring(4, 6);
    month = parseFloat(month);
    if (year < 1900 || year > 2100)
        return false;
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
        iaMonthDays[1] = 29;
    if (month < 1 || month > 12)
        return false;
    if (day < 1 || day > iaMonthDays[month - 1])
        return false;
    return true;
}


if(${msg != null && msg != ""}) {
    alert("${msg }");
}

</script>