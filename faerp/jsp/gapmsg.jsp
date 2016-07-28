<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<logic:notEmpty  name="local_in_sesson_key" scope="session">
    <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
</logic:notEmpty>
<fmt:setBundle basename="ApplicationResources" scope="application" var="applicationResources"/>
<fmt:setBundle basename="gap.message.message_resource" scope="application" var="applicationMessageResources"/>

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
        <form name="formMsg" method="post" action="<%=request.getContextPath()%>/MessageLoginController.do">
          <table width="722" height="322" border="0" align="center" cellpadding="0" cellspacing="0" background="<%=request.getContextPath()%>/images/index/Limit2_1.gif">
            <tr>
              <td valign="top"><br />
                  <br />
                  <table width="53%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="9%" height="23">&nbsp;</td>
                      <td width="91%" valign="bottom"><img src="<%=request.getContextPath()%>/images/login/in_id.gif" width="348" height="40" /><br />
                          <br />
                          <span class="leftfont_Content"><fmt:message key='gap.message.Quick_Login' bundle='${applicationMessageResources}' />: <a href="<%=request.getContextPath()%>/MessageLoginController.do?VENUS_PARTY_ID=1000000000000000002&VENUS_PARTY_NAME=马子华"> 马子华</a> |<a href="<%=request.getContextPath()%>/MessageLoginController.do?VENUS_PARTY_ID=1000000000000000003&VENUS_PARTY_NAME=夏金鑫"> 夏金鑫</a> | <a href="<%=request.getContextPath()%>/MessageLoginController.do?VENUS_PARTY_ID=1000000000000000005&VENUS_PARTY_NAME=马啸"> 马 啸</a> |<a href="<%=request.getContextPath()%>/MessageLoginController.do?VENUS_PARTY_ID=1000000000000000008&VENUS_PARTY_NAME=向琼"> 向 琼</a> | <a href="<%=request.getContextPath()%>/MessageLoginController.do?VENUS_PARTY_ID=1000000000000000009&VENUS_PARTY_NAME=臧键">臧 键</a></span><br />
                          <br />
                          <br />
                          <br />
                          <br />
                          <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                              <td width="89"><img src="<%=request.getContextPath()%>/images/login/gapb1.gif" width="15" height="16" /> <fmt:message key='gap.message.Login' bundle='${applicationMessageResources}' /> I D<fmt:message key='gap.message._' bundle='${applicationMessageResources}' /><br /></td>
                              <td width="147" class="in_id"><input name="VENUS_PARTY_ID" type="text" class="in_pass" /></td>
                              <td width="64"><a href="<%=request.getContextPath()%>/jsp/msgbox/organization/orgModel.jsp"><img src="<%=request.getContextPath()%>/images/index/see_1.gif" width="110" height="24" style="border:0" /></a></td>
                            </tr>
                            <tr>
                              <td><img src="<%=request.getContextPath()%>/images/login/gapb2.gif" width="15" height="16" /> <fmt:message key='gap.message.Login_name_' bundle='${applicationMessageResources}' /></td>
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
                                <fmt:message key='gap.message._0' bundle='${applicationMessageResources}' /> 
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
        <td align="center" class="leftfont_Content"><fmt:message key='gap.message.All_rights_reserved' bundle='${applicationMessageResources}' />&copy; <fmt:message key='gap.message.UFIDA_Software_Engineering' bundle='${applicationMessageResources}' /> UFIDA All rights reserved. <fmt:message key='gap.message.Recommended' bundle='${applicationMessageResources}' />IE6.0<fmt:message key='gap.message.Above_browsers' bundle='${applicationMessageResources}' /> 1024*768 <fmt:message key='gap.message.Resolution' bundle='${applicationMessageResources}' /></td>
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
<!-- </center> -->
</body>
</html>
<script language="javascript">
try {
	parent.parent.frames[1].funcTreeFrame.location.reload();
} catch(e) {
	//alert("No Frameset.");
}
</script>

