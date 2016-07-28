<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
 function insert_onClick(){  //插入单条数据
     var file1=document.form.file1.value.trim();
     file1=file1.substring(file1.lastIndexOf(".")+1);
     if(file1!="xls"&&file1!="xlsx"){
              alert("文件类型必须为excel！");
             return ;
     }
        
    if(checkAllForms()){
        var filetype =  $("input[name=filetype]:checked").val();
        form.action="<%=request.getContextPath()%>/VatCostCenterDataInitAction.do?cmd=upload&filetype="+filetype;
        form.submit();
    }
}
</script>
</head>
<body>

<form name="form" method="post" enctype="multipart/form-data">
	<div id="right">
		<div id="ccChild1" class="box_xinzeng"> 
			<table width="90%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
				<tr>
					<td class="td_1" >导入类型</td>
					<td class="td_2 ">
					    <input type="radio" name="filetype" value="1" checked> 更新成本中心基本信息
					    <input type="radio" name="filetype" value="2" > 更新成本中心代收付附加税配置
					    <input type="radio" name="filetype" value="3" ><font color="red">代收付附加税配置初始化</font> 
					</td>
				</tr>
				<tr>
					<td class="td_1" >导入文件</td>
					<td class="td_2 ">
						<input type="file" id="fileInput" name="file1"  validate="notNull;" inputName="导入文件"  >
					</td>
				</tr>
			</table>
		   
		    <div class="mx_button">
				<input type="button" class="icon_2" value='上传' onClick="javascript:insert_onClick()" />
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