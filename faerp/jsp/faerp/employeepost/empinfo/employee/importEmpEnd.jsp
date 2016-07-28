<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<html>
<fmt:bundle basename="rayoo.employeepost.empinfo.employee.employee_resource" prefix="rayoo.employeepost.empinfo.employee.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 
<title>importExcel</title>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>
</head>
<body>
    <table>
        <tr>
            <td>${msg == null ? "上传成功" :  msg}</td>
            <td><button onClick="myclose();"><fmt:message key="close"/></button></td>
        </tr>
    </table>
    
</body>
<script type="text/javascript">
      function myclose() {
        window.returnValue="1";//刷新父页面
        window.close();
      }
      
      $(window).unload( function () {  
        window.returnValue="1";//刷新父页面 TOTEST
      });
</script>
</fmt:bundle>
</html>