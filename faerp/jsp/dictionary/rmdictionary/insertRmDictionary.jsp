<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="gap.rm.project.dictionary.rmdictionary.vo.RmDictionaryVo" %>
<%@ page import="gap.rm.project.dictionary.rmdictionary.util.IRmDictionaryConstants" %>
<%  //判断是否为修改页面
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
	}
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<script src="<%=request.getContextPath()%>/js/rm-insert.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/jsp/include/FCKeditor/fckeditor.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中国网通（集团）有限公司河北省分公司企业信息门户</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
    	form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=insert";
	    form.submit();
	}
  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/RmDictionaryAction.do?cmd=update";
    	form.submit();
	}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<%=isModify?"修改页面":"新增页面"%>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td>
			<input name="button_save" class="button_ellipse" type="button" value="保存" onClickTo="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>">
			<input name="button_cancel" class="button_ellipse" type="button" value="取消"  onClick="javascript:history.go(-1)" >
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><%=isModify?"修改":"新增"%>数据字典
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
<tr><td> 
	<table class="table_div_content_inner">
		<tr>
			<td align="right"><span class="style_required_red">* </span>类型关键字</td>
			<td align="left">
				<input type="text" class="text_field_readonly" name="type_keyword" inputName="类型关键字" value="" maxLength="200" validate="notNull;"/>
				<div>字段被引用的值，比如：0、1、1001等</div>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><span class="style_required_red">* </span>数据关键字</td>
			<td align="left">
				<input type="text" class="text_field" name="data_key" inputName="数据关键字" value="" maxLength="200" validate="notNull;"/>
				<div>即中文含义，比如：启用、禁用等</div>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">数据值</td>
			<td align="left">
				<input type="text" class="text_field" name="data_value" inputName="数据值" value="" maxLength="200" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">排序编码</td>
			<td align="left">
				<input type="text" class="text_field" name="order_code" inputName="排序编码" value="" maxLength="500" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">备注</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="remark" maxLength="500"  id="remarkId"></textarea>
			</td>
		</tr>
	</table>
</td></tr>
</table>
</div>
            
<input type="hidden" name="id" value="">
<input type="hidden" name="enable_status" value="1">

</form>			
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<%  //取出要修改的那条记录，并且回写表单
  	out.print("<script language=\"javascript\">\n");  //输出script的声明开始
	if(isModify) {  //如果本页面是修改页面
  		RmDictionaryVo resultVo = null;  //定义一个临时的vo变量
  		if(request.getAttribute(IRmDictionaryConstants.REQUEST_BEAN_VALUE) != null) {  //如果request中取出的bean不为空
  			resultVo = (RmDictionaryVo)request.getAttribute(IRmDictionaryConstants.REQUEST_BEAN_VALUE);  //从request中取出vo, 赋值给resultVo
  		}
  		if(resultVo != null) {  //如果vo不为空
			out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
		}
  	} else {
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromRequest(request)));  //输出表单回写方法的脚本
	}
	out.print("writeBackMapToForm();\n");  //输出执行回写方法
	out.print("</script>");  //输出script的声明结束
%>
