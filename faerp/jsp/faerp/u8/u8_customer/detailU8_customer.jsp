<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.u8.u8_customer.vo.U8_customerVo" %>
<%@ page import="rayoo.u8.u8_customer.util.IU8_customerConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
	U8_customerVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (U8_customerVo)request.getAttribute(IU8_customerConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
      window.close();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 
	
       <div id="right">
    	<div class="ringht_s">
<div id="ccChild0" class="box_3" style="height: 300px"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >客户编码：</td>
			<td class="td_2" >${bean.ccuscode }</td>
			<td class="td_1" >客户名称：</td>
            <td class="td_2" >${bean.ccusname }</td>
		</tr>
	
		<tr>
			<td class="td_1" >客户简称：</td>
			<td class="td_2" >${bean.ccusabbname }</td>
			<td class="td_1" >英文名称：</td>
            <td class="td_2" >${bean.ccusenname }</td>
		</tr>
	
		<tr>
			<td class="td_1" >客户分类编码：</td>
			<td class="td_2" >${bean.ccccode }</td>
			 <td class="td_1" >地区编码：</td>
            <td class="td_2" >${bean.cdccode }</td>
		</tr>
	
		<tr>
			<td class="td_1" >地址：</td>
			<td class="td_2" >${bean.ccusaddress }</td>
			<td class="td_1" >邮政编码：</td>
            <td class="td_2" >${bean.ccuspostcode }</td>
		</tr>
		
		<tr>
			<td class="td_1" >纳税人登记号：</td>
			<td class="td_2" >${bean.ccusregcode }</td>
			 <td class="td_1" >开户银行：</td>
            <td class="td_2" >${bean.ccusbank }</td>
		</tr>
	
		<tr>
			<td class="td_1" >银行账号：</td>
			<td class="td_2" >${bean.ccusaccount }</td>
			<td class="td_1" >法人：</td>
            <td class="td_2" >${bean.ccuslperson }</td>
		</tr>
	
		<tr>
			<td class="td_1" >联系人：</td>
			<td class="td_2" >${bean.ccusperson }</td>
			 <td class="td_1" >联系电话：</td>
            <td class="td_2" >${bean.ccusphone }</td>
		</tr>
		
		<tr>
			<td class="td_1" >所属行业：</td>
			<td class="td_2" >${bean.ctrade }</td>
			<td class="td_1" align="right"></td>
            <td class="td_2" align="left"></td>
		</tr>
		
	</table>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>"> 	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='关闭'   onclick="javascript:back_onClick();" />
</div>
</div>
</div>
 </div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
