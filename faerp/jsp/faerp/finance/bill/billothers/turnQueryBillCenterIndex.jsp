<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
<style>
   body{
        overflow-y:hidden;
    }
 </style>
</head>
<body>
<iframe id = "referenceContent" name="referenceContent" src="${requestScope.frameUrl}"
	width="100%"> </iframe>
<script type="text/javascript">
    var height = document.documentElement.clientHeight;
    document.getElementById("referenceContent").height = height +"px";
</script>
</html>