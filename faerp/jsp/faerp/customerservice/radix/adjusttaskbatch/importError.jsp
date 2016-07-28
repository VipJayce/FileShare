<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.customerservice.radix.adjusttaskbatch.adjusttaskbatch_resource" prefix="rayoo.customerservice.radix.adjusttaskbatch.">
<head>
<%
String id = request.getParameter("id"); 
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="look_imp_error_date"/></title>
<script language="javascript">

    function export_onClick(){
        var id = document.getElementById('ids').value;
        form.action="<%=request.getContextPath()%>/AdjustTaskBatchAction.do?cmd=exportExeclError&id="+id;
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="backFlag" id="backFlag" value="false">
<input type="hidden" id="ids" name="ids" value="<%=id %>"/>
<div id="right">

<div class="ringht_s">                           
<div id="ccParent1" class="button"> 
 <div class="button_right">
    <ul>
        <li class="e"><a href="#" onclick="javascript:export_onClick();"><fmt:message key="export"/></a></li>
    </ul>
</div>
<div class="clear"></div>           
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/AdjustTaskBatchAction.do?cmd=importError"
        width="98%"
        height="318px"
        xpath="AdjustErrorVo"
        submitXpath="AdjustErrorVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field width="250" fieldName="adjust_task_name" messagekey="imp_file_adjust_task" >
      </r:field>
      <r:field fieldName="employee_code" messagekey="gy_emp_code" >
      </r:field>
      <r:field fieldName="employee_name" messagekey="gy_emp_name" >
      </r:field>
      <r:field width="350" fieldName="error_type_bd" messagekey="imp_error_result" allowModify="false">
           <d:select dictTypeId="ERROR_TYPE_BD"/>
      </r:field>
     
    </r:datacell>
</div> 

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
