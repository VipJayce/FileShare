<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<html>
<head>
<script>
    function save_onClick(){  //文件上传
        if(frm.filename.value==null || frm.filename.value==""){
            alert("没有选择的文件名。");
            return;
        }
        <%
            String filePath="";
            if(request.getParameter("filePath") != null) {
                filePath= request.getParameter("filePath").toString();
            }
        %>
        if(frm.filename.value.indexOf("expert.xml")>=0){
            frm.action="<venus:base/>/UpLoadFileEmploy.do?cmd=upLoadFile&filePath=<%=filePath%>";
        }else{
	        frm.action="<venus:base/>/UpLoadFile.do?cmd=upLoadFile&filePath=<%=filePath%>";
        }
        frm.submit();
    }
</script>

</head>
<body>
<script language="javascript">
    writeTableTop('文件上传','<venus:base/>/');
</script>

<form name="frm" enctype="multipart/form-data" method="post" action="<venus:base/>/UpLoadFile.do?cmd=upLoadFile&filePath=<%=filePath%>">
<div id="ccChild0"> 
<table class="table_div_content">
<tr nowrap>
    <td align="right" nowrap width="100em">上传文件路径</td>
    <td nowrap width="200em">
        <input name="filename" type="file" size="40" class="text_field_reference" inputName="上传并保存索引" validate="isSearch"/>
    </td>
    <td align="left" nowrap><input name="save"  class="button_ellipse" type="button" onClick="javascript:save_onClick();" value="上传"/></td>
</tr>
</table>
</div>
</form>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</body>
</html>