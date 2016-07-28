<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.salary.sabillimp.vo.SaBillImpVo" %>
<%@ page import="rayoo.salary.sabillimp.util.ISaBillImpConstants" %>
<%  //取出本条记录
	SaBillImpVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SaBillImpVo)request.getAttribute(ISaBillImpConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/RoomAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="detail_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
	<tr>
		<td><br>&nbsp;&nbsp;&nbsp;&nbsp;<input name="button_back" class="button_ellipse" type="button" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" >
		</td>
	</tr>
</table>

<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
	<table class="viewlistCss" style="width:100%">
		<tr>
			<td align="right" width="10%" nowrap>company_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sa_batch_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSa_batch_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sa_batch_code：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSa_batch_code())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>customer_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCustomer_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>file_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getFile_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>file_path：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getFile_path())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>import_time：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getImport_time(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>import_user_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getImport_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_pasword：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_pasword())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>file_pwd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getFile_pwd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>emp_differ_list：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_differ_list())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>emp_differ_cause：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_differ_cause())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sum_differ_list：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSum_differ_list())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sum_differ_cause：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSum_differ_cause())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>e_tax_list：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getE_tax_list())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>e_fund_list：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getE_fund_list())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>only_tax_list：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOnly_tax_list())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>alien_list：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAlien_list())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>other_cause：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOther_cause(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_del：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_user_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</div>

<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
