<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<head>
<meta charset="gb2312" content="text/html;" http-equiv="Content-Type" />
<script language="javascript">

function switchSysBar(){
if (parent.document.getElementById('mainframe').cols=="200,10,*"){
document.getElementById('midFrame').style.display="";
parent.document.getElementById('mainframe').cols="0,10,*";
}
else{
parent.document.getElementById('mainframe').cols="200,10,*";
document.getElementById('midFrame').style.display="none"
}
}
function load(){
if (parent.document.getElementById('mainframe').cols=="0,10,*"){
document.getElementById('midFrame').style.display="";
}
}

</script>
</head>
<body marginwidth="0" marginheight="0" bgcolor="#000000" onload="load()"
	topmargin="0" leftmargin="0">
<center>
<table height="100%" cellspacing="0" cellpadding="0" border="0"
	width="100%">
	<tbody>
		<tr>
			<td bgcolor="#009fef" width="1"><img height="1" width="1"
				src="images/ccc.gif" /></td>
			<td id="midFrame" bgcolor="#f5f4f4" style="display: none;"><a
				onclick="switchSysBar()" href="javascript:void(0);"> <img
				height="90" border="0" width="9" alt='<fmt:message key="controldata.expand_leftmenu"/>'
				src="<%=request.getContextPath()%>/images/dd/right.gif" /> </a></td>
			<td id="rightbar" bgcolor="#f5f4f4"><a onclick="switchSysBar()"
				href="javascript:void(0);"> <img height="90" border="0"
				width="9" alt='<fmt:message key="controldata.hide_leftmenu"/>'
				src="<%=request.getContextPath()%>/images/dd/left.gif" /> </a></td>
		</tr>
	</tbody>
</table>
</center>
</body>
</fmt:bundle>
</html>
