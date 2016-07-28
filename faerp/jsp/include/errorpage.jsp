<%@ page isErrorPage="true" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body bgcolor=#dae7f8>

<a href="#" onClick="history.go(-1)">返回</a>

<h1>JSP页面异常信息</h1>
请求的URL:<%=request.getRequestURL()%>

异常类型：<%
if (exception != null){ 

    out.print(exception.getClass());
}
%>
<br>
异常描述:<%
if (exception != null){ 
    out.print(exception.getMessage());
}

%>
<br>
异常堆栈:<br>
<pre>
<%
			
		    java.io.PrintWriter pw = response.getWriter();
if (exception != null){ 
			exception.printStackTrace(pw);
}

%>
</pre>

</body>
</html>