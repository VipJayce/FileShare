<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ page import="gap.report.util.VoHelperTools"%>
<%@ page import="gap.report.util.StringHelperTools"%>
<%@ page import="gap.report.filemanage.vo.ReportFileVo"%>
<%@ page import="gap.report.filemanage.util.IReportFileConstants"%>
<%@ taglib uri="/WEB-INF/gap-authority.tld" prefix="au"%>
<fmt:bundle basename="gap.report.report_resource" prefix="gap.report.">
<%
	//取出本条记录
	ReportFileVo resultVo = null; //定义一个临时的vo变量
	resultVo = (ReportFileVo) request
			.getAttribute(IReportFileConstants.REQUEST_BEAN_VALUE); //从request中取出vo, 赋值给resultVo
	VoHelperTools.replaceToHtml(resultVo); //把vo中的每个值过滤
	String type = resultVo.getType();
%>
<%@page import="java.net.URLEncoder"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript">
    function find_onClick(){  //直接点到修改页面
        var parent_code = document.form.parent_code.value;
        form.action="<%=request.getContextPath()%>/ReportFileAction.do?cmd=find&parent_code="+parent_code;
        form.submit();
    }
    function delete_onClick(){  //直接点删除单条记录
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        form.action="<%=request.getContextPath()%>/ReportFileAction.do?cmd=delete";
        form.target="_parent";
        form.submit();
    }  
    function toAddFolder_onClick() {  //到增加栏目页面
        var total_code = document.form.total_code.value;
        var name = document.form.name.value;
        var type = document.form.type.value;
        window.location="<%=request.getContextPath()%>/jsp/report/filemanage/insertReportFolder.jsp?parent_code="+total_code+"&parent_name="+name+"&parent_type="+type;



    }
    function toAddFile_onClick() {  //到增加报表页面
        var total_code = document.form.total_code.value;
        var name = document.form.name.value;
        var type = document.form.type.value;
        window.location="<%=request.getContextPath()%>/jsp/report/filemanage/insertReportFile.jsp?parent_code="+total_code+"&parent_name="+name+"&parent_type="+type;



    }
    function toSort_onClick() {  //到排序页面
        var total_code = document.form.total_code.value;
        var name = document.form.name.value;
        window.location="<%=request.getContextPath()%>/jsp/report/filemanage/sortReportFile.jsp?parent_code="+total_code+"&parent_name="+name;



    }
    function toPreview_onClick() {  //到预览页面
        var total_code = document.form.total_code.value;
        var url = document.form.url.value;
        var name = document.form.name.value;
        window.open("<%=request.getContextPath()%>/frameset?__report="+url);
    }
</script>
</head>
<body>

<form name="form" method="post">

