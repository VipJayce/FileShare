<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empentry.empserviceitem.vo.EmpserviceitemVo" %>
<%@ page import="rayoo.employeepost.empentry.empserviceitem.util.IEmpserviceitemConstants" %>
<%  //取出本条记录
	EmpserviceitemVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (EmpserviceitemVo)request.getAttribute(IEmpserviceitemConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emphirefire.emphirefire_resource" prefix="rayoo.employeepost.empentry.emphirefire.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EmpserviceitemAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" ><fmt:message key="service_name"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getService_name())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="on_post_desc1"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getService_desc())%></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="service_status"/>：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmpserviceitemConstants.DICTIONARY_, resultVo.getService_status())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="service_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getService_date(), 10)%></td>
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
