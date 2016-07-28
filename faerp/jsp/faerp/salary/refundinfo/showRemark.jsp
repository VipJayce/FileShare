<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class="box_xinzeng" style="margin:0px;height:80px;" >
    <p style="font-size: 12px;font-family: Tahoma,Arial,Helvetica,sans-serif;text-align: center;">重新生成的批次号为：${code}</p>
    <input name="button_ok" class="icon_1"   type="button" value='确定' onClick="window.close();" style="text-align: center;margin-left: 60px;">
</div>
</body>
</html>
