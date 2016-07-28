<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.authority.util.GlobalConstants" %>
<%@ page import="gap.authority.service.sys.vo.SysParamVo" %>
<%@ taglib uri="/WEB-INF/sslext.tld" prefix="sslext"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 
	
 

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
 
<%
	}
	String message = (String)request.getAttribute("Message");
	if(message!=null && ! message.equals("")) {
		out.println("<script language='javascript'>alert('"+message+"')</script>");
	}
	String errorType = request.getParameter("errorType");//错误标志
	 
%>

<title>FESCO Adecco ERP系统</title>
<link href="<%=request.getContextPath()%>/css/common.css" rel="stylesheet" type="text/css" />
 
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

function fTrim(str)
    {
     str=str.replace(/\'/g,""); 
    str=str.replace(/\"/g,"");
    return str;
    }
    
function onFrmSubmit()
{
    loginForm.login_id.value=fTrim(loginForm.login_id.value);
    loginForm.password.value=fTrim(loginForm.password.value);
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
  if (window != top) 
      top.location.href = location.href; 
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


<%
 
	 
	//if(message!=null && ! message.equals("")) {
	//	out.println("<script language='javascript'>alert('"+message+"')</script>");
	//}
 
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
</head>


  

<body oncontextmenu="return false">
<form name="loginForm" method="post"  onsubmit="return onFrmSubmit();" target="_parent" action="<%=request.getContextPath()%>/LoginAction.do">

 

<input type="hidden" name="login_mac" value="">
<div id="login">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="login_left">&nbsp;</td>
    <td class="login_bg">
    	 <div class="login_box">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td style="font-weight:bold; font-size:13px; color:#fff;">用户名</td>
            <td style="padding-left:10px;"><input name="login_id" type="text"   tabindex="1"  value="" style="width:150px"/></td>
            </tr>
          <tr>
            <td style="font-weight:bold;font-size:13px; color:#fff;">密&nbsp;&nbsp;码</td>
            <td style="padding-left:10px;"><input  name="password" type="password"    tabindex="2" value="" style="width:150px"/></td>
            </tr>
          <tr>
            <td>&nbsp;</td>
            <td style="padding-left:10px;">
              <input type="submit" value="登录" class=" 
login_input" style="font-weight:bold;font-size:13px; "/>
              <input type="reset" value="重置" class=" login_input" style="font-weight:bold;font-size:13px; "/> 
              </td>
          </tr>
        </table>
      </div>
    </td>
    <td class="login_right">&nbsp;</td>
  </tr>
</table>
<div style="position:absolute;width:100px;height:100px;z-indent:2;left:900px;top:430px;font-weight:Axure Handwriting; font-size:15px; color:#919191;">Version&nbsp;2.3.80</div>

</div>
</form>
<script language="javascript">
    document.loginForm.login_id.focus();
</script>
</body>
</html>

