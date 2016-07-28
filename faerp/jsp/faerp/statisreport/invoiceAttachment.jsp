<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.login.vo.LoginSessionVo"%>
<html>
<%
	String login_user_id = RmJspHelper.getParty_idFromRequest(request);
	//String login_user_name="";
	//LoginSessionVo loginVo =(LoginSessionVo) request.getSession().getAttribute("LOGIN_SESSION_VO"); 
	//if(null!=loginVo){
	//login_user_name=loginVo.getName();
	//}
%>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

<script language="javascript">
  //选择客户页面返回值
    function rtnFuncCustomer(arg){
        var lookup = $id("cust_name1");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        document.form.cust_id.value=arg[0];
        $id("cost_center_id").addParam("cust_id", arg[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
    }
    function clearId(){
        var lookup = $id("cust_name1");
        lookup.value = '';
        lookup.setDisplayValue('');
        document.form.cust_id.value='';
     }
</script>
	</head>
	<body>

		<form name="form" method="post" id="datacell_formid"
			action="<%=request.getContextPath()%>/InvoiceAttachmentAction.do?cmd=export">

			<div id="right">
				<script language="javascript">
				       writeTableTopFesco('账单手工开票附件下载','<%=request.getContextPath()%>/');  //显示本页的页眉
				</script>
				<div class="ringht_s">

					<table width="98%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<div class="zbox">
									<div class="xz_title">报表</div>
									<!--表格1-->
									<div class="box_3">
										<table width="100%" height="40" border="0" cellpadding="0"
											cellspacing="1" bgcolor="#c5dbe2">
											<tr>
												<td class="td_1">上传时间</td>
												<td class="td_2"><w:date allowInput="true"
														format="yyyy-MM-dd" id="create_date_from" name="create_date_from"
														width="90" />&nbsp;&nbsp;到 &nbsp;&nbsp;<w:date allowInput="true"
														format="yyyy-MM-dd" id="create_date_to" name="create_date_to"
														width="90" /></td>
												<td class="td_1">账单年月</td>
												<td class="td_2"><input type="text" class="text_field"
													id="bill_year_month" name="bill_year_month"
													inputName="账单年月" maxLength="6"
													onkeyup="this.value=this.value.replace(/\D/g,'')"
													onafterpaste="this.value=this.value.replace(/\D/g,'')" /></td>
											</tr>
											<tr>
												<td class="td_1">客户</td>
												<td class="td_2"><input type="hidden" name="cust_id"
													id="cust_id" value=""> <w:lookup
														onReturnFunc="rtnFuncCustomer" id="cust_name1"
														name="cust_name1"
														lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
														dialogTitle="选择客户" height="440" width="600"
														style="width:170px" ondblclick="clearId();" readonly="true"/><font color="red">双击清空</font></td>
												<td class="td_1">成本中心</td>
												<td class="td_2"><r:comboSelect id="cost_center_id"
														name="cost_center_id"
														queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
														textField="cost_center_name" valueField="id"
														xpath="CostcenterVo" width="190" nullText="--请选择--">
													</r:comboSelect></td>
											</tr>
											<tr>
												<td class="td_1">申请人</td>
												<td class="td_2"><input type="text" class="text_field"
													id="user_name" name="user_name" inputName="申请人" maxLength="50" /></td>
												<td class="td_1">所属部门</td>
												<td class="td_2"><r:comboSelect id="dept_id"
														name="dept_id"
														queryAction="/FAERP/InvoiceAttachmentAction.do?cmd=getAllDept"
														textField="dept_name" valueField="id" xpath="DepartmentVo"
														value="" width="190" nullText="--请选择--" /></td>

											</tr>
										</table>
									</div>
									<div class="foot_button">
										<a class="foot_icon_2" onClick="form.submit()">导出报表</a>
									</div>
									<!--表格1 end-->
								</div>
							</td>
						</tr>
					</table>
		</form>
</fmt:bundle>
</body>
</html>
