<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="date_time_reference" bundle="${applicationResources}"/></title>
</head>
<body>
<table border="0" align="center" bgcolor="#D9E9FA">

  <tr>
    <td>
        <iframe name="yearMonthDayIFrame" src="../calendar/calendar.jsp" height="200px" scrolling="no" width="300px"  frameborder="0" onLoad="yearMonthDayIFrame.hidden_button1();eval('yearMonthDayIFrame.cal_ondblclick=function(){}');">
        </iframe>
    </td>
  </tr>

  <tr>
    <td>
        <iframe name="hourMinuteSecondIFrame" src="hourMinuteSecond.jsp" height="50"  frameborder="0" scrolling="no" onLoad="hourMinuteSecondIFrame.hidden_button();">
        </iframe>
    </td>
  </tr>
</table>
<table border="0" align="center">
  <tr>
    <td><input type="button" name="button_ok" value='<fmt:message key="confirm" bundle="${applicationResources}"/>' onClick="ok_onClick();">&nbsp;&nbsp;
    <input type="button" name="button_cancel" value='<fmt:message key="cancel" bundle="${applicationResources}"/>' onClick="window.close()"></td>
  </tr>
</table>
</body>
</html>
<script language="javascript">
    function ok_onClick() {
        var hourMinuteSecond = getValue();
        window.returnValue = hourMinuteSecond;
        window.close(); 
    }
    function getValue() {
        return yearMonthDayIFrame.fnGetValue() + " " + hourMinuteSecondIFrame.getValue();
    }
</script>