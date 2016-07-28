<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.insurance.claim.settlementclaimpay.vo.SettlementclaimpayVo" %>
<%@ page import="rayoo.insurance.claim.settlementclaimpay.util.ISettlementclaimpayConstants" %>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
    SettlementclaimpayVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (SettlementclaimpayVo)request.getAttribute(ISettlementclaimpayConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        form.submit();
    }
    
    //审批操作
    function appOperate_onClick(){
      var message =addAppReason("<%=request.getContextPath()%>");
      if(message==null)return;
        form.action="<venus:base/>/SettlementclaimpayAction.do?message="+message[0];
        document.getElementById("cmd").value="appOperate";
        form.submit();         
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/SettlementclaimpayAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
    }
</script>
</head>
<body> 
<form name="form" method="post">
  <input  type="hidden"  value="" name="cmd" id="cmd"  >
 <input  type="hidden"  value="<%=taskuid%>" name="taskuid" id="taskuid"  >
 
<table class="table_noFrame" >
    <tr>
         <td >
        <input name="button_back" class="button_ellipse" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
        <input name="button_app" class="button_ellipse" type="button" value="同意"  onclick="javascript:appOperate_onClick();" >
        <input name="button_back" class="button_ellipse" type="button" value="驳回"  onclick="javascript:backOperate_onClick();" >
        </td>
    </tr>
</table>
	<div id="right">
        <div class="right_title_bg">
     <div class=" right_title">查看理赔付款申请单</div>
     </div>
        <div class="ringht_s">
<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >付款单编号</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getSett_claim_pay_code())%></td>
            <td class="td_1" >批次号</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getBatch_num())%></td>
            <td class="td_1" >保险公司</td>
            <td class="td_2" ><%=RmStringHelper.prt(resultVo.getInsurance_agent_name())%></td>            
        </tr>
        <tr>
            <td class="td_1" >付款类型</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("PAY_TYPE",String.valueOf(resultVo.getPay_type()))%></td>
            <td class="td_1" >审批状态</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("APPROVAL_STATE_BD",String.valueOf(resultVo.getApproval_state())) %></td>
            <td class="td_1" >本次合计</td>
            <td class="td_2"><%=RmStringHelper.prt(resultVo.getTotal_count())%></td>
        </tr>
        <tr>
            <td class="td_1" >备注</td>
            <td class="td_2" colspan="5"><%=RmStringHelper.prt(resultVo.getRemark())%>&nbsp;</td>
        </tr>
    </table>
    </div>
    <div id="values_div"> 
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SettlementclaimpayAction.do?cmd=searchSettlementclaimpayData&payid=${bean.id}"
        width="98%"
        height="318px"
        xpath="SettlementclaimpayVo"
        paramFormId="datacell_formid"
        >
         <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="emp_name" width="303px" label="员工姓名">
      </r:field>
      <r:field fieldName="account_num" width="350px" label="银行账号">
      </r:field>
      <r:field fieldName="bank_name" width="340px" label="开户行">
      </r:field>
      <r:field fieldName="amount" width="150px" label="金额">
      </r:field>
    </r:datacell>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
   /*jQuery(document).ready(function() {
	    $id("datacell1").afterRefresh = function() {
	          var total=0;
	          var Me = $id("datacell1");
	          var rows = Me.allTR;
	          for (var i=0;i<rows.length;i++ ){
	            var entity1 = Me.dataset.get(i);
	            total += parseFloat(entity1.getProperty("amount"));
	          }          
	          document.getElementById("total_count").innerHTML = total;
	    }
	});*/
</script>
</body>
</html>
