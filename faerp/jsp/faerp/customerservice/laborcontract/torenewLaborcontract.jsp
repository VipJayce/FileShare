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
<fmt:bundle basename='rayoo.customerservice.custservice.laborcontract.torenewLaborcontract_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	   var fixed_term = document.getElementById('fixed_term').value;
	    var is_fixed_term = document.getElementById('is_fixed_term');
	    var send_start_date = document.getElementById('send_start_date').value;
	    var send_end_date = document.getElementById('send_end_date').value;
        if(is_fixed_term.checked){
	         if(fixed_term == "0"){
	            var end_date = document.getElementById('end_date').value;
	            if(end_date == null || end_date== ''){
	                alert("合同结束日期不能为空");
	                return;
	            }
	         }
            var continuation_years = document.getElementById('continuation_years').value;
            if(continuation_years == null || continuation_years == ""){
                alert("自动延续状态已勾选，请选择自动延续年数");
                return;
            }
            document.getElementById('is_fixed_term').value=0;
        }else
        {
            var continuation_years = document.getElementById('continuation_years').value;
             if(continuation_years == null || continuation_years == "" || continuation_years == " "){
                }else{
                    alert("自动延续状态未勾选，不能选择自动延续年数");
                    return;
                }
              document.getElementById('is_fixed_term').value=1;
        }
        var status_db= '${vo.emp_post_type_bd }';
        if(status_db=="1")
        {
             if(send_start_date==null||send_start_date=="")
            {
                alert("派遣期限起始日期不成为空，请选择！");
                return ;
            }
            if(fixed_term == "0"){
	            if(send_end_date==null||send_end_date=="")
	            {
	                alert("派遣期限截至日期不成为空，请选择！");
	                return ;
	            }
	             if(send_start_date>send_end_date)
	            {
	                   alert("<fmt:message key='torenewLaborcontract0003'/>");
	                   return ;
	            }
            }
        }
        
		  form.action="<%=request.getContextPath()%>/LaborcontractAction.do?cmd=insert";
		  form.submit();
		  window.close();
	}
    
    
</script>

</head>
<body>

<form name="form" method="post">
<div id="right">
<div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="80" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
            <td class="td_1" ><fmt:message key='torenewLaborcontract0004'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="send_start_date" name="send_start_date" format="YYYY-MM-DD" property="vo/send_end_date"/>               
            </td>
            <td class="td_1" ><fmt:message key='torenewLaborcontract0005'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="send_end_date" name="send_end_date" format="YYYY-MM-DD" />               
            </td>
        </tr> 
        <tr>
            <td class="td_1" >合同期限</td>
            <td class="td_2">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("fixed_term", -1,"FIXED_TERM",resultVo.getFixed_term(),"id=fixed_term  style='width: 170px'",false) %>
            </td>
            <td class="td_1" ></td>
            <td class="td_2"></td>
        </tr>
        <tr>
            <td class="td_1" >自动延续状态</td>
            <td class="td_2">
                 <input type="checkbox" name="is_fixed_term" id="is_fixed_term" />
            </td>
            <td class="td_1" >自动延续年数</td>
            <td class="td_2">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("continuation_years", -1,"CONTINUATION_YEARS",resultVo.getContinuation_years(),"id=continuation_years  style='width: 170px'",false) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='torenewLaborcontract0007'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="start_date" name="start_date" format="YYYY-MM-DD" property="vo/start_date"/>                
            </td>
            <td class="td_1" ><fmt:message key='torenewLaborcontract0008'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="end_date" name="end_date" format="YYYY-MM-DD"  property="vo/end_date" />                
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='torenewLaborcontract0009'/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="position"  inputName="<fmt:message key='torenewLaborcontract0009'/>" value="<%=resultVo.getPosition()==null?"":resultVo.getPosition() %>" style="width: 170px;" />
            </td>
            <td  class="td_1" ><fmt:message key='torenewLaborcontract0011'/>(<fmt:message key='torenewLaborcontract0012'/>)</td>
            <td  class="td_2" >
                <input type="text" class="text_field" name="salary" inputName="<fmt:message key='torenewLaborcontract0013'/>"value="<%=resultVo.getSalary()==null?"":resultVo.getSalary()%>" maxLength="23" integerDigits="18" decimalDigits="4" style="width: 170px;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key='torenewLaborcontract0014'/></td>
            <td class="td_2 ">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("working_bd", -1,"WORKING_BD",resultVo.getWorking_bd(),"id=working_bd  style='width: 170px'",false) %>
            </td>
            <td class="td_1" ><fmt:message key='torenewLaborcontract0015'/></td>
            <td class="td_2">
                <w:date allowInput="true" id="subscribe_date" name="subscribe_date" format="YYYY-MM-DD" property="vo/subscribe_date"/>               
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='torenewLaborcontract0016'/></td>
            <td colspan="3" class="td_2" >
                <textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName="<fmt:message key='torenewLaborcontract0016'/>" maxLength="1000" ><%=resultVo.getRemark()==null?"":resultVo.getRemark()%></textarea>
            </td>
        </tr>
</table>


            
   
   
    <div class="mx_button" style="text-align: center;">
        <input type="button" class="icon_2" value='<fmt:message key="torenewLaborcontract0019"/>' onClick="javascript:insert_onClick()" />
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
</form>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	var is_fixed_term="${vo.is_fixed_term }";
	if(is_fixed_term=="1")
	{
	  jQuery("#is_fixed_term").attr("checked","true");
	}
	
</script>
</body>
</fmt:bundle>
</html>

