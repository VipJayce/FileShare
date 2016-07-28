<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<style type="text/css">
<!--
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    overflow:hidden;
}
-->
.navPoint { COLOR: white; CURSOR: hand; FONT-FAMILY: Webdings; FONT-SIZE: 9pt } 
-->
</style>
<script>
function switchSysBar(){ 
var locate=location.href.replace('middel.jsp','');
var ssrc=document.all("img1").src.replace(locate,'');
if (ssrc=="images/main_55.gif")
{ 
document.all("img1").src="images/main_55_1.gif";
document.all("frmTitle").style.display="none" 
} 
else
{ 
document.all("img1").src="images/main_55.gif";
document.all("frmTitle").style.display="" 
} 
} 


function SetWinHeight(obj)
{
	var win=obj;
	if (document.getElementById)
	{
		if (win && !window.opera) 
		{
			if (win.contentDocument && win.contentDocument.body.offsetHeight) 
				win.height = win.contentDocument.body.offsetHeight; 
			else if(win.Document && win.Document.body.scrollHeight)
				win.height = win.Document.body.scrollHeight;
		}
	}
}

</script>

</head>

<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" 
  <tr>
    <td width="155" id=frmTitle noWrap name="fmTitle" align="center" valign="top">
    <table width="121" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
      <tr>
        <td  bgcolor="#198bca" style="width:5px;">&nbsp;</td>
        <td width="150" valign="top"><iframe name="I1" height="100%" width="150" src="left.jsp" border="0" frameborder="0" scrolling="yes"></iframe></td>
      </tr>
    </table>		</td>
    <td width="6"  style="width:6px;"valign="middle" bgcolor="198bca" onclick=switchSysBar()><SPAN class=navPoint 
id=switchPoint title=关闭/打开左栏><img src="images/main_55.gif" name="img1"  id=img1></SPAN></td>
    <td width="100%" align="center" valign="top"><iframe id="contentFrame" name="contentFrame" height="100%" width="100%" border="0" frameborder="0" src="<%=request.getContextPath() %>/TabannounceinfoAction.do?cmd=queryAll1" scrolling="yes"></iframe></td>
  </tr>
</table>
</body>
</html>
