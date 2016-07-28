<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客服服务员工明细查询</title>
<script language="javascript">
    function exportEXCEL_onClick(){
        var end_date = document.getElementById("end_date").value; //截止日期
        var lk_cs = document.getElementById("lk_cs_hidden").value; //客服ID
        var cust_dept = document.getElementById("cust_dept").value;//客服部门ID
        
        var url = "";
        
        url = "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showServiceEmpList.jsp?raq=service_emp_list.raq&end_date="+end_date+"&lk_cs="+lk_cs+"&cust_dept="+cust_dept;
        
        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
    }
    
     //选择客服
		function rtnFuncCS(arg){
		    var lookup = $id("lk_cs");
		    lookup.value = arg[0];
		    lookup.displayValue = arg[1];
		    jQuery("#cust_name").val(arg[0]);        
		    return false;
		}
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">

<div id="right">
<script language="javascript">
       writeTableTopFesco('客服服务员工明细查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

	<table width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<div class="zbox">
			<div class="xz_title">报表</div>
			<!--表格1-->
			<div class="box_3">
			<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
				<tr>
					<td class="td_1">截止时间</td>
					<td class="td_2">
                        <w:date format="yyyy-MM-dd" id="end_date" name="end_date" property="bean/end_date" width="189px"/>
					</td>
					<td class="td_2">&nbsp;</td>
					<td class="td_2">
                        &nbsp;
					</td>
				</tr>
				<tr>
					<td class="td_1">客服代表</td>
					<td class="td_2">
                        <w:lookup onReturnFunc="rtnFuncCS" style="width:170px" readonly="true" id="lk_cs" lookupUrl="/CustServiceAction.do?cmd=toCustService" dialogTitle="选择客服" height="450" width="500"/>
					</td>
					<td class="td_1">客服部门</td>
					<td class="td_2">
                        <r:comboSelect id="cust_dept" name="cust_dept" queryAction="/FAERP/FinbillAction.do?cmd=getCustDeptListData"
                       textField="name" valueField="id" xpath="AupartyVO" width="180px" nullText="--请选择--" />
					</td>
				</tr>
			</table>
			</div>
			<div class="foot_button">
			     <a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();">导出报表</a>
			</div>
			<!--表格1 end--></div>
			</td>
		</tr>
	</table>
	</form>
</fmt:bundle>
</body>
</html>
