<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ page import="gap.report.util.VoHelperTools"%>
<%@ page import="gap.report.filemanage.vo.ReportFileVo"%>
<%@ page import="gap.report.filemanage.util.IReportFileConstants"%>
<fmt:bundle basename="gap.report.report_resource" prefix="gap.report.">
<% //判断是否为修改页面
        boolean isModify = false; //定义变量,标识本页面是否修改(或者新增)
        if (request.getParameter("isModify") != null) { //如果从request获得参数"isModify"不为空
            isModify = true; //赋值isModify为true
        }

        String parent_code = request.getParameter("parent_code");
        if (parent_code == null) { //如果从request获得参数"parent_code"为空
            return;
        }
        String parent_type = request.getParameter("parent_type");
%>
<html>
<head>
<script src="<%=request.getContextPath()%>/js/rm-insert.js"
	type=text/javascript></script>
<script
	src="<%=request.getContextPath()%>/jsp/include/FCKeditor/fckeditor.js"
	type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">
	function isEmpty(str){
 		for(var i=0;i<str.length;i++){
 			 if(str.charAt(i)!==" "){
   				 return false;
 			 }
 		}
		return true;
	}
	function insert_onClick(){  //插入单条数据
		var str=form.uploadfile.value;
		if(!isEmpty(str) && !(str.indexOf(".rptdesign",0)!=-1 )){
			alert(i18n_report.upload_format_error);    
			return false;
		}
    	form.action="<%=request.getContextPath()%>/ReportFileAction.do?cmd=insertFile";
    	form.target="_parent";
	    form.submit();
	}
  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		var str=form.uploadfile.value;
		if(!isEmpty(str) && !(str.indexOf(".rptdesign",0)!=-1 )){
			alert(i18n_report.upload_format_error);    
			return false;
		}
	    form.action="<%=request.getContextPath()%>/ReportFileAction.do?cmd=updateFile";
	    form.target="_parent";
    	form.submit();
	}
</script>
</head>
<body>
<form name="form" enctype="multipart/form-data" method="post">

<table class="table_noFrame">
	<tr>
		<td><input name="button_save" class="button_ellipse" type="button"
			value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>'
			onClickTo="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>">
		<input name="button_cancel" class="button_ellipse" type="button"
			value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:history.go(-1)"></td>
	</tr>
</table>

<div id="auDivParent1">
<table class="table_div_control">
	<tr>
		<td><img src="<%=request.getContextPath()%>/images/icon/07-0.gif"
			class="div_control_image"
			onClick="javascript:hideshow('auDivChild1',this,'<%=request.getContextPath()%>/')"><%=isModify ? "<fmt:message key='modify'  bundle='${applicationResources}'></fmt:message>" : "<fmt:message key='add'  bundle='${applicationResources}'></fmt:message>"%><%=IReportFileConstants.TABLE_NAME_CHINESE%>
		</td>
	</tr>
</table>
</div>

<div id="auDivChild1">
<table class="table_div_content">
	<tr>
		<td>
		<table class="table_div_content_inner">
			<tr>
				<td width="70" align="right">&nbsp;</td>
				<td align="left">&nbsp;</td>
			</tr>
			<%if (!isModify) {%>
			<!--如果是新增页面-->
			<tr>
				<td align="right"><fmt:message key="filemanage.parent_part"/></td>
				<td align="left"><input type="text" class="text_field_readonly"
					name="parent_name" 
					value="<%=request.getParameter("parent_name")%>" maxlength="30" />
				</td>
			</tr>
			<%}%>
			<tr>
				<td align="right"><fmt:message key="filemanage.status"/></td>
				<td align="left"><input type="radio" name="enable_status" value="1"
					checked><fmt:message key="filemanage.enable"/> <input type="radio" name="enable_status" value="0"><fmt:message key="filemanage.disable"/></td>
			</tr>
			<tr>
				<td align="right"><span class="style_required_red">* </span><fmt:message key="filemanage.report_name"/></td>
				<td align="left"><input type="text" class="text_field" name="name"
					value="" maxLength="150" validate="notNull;isSearch" />
				</td>
			</tr>
			<tr>
				<td align="right"><fmt:message key="filemanage.report_author"/></td>
				<td align="left"><input type="text" class="text_field" name="author"
					value="" maxLength="150" validate="isSearch" /></td>
			</tr>
			<tr>
				<td align="right"><span class="style_required_red">* </span><fmt:message key="filemanage.function_description"/></td>
				<td align="left"><textarea class="textarea_limit_words" cols="60"
					rows="5" name="help" maxLength="150" id="helpId"
					validate="notNull;isSearch"></textarea></td>
			</tr>
			<tr>
				<td align="right"><fmt:message key="filemanage.upload_file"/></td>
				<td align="left"><input type="file" class="text_field"
					name="uploadfile" value="" maxLength="500" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<input type="hidden" name="code" value=""> <!--自编码--> <input
	type="hidden" name="parent_code" value="<%=parent_code%>"><!--父编码--> <input
	type="hidden" name="total_code" value=""> <!--全编码--> <input
	type="hidden" name="hot_key" value=""> <!--快捷键--> <input type="hidden"
	name="is_leaf" value="1"> <!--是否叶子--> <input type="hidden" name="type"
	value="2"> <!--报表类型--> <input type="hidden" name="type_is_leaf"
	value="1"> <!--类型内是否叶子--> <input type="hidden" name="order_code"
	value=""> <!--排序编码--> <input type="hidden" name="create_date" value="">
<!--添加时间--> <input type="hidden" name="modify_date" value=""> <!--修改时间-->
<input type="hidden" name="id" value=""> <!--主键--> <input type="hidden"
	name="url"><!--主键--></form>
</body>
<% //取出要修改的那条记录，并且回写表单
        if (isModify) { //如果本页面是修改页面
            out.print("<script language=\"javascript\">\n"); //输出script的声明开始
            ReportFileVo resultVo = null; //定义一个临时的vo变量
            if (request.getAttribute(IReportFileConstants.REQUEST_BEAN_VALUE) != null) { //如果request中取出的bean不为空
                resultVo = (ReportFileVo) request.getAttribute(IReportFileConstants.REQUEST_BEAN_VALUE); //从request中取出vo, 赋值给resultVo
            }
            if (resultVo != null) { //如果vo不为空
                out.print(VoHelperTools.writeBackMapToForm(VoHelperTools.getMapFromVo(resultVo))); //输出表单回写方法的脚本
                out.print("writeBackMapToForm();\n"); //输出执行回写方法
            }
            out.print("</script>"); //输出script的声明结束
        }
%>
</fmt:bundle>
</html>
