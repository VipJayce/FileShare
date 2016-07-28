<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<jsp:useBean id="onlineuser" class="gap.authority.login.tools.OnLineUser" scope="application"/>
<%
session = request.getSession(false);
String name = LoginHelper.getLoginName(request);//获得用户姓名
%>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FESCO Adecco ERP系统</title>
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/common.js"></script>
<script language="javascript">

   function get_time()
  {
    var date=new Date();
    var year="",month="",day="",week="",hour="",minute="",second="";
    year=date.getYear();
    month=add_zero(date.getMonth()+1);
    day=add_zero(date.getDate());
    week=date.getDay();
    switch (date.getDay()) {
    case 0:val="\u661f\u671f\u5929";break
    case 1:val="\u661f\u671f\u4e00";break
    case 2:val="\u661f\u671f\u4e8c";break
    case 3:val="\u661f\u671f\u4e09";break
    case 4:val="\u661f\u671f\u56db";break
    case 5:val="\u661f\u671f\u4e94";break
    case 6:val="\u661f\u671f\u516d";break
      }
    hour=add_zero(date.getHours());
    minute=add_zero(date.getMinutes());
    second=add_zero(date.getSeconds());
    document.getElementById("timetable").innerText=" "+year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second+" "+val;
  }
  
    function add_zero(temp)
  {
    if(temp<10) return "0"+temp;
    else return temp;
  }
  
  setInterval("get_time()",1000);
	//é®åè¯­
	function WenHou()
  	{
	  var wenhou="";
	  now = new Date(),hour = now.getHours() 
	if(hour < 6)wenhou="\u51cc\u6668\u597d\uff01";
	else if (hour < 9)wenhou="\u65e9\u4e0a\u597d\uff01";
	else if (hour < 12)wenhou="\u4e0a\u5348\u597d\uff01";
	else if (hour < 14)wenhou="\u4e2d\u5348\u597d\uff01";
	else if (hour < 17)wenhou="\u4e0b\u5348\u597d\uff01";
	else if (hour < 19)wenhou="\u508d\u665a\u597d\uff01";
	else if (hour < 22)wenhou="\u665a\u4e0a\u597d\uff01";
	document.getElementById("wenhouyu").innerText=wenhou;
	//alert(wenhou);
 	}
	
  
</script>
</head>
<body onload="WenHou()">
<div id="seat">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="21"><img src="../images/seat_left.gif" width="21" height="27" /></td>
    <td class="seat_center" height="27" width="100%">
    	<div class="yhu"><%=name %></div><div id="wenhouyu" style="padding-left:8px; margin-top:3px; float: left; color:#3b90b7;"></div>
        <div class="date" id="timetable"></div>
    </td>
    <td width="21" height="27"><img src="../images/seat_right.gif"/></td>
  </tr>
</table>

</div>
</body>
</html>
