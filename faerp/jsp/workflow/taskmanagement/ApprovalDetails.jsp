<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>审批详细信息</title>
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
                          <r:field fieldName="activityname" label="任务名" width="130px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="performername" label="任务处理人" width="130px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="statereason" label="审批意见" width="300px">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="createddate" label="任务发起时间" width="160px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                          <r:field fieldName="completeddate" label="任务完成时间" width="160px">
                            <w:date format="yyyy-MM-dd HH:mm:ss"/>
                          </r:field>
                         
                          <r:field fieldName="state" label="当前状态" width="100px">
                            <h:text/>
                          </r:field>
                        </r:datacell>
         </div>


  </div>

</form>
</body>
</html>
