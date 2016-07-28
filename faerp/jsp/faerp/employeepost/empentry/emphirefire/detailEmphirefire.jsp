<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empentry.emphirefire.vo.EmphirefireVo" %>
<%@ page import="rayoo.employeepost.empentry.emphirefire.util.IEmphirefireConstants" %>
<%  //取出本条记录
	EmphirefireVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (EmphirefireVo)request.getAttribute(IEmphirefireConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emphirefire.emphirefire_resource" prefix="rayoo.employeepost.empentry.emphirefire.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EmphirefireAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" ><fmt:message key="now_the_files_are_located"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getArchives_address())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="employment_begin_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_start_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="employment_address"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_address())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="handle_employment_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_handle_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="archive_cards"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFile_card())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="office_srfm_labor_and_employment"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_handler_id())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="hire_operate_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_operate_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="social_unit"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSocial_unit())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="hire_fire_status"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_fire_status_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="fire_handle_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFire_handle_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="fire_mode"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFire_mode_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="fire_memo"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFire_memo())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="hire_memo"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHire_memo())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="fire_resident_address"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFire_resident_address())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="cancel_reason"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCancel_reason())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="back_reason"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBack_reason())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="transfer_type"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTransfer_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="last_icst_id"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_icst_id())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="last_eoop_id"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_eoop_id())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_laborbook"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_laborbook_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_fire_prove"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_fire_prove_bd())%></td>
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
