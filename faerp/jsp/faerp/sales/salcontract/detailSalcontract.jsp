<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>
<%  //取出本条记录
	SalcontractVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SalcontractVo)request.getAttribute(ISalcontractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 
	
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	<fmt:message key="detail_page"/>
	 </div>
	 </div>
    	<div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >分公司ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >客户ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_id())%></td>
		</tr>
		<tr>
			<td class="td_1">客户简档中的 合同类型：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISalcontractConstants.DICTIONARY_, resultVo.getContract_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同生成方式：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreate_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同模板ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_template_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同编号：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同甲方：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_a_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同乙方：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAgent_b_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同起始日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_start_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >合同终止日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_stop_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >合同附件ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_attachment_id())%></td>
		</tr>
		<tr>
			<td class="td_1">合同状态：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISalcontractConstants.DICTIONARY_, resultVo.getContract_status_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >主签方：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMain_part_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_valid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_del：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" align="right"></td>
			<td class="td_2" align="left"></td>
		</tr>
	</table>
</div>


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>