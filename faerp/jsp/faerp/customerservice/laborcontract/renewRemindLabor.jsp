<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.customerservice.laborcontract.vo.LaborcontractVo" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
    LaborcontractVo resultVo = (LaborcontractVo)request.getAttribute("vo");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date;"%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.laborcontract.renewRemindLabor_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
        var is_deadline = document.getElementById('is_deadline');
        if(!is_deadline.checked){
            var end_date = document.getElementById('end_date').value;
            if(end_date == null || end_date== ''){
                alert('<fmt:message key='renewRemindLabor0000'/>');
                return;
            }
        }
        if(checkAllForms()){
          form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=updateRenew";
          form.submit();
          window.close();
        }
    }

</script>
</head>
<body>

<form name="form" method="post">
<div id="right">
<div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
            <td class="td_1" ><fmt:message key='renewRemindLabor0001'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="send_start_date" name="send_start_date" format="YYYY-MM-DD" property="vo/send_start_date"/>               
            </td>
            <td class="td_1" ><fmt:message key='renewRemindLabor0002'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="send_end_date" name="send_end_date" format="YYYY-MM-DD" property="vo/send_end_date"/>               
            </td>
        </tr> 
        <tr>
            <td class="td_1" ><fmt:message key='renewRemindLabor0003'/></td>
            <td class="td_2" colspan="3">
                <input type="checkbox" name="is_deadline" id="is_deadline" value="1"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='renewRemindLabor0004'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="start_date" name="start_date" format="YYYY-MM-DD" property="vo/start_date"/>                
            </td>
            <td class="td_1" ><fmt:message key='renewRemindLabor0005'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="end_date" name="end_date" format="YYYY-MM-DD" property="vo/end_date"/>                
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='renewRemindLabor0006'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="position"  inputName="<fmt:message key='renewRemindLabor0006'/>" value="<%=resultVo.getPosition()==null?"":resultVo.getPosition() %>" maxLength="64" />
            </td>
            <td  class="td_1" ><fmt:message key='renewRemindLabor0008'/>(<fmt:message key='renewRemindLabor0009'/>)</td>
            <td  class="td_2" >
                <input type="text" class="text_field" name="salary" inputName="<fmt:message key='renewRemindLabor0010'/>" value="<%=resultVo.getSalary()==null?"":resultVo.getSalary()%>" maxLength="23" integerDigits="18" decimalDigits="4" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='renewRemindLabor0011'/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("working_bd", -1,"WORKING_BD",resultVo.getWorking_bd(),"id=working_bd",false) %>
            </td>
            <td class="td_1" ><fmt:message key='renewRemindLabor0012'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="subscribe_date" name="subscribe_date" format="YYYY-MM-DD" property="vo/subscribe_date"/>               
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='renewRemindLabor0013'/></td>
            <td colspan="3" class="td_2" >
                <textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName="<fmt:message key='renewRemindLabor0013'/>" maxLength="1000" ><%=resultVo.getRemark()==null?"":resultVo.getRemark()%></textarea>
            </td>
        </tr>
</table>


            
   
   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()" />
        </div>
</div>           
</div>
</div>
     
<input type="hidden" name="id" value="<%=resultVo.getId() %>">
<input type="hidden" name="create_date" />
<input type="hidden" name="labor_type_bd" value="2">
<input type="hidden" name="company_id" value="<%=resultVo.getCompany_id()==null?"":resultVo.getCompany_id() %>">
<input type="hidden" name="emp_post_id" value="<%=resultVo.getEmp_post_id()==null?"":resultVo.getEmp_post_id() %>">
<input type="hidden" name="emp_code" value="<%=resultVo.getEmp_code()==null?"":resultVo.getEmp_code() %>">
<input type="hidden" name="emp_name" value="<%=resultVo.getEmp_name()==null?"":resultVo.getEmp_name() %>">
<input type="hidden" name="cust_name" value="<%=resultVo.getCust_name()==null?"":resultVo.getCust_name() %>">
<input type="hidden" name="cust_code" value="<%=resultVo.getCust_code()==null?"":resultVo.getCust_code() %>">
<input type="hidden" name="cust_id" value="<%=resultVo.getCust_id()==null?"":resultVo.getCust_id() %>">
<input type="hidden" name="labor_status_bd" value="<%=resultVo.getLabor_status_bd()==null?"":resultVo.getLabor_status_bd() %>">
<input type="hidden" name="working_bd" value="<%=resultVo.getWorking_bd()==null?"":resultVo.getWorking_bd() %>">
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

