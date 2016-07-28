<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="java.net.URLEncoder" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="<%=request.getContextPath()%>/js/common/TaskMenu.js"></script>
<script>
//TaskMenu.setStyle("<%=request.getContextPath()%>/css/Blue/blueStyle.css");
</script>
<link href="<%=request.getContextPath()%>/css/gap31_mainstyle.css" type="text/css" rel="stylesheet" charset='UTF-8'>
<style type="text/css">
<!--
a:link {
	color: #0082C5;
	text-decoration: none;
}
a:visited {
	color: #0082C5;
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
.in_id{
	background-image: url(<%=request.getContextPath()%>/images/login/in_id.gif);
	height: 18px;
	width: 108px;
	background-repeat: no-repeat;
}
.in_pass{
	border: 0px;
	width:108px;
	background-color:transparent;
}
-->
</style></head>
<body>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="45" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=request.getContextPath()%>/images/templatestyle/main0_04.jpg">
      <tr>
        <td width="420" valign="top" class="indextitlebg">&nbsp;</td>
        <td background="<%=request.getContextPath()%>/images/templatestyle/main0_04.jpg"><img src="<%=request.getContextPath()%>/images/templatestyle/main0_04.jpg" width="2" height="45" /></td>
        <td width="403" align="right" class="indextitlebg_right">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center" valign="top"><br>
        <br>
        <br>
        <br>
        <form name="formAlex" method="post" action="<%=request.getContextPath()%>/LoginController.do">
          <table width="722" height="322" border="0" align="center" cellpadding="0" cellspacing="0" background="<%=request.getContextPath()%>/images/index/Limit2_1.gif">
            <tr>
              <td valign="top"><br />
                  <br />
                  <table width="53%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="9%" height="23">&nbsp;</td>
                      <td width="91%" valign="bottom"><img src="<%=request.getContextPath()%>/images/index/dil_workflow1.gif" width="348" height="40" /><br />
                          <br />
                          <span class="leftfont_Content">快速登录: <a href="<%=request.getContextPath()%>/LoginController.do?VENUS_PARTY_ID=1000000000000000002&VENUS_PARTY_NAME=<%=URLEncoder.encode("马子华","GBK")%>"> 马子华</a> |<a href="<%=request.getContextPath()%>/LoginController.do?VENUS_PARTY_ID=1000000000000000003&VENUS_PARTY_NAME=<%=URLEncoder.encode("夏金鑫","GBK")%>"> 夏金鑫</a> | <a href="<%=request.getContextPath()%>/LoginController.do?VENUS_PARTY_ID=1000000000000000006&VENUS_PARTY_NAME=<%=URLEncoder.encode("刘国华","GBK")%>"> 刘国华</a> |<a href="<%=request.getContextPath()%>/LoginController.do?VENUS_PARTY_ID=1000000000000000001&VENUS_PARTY_NAME=<%=URLEncoder.encode("郭鹏","GBK")%>"> 郭 鹏</a> </span><br />
                          <br />
                          <br />
                          <br />
                          <br />
                          <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                              <td width="89"><img src="<%=request.getContextPath()%>/images/login/gapb1.gif" width="15" height="16" /> 登录 I D：<br /></td>
                              <td width="147" class="in_id"><input name="VENUS_PARTY_ID" type="text" class="in_pass" /></td>
                              <td width="64"><a href="<%=request.getContextPath()%>/jsp/flowdesign/orgModel.jsp"><img src="<%=request.getContextPath()%>/images/index/see_1.gif" width="110" height="24" style="border:0" /></a></td>
                            </tr>
                            <tr>
                              <td><img src="<%=request.getContextPath()%>/images/login/gapb2.gif" width="15" height="16" /> 登录名称：</td>
                              <td class="in_id"><input name="VENUS_PARTY_NAME" type="text" class="in_pass" /></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                              <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td><input type="image" name="btnSubmit" src="<%=request.getContextPath()%>/images/login/in_Login.gif" onClick="this.form.submit();" ></td>
                                    <td><img src="<%=request.getContextPath()%>/images/login/in_Resetting.gif" onClick="document.forms.formAlex.reset();"  style="cursor:hand" ></td>
                                  </tr>
                                </table>
                                　 
                              </td>
                              <td>&nbsp;</td>
                            </tr>
                          </table>
                        <br /></td>
                    </tr>
                </table></td>
            </tr>
          </table>
          <br/>
        </form></td>
  </tr>
  <tr>
    <td align="center" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>&nbsp;</td>
        <td align="center" class="leftfont_Content">版权所有&copy; 用友软件工程 UFIDA All rights reserved. 建议使用IE6.0以上浏览器 1024*768 分辨率</td>
        <td align="right">&nbsp;</td>
      </tr>
      <tr>
        <td width="11" valign="bottom"><img src="<%=request.getContextPath()%>/images/templatestyle/main0_15.gif" width="11" height="11"></td>
        <td>&nbsp;</td>
        <td width="11" align="right" valign="bottom"><img src="<%=request.getContextPath()%>/images/templatestyle/main0_18.gif" width="11" height="11"></td>
      </tr>
    </table></td>
  </tr>
</table>


<b></b>
<!--</center>  -->
</body>
</html>
<script language="javascript">
try {
	parent.parent.frames[1].funcTreeFrame.location.reload();
} catch(e) {
	alert("No Frameset.");
}
</script>