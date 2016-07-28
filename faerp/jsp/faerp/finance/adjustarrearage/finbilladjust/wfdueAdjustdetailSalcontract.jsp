<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo"%>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ taglib uri="/WEB-INF/gap-html.tld" prefix="venus"%>
<%  //取出本条记录
FinbilladjustVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (FinbilladjustVo)request.getAttribute(IFinbilladjustConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤滤
    String taskuid= null==request.getAttribute("taskuid") ? "0":request.getAttribute("taskuid").toString();
    String bill_type_bd = "";
    if(resultVo.getBill_type_bd().equals("1")){
        bill_type_bd = "社保福利+工资";
    }else if(resultVo.getBill_type_bd().equals("2")){
        bill_type_bd = "社保福利";
    }else{
        bill_type_bd="工资";
    String name=RmStringHelper.prt(resultVo.getName());
    }
%>
<%@page
	import="rayoo.finance.adjustarrearage.finbilladjust.vo.FinbilladjustVo"%>
<%@page
	import="rayoo.finance.adjustarrearage.finbilladjust.util.IFinbilladjustConstants"%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<html>
<head>
<script language="javascript">
    var dir_base = "/FAERP";
</script>

<link href="/FAERP/css/gap-css.jsp" type="text/css" rel="stylesheet"
	charset="UTF-8">
<script language="javascript"
	src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/js/common/variable-i18n_zh.js'></script>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/common/gap-mainframe.js"></script>


<link href="<%=request.getContextPath()%>/css/alex-css.jsp"
	type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/common.css"
	type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/index.css" type="text/css"
	rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/tabs.css.jsp"
	rel="stylesheet" type="text/css">
<style type="text/css">
tr.odd {
	background: #fff;
}

tr.even {
	background: #f9fcfd;
}

.box tr:hover,tr.hover {
	background: #c4e7f8;
}

.box tr:selected,tr.selected {
	background-color: #eef8ff;
	border-bottom-color: #daf1ff;
	border-right-color: #daf1ff;
}

.fex_row {
	LEFT: expression(document . getElementById('values_div') . scrollLeft );
	POSITION: relative;
}
</style>


<script language="javascript" src="/FAERP/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
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
      //  alert('审批操作'+message);
      //  form.action="<venus:base/>/dueAdjustWorkFlowAction.do?cmd=appOperate&message="+message[0]+"&taskuid=<%=taskuid%>";
      
      form.action="<venus:base/>/FinbilladjustAction.do?message="+message[0];
           document.getElementById("cmd").value="appOperate";
        form.submit();
        
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/FinbilladjustAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
        
    }
 </script>

<script src="<%=request.getContextPath()%>/js/template/tabs.js"></script>

</head>
<body>
<div id="right"><script language="javascript">
	writeTableTopFesco('分配经办人审批页面','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" id="form" method="post"><input type="hidden"
	value="" name="cmd" id="cmd"> <input type="hidden"
	value="<%=taskuid%>" name="taskuid" id="taskuid">

<table class="table_noFrame">
	<tr>
		<td><input name="button_back" class="button_ellipse"
			type="button" value="返回" onclick="javascript:backTask_onClick();">
		<input name="button_app" class="button_ellipse" type="button"
			value="同意" onclick="javascript:appOperate_onClick();"> <input
			name="button_back" class="button_ellipse" type="button" value="驳回"
			onclick="javascript:backOperate_onClick();"></td>
	</tr>
</table>
<div id="ccChild0" class="box_3"> 
<table width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	       <tr>
				<td class="td_1">客户唯一号</td>
				<td class="td_2"><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
				<td class="td_1">客户名称</td>
				<td class="td_2"><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
				<td class="td_1">客户付款方</td>
				<td class="td_2"><%=RmStringHelper.prt(resultVo.getCost_center_name())%></td>
			</tr>
			<tr>
				<td class="td_1">应收年月</td>
				<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBill_year_month())%></td>
				<td class="td_1">应收类型</td>
				<td class="td_2"><%=bill_type_bd%></td>
				<td class="td_1">应收金额</td>
				<td class="td_2"><%=RmStringHelper.prt(resultVo.getBill_amount())%></td>
			</tr>
			<tr>
				<td class="td_1">实收金额</td>
				<td class="td_2"><%=RmStringHelper.prt(resultVo.getVerification_amount())%></td>
				<td class="td_1">小额调整</td>
				<td class="td_2"><%=RmStringHelper.prt(resultVo.getRate_odds())%></td>
				<td class="td_1">调整日期</td>
				<td class="td_2"><%=RmStringHelper.prt(resultVo.getAdjust_date())%></td>
			</tr>
			<tr>
				<td class="td_1">调整金额</td>
				<td  class="td_2"><%=RmStringHelper.prt(resultVo.getAdjust_amout())%></td>
				<td class="td_1">申请人</td>
				<td class="td_2"><%=RmStringHelper.prt(resultVo.getName())%></td>
				<td class="td_1"></td>
                <td class="td_2"></td>
			</tr>
			<tr>
				 <td class="td_1">备注</td>
                <td  class="td_2" colspan="5"><%=RmStringHelper.prt(resultVo.getAdjust_desc())%></td>
			</tr>
</table>
</div>
</div>

<script type="text/javascript">
writeTabs(400);
</script>
</form>
</body>
</html>
