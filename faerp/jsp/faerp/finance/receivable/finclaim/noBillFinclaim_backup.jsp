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
 <fmt:bundle basename="rayoo.finance.receivable.finclaim.finclaim_resource" prefix="rayoo.finance.receivable.finclaim.">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key="button_rl"/></title>
</head>
<body>
<form name="form" method="post" action="<%=request.getContextPath()%>/FinclaimAction.do">
<input type="hidden" id="cmd" name="cmd" value = "showClaimingPageByIncomingID">
<input type="hidden" value="${requestScope.balanceflag}" name="balanceflag" id="balanceflag">
<div id="right">
    <div class="ringht_s">
     <div class="social_tab">
         <div style="margin-top:10px;" class="xz_title"><fmt:message key="finclaim_info"/></div>
        <div class="box_3">
           <table  width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1"><fmt:message key="inc_code"/><input type="hidden" value="${bean.id }" name="incoming_id"/>
               <input type="hidden" value="${requestScope.balanceAmount}" name="balanceAmount" id="balanceAmount"/>
               </td>
               <td class="td_2">${bean.inc_code }</td>
               <td class="td_1"><fmt:message key="inc_date"/></td>
               <td class="td_2"><fmt:formatDate value="${bean.inc_date }" pattern="yyyy-MM-dd"/></td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key="inc_amout"/></td>
               <td class="td_2"><label id="inc_amout"><fmt:formatNumber value="${bean.inc_amout}" pattern="###,###,###,###.##"  minFractionDigits="2"/></label>
                  <input type="hidden" id="inc_amout_h" name="inc_amout_h" value="${bean.inc_amout}"/>
               </td>
               <td class="td_1"><fmt:message key="inc_bank_"/></td>
               <td class="td_2">
                    <bean:define id="inc_bank" name="bean" property="inc_bank"/>
                    <%=BaseDataHelper.getNameByCode("BANK",String.valueOf(inc_bank))%>
               </td>
             </tr>
            <tr>
               <td class="td_1"><fmt:message key="upload_date"/></td>
               <td class="td_2"><fmt:formatDate value="${bean.upload_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
               <td class="td_1"><fmt:message key="upload_user"/></td>
               <td class="td_2">
                    <bean:define id="create_user" name="bean" property="upload_user_id"/>
                    <%=OrgHelper.getPartyVoByID(create_user.toString()) == null ? "" : OrgHelper.getPartyVoByID(create_user.toString()).getName()%>
                </td>
             </tr>
<tr>
               <td class="td_1"><fmt:message key="last_claim_date_"/></td>
               <td class="td_2"><fmt:formatDate value="${bean.last_claim_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
               <td class="td_1"><fmt:message key="claim_user_name"/></td>
               <td class="td_2">${bean.last_claim_user_name }</td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key="last_claim_amount"/></td>
               <td class="td_2"><fmt:formatNumber value="${bean.last_claim_amount}" pattern="###,###,###,###.##"  minFractionDigits="2"/></td>
               <td class="td_1"><fmt:message key="last_claim_desc"/></td>
               <td class="td_2">${bean.last_claim_desc }</td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key="claim_status_bd"/></td>
               <td class="td_2">
                    <bean:define id="claim_status_bd" name="bean" property="claim_status_bd"/>
                    <%=BaseDataHelper.getNameByCode("CLAIM_STATUS_BD",String.valueOf(claim_status_bd))%>
               </td>
               <td class="td_1"><fmt:message key="un_claim_amout"/></td>
               <td class="td_2" id="td_unc">
                <label id="un_claim_amout"><fmt:formatNumber value="${bean.un_claim_amout}" pattern="###,###,###,###.##"  minFractionDigits="2"/></label>
                <input type="hidden" id="un_claim_amout_h" name="un_claim_amout_h" value="${bean.un_claim_amout}">
                </td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key="inc_cust_name"/></td>
               <td class="td_2">${bean.inc_cust_name }</td>
               <td class="td_1"><fmt:message key="last_claim_year_month_"/></td>
               <td class="td_2"> <input type="text" id="bill_year_month" class="text_field" name="bill_year_month"  maxLength="6" style="width:150px;">（格式如：201301）</td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key="last_claim_cust_name"/></td>
               <td class="td_2"><input type="text" name="cust_name" id="cust_name" value="" class="text_field"  maxLength="70" style="width:250px;"> </td>
               <td class="td_1"><fmt:message key="claim_desc"/></td>
               <td class="td_2"><textarea id="claim_desc" style="width:250px; height:40px;" class="xText_d" rows="3" name="claim_desc"></textarea></td>
             </tr>
             
             <tr>
               <td class="td_1"><fmt:message key="v_n_sumv_h"/></td>
               <td class="td_2"> <input type="text" id="txt_ver" name="txt_ver" value="${bean.un_claim_amout}" onkeyup="onKey_Up(this.value)" class="text_field" maxLength="15" style="width:250px;"></td>
               <td class="td_1"><fmt:message key="table1_5"/></td>
               <td class="td_2"><input type="text" id="txt_difference" readonly="readonly" name="txt_difference" value="0" class="text_field" style="width:250px;"></td>
             </tr>

          </table>
         </div>
     </div>
     </div>
     </div>

      <div class="foot_button">
      <input type="button" value="<fmt:message key="button_subclaim"/>" class="foot_icon_2" onclick="subclaim();" id="subclaim_button" >
      <input type="button" class="foot_icon_1" value="<fmt:message key="button_go_back"/>"  onclick="javascript:cancel_onClick();" />
      </div>
