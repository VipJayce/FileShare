<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.customerservice.radix.adjusthandle.adjusthandle_resource" prefix="rayoo.customerservice.radix.adjusthandle.">
<head>
<%
String id = request.getParameter("id"); 
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="adjust_info_look"/></title>
<script language="javascript">
    
    function export_onClick(){
        var id = document.getElementById('ids').value;
         form.action="<%=request.getContextPath()%>/AdjusthandleAction.do?cmd=exportTempExeclAdjust&id="+id;
         form.submit();
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryDetailAdjust">
<input type="hidden" name="backFlag" id="backFlag" value="false">
<input type="hidden" id="ids" name="ids" value="<%=id %>"/>
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="adjust_info_look"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">                           
<div id="ccParent1" class="button"> 
 <div class="button_right">
    <ul>
        <li class="e"><a onClick="javascript:export_onClick()"><fmt:message key="export"/></a></li>
    </ul>
</div>
<div class="clear"></div>           
</div>
 
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/AdjusthandleAction.do?cmd=queryTempDetailAdjust"
        width="98%"
        height="318px"
        xpath="DetailAdjustVO"
        submitXpath="DetailAdjustVO"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>   
             
      <r:field fieldName="batch_code"  messagekey="imp_code" >
      </r:field>
      <r:field fieldName="adjust_task_id" messagekey="adjust_task_id"  >
      </r:field>
      <r:field fieldName="adjust_task_name" messagekey="adjust_task_name" >
      </r:field>
      <r:field fieldName="employee_code" messagekey="emp_code" >
      </r:field>
      <r:field fieldName="employee_name" messagekey="gy_emp_name" >
      </r:field>
      <r:field fieldName="id_card" messagekey="id_card" >
      </r:field>
      <r:field fieldName="id_card18" messagekey="id_card18" >
      </r:field>
      <r:field fieldName="company_code" messagekey="cust_code" >
      </r:field>
      <r:field fieldName="company_chinese_name" messagekey="cust_name" >
      </r:field>
      <r:field fieldName="ntype" messagekey="ntype" width="260px">
      </r:field>

    </r:datacell>
</div> 


</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
