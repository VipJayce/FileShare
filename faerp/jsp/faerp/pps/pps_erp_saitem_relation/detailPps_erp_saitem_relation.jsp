<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.pps.pps_erp_saitem_relation.vo.Pps_erp_saitem_relationVo" %>
<%@ page import="rayoo.pps.pps_erp_saitem_relation.util.IPps_erp_saitem_relationConstants" %>
<%  //取出本条记录
	Pps_erp_saitem_relationVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (Pps_erp_saitem_relationVo)request.getAttribute(IPps_erp_saitem_relationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/Pps_erp_saitem_relationAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >帐套与薪资类别对应表ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_erp_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >帐套项目ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_templ_item_id())%></td>
		</tr>
		<tr>
			<td class="td_1">ERP薪资项目ID：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IPps_erp_saitem_relationConstants.DICTIONARY_, resultVo.getErp_item_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >PPS对应DEF编号：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_def_index())%></td>
		</tr>
		<tr>
			<td class="td_1" >ERP对应DEF编号：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getErp_def_index())%></td>
		</tr>
		<tr>
			<td class="td_1" >状态：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStatus())%></td>
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
