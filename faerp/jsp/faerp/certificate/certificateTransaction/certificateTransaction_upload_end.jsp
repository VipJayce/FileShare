<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="java.util.*" %>
<%@page import="gap.rm.tools.helper.RmJspHelper;"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 
<title>导入查询数据结果</title>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
</head>
<body>
    <table>
        <tr>
            <td>${msg == null ? "上传成功" :  msg}</td>
            <td><button onClick="myclose();">关闭</button></td>
        </tr>
    </table>
    
</body>
<script type="text/javascript">
      function myclose() {
        window.returnValue="1";//刷新父页面
        window.close();
      };
      
      $(window).unload( function () {  
        window.returnValue="1";//刷新父页面 TOTEST
      });
</script>
</html>