<table class="table_div_control">
	<tr>
		<td><img src="<venus:base/>/images/icon/07-0.gif"
			class="div_control_image"
			onClick="javascript:hideshow('auDivChild',this,'<venus:base/>/')">&nbsp;<%
			if (type.equals("1")) {
		%><fmt:message key="filemanage.part_info"/><%
			} else {
		%><fmt:message key="filemanage.report_info"/><%
			}
		%>
		</td>
		<%
			if (type.equals("1")) {
		%>
		<td>
		<table align="right">
			<tr>
				<td class="button_ellipse"
					onClick="javascript:toAddFolder_onClick();"<!--au:authorityBtn code="addfolder" type="1"/-->
				<img src="<venus:base/>/images/icon/add.gif"
					class="div_control_image"><fmt:message key="filemanage.add_new_part"/></td>
				<td class="button_ellipse"
					onClick="javascript:toAddFile_onClick(); "<!--au:authorityBtn code="addfile" type="1"/--><img
					src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key="filemanage.add_new_report"/></td>
				<td class="button_ellipse" onClick="javascript:find_onClick();"<!--au:authorityBtn code="modifyfolder" type="1"/--><img
					src="<venus:base/>/images/icon/modify.gif"
					class="div_control_image"><fmt:message key="modify"  bundle="${applicationResources}"></fmt:message></td>
				<td class="button_ellipse" onClick="javascript:delete_onClick();"<!--au:authorityBtn code="deletefolder" type="1"/-->
				<img src="<venus:base/>/images/icon/delete.gif"
					class="div_control_image"><fmt:message key="delete"  bundle="${applicationResources}"></fmt:message></td>
				<td class="button_ellipse" onClick="javascript:toSort_onClick();"><img
					src="<venus:base/>/images/icon/refresh.gif"
					class="div_control_image"><fmt:message key="sort"  bundle="${applicationResources}"></fmt:message></td>
				<td class="button_ellipse" onClick="javascript:history.go(-1);"><img
					src="<venus:base/>/images/icon/return.gif"
					class="div_control_image"><fmt:message key="return"  bundle="${applicationResources}"></fmt:message></td>
			</tr>
		</table>
		</td>
		<%
			} else {
		%>
		<td>
		<table align="right">
			<tr>
				<td class="button_ellipse" onClick="javascript:find_onClick();"<!--au:authorityBtn code="modifyfile" type="1"/--><img
					src="<venus:base/>/images/icon/modify.gif"
					class="div_control_image"><fmt:message key="modify"  bundle="${applicationResources}"></fmt:message></td>
				<td class="button_ellipse" onClick="javascript:delete_onClick();"<!--au:authorityBtn code="deletefile" type="1"/-->
				<img src="<venus:base/>/images/icon/delete.gif"
					class="div_control_image"><fmt:message key="delete"  bundle="${applicationResources}"></fmt:message></td>
				<td class="button_ellipse" onClick="javascript:toSort_onClick(); "><img
					src="<venus:base/>/images/icon/refresh.gif"
					class="div_control_image"><fmt:message key="sort"  bundle="${applicationResources}"></fmt:message></td>
				<td class="button_ellipse" onClick="javascript:toPreview_onClick();"><img
					src="<venus:base/>/images/icon/preview.gif"
					class="div_control_image"><fmt:message key="preview"  bundle="${applicationResources}"></fmt:message></td>
				<td class="button_ellipse" onClick="javascript:history.go(-1);"><img
					src="<venus:base/>/images/icon/return.gif"
					class="div_control_image"><fmt:message key="return"  bundle="${applicationResources}"></fmt:message></td>
			</tr>
		</table>
		</td>
		<%
			}
		%>
	</tr>


</table>
<br>
<div id="auDivChild">
<table border="1" bordercolordark="#FFFFFF" bordercolorlight="#7EBAFF"
	cellpadding="5" cellspacing="0" width="98%" align="center">
	<%
		if (type.equals("1")) {
	%>
	<!--如果是目录-->
	<tr>
		<td width="70" align="right"><fmt:message key="filemanage.part_name"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getName())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.part_code"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getTotal_code())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.part_info"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getHelp())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.creator"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getAuthor())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.create_time"/></td>
		<td align="left" bgcolor="#FFFFFF" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getCreate_date(), 16)%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.modify_time"/></td>
		<td align="left" bgcolor="#FFFFFF" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getModify_date(), 16)%></td>
	</tr>
	<%
		} else if (type.equals("2")) {
	%>
	<!--如果是报表文件-->
	<tr>
		<td width="70" align="right"><fmt:message key="filemanage.report_name"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getName())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.report_code"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getTotal_code())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.report_author"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getAuthor())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.function_description"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getHelp())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.status"/></td>
		<td align="left" bgcolor="#FFFFFF">&nbsp;<%=resultVo.getEnable_status().equals("1") ? "<fmt:message key=\"filemanage.enable\"/>"
						: "<fmt:message key=\"filemanage.disable\"/>"%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.file_path"/></td>
		<td align="left" bgcolor="#FFFFFF" style="word-break: break-all">&nbsp;<%=StringHelperTools.prt(resultVo.getUrl())%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.create_time"/></td>
		<td align="left" bgcolor="#FFFFFF" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getCreate_date(), 16)%></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="filemanage.modify_time"/></td>
		<td align="left" bgcolor="#FFFFFF" bgcolor="#FFFFFF">&nbsp;<%=StringHelperTools.prt(resultVo.getModify_date(), 16)%></td>
	</tr>
	<%
		}
	%>
</table>
</div>
<input type="hidden" name="id"
	value="<%=StringHelperTools.prt(resultVo.getId())%>"> <input
	type="hidden" name="type"
	value="<%=StringHelperTools.prt(resultVo.getType())%>"> <input
	type="hidden" name="total_code"
	value="<%=StringHelperTools.prt(resultVo.getTotal_code())%>"> <input
	type="hidden" name="name"
	value="<%=StringHelperTools.prt(resultVo.getName())%>">
<input type="hidden" name="parent_code"
	value="<%=StringHelperTools.prt(resultVo.getParent_code())%>">
<input type="hidden" name="url"
	value="<%=StringHelperTools.prt(resultVo.getUrl())%>"></form>
</body>
</fmt:bundle>
</html>

