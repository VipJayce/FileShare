<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.finance.receivable.finincoming.finincoming_resource" prefix="rayoo.finance.receivable.finincoming.">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='title_update'/></title>
	<script language="javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.7.2.min.js"></script>
	<script language="javascript">
	    var venusbase = "<%=request.getContextPath()%>";
    </script>
	</head>
	<body>

<form name="form" method="post">
<div id="right" style="height: 150px;">
<div class="ringht_x" style="height: 150px;">
	<div id="ccChild1" class="box_xinzeng" style="height: 150px;">
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1"><fmt:message key='inc_code'/></td>
			<td class="td_2 ">
			    <input type="text" class="text_field" name="inc_code" readonly="readonly" value="${bean.inc_code }" />
		    </td>
			<td class="td_1"><fmt:message key='inc_date'/></td>
			<td class="td_2">
			    <w:date name="inc_date" id="inc_date" property="bean/inc_date" format="yyyy-MM-dd"/>
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='inc_amout'/></td>
			<td class="td_2"><input type="text" class="text_field" name="inc_amout" id="inc_amout" value="${bean.inc_amout }" /></td>
			<td class="td_1"><fmt:message key='inc_bank'/></td>
			<td class="td_2 ">
                <d:select dictTypeId="BANK" name="inc_bank" value="${bean.inc_bank }"></d:select>
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='inc_cust_name'/></td>
			<td class="td_2 "><input type="text" class="text_field" name="inc_cust_name" id="inc_cust_name" value="${bean.inc_cust_name }"/>
			</td>
			<td class="td_2"></td>
			<td class="td_2"></td>
		</tr>
	</table>
	<div class="mx_button">
	    <input type="button" class="icon_2" value="<fmt:message key='button_update'/>" id="submodify"/>
	</div>
</div>
</div>
	<input type="hidden" name="id" value="${bean.id }">
	</form>
</body>
</html>

<script language="javascript">
$(document).ready(function() {
    _$("#submodify").bind('click', function(){
        var inc_date = _$("#inc_date_input").val();
        var inc_cust_name = _$("#inc_cust_name").val();
        var inc_amout = _$("#inc_amout").val();
        
        if (!inc_date) {
            alert("<fmt:message key='alert_inc_date_isnull'/>");
            return false;
        }
        if (!inc_amout) {
            alert("<fmt:message key='alert_inc_amout_notnull'/>");
            return false;
        }
        if (!inc_cust_name) {
            alert("<fmt:message key='alert_inc_cust_name_notnull'/>");
            return false;
        }
        
        $.ajax({
            type : "post",
            url : venusbase + "/FININCOMINGAction.do?cmd=updateById",
            data : $("form").serialize(),
            dataType : "html",
            success : function(data) {
                if (data && data.length < 4000) {
                    if (data == "1") {
                        alert("<fmt:message key='alert_update_success'/>");
                        window.close();
                    } else {
                        alert(data);
                    }
                }
            }
        });
    });
});
</script>
</fmt:bundle>
