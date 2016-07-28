<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.authority.util.GlobalConstants" %>
<%@ page import="gap.authority.service.sys.vo.SysParamVo" %>
<%@ taglib uri="/WEB-INF/sslext.tld" prefix="sslext"%>
<%@ include file="/jsp/include/global.jsp" %>
<%
	String isExit = request.getParameter("isExit");//注销标志
	String login_id = (String)session.getAttribute(gap.authority.util.GlobalConstants.getCasFilterUser());
	
	if(login_id!=null) {//如果是通过单点登录过来的
		if("1".equals(isExit)) {
			try{
	            session.invalidate();
	        }catch(Exception e) {
	            //e.printStackTrace();
	        }
			String logoutUrl = gap.authority.util.GlobalConstants.getPortalLogoutUrl();
			response.sendRedirect(logoutUrl);
		}				
%>
	<script language="javascript">
		window.location.href="<%=request.getContextPath()%>/LoginAction.do?login_id=<%=login_id%>&isPortalLogin=1";
	</script>
<%
	}
	if("1".equals(isExit)) {//如果是注销
		try{
		    session.invalidate();
        }catch(Exception e) {
            //e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath()+"/jsp/login/login.jsp");
	}
%>
<logic:notEmpty  name="local_in_sesson_key" scope="session">
    <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
</logic:notEmpty>
<fmt:setBundle basename="ApplicationResources" scope="session" var="applicationResources"/>
<fmt:setBundle basename="gap.authority.authority_resource" scope="session" var="applicationAuResources"/>
<%
	//校验码
    SysParamVo checkCodeVo = GlobalConstants.getSysParam("CHECKCODE");
    String checkCode = null==checkCodeVo?"":checkCodeVo.getValue();
    
    SysParamVo loginStgVo = GlobalConstants.getSysParam(GlobalConstants.LOGINSTRATEGY);
    String loginStg = null==loginStgVo?"":loginStgVo.getValue();
	
	if(gap.authority.helper.LoginHelper.getLoginId(request)!=null) {//如果是已经登录的
%>
	<script language="javascript">
		window.location.href="<%=request.getContextPath()%>/jsp/main.jsp";//index.jsp";//openNewWindow
	</script>
<%
	}
	String message = (String)request.getAttribute("Message");
	if(message!=null && ! message.equals("")) {
		out.println("<script language='javascript'>alert('"+message+"')</script>");
	}
	String errorType = request.getParameter("errorType");//错误标志
	if("1".equals(errorType)) {
%>
	<script language="javascript">
		alert("<fmt:message key='gap.authority.You_are_logged_in_the_system_or_login_has_timed_out_please_re_login_system_' bundle='${applicationAuResources}' />")
		window.top.location.href="<%=request.getContextPath()%>/jsp/login/login.jsp";
	</script>
<%
	}else if("2".equals(errorType)) {
	    %>
	    <script language="javascript">
	        alert("<fmt:message key='gap.authority.Access_denied_please_contact_the_administrator_' bundle='${applicationAuResources}' />")
	        window.top.location.href="<%=request.getContextPath()%>/jsp/login/login.jsp";
	    </script>
	<%
	}
%>
<title>GAP <fmt:message key='gap.authority.Organizational_competence_system' bundle='${applicationAuResources}' /></title>
<link href="../css/gap31_mainstyle.css" type="text/css" rel="stylesheet" charset='UTF-8'>
<style type="text/css">
<!--

body {
	font-size: 12px;
	background-image: url(<%=request.getContextPath()%>/images/login/Login1_1.gif);
	color: #1264A0;
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
}-->
</style>
<script language="javascript">
<!--
document.onkeydown=function(event) {
    var event = (event) ? event : ((window.event) ? window.event : "")
    var key = event.keyCode ? event.keyCode:event.which;
    if( key == 13 ) {
        //if(!(navigator.userAgent.toLowerCase().match(/chrome\/([\d.]+)/)))// not chrome
        if(onFrmSubmit()){
          document.forms.loginForm.submit();
        }
        //}
    }
}

function onFrmSubmit()
{
	if(loginForm.login_id.value == "") {
		alert("<fmt:message key='gap.authority.Please_enter_a_user_name_' bundle='${applicationAuResources}' />");
		loginForm.login_id.focus();
		return false;
	}
	if(loginForm.password.value == "") {
		alert("<fmt:message key='gap.authority.Please_enter_your_password_' bundle='${applicationAuResources}' />");
		loginForm.password.focus();
		return false;
	}
	return true;
}

function onFrmReset()
{
	loginForm.reset();
}

function register()
{
	var topValue=screen.width/2-400;
	var leftValue=screen.height/2-70;
	window.open("<%=request.getContextPath()%>/jsp/login/register.jsp","newwindow","height=500, width=350, top="+topValue+", left="+leftValue+",toolbar=no,menubar=no,resizable=yes,location=no,status=no");
}

function showHelp()
{
	//window.open("<%=request.getContextPath()%>/htm/index.html");
}

function crml(nid) 
{ 
	try { 
		nid=new ActiveXObject("Agent.Control.2"); 
		nid.Connected = true; 
		nid.Characters.Load(""); 
		return nid;
	} 
	catch (err) { 
		return false; 
	}
}

function chplay () 
{ 
	if (ml=crml ("ml"))
	{ 
		var MerlinID; 
		var MerlinACS; 
		Merlin = ml.Characters.Character(MerlinID); 
		Merlin.MoveTo(700,400);
		Merlin.Show(); 
		Merlin.Play("Explain"); 
		
		Merlin.Speak("<fmt:message key='gap.authority.Welcome_to_the_system_' bundle='${applicationAuResources}' />"); 
		Merlin.Play("Announce"); 
		Merlin.Speak("<fmt:message key='gap.authority.Thank_you_' bundle='${applicationAuResources}' />");
		Merlin.Play("Announce"); 
		Merlin.Speak("<fmt:message key='gap.authority.Wish_you_a_happy_work_' bundle='${applicationAuResources}' />");
		Merlin.Play("Surprised"); 
		
		//Merlin.Hide();
	}
} 
function doLoginSubmit() {
    if(onFrmSubmit()){
        document.forms.loginForm.submit();
    }
}
//-->
</script>
<script>
function freshImage(){
	var t=new Date(); 
	document.getElementById("validateimg").src="<%=request.getContextPath()%>/jcaptcha?time="+t;
}

function enableScript() {
	window.location = "<%=request.getContextPath()%>/jsp/login/download.jsp?type=1";
}

function undoScript() {
	window.location = "<%=request.getContextPath()%>/jsp/login/download.jsp?type=0";
}
</script>
<% 
	SysParamVo loginStrategy = GlobalConstants.getSysParam(GlobalConstants.LOGINSTRATEGY);
	if (loginStrategy != null && "1".equals(loginStrategy.getValue())) {
%>
<object id=locator classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 viewastext></object>
<object id=clientObj classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></object>
<script language="javascript">
   var service = locator.ConnectServer();
   var MACAddr ;
   service.Security_.ImpersonationLevel=3;
   service.InstancesOfAsync(clientObj, 'Win32_NetworkAdapterConfiguration');
</script>
<script language="javascript" event="OnCompleted(hResult,pErrorObject, pAsyncContext)" for=clientObj>
	document.forms[0].login_mac.value = unescape(MACAddr);
</script> 
<script language="javascript" event=OnObjectReady(objObject,objAsyncContext) for=clientObj>
   if(objObject.IPEnabled != null && objObject.IPEnabled != undefined && objObject.IPEnabled == true) {
	    if(objObject.MACAddress != null && objObject.MACAddress != "undefined")
	    	MACAddr = objObject.MACAddress;
    }
</script>
<% } %>
</head>

<body oncontextmenu="return false">

<sslext:form name="loginForm" method="post" onsubmit="return onFrmSubmit();" target="_parent" action="/LoginAction.do" >
<input type="hidden" name="login_mac" value="">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
	
<table width="700" height="54" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="5" height="5" valign="top"><img src="<%=request.getContextPath()%>/images/login/Loginangle1_1.gif" width="5" height="5" /></td>
    <td width="690" valign="top" bgcolor="#D0EAFC"></td>
    <td width="5" align="center" valign="top"><img src="<%=request.getContextPath()%>/images/login/Loginangle1_2.gif" width="5" height="5" /></td>
  </tr>
  <tr>
    <td bgcolor="#D0EAFC"></td>
    <td height="57" bgcolor="#D0EAFC"><img src="<%=request.getContextPath()%>/images/login/ufida_logo1<au:i18next/>.gif" width="291" height="26"/></td>
    <td bgcolor="#D0EAFC"></td>
  </tr>
</table>
<table width="720" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="7"><img src="<%=request.getContextPath()%>/images/login/Loginangle2_1.gif" width="7" height="7" /></td>
    <td width="706" valign="top" background="<%=request.getContextPath()%>/images/login/Loginangle2_5.gif"><img src="<%=request.getContextPath()%>/images/login/Loginangle2_5.gif" width="1" height="7" /></td>
    <td width="7"><img src="<%=request.getContextPath()%>/images/login/Loginangle2_2.gif" width="7" height="7" /></td>
  </tr>
  <tr>
    <td height="96" valign="top" background="<%=request.getContextPath()%>/images/login/Loginangle2_6.gif"><img src="<%=request.getContextPath()%>/images/login/Loginangle2_9.gif" width="7" height="293" /></td>
    <td bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="14%" valign="top"><p><img src="<%=request.getContextPath()%>/images/login/Loginleft.gif" height="292" /></p>
          </td>
        <td width="77%"><p>&nbsp;</p>
          <p>&nbsp;</p>
          <p>&nbsp;</p>
          <p><img src="<%=request.getContextPath()%>/images/login/gap31<au:i18next/>.gif" width="252" height="62" /><br />
              <br />
			  <br />
           </p>
          <table width="82%" border="0" align="center">
            <tr valign="middle">
              <td width="24"><img src="<%=request.getContextPath()%>/images/login/gapb1.gif" width="15" height="16" /></td>
              <td class="in_id"><input name="login_id" type="text" class="in_pass"  maxLength="50" tabindex="1" autocomplete="off"/></td>
              <td width="49"><img src="<%=request.getContextPath()%>/images/login/in_Login<au:i18next/>.gif" onClick="javascript:doLoginSubmit();"  style="cursor:hand"  tabindex="4"/></td>
            </tr>
            <tr valign="middle">
              <td><img src="<%=request.getContextPath()%>/images/login/gapb3.gif" width="15" height="16" /></td>
              <td class="in_id"><input name="password" type="password" class="in_pass"  maxLength="50" tabindex="2" autocomplete="off"/></td>
              <td><img src="<%=request.getContextPath()%>/images/login/in_Resetting<au:i18next/>.gif" onClick="document.forms.loginForm.reset();"  style="cursor:hand"  tabindex="5"></td>
            </tr>
            <%if("true".equals(checkCode)){%>
            <tr valign="middle">
              <td valign="top"><img src="<%=request.getContextPath()%>/images/login/gapb2.gif" width="15" height="16" /></td>
              <td valign="top" class="in_id"><input type='text' name='j_captcha_response' class="in_pass"  maxLength="50" tabindex="3" autocomplete="off"></td>
              <td><img id="validateimg" src="<%=request.getContextPath()%>/jcaptcha" alt="<fmt:message key='gap.authority.Click_Refresh' bundle='${applicationAuResources}' />"  onClick="javascript:freshImage();"  style="cursor:hand"  tabindex="6"></td>
            </tr> 
            <%}%>  
            <%if("1".equals(loginStg)){%>
			<tr>
				<td><img src="<%=request.getContextPath()%>/images/login/script.png" width="15" height="16" /></td>
				<td>&nbsp;<a href="javascript:enableScript();" title="<fmt:message key='gap.authority.Log_exclusive_feature_is_enabled_on_a_trusted_site_to_allow_the_implementation_of' bundle='${applicationAuResources}' />ActiveX<fmt:message key='gap.authority.Control_Script' bundle='${applicationAuResources}' />"><fmt:message key='gap.authority.Enable_scripting' bundle='${applicationAuResources}' /></a>&nbsp;&nbsp;<a href="javascript:undoScript();" title="<fmt:message key='gap.authority.Disable_log_mutex_function_restoration_of_trusted_sites' bundle='${applicationAuResources}' />ActiveX<fmt:message key='gap.authority.Control_Script' bundle='${applicationAuResources}' />"><fmt:message key='gap.authority.Recovery_script' bundle='${applicationAuResources}' /></a></td>
				<td></td>
			</tr>        
			<%}%>  
          </table>
          <br />
          <br />
          <br /></td>
        <td width="9%"><img src="<%=request.getContextPath()%>/images/login/Loginrig.gif" width="382" height="255" /></td>
      </tr>
    </table></td>
    <td background="<%=request.getContextPath()%>/images/login/Loginangle2_7.gif"></td>
  </tr>
  <tr>
    <td height="7"><img src="<%=request.getContextPath()%>/images/login/Loginangle2_4.gif" width="7" height="7" /></td>
    <td valign="baseline" background="<%=request.getContextPath()%>/images/login/Loginangle2_8.gif"><img src="<%=request.getContextPath()%>/images/login/Loginangle2_8.gif" width="1" height="7" /></td>
    <td><img src="<%=request.getContextPath()%>/images/login/Loginangle2_3.gif" width="7" height="7" /></td>
  </tr>
</table>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="28" bgcolor="#D0EAFC">&nbsp;</td>
    <td width="690" bgcolor="#D0EAFC"><fmt:message key='gap.authority.All_rights_reserved' bundle='${applicationAuResources}' /> &copy;2010 <fmt:message key='gap.authority.UF_Software_Engineering_Co_Ltd_Beijing' bundle='${applicationAuResources}' />  &copy;2010 USE All rights reserved. </td>
    <td width="5" align="center" bgcolor="#D0EAFC">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="<%=request.getContextPath()%>/images/login/Loginangle1_4.gif" width="5" height="5" /></td>
    <td bgcolor="#D0EAFC"></td>
    <td><img src="<%=request.getContextPath()%>/images/login/Loginangle1_3.gif" width="5" height="5" /></td>
  </tr>
</table>
<br>
<br>
<br>
<br>
<br>
<br>
	
	</td>
  </tr>
</table>
</sslext:form>
<script language="javascript">
    document.loginForm.login_id.focus();
</script>
</body>
</html>

