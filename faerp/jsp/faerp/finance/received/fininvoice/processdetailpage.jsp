<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.received.fininvoice.fininvoice_resource" prefix="rayoo.finance.received.fininvoice.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='processdetail'/></title>
<script language="javascript">

</script>
</head>
<body>
<form name="datacell_formid" id="datacell_formid" method="post"> 
<div id="right">
         <div  id="div1" style="margin:5px 0px 0px 10px;">
                            <r:datacell 
                            queryAction="/FAERP/SalcontractAction.do?cmd=getApprovalDetails&processinstanceid=${requestScope.processinstanceid}"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="99%" height="300px" 
                            xpath="GapwfWorkItem" readonly="true">
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="activityname" messagekey="activityname" width="130px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="performername" messagekey="performername" width="130px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="statereason" messagekey="statereason" width="300px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="createddate" messagekey="createddate" width="160px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                          <r:field fieldName="completeddate" messagekey="completeddate" width="160px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                         
                          <r:field fieldName="state" messagekey="state" width="100px">
                            <h:text/>
                          </r:field>
                        </r:datacell>
         </div>


  </div>

</form>
</body>
</fmt:bundle>
</html>
