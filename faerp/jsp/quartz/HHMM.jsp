<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.quartz.quartz_resource" prefix="gap.quartz.">

<html>
<head>
<script language="javascript">
	objFrom = dialogArguments;
	//alert(objFrom+" = "+objFrom.value); 
	var tiannetDateNow = new Date();
	var tiannetHour = tiannetDateNow.getHours();
	var tiannetMinute = tiannetDateNow.getMinutes();
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
					out.println("<option value="+i+" >0"+i+"</option>");
				}else{
				out.println("<option value="+i+" >"+i+"</option>");
				}
			}
			%>
			
			</select>&nbsp;<fmt:message key="Hour"/>&nbsp;
		</td>
		<td class=Title_><select id="minute" style="width:40">
			<%for(int i=0;i<60;i++){
				if(i<10){
					out.println("<option value="+i+" >0"+i+"</option>");
				}else{
				out.println("<option value="+i+" >"+i+"</option>");
				}
			}
			%>
			</select>&nbsp;<fmt:message key="Minute"/>&nbsp;</td>
		<td><input type="button" name="button1" class="button_ellipse" value='<fmt:message key="Confirm"/>' class=enter LANGUAGE=javascript onclick="return button1_onclick();">
		</td>
	</tr>
</table>
</form>

</fmt:bundle>   

<body>
</html>

<script language="javascript">
	document.form1.hour.value=tiannetHour;
	document.form1.minute.value=tiannetMinute;
</script>