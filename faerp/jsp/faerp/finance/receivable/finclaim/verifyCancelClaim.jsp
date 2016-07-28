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
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
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
        //到款id
        var incoming_id = _$("#incoming_id").val();
        //认领id
        var claim_id = _$("#claim_id").val();
        //核销id
        var ver_id = _$("#ver_id").val();
        //审批意见
        var message =addAppReason("<%=request.getContextPath()%>");
        if(message==null){
            return;
        }
        _$("#message").val(message[0]);
        var params = _$("#datacell_formid").serialize();
        _$.ajax({
             type: "POST",
             url: venusbase + "/FinclaimAction.do?cmd=verifyCancelClaim&opState="+ opState,
             data:params,
             dataType: "html",
             success: function(msg){
                   alert(msg);
                   _$("#isLook").val("true");
                   backTask_onClick();
             }
        });
    }
</script>
</head>
<body> 
<form name="form" method="post" id="datacell_formid">
  <input  type="hidden"  value="${taskuid}" name="taskuid" id="taskuid"  >
  <input  type="hidden"  value="${fincomingVo.id}" name="incoming_id" id="incoming_id"  >
  <input  type="hidden"  value="${finclaimVo.id}" name="claim_id" id="claim_id"  >
  <input  type="hidden"  value="${verVo.id}" name="ver_id" id="ver_id"  >
  <input  type="hidden"  value="${isLook}" name="isLook" id="isLook"  >
  <input  type="hidden"  value="" name="message" id="message"  />
 
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
        <div class=" right_title">取消详情</div>
     </div>
     <table  width="70%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >申请人</td>
            <td class="td_2 " nowrap="nowrap">
                ${user_name}
            </td>
            <td class="td_1" >申请人所属部门</td>
            <td class="td_2 " nowrap="nowrap">
                ${dept_name}
            </td>
        </tr>
        
        <tr>
            <td class="td_1" >到款编号</td>
            <td class="td_2 " nowrap="nowrap">
                ${fincomingVo.inc_code }
            </td>
            <td class="td_1" >到款金额</td>
            <td class="td_2"  nowrap="nowrap">
                ${fincomingVo.inc_amout }
            </td>
       </tr>
       
       <c:if test="${ empty verVo}">
	       <tr>
	            <td class="td_1" >认领金额</td>
	            <td class="td_2 " colspan="3">
	                ${finclaimVo.claim_amount }
	            </td>
	       </tr>
       </c:if>
       
       <c:if test="${ not empty verVo}">
	       <tr>
	            <td class="td_1" >客户编号</td>
	            <td class="td_2 " nowrap="nowrap">
	                ${verVo.cust_code }
	            </td>
	            <td class="td_1" >客户名称</td>
	            <td class="td_2"  nowrap="nowrap">
	                ${verVo.cust_name }
	            </td>
	        </tr>
	        
	        <tr>
	             <td class="td_1" >账单年月</td>
	            <td class="td_2 " nowrap="nowrap">
	                ${verVo.bill_year_month }
	            </td>
	            <td class="td_1" >核销金额</td>
	            <td class="td_2"  nowrap="nowrap">
	                ${verVo.ver_amount }
	            </td>
	        </tr>
	        
	        <tr>
                 <td class="td_1" >是否有开票记录</td>
                <td class="td_2 " nowrap="nowrap">
                    <c:if test="${fn:length(invoiceList) > 0 }">是</c:if>
                    <c:if test="${fn:length(invoiceList) == 0 }">否</c:if>
                </td>
                <td class="td_1" >是否有支付记录</td>
                <td class="td_2"  nowrap="nowrap">
                    <c:if test="${fn:length(paymentList) > 0 }">是</c:if>
                    <c:if test="${fn:length(paymentList) == 0 }">否</c:if>
                </td>
            </tr>
        </c:if>
        
        <tr  style="height:60px;">
            <td class="td_1">取消原因</td>
            <td class="td_2"  nowrap="nowrap"  colspan="3" style="height:60px;width:540px;overflow: visible">
                ${finclaimVo.remark}
            </td>
        </tr>
     </table>
</div>
</form>
</fmt:bundle>
</body>
</html>
