<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>
<html>
<%
String login_user_id= RmJspHelper.getParty_idFromRequest(request);
//String login_user_name="";
//LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
//if(null!=loginVo){
    //login_user_name=loginVo.getName();
  //}
%>
<fmt:bundle basename="rayoo.salary.reporttax.reporttax_resource" prefix="rayoo.salary.reporttax.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_reporttax'/></title>

<script language="javascript">

    function exportEXCEL_onClick(){
        var start_date = document.getElementById("start_date").value;
        var end_date = document.getElementById("end_date").value;
        var raq = "TAX_DIFFERENCE.raq";
        
        var url="";
        
        if(start_date==null || start_date==""){
            alert("<fmt:message key='alert_start_date'/>");
            return;
        }
        if(end_date==null || end_date==""){
            alert("<fmt:message key='alert_end_date'/>");
            return;
        }
        if(start_date > end_date){
            var tmp = start_date;
            start_date = end_date;
            end_date = tmp;
        }

        url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showReportTaxDifference.jsp?raq="+raq+"&start_yearmonth="+start_date+"&end_yearmonth="+end_date;
        window.open(url,"<fmt:message key='button_taxdifference'/>","height=700px,width=1024px,top =200,left=200,help=no,menubar=no,resizable=yes,scrollbars=yes,location=no,status=no");
    }
</script>
</head>
<body>

<h:form name="form" method="post" id="datacell_formid" checkType="blur">
<div id="right">
<script language="javascript">
        writeTableTopFesco("<fmt:message key='button_taxdifference'/>");  //显示本页的页眉
</script>
<div class="ringht_s">

    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title"><fmt:message key='tax_report'/></div>
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td class="td_1"><fmt:message key='start_date'/></td>
                    <td class="td_2">
                      <input type="text" class="text_field" id="start_date" name="start_date" inputName="报税基本年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                    </td>
                    <td class="td_1"><fmt:message key='end_date'/></td>
                    <td class="td_2">
                      <input type="text" class="text_field" id="end_date" name="start_date" inputName="报税对比年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                    </td>
                </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();"><fmt:message key='button_export_report'/></a>
            </div>
            <!--表格1 end--></div>
            </td>
        </tr>
    </table>
    </h:form>
</fmt:bundle>
</body>
</html>
