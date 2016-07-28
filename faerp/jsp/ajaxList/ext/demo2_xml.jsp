<?xml version ="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ page import="gap.ajax.jquery.table.util.Constant" %>
<rows total="<%=request.getAttribute("recordsCount")%>">
  	<logic:iterate id="user" name="users" type="gap.ajax.vo.UserInfo">
		    <row> 
		      <id><bean:write name="user"  property="id"/></id>
		      <name> <bean:write name="user"  property="name"/></name>
		      <sex><bean:define id="sex" name="user" property="sex"/><%=Constant.SEX.get(sex)%></sex>
		      <city><bean:define id="city" name="user" property="city"/><%=Constant.CITY.get(city)%></city>
		      <cardType><bean:define id="cardType" name="user" property="cardType"/> <%=Constant.CARDTYPE.get(cardType)%></cardType>
		      <cardNo> <bean:write name="user"  property="cardNo"/></cardNo>
		      <note>  <![CDATA[<bean:write name="user"  property="note"/>]]>  </note>
		    </row>
	</logic:iterate>
</rows>