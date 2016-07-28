<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.ppsuserloginemailmanager.vo.PpsuserloginemailmanagerVo" %>
<%@ page import="rayoo.pps.ppsuserloginemailmanager.util.IPpsuserloginemailmanagerConstants" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%  //判断是否为修改页面
	PpsuserloginemailmanagerVo resultVo = null;  //定义一个临时的vo变量
	if(request.getAttribute(IPpsuserloginemailmanagerConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
	    resultVo = (PpsuserloginemailmanagerVo)request.getAttribute(IPpsuserloginemailmanagerConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
  	function update_onClick(){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		var action="<%=request.getContextPath()%>/PpsuserloginemailmanagerAction.do?cmd=update";
        var myAjax = new Ajax(action);
	    myAjax.addParam('userEmail', document.getElementById("userEmail").value);        
	    myAjax.addParam('userCard', document.getElementById("userCard").value);        
        myAjax.submit();
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
              alert(""+myAjax.getProperty("returnValue"));
              window['returnValue'] = ""+myAjax.getProperty("returnValue");
              window.close();
              window.opener.simpleQuery_onClick();
         }
	}

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post">
<div id="right">
 <div class="ringht_s">
 <div class="social_tab">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" width="25%">用户名称</td>
			<td class="td_2 "width="25%">
				<input type="text" class="text_field" name="userName" id="userName" inputName="用户名称" readonly="readonly" value="" />
			</td>
			<td class="td_1" width="25%">用户身份证</td>
			<td class="td_2" width="25%"><input type="text" class="text_field" name="userCard" id="userCard" inputName="用户身份证" readonly="readonly" value="" /></td>
		</tr>
		<tr>
			<td class="td_1">用户唯一号</td>
			<td class="td_2"><input type="text" class="text_field" name="userSole" id="userSole" inputName="用户唯一号" readonly="readonly" value="" /></td>
			<td class="td_1">用户email</td>
			<td class="td_2"><input type="text" class="text_field" name="userEmail" id="userEmail" inputName="用户email" value="" /></td>
		</tr>
	</table>
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:update_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
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
<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
%>
</script>
