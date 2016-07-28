<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.credentials.vo.CredentialsVo" %>
<%@ page import="rayoo.customerservice.credentials.util.ICredentialsConstants" %>
<%  //取出List
String cardno="";
if(request.getAttribute("cardno")!=null){
    cardno=request.getAttribute("cardno").toString();
}
%>
<html>
<fmt:bundle basename="rayoo.customerservice.credentials.credentials_resource" prefix="rayoo.customerservice.credentials.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="history_credentials"/></title>
<script language="javascript">
  

</script>
</head>
<body>

<!--  <form name="form" method="post" action="<%=request.getContextPath()%>/CredentialsAction.do">-->
<form name="form" method="post"  id="datacell_formid" action="<%=request.getContextPath()%>/CredentialsAction.do">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 <input type="hidden" name=“cardno” id="cardno" value="<%=cardno %>">
 
<div id="right">
<div class="ringht_s">
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/CredentialsAction.do?cmd=queryHandleInfoData&cardno=${requestScope.cardno}" 
  width="98%" height="320px" xpath="CredentialsVo" paramFormId="datacell_formid">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
  <r:field fieldName="employee_name" messagekey="employee_name1"></r:field>
  <r:field fieldName="emp_card_no" messagekey="emp_card_no3"></r:field>
  <r:field fieldName="credentials_type_bd" messagekey="credentials_type_bd" allowModify="false">
    <d:select dictTypeId="CREDENTIALS_TYPE_BD"></d:select>
  </r:field>
  <r:field fieldName="cust_name" messagekey="cust_name"></r:field>
  <r:field fieldName="talent_center" messagekey="talent_center"></r:field>
  <r:field fieldName="submit_date" messagekey="submit_date" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="finish_date" messagekey="finish_date" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="validity" messagekey="validity" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="approve_date" messagekey="approve_date1" allowModify="false">
    <w:date format="YYYY-MM-DD"/>
  </r:field>
  <r:field fieldName="retinue_name" messagekey="retinue_name"></r:field>
  <r:field fieldName="retinue_card_no" messagekey="retinue_card_no"></r:field>
  <r:field fieldName="status_name" messagekey="credentials_type_state"></r:field>
  <r:field fieldName="remark" messagekey="remark"></r:field>
  </r:datacell>
</div>   
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
