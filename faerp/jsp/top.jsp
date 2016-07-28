<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FESCO Adecco ERP系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<script>

function modifyPassword() {
        var url = "<%=request.getContextPath()%>/jsp/authority/au/auuser/modifyPasswordFrame.jsp?_ts="+(new Date()).getTime();
        window.showModalDialog(url, new Object(),'dialogWidth=440px;dialogHeight=300px;resizable:yes;status:no;scroll:no;');
        //showModalCenter(url, window, "", 450, 350, "修改密码"); 
}
</script>
</head>
<body>
<div id="header">
	<div class="header_top">
        <div class="out">
			<a href="main.jsp" target="_parent" class="fh">返回首页</a>
			<a href="###" onClick="javascript:modifyPassword();"  class="xgmm">修改密码</a>
            <a href="login/login.jsp?isExit=-1" target="_parent" class="tc">退出</a>
        </div>
    </div>
</div>
</body>
</html>
