<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename='rayoo.customerservice.custservice.hirefire.hirefire.applyformsg_resource' prefix='auto.'>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='applyformsg0000'/></title>
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="form">
<div id="right">
<div class="ringht_s">
    <textarea rows="8" cols="43" id="applymsg" name="apply" onkeyup="countChar();"></textarea>
</div>
<fmt:message key='applyformsg0001'/><span id="surplus">400</span><fmt:message key='applyformsg0002'/>
<div align="center"><input type="button" value="<fmt:message key='applyformsg0003'/>" onclick="clickclose();"/></div>
</form>
</body>
</fmt:bundle>
</html>
<script language="javascript">
    function clickclose() {
        var msg = _$("#applymsg").val();
        window['returnValue'] =  msg;
        window.close();
    }
    function countChar() {
        var totalLength = 400;
        var content = _$("#applymsg").val();
        var currentLength = content.length;
        var count = parseFloat(totalLength) - parseFloat(currentLength);
        if (count <= 0 ) {
            var text = content.substring(0, 400);
            _$("#applymsg").val(text);
            count = 0;
        }
        _$("#surplus").text(count);
    }
</script>