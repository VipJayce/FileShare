<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="gap.authority.login.tools.OnlineUserVo" %>
<%@ page import="gap.commons.xmlenum.EnumRepository" %>
<%@ page import="gap.commons.xmlenum.EnumValueMap" %>
<%@ page import="gap.authority.service.profile.model.UserProfileModel" %>
<%@ page import="gap.authority.service.sys.vo.SysParamVo" %>
<jsp:useBean id="onlineuser" class="gap.authority.login.tools.OnLineUser" scope="application"/>
<%  

	session = request.getSession(false);
	String login_mac = (String)session.getAttribute("login_mac");
	String session_id = session.getId(); 
	if( gap.authority.login.tools.OnLineUser.isNewLogin(session_id) ) {
		String login_id = LoginHelper.getLoginId(request);//获得登录账号
		if ( null == login_id ){
			%><script>
			window.location.href="<%=request.getContextPath()%>/jsp/login/login.jsp";
		</script><%
			return;
		}
		String name = LoginHelper.getLoginName(request);//获得用户姓名
		Timestamp loginTime = new Timestamp(session.getCreationTime());//获得session创建时间
		String ip = request.getRemoteAddr();//获得客户端的ip地址
		String host = request.getRemoteHost();//获得客户端电脑的名字，若失败，则返回客户端电脑的ip地址 
		String agent = request.getHeader("user-agent");
		String browser = null;
		String os = null;
	    if(agent.contains("Mozilla/5.0")){
	        if(agent.contentEquals("MSIE")){
                StringTokenizer st = new StringTokenizer(agent,";"); 
                st.nextToken(); 
                browser = st.nextToken(); //得到用户的浏览器名 
                os = st.nextToken(); //得到用户的操作系统名 
            }else{
                StringTokenizer st = new StringTokenizer(agent,"(");
                st.nextToken();
                os = new StringTokenizer(st.nextToken(),")").nextToken(); //得到用户的操作系统名
                if(os.contains(";")){
                    os = os.substring(0,os.indexOf(";"));   
                }
                String allTokens = agent.replaceAll("\\(.*?\\)","");
                String tokens[] = allTokens.split("\\s+");
                browser = tokens[2]; //得到用户的浏览器名 
            }
	    }else{
	        StringTokenizer st = new StringTokenizer(agent,";"); 
            st.nextToken(); 
            browser = st.nextToken(); //得到用户的浏览器名 
            os = st.nextToken(); //得到用户的操作系统名 
	    }
		
	    boolean isAdmin = LoginHelper.getIsAdmin(request);
		
		OnlineUserVo vo = new OnlineUserVo();
		vo.setLogin_id(login_id);
		vo.setName(name);
		vo.setLogin_ip(ip);
		vo.setParty_id(LoginHelper.getPartyId(request));
		vo.setIe(browser);
		vo.setOs(os);
		vo.setHost(host);
		vo.setLogin_time(loginTime);
		vo.setSession_id(session_id);
		vo.setUserSession(session);
		vo.setIsAdmin(isAdmin);
		vo.setLogin_state(venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Login_successful_"));
		vo.setLogin_mac(login_mac);
		session.setMaxInactiveInterval(GlobalConstants.getSessionTimeOut());
		session.setAttribute("OnlineUserVo",vo); 
		session.setAttribute(session_id,onlineuser); 
		session.setAttribute("VENUS_PARTY_ID",LoginHelper.getPartyId(request));
		session.setAttribute("VENUS_PARTY_NAME",name);
	}
	EnumRepository er = EnumRepository.getInstance();
    er.loadFromDir();
    EnumValueMap pwdtimes = er.getEnumValueMap("Au_UserProfile");
    UserProfileModel profile = new UserProfileModel(LoginHelper.getPartyId(request));
    int changPwdTimes = Integer.parseInt(null==profile.snapshotValue(pwdtimes.getValue("CHANGEPWDTIMES"))?"0":profile.snapshotValue(pwdtimes.getValue("CHANGEPWDTIMES")));
    int showchangepwd = Integer.parseInt(null==profile.snapshotValue(pwdtimes.getValue("SEECHANGEPWDAGAIN"))?"0":profile.snapshotValue(pwdtimes.getValue("SEECHANGEPWDAGAIN")));
    SysParamVo changePwdVo = GlobalConstants.getSysParam("CHANGEPASSWORD");
    int changePwd = Integer.parseInt(null==changePwdVo?"0":changePwdVo.getValue());
    SysParamVo funcMenuType = GlobalConstants.getSysParam(GlobalConstants.FUNCMENUTYPE);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GAP <fmt:message key='gap.authority.Organizational_competence_system' bundle='${applicationAuResources}' /></title>
<script>

try {
	window.moveTo(0,0);
	window.resizeTo(screen.availWidth,screen.availHeight);
	if (window.self != window.top) {
		window.open(this.location, "_top");
	}
	
	document.onmousedown = function(){
		event.cancelBubble;
	}
	
	document.onkeydown = function() {
		event.cancelBubble;
	}
	
} catch(e) {
	alert(e.message);
}

function logout(event) {
	if(window.screenLeft>=10000 && window.screenTop>=10000 || event.clientX >360 && event.clientY<0 || event.altKey) {
		 window.location.href="<%=request.getContextPath()%>/jsp/login/login.jsp?isExit=1";
	}
}

function changePassWord(){
    <%if((0==changPwdTimes&&1==changePwd&&0==showchangepwd)||(0==changPwdTimes&&2==changePwd)){%>
        window.showModalDialog("<%=request.getContextPath()%>/jsp/authority/au/auuser/forceModifyPasswordFrame.jsp?changePwd=<%=changePwd%>", 
            new Object(),'dialogWidth=640px;dialogHeight=480px;resizable:yes;status:no;scroll:no;');
    <%}%>    
}
</script>

</head>
<% if (funcMenuType != null && "1".equals(funcMenuType.getValue())) { %>
<!-- 三级菜单 -->
<frameset onload="javascript:changePassWord();" onUnload="javascript:logout(event);" name="totalFrameSet" rows="99,70,*" frameborder="no" scrolling="NO" border="0" framespacing="0">
    <frame id="topFrame"  src="<%=request.getContextPath()%>/jsp/homepage/top.jsp" scrolling="no" noresize>
    <frame id="headFrame"  src="<%=request.getContextPath() %>/jsp/authority/menu/topMenu.jsp" scrolling="no" noresize>
    <frameset id="subMainFrameSet" name="subMainFrameSet" rows="*" cols="185,11,*" framespacing="0" frameborder="NO" border="0">
        <frame id="funcTreeFrame"  name="funcTreeFrame" class="frameTR" src=""  frameborder="no" scrolling="no" noresize>
        <frame id="controlFrame"  name="controlFrame" class="frameLR" src="<%=request.getContextPath() %>/jsp/authority/menu/control.jsp" frameborder="no" scrolling="no" noresize >
        <frame id="contentFrame" name="contentFrame" class="frameLT" src="<%=request.getContextPath() %>/jsp/homepage/contentFrame.jsp" frameborder="no" scrolling="auto" noresize>
    </frameset>
</frameset> 
<%} else { %>
<!-- 默认的页面布局-->
<frameset onload="javascript:changePassWord();" onUnload="javascript:logout(event);" name="totalFrameSet" rows="99,*,0" frameborder="no" scrolling="NO" border="0" framespacing="0">
  <frame src="<%=request.getContextPath()%>/jsp/homepage/top.jsp" name="headFrame" scrolling="NO" noresize id="headFrame">
  <frame src="<%=request.getContextPath()%>/jsp/homepage/centerframe.htm" name="mainFrame" frameborder="no" scrolling="auto" noresize id="mainFrame">
  <frame src="<%=request.getContextPath()%>/jsp/homepage/hidden.htm" name="hiddenFrame" frameborder="no" scrolling="no" noresize id="hiddenFrame">
</frameset>
<%} %>
<noframes><body></body></noframes>
</html>

