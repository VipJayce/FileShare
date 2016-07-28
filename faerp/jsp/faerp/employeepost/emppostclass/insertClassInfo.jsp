<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.emimpempinfo.vo.EmimpempinfoVo" %>
<%@ page import="rayoo.employeepost.emimpempinfo.util.IEmimpempinfoConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EmimpempinfoVo resultVo = null;  				//定义一个临时的vo变量
	boolean isModify = false;  							//定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  										//赋值isModify为true
		if(request.getAttribute(IEmimpempinfoConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EmimpempinfoVo)request.getAttribute(IEmimpempinfoConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传</title>
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
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=uploadClassFile&filetype="+filetype;
        form.submit();
    }
}
	
	
	
	

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	   if(checkAllForms())
	   {
		    form.action="<%=request.getContextPath()%>/EmimpempinfoAction.do?cmd=update";
		   	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=impClass";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post"   enctype="multipart/form-data">
<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng">
						<table width="100%" height="40" border="0" cellpadding="0"	 cellspacing="1" bgcolor="#c5dbe2">

							<tr>
								<td class="td_1">导入文件</td>
								<td class="td_2 "><input type="file" id="fileInput"		name="file1" validate="notNull;" inputName="导入文件"></td>
							</tr>
						</table>
						<div class="mx_button">
					         <input type="button" class="icon_2" value='上传' onClick="javascript:insert_onClick()" />
					        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>	 
					     </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
