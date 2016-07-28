<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="java.util.*"%>
<%@ page import="venus.pub.util.VoHelper" %>

<title>查询模板</title>

</head>
<body>
<script language="javascript">
	writeTableTop('核对订单信息','<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/BookStoreDemo.do?cmd=submitOrder">
<div id="ccChild0"> 
<table class="table_div_content">
	<tr> 
		<td align="right" width="20%" nowrap><font color="red">*</font>收货人</td>
		<td align="left">
			<input type="hidden" name="accountId" value="<layout:write name='order' property='accountId'/>">
			<input name="name" type="text" value="<layout:write name='order' property='name'/>" class="text_field" inputName="收货人" validate="notNull" >
		</td>
	</tr>
	<tr>
		<td align="right"><font color="red">*</font>地址</td>
		<td align="left">
			<input name="address" type="text" class="text_field" inputName="地址" validate="notNull" value="<layout:write name='order' property='address'/>">			
		</td>
	</tr>
	<tr>
		<td align="right"><font color="red">*</font>联系电话</td>
		<td align="left">
			<input name="tel" type="text" class="text_field" inputName="联系电话" validate="notNull;isNumeric" value="<layout:write name='order' property='tel'/>">			
		</td>
	</tr>
	
	<tr>
		<td align="right"><font color="red">*</font>邮编</td>
		<td align="left">
			<input name="postcode" type="text" class="text_field" inputName="邮编" validate="notNull" value="<layout:write name='order' property='postcode'/>">
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td>
		<layout:collection name="order" property="items" id="item"  styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%"  title="序" style="text-align:center;">
				<venus:sequence/>
				<input type="hidden" name="checkbox_template" />
			</layout:collectionItem>
			<layout:collectionItem width="25%" title="书名" property="book.bookName"  style="text-align:center;"/>
			<layout:collectionItem width="15%" title="作者" property="book.author"  style="text-align:center;"/>
			<layout:collectionItem width="15%" title="定价" property="book.price"  style="text-align:center;"/>
			<layout:collectionItem width="10%" title="数量" property="quantity"  style="text-align:center;" />
			<layout:collectionItem width="15%" title="总价"  property="totalPrice"  style="text-align:center;"/>
			<logic:notEmpty name="accountInSession">
					<layout:collectionItem width="15%" title="会员价"  property="vipPrice"  style="text-align:center;color:red"/>
			</logic:notEmpty>
		</layout:collection>
		</td>
	</tr>
	<tr>	<td>&nbsp;</td></tr>
</table>
</div>
<div id="ccChild2"> 
<table class="table_div_content">
	<tr> 
		<td align="right" width="20%" nowrap>&nbsp;</td>
		<td align="right" width="60%">
			您需要为订单支付￥<font color="red"><layout:write name="order" property="money"/></font>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center" colspan="3">
			<input  type="button" class="button_ellipse"  value="提交订单" onclick="javascript:form.submit()">	
			<input  type="button" class="button_ellipse"  value="返回" onclick="javascript:history.go(-1)">		
		</td>
	</tr>
	<tr><td>&nbsp;<td></tr>
	</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
