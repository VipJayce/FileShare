<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page errorPage="/jsp/include/errorpage.jsp" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld" prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-layout.tld" prefix="layout" %>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus" %>
<%@ page import="java.util.*"%>
<%@ page import="venus.pub.util.VoHelper" %>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
response.setHeader("Pragma","no-cache"); //HTTP 1.0 
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="/jsp/dd/include/jquery.jsp" %>
<script type="text/javascript">
	function deleteItem(bookId){
		window.location="<%=request.getContextPath()%>/BookStoreDemo.do?cmd=removeItemFromCart&bookId="+bookId;
	}
	function updateCart(bookId,qurantity){
		window.location='<%=request.getContextPath()%>/BookStoreDemo.do?cmd=updateCart&'+bookId+'='+qurantity;
	}
	
	function return_onClick()
	{
		window.location="<%=request.getContextPath()%>/BookStoreDemo.do?cmd=queryAllBooks";
	}
	
</script>
<style>
	.cartDetail{
		display:none;
		z-index:100;
		position:absolute;
		top:5%;
		left:5%;
		width:80%;
	}
</style>
<div style="overflow:auto;height:150px;">
<table class="table_div_content">
	<tr>
		<td>
		<layout:collection name="cartInSession" property="items" id="item"  styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%"  title="序" style="text-align:center;">
				<venus:sequence/>
				<input type="hidden" name="checkbox_template" />
			</layout:collectionItem>
			<layout:collectionItem width="20%" title="书名" property="book.bookName"  style="text-align:center;"/>
			<layout:collectionItem width="15%" title="作者" property="book.author"  style="text-align:center;"/>
			<layout:collectionItem width="10%" title="定价" property="book.price"  style="text-align:center;"/>
			<layout:collectionItem width="10%" title="数量" property="quantity"  style="text-align:center;">
					<bean:define id="bookQuantity" name="item" property="quantity"/>
					<bean:define id="bookId" name="item" property="book.id"/>
					<input type="text" name="<%=bookId%>" value="<%=bookQuantity%>" onchange="updateCart(this.name,this.value)" style="text-align:center;width:40px" class="text_field" size="4"/>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title="总价"  property="totalPrice"  style="text-align:center;"/>
			<logic:notEmpty name="accountInSession">
					<layout:collectionItem width="10%" title="会员价"  property="vipPrice"  style="text-align:center;color:red"/>
			</logic:notEmpty>
			<layout:collectionItem width="15%" title="操作"  url=""  style="text-align:center;">
				<bean:define id="bookId" name="item" property="book.id"/>
				<a href="#" onclick="deleteItem('<%=bookId%>')">删除</a>
			</layout:collectionItem>
		</layout:collection>
		</td>
		<div style="float:right" class="button_ellipse" onClick="return_onClick();"><img src="<venus:base/>/images/icon/return.gif" class="div_control_image">返回</div>
	</tr>
	<tr>	<td>&nbsp;</td></tr>
</table>
<div>