<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp" %>

<fmt:bundle basename="gap.bnLog.bnLog_resource" prefix="gap.bnLog.">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>businessLog</title>
</head>
<SCRIPT LANGUAGE="javascript">
	function BnLog_onClick() {  
			form.action="<%=request.getContextPath()%>/BnLogAction.do";
			form.cmd.value="queryAll";
			form.target="body1";
			form.submit();
	}
	function BnLogMapping_onClick() {  
			form.action="<%=request.getContextPath()%>/MappingAction.do";
			form.cmd.value="queryAll";
			form.target="body1";
			form.submit();
	}
</SCRIPT>
<style type="text/css">
<!--
body {
	background-color: #004d9f;
}
-->
</style>
<body>
<form name="form" method="post" action="<%=request.getContextPath()%>/LogTypeAction.do">
<input type="hidden" name="cmd" value="">

    <table cellpadding="0" cellspacing="0" class="table_div_content_frame" height="30"  width="100%" >
      <tr>
        <td width="11" valign="bottom" align="left"><img src="<%=request.getContextPath()%>/images/templatestyle/main0_15.gif" width="11" height="11"></td>
        <td >
		<table align="left">
				<tr> 
					<td class="button_ellipse" onClick="javascript:BnLog_onClick();"><img src="<venus:base/>/images/icon/arrow.gif" class="div_control_image"><fmt:message key="business_log_Admin"/></td>
					<td class="button_ellipse" onClick="javascript:BnLogMapping_onClick();"><img src="<venus:base/>/images/icon/arrow.gif" class="div_control_image"><fmt:message key="method_mapping_admin"/></td>
				</tr>
			</table>
		</td>
        <td width="11" align="right" valign="bottom"><img src="<%=request.getContextPath()%>/images/templatestyle/main0_18.gif" width="11" height="11"></td>
      </tr>
    </table>
</form>
</body>
</html>
</fmt:bundle>