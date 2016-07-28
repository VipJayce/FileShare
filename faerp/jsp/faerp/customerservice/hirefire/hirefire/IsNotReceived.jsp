<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function submit_onClick(){
    	var action="<%=request.getContextPath()%>/HirefireAction.do?cmd=NotReceived";
        var myAjax = new Ajax(action);
        var isReceived = document.getElementsByName("isReceived");
        var isReceivedstr;
        for(var i = 0; i<isReceived.length;i++){
        	if(isReceived[i].checked){
        		isReceivedstr = isReceived[i].value;
        	}
        }
        myAjax.addParam('ids', document.form.ids.value);
        myAjax.addParam('isReceived', isReceivedstr);        
        myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if(returnNode) {
	        if(myAjax.getValue("root/data/returnValue")==1) {
	            alert('操作成功！');
	            window.close();
	        } else {
	            alert('操作失败！');
	        }
	    } else {
	        alert('操作失败！');
	    }
    }
    
</script>
</head>
<body>
<form name="form" method="post">
<input type="hidden" name="ids" id="ids" value="${ids }"/>
<div id="right">
<div class="ringht_s">
<div id="ccChild0" class="box_3"> 
  	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	  <tr>
	    <td class="td_1" style="width: 30%;">是否收到退工单</td>
	    <td class="td_2">
	        未收到 <input type="radio" name="isReceived" id="isReceived" value="1" checked="checked"> 已收到 <input type="radio" name="isReceived" id="isReceived" value="0">   
	    </td>
	  </tr>
    </table>
</div>
    
<div class="foot_button">
<input type="button" class="foot_icon_1" value='确定'  onclick="javascript:submit_onClick();" />
</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
