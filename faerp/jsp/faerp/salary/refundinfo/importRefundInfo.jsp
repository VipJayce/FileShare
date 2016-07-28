<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<%
String message = "";
if(request.getAttribute("message")!=null){
    message = (String)request.getAttribute("message");
}
%>
<script language="javascript">

function downloadModel(){  //下载模板
        form.action="<%=request.getContextPath()%>/RefundInfoAction.do?cmd=downLoadBatchRefund";
        form.submit();
    }
    
 function insert_onClick(){  //插入单条数据
     var file1=document.form.file1.value.trim();
     file1=file1.substring(file1.lastIndexOf(".")+1);
     if(file1!="xls"&&file1!="xlsx"){
              alert("文件类型必须为excel！");
             return ;
     }
        
    if(checkAllForms()){
	     //设置16:15时间点
	    var timePoint = new Date();
	    timePoint.setHours(16);
	    timePoint.setMinutes(15);
	    timePoint.setSeconds(0);
	    
	    //给申请发放日期设置默认值
	    _now = new Date();
	    if(_now.getTime() > timePoint.getTime()){
	        _now.setDate(_now.getDate()+1);
	        /*
	        if(!window.confirm("<fmt:message key='alert_long_msg_1'/>")){
	            return;
	        };*/
	    }
    
    
        form.action="<%=request.getContextPath()%>/RefundInfoAction.do?cmd=insert&apply_pay_time="+dateToString(_now);
        form.submit();
    }
}
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/RefundInfoAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post"   enctype="multipart/form-data">

<div id="right">
<script language="javascript">
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>

 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >导入文件</td>
            <td class="td_2 ">
                <input type="file" id="fileInput" name="file1"  validate="notNull;"  inputName="导入文件"  >
            </td>
        </tr>

    </table>
 
    <div class="mx_button">
        <input type="button" class="icon_2" value='下载模板' onClick="javascript:downloadModel()" />
         <input type="button" class="icon_2" value='批量导入' onClick="javascript:insert_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        
        
        
        </div>
        
        <div>
       <%=message %>
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

