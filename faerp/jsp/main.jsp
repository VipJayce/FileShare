<%@ page contentType="text/html; charset=UTF-8"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/index.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/common.js"></script>
<script type="text/javascript" src="../js/jquery/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="../js/jquery/q_box.js"></script>
<link id="skin" href="../css/q_box_style.css" rel="stylesheet"  type="text/css" />
<script>
    jQuery(document).ready(function () {
         getSystemMessage();//登录系统是查询一次之后  每5分钟一查询
         setInterval("getSystemMessage()",300000);//5分钟查一次 create by  sqp
					//setInterval这个函数会根据后面定义的1000既每隔1秒执行一次前面那个函数
        			 //如果你用局部刷新，要用AJAX技术
       	 setInterval("queryBillBatchStatus()",30000);//30s查一次 查询是否有可下载账单 add by lbd
       });
            
    function startRequest()
    {
        window.open ('/FAERP/index/im-index.jsp','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
    }

  //查询是否有可下载账单 add by lbd
    function queryBillBatchStatus(){
        var u='/FAERP/FinbillAction.do?cmd=queryBillBatchStatus'; 
        jQuery.ajax({
            type:"post",
            url:u,
            data:null,
            success:function(msg){
                if(msg!=null&&msg!=""){ 
                    var html=msg;   
                    jQuery.gBox.message({Title:"温馨提示",Content:html,Width:400,Time:1000},290000);  //窗口最多存在4.8分钟
                }
            }
        });
    }
  
	   function getSystemMessage(){//Create by sqp
	  var u='/FAERP/TabannounceinfoAction.do?cmd=systemRemind1'; 
          jQuery.ajax({
            type:"post",
            url:u,
            data:null,
            success:function(msg){
            if(msg!=null&&msg!=""){ 
                var html=msg;   
             jQuery.gBox.message({Title:"温馨提示",Content:html,Width:400,Time:1000},290000);  //窗口最多存在4.8分钟
             }
            }
        });
	}
	
	function getMessage(){
	    var u='/FAERP/SmsSenderAction.do?cmd=msgNotice'; 
	          jQuery.ajax({
	            type:"post",
	            url:u,
	            data:null,
	            success:function(msg){ 
		            if(msg == 1){
		            	
		            }else{
		            	var html=msg;   
		            	jQuery.gBox.message({Title:"温馨提示",Content:html,Width:250,Time:1000},10000);  
		           	}
	            }
	     });
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FESCO Adecco ERP系统</title>
</head>

<frameset rows="52,27,*,26" frameborder="no" border="0" framespacing="0">
  <frame src="top.jsp" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" />
  <frame src="seat.jsp" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" />
  <frame src="middel.jsp" name="contents" id="contents">
  <frame src="down.jsp" name="bottomFrame" scrolling="no" noresize="noresize" id="bottomFrame" />
  
</frameset>
<noframes> <body>
</body>
</noframes></html>

