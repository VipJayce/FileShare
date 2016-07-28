<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@page import="java.util.List"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>
<% 
	//String info = request.getParameter("info");
	List<String> infos = (List<String>)request.getAttribute("lists");
	//String[] infos = info.split(",");
%>
<body style="overflow: hidden">
<form name="form" method="post" id="form">
<div class="box_2" style="margin-top: 10px; overflow: auto; height: 380px;">
<center><span style="color: black; font-size: 20px;"><b>生成凭证信息</b></span></center>
<%for(int i = 0;i<infos.size(); i++){ %>
<span style="color: black;"><%=infos.get(i) %></span><br>
<%} %>
  <div class="xz_button">
 <input name="button1" type="button" class="icon_2" value="关闭" onclick="window.close();"/>
</div>
</div>
</form>
</body>
</html>
</fmt:bundle>