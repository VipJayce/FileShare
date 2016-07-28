<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/jsp/include/global.jsp" %>
<%
	String filePath="";
	if(request.getParameter("filePath") != null) {
	    filePath= request.getParameter("filePath").toString();
	}
%>
</head>
<body>
<iframe src="operateFile.jsp?filePath=<%=filePath %>" frameBorder=0 scrolling=yes style="width:100%;height:100%" ></iframe></body>
</html>