<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.sales.salcontractitem.vo.SalcontractitemVo" %>
<%@ page import="rayoo.sales.salcontractitem.util.ISalcontractitemConstants" %>
<%  //取出本条记录
	SalcontractitemVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SalcontractitemVo)request.getAttribute(ISalcontractitemConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/SalcontractitemAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >合同ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同模板ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_template_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同模板子条款ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_template_item_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同条款名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_content_item_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同条款内容：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContract_template_itme_content())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同模板条款英文名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEnglish_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同模板条款英文内容：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEnglish_content())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同条款序列：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSerial_no())%></td>
		</tr>
		<tr>
			<td class="td_1" >合同条款父ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getParent_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >edit_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEdit_type())%></td>
		</tr>
		<tr>
			<td class="td_1" >node_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getNode_type())%></td>
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
