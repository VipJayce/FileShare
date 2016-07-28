<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="gap.rm.tools.helper.RmStringHelper" %>
<%@ page import="gap.rm.project.dictionary.rmdictionarytype.vo.RmDictionaryTypeVo" %>
<%@ page import="gap.rm.project.dictionary.rmdictionarytype.util.IRmDictionaryTypeConstants" %>
<%  //取出本条记录
	RmDictionaryTypeVo resultVo = null;  //定义一个临时的vo变量 
	resultVo = (RmDictionaryTypeVo)request.getAttribute(IRmDictionaryTypeConstants.REQUEST_BEAN_VALUE);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤 
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中国网通（集团）有限公司河北省分公司企业信息门户</title>
<script language="javascript">
	function find_onClick(){  //直接点到修改页面
		form.action="<%=request.getContextPath()%>/RmDictionaryTypeAction.do?cmd=find";
		form.submit();
	}
	function delete_onClick(){  //直接点删除单条记录
		if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
			return false;
		}
		form.action="<%=request.getContextPath()%>/RmDictionaryTypeAction.do?cmd=delete";
		form.submit();
	}  
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('详细页面','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
	<tr>
		<td>
			<input name="button_update" class="button_ellipse" type="button" value="修改" onClick="javascript:find_onClick();">
			<input name="button_delete" class="button_ellipse" type="button" value="删除" onClick="javascript:delete_onClick();">
			<input name="button_back" class="button_ellipse" type="button" value="返回"  onclick="javascript:history.go(-1);" >
		</td>
	</tr>
</table>

<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')">察看数据字典类型详细
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<tr><td>
	<table class="table_div_content_inner">
		<tr>
			<td width="15%" align="right"><strong>基本信息</strong><br><br></td>
			<td width="35%" align="left">&nbsp;</td>
			<td width="15%" align="right">&nbsp;</td>
			<td width="35%" align="left">&nbsp;</td>
		</tr>
		<tr>
			<td align="right">类型关键字：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getType_keyword())%></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">字典类型名称：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getName())%></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">备注：</td>
			<td colspan="3" align="left"><%=RmStringHelper.prt(resultVo.getRemark())%></td>
		</tr>
		<tr>
			<td align="right">自身编码：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSelf_code())%></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">父栏目编码：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getParent_code())%></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">完全编码：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTotal_code())%></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</td></tr>
</table>
</div>

<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">
</form>

<!-- 开始子表信息 -->
<script language="javascript">
var childTableTabs  =  new Array(
	new Array ("子表信息","<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=queryAll&type_keyword=<%=resultVo.getType_keyword()%>")
); 
</script>
<div id="ccParent9">  
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild9',this,'<%=request.getContextPath()%>/')">子表详细
		</td>
	</tr>
</table>
</div>

<div id="ccChild9"> 
<table class="table_div_content">
	<tr>
		<td>
			<table class="table_div_content">
			  <tr>
				<td>
				<div id="childTableTabsDiv"></div>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<!-- 结束子表信息 -->

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
	
