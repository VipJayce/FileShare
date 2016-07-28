<?xml version ="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ page import="gap.ajax.jquery.table.util.Constant" %>
<%
	int i=0;
	PageVo pageVo = (PageVo)request.getAttribute("VENUS_PAGEVO_KEY");
	i = (pageVo.getCurrentPage()-1)*pageVo.getPageSize()+1;
%>
<%@page import="venus.frames.mainframe.web.tags.PageVo"%>
<rows>
  <page><bean:write name="VENUS_PAGEVO_KEY" property="currentPage"/> </page>
  <total>49</total>
  	<logic:iterate id="user" name="users" type="gap.ajax.vo.UserInfo">
		    <row id ='<bean:write name="user"  property="id"/>'> 
			  <cell>  <![CDATA[<input type='checkbox' name='checkbox_grid'onclick='javascript:checkbox_onclick(this)'/>]]></cell>
		      <cell> <%=i%><%i++;%></cell>
		      <cell> <bean:write name="user"  property="name"/></cell>
		      <cell><bean:define id="sex" name="user" property="sex"/><%=Constant.SEX.get(sex)%></cell>
		      <cell><bean:define id="city" name="user" property="city"/><%=Constant.CITY.get(city)%></cell>
		      <cell><bean:define id="cardType" name="user" property="cardType"/> <%=Constant.CARDTYPE.get(cardType)%></cell>
		      <cell> <bean:write name="user"  property="cardNo"/></cell>
		      <cell>  <![CDATA[<bean:write name="user"  property="note"/>]]>  </cell>
		    </row>
	</logic:iterate>
</rows>