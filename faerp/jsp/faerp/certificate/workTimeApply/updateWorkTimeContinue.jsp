<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle
	basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh"
	prefix="rayoo.certificate.certificateTransaction.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
	<title><fmt:message key="credentialsType_maintenance" /></title>
	<script language="javascript">
    //保存
    function save_onClick(){  //保存
            var url;
                  url= '<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=updateWorkTimeNotContinue';
                jQuery.ajax({
                           url:url,
                           type: 'POST',
                           dataType: 'html',
                           data:encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true)),
                           async: false,
                           timeout: 10000,
                                success: function(data){
                                data=eval("("+data+")");
                                    if(data.status=='false'){
			                                returnValue = ["2"];
								            window.close();
								            window.opener.insertcallBack(returnValue);
                                   }
                                   else{
		                                       returnValue = ["0"];
		                                       window.close();
		                                       window.opener.insertcallBack(returnValue);
                                   }
                               }
                           });      
    }
    
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
</script>
	</head>
	<body>
	<form name="form" method="post" id="datacell_formid">
		 <input	type="hidden" name="statusCellValues" id="statusCellValues"> 
		 <input	type="hidden" name="materiaCellValues" id="materiaCellValues">
	<div id="right" style="height: 140px;"><script
		language="javascript">
        writeTableTopFesco("<fmt:message key='notContinue'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
    String ids=request.getParameter("ids");
 %>
 <input type="hidden" name="id" value="<%=ids %>"/>
	<div class="ringht_x" style="height: 70px;">
	<div id="ccChild1" class="box_xinzeng" style="height: 70px;">
	<table width="100%" height="40" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="25%"><fmt:message key='explain' /></td>
			<td class="td_2 " colspan="3"><input type="text" name="explain" maxlength="400" style="width: 700px;"/></td>
		</tr>
	</table>
	</div>
	<div></div>
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
	<input type="button" class="icon_2" value='<fmt:message key="save"/>' 	onClick="javascript:save_onClick()" /> 
	<input type="button"	class="icon_2" value='<fmt:message key="go_back"/>' 	onClick="javascript:cancel_onClick()" /></div>
	</form>
</fmt:bundle>
</body>
</html>
