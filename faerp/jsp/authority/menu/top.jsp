<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="venus.frames.i18n.util.LocaleHolder"%>
<%String currentLang =  LocaleHolder.getLocale().getLanguage();%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Organizational_competence_platform' bundle='${applicationAuResources}' /></title>
<style>
<!--
body,table,td{
    font-size:12px;
}

A.white {
	text-decoration: none;
	color:#ffffff;
}
A.white:link {
	text-decoration:none;
	color:#ffffff;
}
A.white:visited {
	font-size: 9pt;
	color: #ffffff;
	text-decoration: none;
	font-family: "Arial";
}
A.white:Hover {
	position: relative;
	left: 0px;
	top: 0px;
	color:#ffffff;
}
-->
</style>
<script language="javascript" src="<%=request.getContextPath() %>/js/jquery/jquery-1.3.min.js"></script>
<script type="text/javascript">
	function modifyPassword() {
	    window.showModalDialog("<%=request.getContextPath() %>/jsp/authority/au/auuser/modifyPasswordFrame.jsp", 
	        new Object(),'dialogWidth=640px;dialogHeight=480px;resizable:yes;status:no;scroll:no;');
	}
	
function changeLocal(local){
        if(!local||local=="") return;
        var url = "<%=request.getContextPath() %>/jsp/common/changeLocal.jsp?local="+local;
        jQuery.ajax({url:url,async:false,cache:false});
        top.window.location.reload();
}	
</script>
</head>
<body>
<table  background="<%=request.getContextPath() %>/images/au/topline_bg.gif" style="border-right: gray 0px solid; border-top: gray 0px solid; border-left: gray 0px solid; border-bottom: gray 0px solid" cellSpacing=0 cellPadding=0 width="100%" >
  	<tbody>
	  <tr>
	    <td width=694 height=28 ><img src="<%=request.getContextPath() %>/images/au/logo.gif" width="286" height="25"></TD>
	    <td align=right vAlign=middle style="font-size: 9pt;" >
	    <table <%if("zh".equals(currentLang)) { %> width="260" <% } else { %> width="400" <% } %>  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td style="color:#FFFFFF"><img src="<%=request.getContextPath() %>/images/au/home.gif" width="16" height="16" align="absmiddle"> <a href="<%=request.getContextPath() %>/jsp/main.jsp" class="white" target="_parent"><fmt:message key='gap.authority.Home' bundle='${applicationAuResources}' /></a></td>
            <td style="color:#FFFFFF"><img src="<%=request.getContextPath() %>/images/au/key.gif" width="16" height="16" align="absmiddle"> <a href="javascript:modifyPassword()" class="white"><fmt:message key='gap.authority.Change_Password' bundle='${applicationAuResources}' /></a></td>
            <td style="color:#FFFFFF"><img src="<%=request.getContextPath() %>/images/au/cross-circle.gif" width="16" height="16" align="absmiddle"> <a href="<%=request.getContextPath() %>/jsp/login/login.jsp?isExit=1"class="white" target="_parent"><fmt:message key='gap.authority.logout' bundle='${applicationAuResources}' /></a></td>
            <td style="color:#FFFFFF;width:5px"></td> 
            <td style="color:#FFFFFF"><a href="javascript:changeLocal('zh');"><img src="<%=request.getContextPath() %>/images/index/cn.png" title="中文" width="16" height="11" border="0" style="margin: 2px 0px 0px 0px;vertical-align:top"/></a></td>
            <td style="color:#FFFFFF;width:5px">|&nbsp;</td>
            <td style="color:#FFFFFF"><a href="javascript:changeLocal('en');"><img src="<%=request.getContextPath() %>/images/index/en.gif" title="English" width="16" height="11" border="0"  style="margin: 2px 0px 0px 0px;vertical-align:top"/></a> </td>
            <td style="color:#FFFFFF;width:10px"></td>
          </tr>
        </table>	
		</td>
	  </tr>
	</tbody>
</table>
</body>
</html>