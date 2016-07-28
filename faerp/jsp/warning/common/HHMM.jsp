<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<script language="javascript">
	objFrom = dialogArguments;
	//alert(objFrom+" = "+objFrom.value); 
	var tiannetDateNow = new Date();
	var tiannetHour = tiannetDateNow.getHours();
	var tiannetMinute = tiannetDateNow.getMinutes();
    if(tiannetHour<10){
       tiannetHour="0"+tiannetHour;
    }
	if(tiannetMinute<10){
	   tiannetMinute="0"+tiannetMinute;
	}
	//alert(" 当前时间是 "+tiannetHour+":"+tiannetMinute); 
	
	if(objFrom.value != ""){
		tiannetHour = objFrom.value.substring(0,2);
		tiannetMinute = objFrom.value.substring(3);
	}
	//alert(" 现在时间是 "+tiannetHour+":"+tiannetMinute); 
function button1_onclick(){
	var value = "";
	var timeSplit  = ":";
	var hour = document.form1.hour.value;
	if( hour < 10 && hour.toString().length == 1 ) hour = "0" + hour;
	value = hour;
	var minute = document.form1.minute.value;
	if( minute < 10 && minute.toString().length == 1 ) minute = "0" + minute;
	value += timeSplit + minute;
	window.returnValue=value;
	window.close();
}

function resizewindow(w,h){
window.resizeTo(w,h);
}
</script>
</head>
<body>
<form name=form1>
<table border=0 cellpadding=0 cellspacing=0  background="../../js/calendar/images/day_title.gif" align=center class=WholeCalendar_>
	<tr style="borderbottom:1 solid black">
		<td class=Title_ ><select id="hour" style="width:40">
			<%String hour="";
			for(int i=0;i<24;i++){
				if(i<10){
					out.println("<option value='0"+i+"' >0"+i+"</option>");
				}else{
				out.println("<option value="+i+" >"+i+"</option>");
				}
			}
			%>
			
			</select>&nbsp;<fmt:message key="hour" bundle="${applicationResources}"/>&nbsp;
		</td>
		<td class=Title_><select id="minute" style="width:40">
			<%for(int i=0;i<60;i++){
				if(i<10){
					out.println("<option value='0"+i+"' >0"+i+"</option>");
				}else{
				out.println("<option value="+i+" >"+i+"</option>");
				}
			}
			%>
			</select>&nbsp;<fmt:message key="minute" bundle="${applicationResources}"/>&nbsp;</td>
		<td><input type="button" name="button1" class="button_ellipse" value="<fmt:message key="confirm" bundle="${applicationResources}"/>" class=enter LANGUAGE=javascript onclick="return button1_onclick();">
		</td>
	</tr>
</table>
</form>
<body>
</html>

<script language="javascript">
	document.form1.hour.value=tiannetHour;
	document.form1.minute.value=tiannetMinute;
</script>