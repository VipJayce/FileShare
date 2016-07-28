<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.*" %>
<%  //取出本条记录
    Map labor = request.getAttribute("labor")==null?new HashMap():(Map)request.getAttribute("labor");
%>
<%@page import="rayoo.customerservice.laborcontract.vo.LaborcontractVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.detailLabor_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/HirefireAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
  
   <div id="right">
   <div class="ringht_s">

<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
    <td class="td_1"><fmt:message key='detailLabor0000'/></td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("emp_name")==null?"":labor.get("emp_name") %>"/></td>
    <td class="td_1"><fmt:message key='detailLabor0001'/></td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("cust_name")==null?"":labor.get("cust_name")%>"/></td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='detailLabor0002'/>（<fmt:message key='detailLabor0003'/>）</td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("salary")==null?"":labor.get("salary") %>"/></td>
    <td class="td_1"><fmt:message key='detailLabor0004'/></td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("labor_status_bd")==null?"":labor.get("labor_status_bd") %>"/></td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='detailLabor0005'/></td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("subscribe_date")==null?"":labor.get("subscribe_date") %>"/></td>
    <!--<td class="td_1"><fmt:message key='detailLabor0006'/></td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("is_work_out")==null?"":labor.get("is_work_out") %>"/></td>
  --><td class="td_1"><fmt:message key='detailLabor0007'/></td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("working_bd")==null?"":labor.get("working_bd") %>"/></td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='detailLabor0008'/>（<fmt:message key='detailLabor0003'/>）</td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("start_date")==null?"":labor.get("start_date") %>"/></td>
  <td class="td_1"><fmt:message key='detailLabor0010'/>（<fmt:message key='detailLabor0003'/>）</td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("end_date")==null?"":labor.get("end_date") %>"/></td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='detailLabor0008'/>（<fmt:message key='detailLabor0013'/>）</td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("try_start_date")==null?"":labor.get("try_start_date") %>"/></td>
     <td class="td_1"><fmt:message key='detailLabor0010'/>（<fmt:message key='detailLabor0013'/>）</td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("try_end_date")==null?"":labor.get("try_end_date") %>"/></td>  
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='detailLabor0016'/></td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("apply_on_post_date")==null?"":labor.get("apply_on_post_date") %>"/></td>
    <td class="td_1"><fmt:message key='detailLabor0017'/></td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("apply_off_post_date")==null?"":labor.get("apply_off_post_date") %>"/></td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='detailLabor0002'/>（<fmt:message key='detailLabor0013'/>）</td>
    <td class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("try_salary")==null?"":labor.get("try_salary") %>"/></td>
    <td class="td_1"><fmt:message key='detailLabor0020'/></td>
    <td colspan="3" class="td_2"><input type="text" class="text_field" disabled="disabled" value="<%=labor.get("remark")==null?"":labor.get("remark") %>"/></td>
  </tr>
    </table>
</div>


    
<div class="foot_button">

</div>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>
