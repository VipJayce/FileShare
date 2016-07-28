<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,java.util.*" errorPage="" %>
<%request.setCharacterEncoding("gb2312");%>
<%@page pageEncoding="GB2312"%>
<%
String ServerIP = request.getServerName();

String sPageName = "reporting.jsp";
String sHost =  request.getHeader("Host");
String sRAdd = request.getRequestURI(); 
	sRAdd = sRAdd.substring(0,sRAdd.length()-sPageName.length());
    String BaseUrl = "Http://" + sHost + request.getContextPath()+"/";
%>
<html>
<head>
	<script language="javascript">
		var BaseUrl = <%=BaseUrl%>;
	</script>
		
</head>
<body  onload="soaOpen();window.focus();" onunload="soaClose();">
<script language="javascript">
	var bDocOpen = false;
	function soaOpen() 
	{ 
		try {
			/////////////  ????  ///////////////////////////////////////
			formData.SOAOfficeCtrl.SaveDocURL ="/jsp/report/xls/SaveDoc.jsp";      //
			formData.SOAOfficeCtrl.WebOpen("reporting.xls",2,"Someone");  // 
			////////////////////////////////////////////////////////////
		}
		catch (e)
		{

		}
	} 
	function soaClose()
	{
		try {
			if (bDocOpen)
				formData.SOAOfficeCtrl.Close();
			return true; 
		} 
		catch (e) 
		{ 
			alert("关闭文档失败!\n错误信息："+e.message); 
			return false; 
		} 
	}
</script>
		<SCRIPT language="JavaScript" event="OnDocumentOpened(str, obj)" for="SOAOfficeCtrl">
			bDocOpen = true;
		</SCRIPT>
		<SCRIPT language="JavaScript" event="OnDocumentClosed()" for="SOAOfficeCtrl">
			bDocOpen = false;
		</SCRIPT>
<form name="formData" method="post"  id="formData">
	<OBJECT id="SOAOfficeCtrl" codeBase="<%=BaseUrl%>ocx/SOAOffice.ocx#version=3,1,1,0" height="100%" width="100%" classid="clsid:BBD0982A-63C3-4105-B7AF-5FF3E2649082" data="">
	<param name="Server" value="<%=ServerIP%>">
	<param name="ServerPort" value="4357">
	<param name="Caption" value= 北京用友软件工程有限公司>
	<SPAN STYLE="color:red">未能载入SOAOfficeCtrl文档控件。请在安装控件的提示对话框里确认安装，才能使用本控件的功能。</SPAN>
	</OBJECT>
</form>
</body>
</html>