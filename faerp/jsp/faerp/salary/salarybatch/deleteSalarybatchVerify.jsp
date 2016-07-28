<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _$ = window.jQuery;
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.salary.salarybatch.vo.SalarybatchVo" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<%
  SalarybatchVo sbVo = (SalarybatchVo)request.getAttribute("batchVo");
%>
<script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/editbatch.js"></script>
<script language="javascript">
    //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        var isLook = _$("#isLook").val();
        if(isLook !="" && isLook != null ){
             form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true";
        }else{
            form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        }
        form.submit();
    }
    
    //审批操作
    function operate_onClick(opState){
         //任务id
	    var taskuid = _$("#taskuid").val();
	    //工资批次id
	    var batch_id = _$("#batch_id").val();
	    var info ;
	    if(opState == 0){
	       info = "您确认驳回该批次吗？";
	    }else if(opState ==1){
	       info = "您确认审核通过该批次吗？"
	    }
	    if(confirm(info)){
	          _$.ajax({
                   type: "POST",
                   url: venusbase + "/SalarybatchAction.do?cmd=verifyDeleteSalaryBatch&taskuid="+ taskuid+"&batch_id="+batch_id+"&opState="+opState,
                   data:"",
                   dataType: "html",
                   success: function(msg){
                         alert(msg);
                         _$("#isLook").val("true");
                         backTask_onClick();
                   }
           });
	    }
    }
</script>
</head>
<body> 
<form name="form" method="post">
  <input  type="hidden"  value="${taskuid}" name="taskuid" id="taskuid"  >
  <input  type="hidden"  value="${batchVo.id}" name="batch_id" id="batch_id"  >
   <input  type="hidden"  value="${isLook}" name="isLook" id="isLook"  >
 
	<table class="table_noFrame" >
	    <tr>
	         <td >
	        <input name="button_back" class="button_ellipse" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
           <%
	        if(request.getAttribute("isLook")==null||(request.getAttribute("isLook")!=null&&request.getAttribute("isLook").equals("false"))){
	        %>
	        <input name="button_app" class="button_ellipse" type="button" value="同意"  onclick="javascript:operate_onClick(1);" >
	        <input name="button_back" class="button_ellipse" type="button" value="驳回"  onclick="javascript:operate_onClick(0);" >
         <%} %>
	        </td>
	    </tr>
	</table>
    <div id="right" class="box_3">
     <div class="right_title_bg">
        <div class=" right_title">薪资批次详情</div>
     </div>
     <table  width="54%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
            <td class="td_1">薪资批次号</td>
            <td class="td_2"  nowrap="nowrap" colspan="3">
                ${batchVo.sa_batch_code }
            </td>
        </tr>
        
        <tr>
            <td class="td_1" >申请人</td>
            <td class="td_2 " nowrap="nowrap">
                ${batchVo.submit_user }
            </td>
            <td class="td_1" >审核人</td>
            <td class="td_2"  nowrap="nowrap">
                ${batchVo.audit_user_name }
            </td>
        </tr>
        
        <tr>
             <td class="td_1" >客户编号</td>
            <td class="td_2 " nowrap="nowrap">
                ${batchVo.customer_code }
            </td>
            <td class="td_1" >客户名称</td>
            <td class="td_2"  nowrap="nowrap">
                ${batchVo.customer_name }
            </td>
        </tr>
        
        <tr>
            <td class="td_1" >实发金额</td>
            <td class="td_2 " nowrap="nowrap" id="total_amount">
                ${batchVo.total_amount }
            </td>
            <td class="td_1" >实发人数</td>
            <td class="td_2"  nowrap="nowrap">
                ${batchVo.total_number }
            </td>
       </tr>
       <tr>
            <td class="td_1" >审核状态</td>
            <td class="td_2 " nowrap="nowrap">
                <%if("0".equals(sbVo.getAudit_state())){%>
                待审核
               <% } %>
                <%if("1".equals(sbVo.getAudit_state())){%>
                    已通过
               <% } %>
               
                <%if("2".equals(sbVo.getAudit_state())){%>
                    未通过
               <% } %>
               <%if("3".equals(sbVo.getAudit_state())){%>
                    已完成
               <% } %>
            </td>
            <td class="td_1">发放申请状态</td>
            <td class="td_2"  nowrap="nowrap">
                <%if("0".equals(sbVo.getApply_pay_state())){%>
                未申请
               <% } %>
                <%if("1".equals(sbVo.getApply_pay_state())){%>
                已申请
               <% } %>
            </td>
        </tr>
         <tr  style="height:60px;">
            <td class="td_1">删除原因</td>
            <td class="td_2"  nowrap="nowrap"  colspan="3" style="height:60px;width:540px;overflow: visible">
            ${batchVo.remarks}
            </td>
        </tr>
     </table>
</div>
</form>
</fmt:bundle>
<script language="javascript">
_$(document).ready(function(){
    //把实发金额变成千分位显示
    _$("#total_amount").html(MilliFormat(_$("#total_amount").html()));
});

//把数字变成千分位
function MilliFormat(num){  
   if((num+"").trim()==""){
      return "";
   }
   if(isNaN(num)){
      return "";
   }
   num = num+"";
   if(/^.*\..*$/.test(num)){
      //如果是浮点数
      var pointIndex =num.lastIndexOf(".");
      var intPart = num.substring(0,pointIndex);
      var pointPart =num.substring(pointIndex+1,num.length);
      intPart = intPart +"";
       var re =/(-?\d+)(\d{3})/
       while(re.test(intPart)){
          intPart =intPart.replace(re,"$1,$2")
       }
      num = intPart+"."+pointPart;
   }else{
      //整数
      num = num +"";
       var re =/(-?\d+)(\d{3})/
       while(re.test(num)){
          num =num.replace(re,"$1,$2")
       }
   }
    return num; 
}
</script>
</body>
</html>
