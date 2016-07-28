<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导入党员缴费单</title>
<script language="javascript">
    function leading_in()
    {
        var attachName = document.getElementById("attachNameInput").value;
        if(attachName==null&&attachName=="")
        {
            alert("上传文件不能为空，请选择上传的附件！");
            return ;
        }
        else
        {
            var  length = attachName.lastIndexOf(".");
            var postfix = attachName.substring(length+1,attachName.length);
            if(postfix!="xls")
            {
                alert("上传的文件不是Excel，请重新选择！");
                document.getElementById("attachNameInput").value="";
                return ;
            }
        else  if (checkAllForms())
        {
             form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?cmd=importToExcel";
             form.submit();
        }
        }
    }
    
    ///////陈旭添加 导入模板下载
    function downLoad_onClick(){
        form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?cmd=downLoadExcel";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post"  enctype="multipart/form-data">

    	<div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 

</div>

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="30" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	   <tr>
	   <td class="td_1"  style="width: 200px;">Excel格式：</td>
            <td class="td_2">党支部编号&nbsp;姓名&nbsp;开始月&nbsp;截止月&nbsp;党费&nbsp;捐款&nbsp;</td>
	   </tr>
		<tr>
			<td class="td_1"  style="width: 200px;"> 附件上传：</td>
			<td class="td_2">   
			<input type="file"  id="attachNameInput" name="attachNameInput"/>
			</td>
		</tr>
	</table>
</div>


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='模板下载' onClick="javascript:downLoad_onClick();">
<input type="button" class="foot_icon_1" value='上传'  onclick="javascript:leading_in();" />
<input type="button" class="foot_icon_1" value='关闭'  onclick="javascript:window.close();" />
</div>


</div>


	 </div>

</form>
</fmt:bundle>
</body>
</html>
