<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.elfhand.vo.UnConventionalPostVo" %>
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
	UnConventionalPostVo resultVo = null;  //定义一个临时的vo变量
	if(request.getAttribute(IElfhandConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
	    resultVo = (UnConventionalPostVo)request.getAttribute(IElfhandConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
	<div id="right" style="width: 98%;height: 90px;">
		<!-- <script language="javascript">
		     writeTableTopFesco('查看非常规岗位','<%=request.getContextPath()%>/');
		</script> --> 
		<div class="ringht_s">
			<div id="ccChild0" class="box_3"> 
				<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
					<tr>
						<td class="td_1" width="25%">唯一号</td>
						<td class="td_2 " width="25%"><%=RmStringHelper.prt(resultVo.getEmpCode()) %></td>
						<td class="td_1" width="25%">姓名</td>
						<td class="td_2 " width="25%"><%=RmStringHelper.prt(resultVo.getName()) %></td>
					</tr>
					<tr>
			            <td class="td_1" >单位</td>
			            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getUnit()) %></td>
			            <td class="td_1" >岗位工种</td>
			            <td class="td_2 "><%=RmStringHelper.prt(resultVo.getTypeOfWork()) %></td>
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
