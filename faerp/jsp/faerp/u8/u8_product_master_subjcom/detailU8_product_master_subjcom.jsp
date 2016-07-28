<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.u8.u8_product_master_subjcom.vo.U8_product_master_subjcomVo" %>
<%@ page import="rayoo.u8.u8_product_master_subjcom.util.IU8_product_master_subjcomConstants" %>
<%  //取出本条记录
	U8_product_master_subjcomVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (U8_product_master_subjcomVo)request.getAttribute(IU8_product_master_subjcomConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/U8_product_master_subjcomAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >产品主键：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >一级科目编码：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSubjcode())%></td>
		</tr>
		<tr>
			<td class="td_1" >对照生效日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStartend(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >对照截止日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEnddate(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >mark：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMark())%></td>
		</tr>
		<tr>
			<td class="td_1" >define1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDefine1())%></td>
		</tr>
		<tr>
			<td class="td_1" >define2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDefine2())%></td>
		</tr>
		<tr>
			<td class="td_1" >define3：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDefine3())%></td>
		</tr>
		<tr>
			<td class="td_1" >define4：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDefine4())%></td>
		</tr>
		<tr>
			<td class="td_1" >define5：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDefine5())%></td>
		</tr>
		<tr>
			<td class="td_1" >create_user_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreate_user_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >是否删除 0:正常　1:删除：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >1 预收  2 实收 3 应收 4 实付 5 应付：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTime_node())%></td>
		</tr>
		<tr>
			<td class="td_1" >voucher_remark_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getVoucher_remark_id())%></td>
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
