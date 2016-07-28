<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="rayoo.finance.payment.finpayment.vo.FinpaymentVo"%>
<%@ page import="rayoo.finance.payment.finpayment.util.IFinpaymentConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _$ = window.jQuery;
var venusbase = "<%=request.getContextPath()%>";
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
</head>
<body>
<form name="form" id="datacell_formid" method="post">
    <input type="hidden" name="taskuid" id="taskuid" value="${taskuid}" />
    <input type="hidden" name="cmd" value="">
    <input  type="hidden"  value="${isLook}" name="isLook" id="isLook"  />
    <input  type="hidden"  value="" name="message" id="message"  />
<div id="right">
	<div class="ringht_s" style="width: 1150px;">
	   <div>
         <div class="box_3">
           <div class="right_title_bg">
                <div class=" right_title">${wfName}</div>
           </div>
           <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1">申请人</td>
               <td class="td_2">${apply_name}</td>
               <td class="td_1">申请部门</td>
               <td class="td_2">${apply_dept}</td>
             </tr>
             <tr>
               <td class="td_1">客户编号</td>
               <td class="td_2">${finbillVo.cust_code}</td>
               <td class="td_1">客户名称</td>
               <td class="td_2">${finbillVo.cust_name}</td>
             </tr>
             <tr>
               <td class="td_1">成本中心名称</td>
               <td class="td_2">${finbillVo.cost_center_name}</td>
               <td class="td_1">账单编号</td>
               <td class="td_2">${finbillVo.bill_code}</td>
              </tr>
              <tr>
               <td class="td_1">账单金额</td>
               <td class="td_2">${finbillVo.bill_amount}</td>
               <td class="td_1">申请原因</td>
               <td class="td_2">${apply_reason}</td>
              </tr>
            </table>
         </div>
       </div>
             
      <div class="foot_button">
        <input name="button_back" class="foot_icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <%
        if(request.getAttribute("isLook")==null||(request.getAttribute("isLook")!=null&&request.getAttribute("isLook").equals("false"))){
        %>
        <input name="button_app" class="foot_icon_2" type="button" value="通过"  onclick="javascript:operate_onClick(1);" >
        <input name="button_back" class="foot_icon_2" type="button" value="驳回"  onclick="javascript:operate_onClick(0);" >
        <%} %>
      </div>
    
    </div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
<script type="text/javascript">
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
        //审批意见
        var message =addAppReason("<%=request.getContextPath()%>");
        //任务id
        var taskuid = _$("#taskuid").val();
        if(message==null){
            return;
        }
        _$("#message").val(message[0]);
        var params = _$("#datacell_formid").serialize();
        _$.ajax({
             type: "POST",
             url: venusbase+"/FinbillAction.do?cmd=approveChangeBill&opState="+ opState,
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
</body>
</html>
