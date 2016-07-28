<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.elfhand.vo.SingletatsudoVo" %>
<%@ page import="rayoo.elfhand.util.IElfhandConstants" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	SingletatsudoVo resultVo = null;  //定义一个临时的vo变量
	if(request.getAttribute(IElfhandConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
	    resultVo = (SingletatsudoVo)request.getAttribute(IElfhandConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	}
%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post">
	<div id="right" style="width: 98%;height: 90%;">
		<!-- <script language="javascript">
		     writeTableTopFesco('查看单立户、大库','<%=request.getContextPath()%>/');
		</script> --> 
 		<div class="ringht_s">
			<div id="ccChild0" class="box_3"> 
				<table  width="98%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
					<tr>
						<td class="td_1" width="25%">客户名称</td>
						<td class="td_2 " width="25%"><%=RmStringHelper.prt(resultVo.getName()) %></td>
						<td class="td_1" width="25%">客户编号</td>
						<td class="td_2 " width="25%"><%=RmStringHelper.prt(resultVo.getCustomerCode()) %></td>
					</tr>
					<tr>
			            <td class="td_1" >档案代保管地</td>
			            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getOrganization()) %></td>
			            <td class="td_1" >外地人用工地</td>
			            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getEmployment()) %></td>
			        </tr>
			        <tr>
			            <td class="td_1" >组织机构代码</td>
			            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getJName()) %></td>
			            <td class="td_1" >网上办事密码</td>
			            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getJCode()) %></td>
			        </tr>
				</table>
			</div>
    		<div class="mx_button" align="center">
        		<input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        	</div>
		</div>
	</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
%>
</script>
