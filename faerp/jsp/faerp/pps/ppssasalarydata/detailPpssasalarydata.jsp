<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.pps.ppssasalarydata.vo.PpssasalarydataVo" %>
<%@ page import="rayoo.pps.ppssasalarydata.util.IPpssasalarydataConstants" %>
<%  //取出本条记录
	PpssasalarydataVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (PpssasalarydataVo)request.getAttribute(IPpssasalarydataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/PpssasalarydataAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >company_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >department_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDepartment_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >pay_year_month：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPay_year_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >stop_flag：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStop_flag())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_verify：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_verify())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_del：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_postpone：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_postpone())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_email：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_email())%></td>
		</tr>
		<tr>
			<td class="td_1" >email_time：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmail_time(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >email_user：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmail_user())%></td>
		</tr>
		<tr>
			<td class="td_1" >email_remarks：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmail_remarks())%></td>
		</tr>
		<tr>
			<td class="td_1" >def1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef1())%></td>
		</tr>
		<tr>
			<td class="td_1" >def2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef2())%></td>
		</tr>
		<tr>
			<td class="td_1" >def3：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef3())%></td>
		</tr>
		<tr>
			<td class="td_1" >def4：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef4())%></td>
		</tr>
		<tr>
			<td class="td_1" >def5：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef5())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_valid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
		</tr>
		<tr>
			<td class="td_1" >note：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getNote())%></td>
		</tr>
		<tr>
			<td class="td_1" >old_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOld_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >pps_sa_batch_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_sa_batch_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >pps_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >def6：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef6())%></td>
		</tr>
		<tr>
			<td class="td_1" >def7：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef7())%></td>
		</tr>
		<tr>
			<td class="td_1" >def8：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef8())%></td>
		</tr>
		<tr>
			<td class="td_1" >def9：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef9())%></td>
		</tr>
		<tr>
			<td class="td_1" >def10：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef10())%></td>
		</tr>
		<tr>
			<td class="td_1" >def11：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef11())%></td>
		</tr>
		<tr>
			<td class="td_1" >def12：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef12())%></td>
		</tr>
		<tr>
			<td class="td_1" >def13：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef13())%></td>
		</tr>
		<tr>
			<td class="td_1" >def14：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef14())%></td>
		</tr>
		<tr>
			<td class="td_1" >def15：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef15())%></td>
		</tr>
		<tr>
			<td class="td_1" >def16：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef16())%></td>
		</tr>
		<tr>
			<td class="td_1" >def17：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef17())%></td>
		</tr>
		<tr>
			<td class="td_1" >def18：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef18())%></td>
		</tr>
		<tr>
			<td class="td_1" >def19：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef19())%></td>
		</tr>
		<tr>
			<td class="td_1" >def20：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef20())%></td>
		</tr>
		<tr>
			<td class="td_1" >def21：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef21())%></td>
		</tr>
		<tr>
			<td class="td_1" >def22：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef22())%></td>
		</tr>
		<tr>
			<td class="td_1" >def23：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef23())%></td>
		</tr>
		<tr>
			<td class="td_1" >def24：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef24())%></td>
		</tr>
		<tr>
			<td class="td_1" >def25：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef25())%></td>
		</tr>
		<tr>
			<td class="td_1" >def26：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef26())%></td>
		</tr>
		<tr>
			<td class="td_1" >def27：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef27())%></td>
		</tr>
		<tr>
			<td class="td_1" >def28：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef28())%></td>
		</tr>
		<tr>
			<td class="td_1" >def29：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef29())%></td>
		</tr>
		<tr>
			<td class="td_1" >def30：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef30())%></td>
		</tr>
		<tr>
			<td class="td_1" >def31：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef31())%></td>
		</tr>
		<tr>
			<td class="td_1" >def32：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef32())%></td>
		</tr>
		<tr>
			<td class="td_1" >def33：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef33())%></td>
		</tr>
		<tr>
			<td class="td_1" >def34：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef34())%></td>
		</tr>
		<tr>
			<td class="td_1" >def35：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef35())%></td>
		</tr>
		<tr>
			<td class="td_1" >def36：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef36())%></td>
		</tr>
		<tr>
			<td class="td_1" >def37：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef37())%></td>
		</tr>
		<tr>
			<td class="td_1" >def38：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef38())%></td>
		</tr>
		<tr>
			<td class="td_1" >def39：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef39())%></td>
		</tr>
		<tr>
			<td class="td_1" >def40：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef40())%></td>
		</tr>
		<tr>
			<td class="td_1" >def41：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef41())%></td>
		</tr>
		<tr>
			<td class="td_1" >def42：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef42())%></td>
		</tr>
		<tr>
			<td class="td_1" >def43：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef43())%></td>
		</tr>
		<tr>
			<td class="td_1" >def44：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef44())%></td>
		</tr>
		<tr>
			<td class="td_1" >def45：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef45())%></td>
		</tr>
		<tr>
			<td class="td_1" >def46：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef46())%></td>
		</tr>
		<tr>
			<td class="td_1" >def47：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef47())%></td>
		</tr>
		<tr>
			<td class="td_1" >def48：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef48())%></td>
		</tr>
		<tr>
			<td class="td_1" >def49：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef49())%></td>
		</tr>
		<tr>
			<td class="td_1" >def50：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef50())%></td>
		</tr>
		<tr>
			<td class="td_1" >def51：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef51())%></td>
		</tr>
		<tr>
			<td class="td_1" >def52：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef52())%></td>
		</tr>
		<tr>
			<td class="td_1" >def53：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef53())%></td>
		</tr>
		<tr>
			<td class="td_1" >def54：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef54())%></td>
		</tr>
		<tr>
			<td class="td_1" >def55：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef55())%></td>
		</tr>
		<tr>
			<td class="td_1" >def56：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef56())%></td>
		</tr>
		<tr>
			<td class="td_1" >def57：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef57())%></td>
		</tr>
		<tr>
			<td class="td_1" >def58：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef58())%></td>
		</tr>
		<tr>
			<td class="td_1" >def59：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDef59())%></td>
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
