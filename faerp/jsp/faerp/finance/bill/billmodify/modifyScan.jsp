<%@page import="net.sf.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>


<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>预览修改后各项总额</title>
	
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
	<% JSONObject json =  JSONObject.fromObject(request.getAttribute("result"));
		String vat_total_old = json.getString("vat_total_old");
		String vat_total_new = json.getString("vat_total_new");
		String add_total_old = json.getString("add_total_old");
		String add_total_new = json.getString("add_total_new");
		String weicha_old = json.getString("weicha_old");
		String weicha_new = json.getString("weicha_new");
		String notax_total_old = json.getString("notax_total_old");
		String notax_total_new = json.getString("notax_total_new");
		String total_old = json.getString("total_old");
		String total_new = json.getString("total_new");
	%>
	<div id="ccChild0" class="box_3" style="margin-top:50px"> 
		<table width="50%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" align="center">
			<tr>
				<td class="td_2" width="30%" align="center" style="background-color:#f1f7f9">&nbsp;</td>
				<td class="td_2" width="35%" align="center">修改前</td>
				<td class="td_2" width="35%" align="center" style="background-color:#f1f7f9">修改后</td>
			</tr>
			<tr>
				<td class="td_2" width="30%" align="center" style="background-color:#f1f7f9">增值税总计</td>
				<td class="td_2" width="35%" align="right"><%=vat_total_old %></td>
				<td class="td_2" width="35%" align="right" style="background-color:#f1f7f9"><%=vat_total_new %></td>
			</tr>
			<tr>
				<td class="td_2" width="30%" align="center" style="background-color:#f1f7f9">附加税总计</td>
				<td class="td_2" width="35%" align="right"><%=add_total_old %></td>
				<td class="td_2" width="35%" align="right" style="background-color:#f1f7f9"><%=add_total_new %></td>
			</tr>
			<tr>
				<td class="td_2" width="30%" align="center" style="background-color:#f1f7f9">尾差</td>
				<td class="td_2" width="35%" align="right"><%=weicha_old %></td>
				<td class="td_2" width="35%" align="right" style="background-color:#f1f7f9"><%=weicha_new %></td>
			</tr>
			<tr>
				<td class="td_2" width="30%" align="center" style="background-color:#f1f7f9">账单税前总计</td>
				<td class="td_2" width="35%" align="right"><%=notax_total_old %></td>
				<td class="td_2" width="35%" align="right" style="background-color:#f1f7f9"><%=notax_total_new %></td>
			</tr>
			<tr>
				<td class="td_2" width="30%" align="center" style="background-color:#f1f7f9">总计（含税）</td>
				<td class="td_2" width="35%" align="right"><%=total_old %></td>
				<td class="td_2" width="35%" align="right" style="background-color:#f1f7f9"><%=total_new %></td>
			</tr>
		</table>
	</div>
	<div class="foot_button" style="margin-top:50px">
       <input type="button" onclick="javascript:window.close();" value="关闭窗口" class="foot_icon_1">
    </div>  
</body>
</html>
