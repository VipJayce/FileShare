<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<html>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>

<script language="javascript">

</script>
<body onload="dwr.engine.setActiveReverseAjax(true);">
<script language="javascript">
	writeTableTop('查询列表','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			竞价拍卖
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
	<tr>
		<td>
		<TABLE id="productNotice" cellSpacing=0 cellPadding=0 border=0 height="18">
		<TBODY id="productbody">
			<TR height=18>
				<TD>拍品号</TD><TD align=right>0001</TD>
			</TR>
			<TR height=18>
				<TD>作　者</TD><TD  align=right>娄师白</TD>
			</TR>
			<TR height=18>
				<TD>名　称</TD><TD  align=right>大展鸿图</TD>
			</TR>
			<TR height=18>
				<TD>形　式</TD><TD  align=right>镜心</TD>
			</TR>
			<TR height=18>
				<TD>质　地</TD><TD  align=right>设色纸本</TD>
			</TR>
			<TR height=18>
				<TD>尺　寸</TD><TD  align=right>69X136X1</TD>
			</TR>
			<TR height=18>
				<TD>估　价</TD><TD  align=right>&nbsp;&nbsp;&nbsp;RMB: 100,000 - 150,000</TD>
			</TR>
			<TR height=18>
				<TD>尺　寸</TD><TD  align=right>69X136X1</TD>
			</TR>
		</TBODY>
		</TABLE>
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td width="270">
			我要出价 <input id="newPrice" type="text" class="text_field" onkeypress="dwr.util.onReturn(event, sendMessage)"/>
		</td>	
		<td width="60">
			<input name="button_save" type="button" class="button_ellipse" value="确定" onClick="javascript:sendMessage('newPrice','chatlog');">
		</td>
		<td></td>
	</tr>
</table>
</div>
<ul id="chatlog" style="list-style-type:none;">
</ul>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>