</form>
</body>
</html>
<script language="javascript">


String.prototype.trim   =   function()
{
         //   用正则表达式将前后空格
         //   用空字符串替代。
         return   this.replace(/(^\s*)|(\s*$)/g,   "");
}

function onKey_Up(v_str) {
            var v_un_claim_amout=${bean.un_claim_amout};
            
            if (!isNaN(v_str)) {
                if(v_str>v_un_claim_amout){
                       alert("<fmt:message key='alert_1'/>["+v_un_claim_amout+"]!");
                       _$("#txt_ver").val(v_un_claim_amout);
                       _$("#txt_difference").val("0");
                       return;
                }
            } else if (v_str == '-') {
                //负数，可以通过
                return;
            } else {
                alert("<fmt:message key='alert_2'/>");
                _$("#txt_ver").val(v_un_claim_amout);
                _$("#txt_difference").val("0");
                return ;
            }
                
		    
		    var  txt_difference=v_un_claim_amout-v_str;
		    //alert(txt_difference.toFixed(4));
		    _$("#txt_difference").val(txt_difference.toFixed(4));
	    
}




function cancel_onClick() {
    window.close();
}
function subclaim() {

	    //验证核销的textbox是否正确
	    var bill_year_month=_$("#bill_year_month").val();
	    var cust_name=_$("#cust_name").val();
	    var claim_desc=_$("#claim_desc").val();
	    var v_txt_ver=_$("#txt_ver").val();
	    var v_un_claim_amout=${bean.un_claim_amout};
	    /*
	    if(bill_year_month==""){
	            alert("请输入认领费用账期！");
	            _$("#bill_year_month").focus();
	            return;
	    }
	    */
	    
	    if(parseFloat(v_txt_ver)<=0){
                        alert("<fmt:message key='alert_3'/>");
                        _$("#txt_ver").val(v_un_claim_amout);
                        _$("#txt_difference").val("0");
                        return;
         }
	    
	     if(cust_name.trim() == ""){
                alert("<fmt:message key='alert_4'/>");
                _$("#cust_name").val("");
                _$("#cust_name").focus();
                return;
         }
         
	    if(v_txt_ver==""){
                alert("<fmt:message key='alert_5'/>");
                _$("#txt_ver").val(v_un_claim_amout);
                _$("#txt_ver").focus();
                return;
        }
        
	    if(bill_year_month!=""){
		        if (!isDateString(bill_year_month)) {
				        alert("<fmt:message key='alert_6'/>");
				        _$("#bill_year_month").val("");
				        _$("#bill_year_month").focus();
				        return;
			    }
	    }
	    //yangxu 
	    _jQuery("#subclaim_button").attr('disabled','disabled');
		var _url = "<%=request.getContextPath()%>/FinclaimAction.do?cmd=noBillClaim&_ts="+(new Date()).getTime(); 
            _$.ajax({
                type : "post",
                url : _url,
                data : jQuery('form').serialize(),
                dataType : "html",
                success : function(data) {
		                alert(data);
		                _jQuery("#subclaim_button").removeAttr('disabled');
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
</fmt:bundle>