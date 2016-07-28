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
                <div class=" right_title">报税延后审核</div>
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
               <td class="td_2">${wfVo.cust_code}</td>
               <td class="td_1">客户名称</td>
               <td class="td_2">${wfVo.cust_name}</td>
             </tr>
             <tr>
               <td class="td_1">工资发放日</td>
               <td class="td_2">${wfVo.pay_day}</td>
               <td class="td_1">报税延后原因</td>
               <td class="td_2">${wfVo.apply_reason}</td>
              </tr>
            </table>
         </div>
       </div>
             
       <div style="margin-left: 10px;">
	       <div class="right_title_bg" style="margin-top: 20px;width: 1128px;">
	            <div class=" right_title">审批详细</div>
	       </div>
                      <r:datacell 
                      queryAction="/FAERP/SalcontractAction.do?cmd=getSalcontractSPInto&contract_id=${wfVo.id}&wfname=${wfName}&wfname1=${wfName}"
                      id="datacell1"
                      paramFormId="datacell_formid" 
                      width="1128px" height="220px" 
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
             url: venusbase+"/SalaryclassAction.do?cmd=approveTaxDelay&opState="+ opState,
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
