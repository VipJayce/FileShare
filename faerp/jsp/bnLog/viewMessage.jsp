<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/jsp/include/errorpage.jsp" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%@ page import="gap.bnLog.vo.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=LocaleHolder.getMessage("gap.bnLog.detail_page") %></title>
</head>
<style>
span {
    font-weight:bold;
    color:#000066;
    }
    }
</style>
<% 
BaseBnLogVO baseBnLogVO = (BaseBnLogVO)request.getAttribute("bean");
String message = baseBnLogVO.getMessage();
Map extendFields = (Map)request.getAttribute("extendFields");
%>
<span ><%=LocaleHolder.getMessage("gap.bnLog.business_log_info_and_ext_info") %></span>
<table class="viewlistCss" style="TABLE-LAYOUT: fixed">
    <tr> 
        <td align="right" width="100pt"><%=LocaleHolder.getMessage("gap.bnLog.business_log_message") %></td>
        <td align="left" style="word-WRAP: break-word"><%
        if(message != null) {
            out.print(message);
        }else {
            out.print("<font color=red size=2 > ");
            out.print(LocaleHolder.getMessage("gap.bnLog.no_business_log_message"));
            out.print("</font> ");
        }
        %></td>
    </tr>
    <%
    if(extendFields != null) {
	    Iterator it = extendFields.entrySet().iterator();  
	    while(it.hasNext()) {  
	        Map.Entry entry = (Map.Entry) it.next();
	        out.print("<tr> <td align=right>");
	        out.print(entry.getKey());
	        out.print("</td> ");
	        out.print("<td align=left>");
	        out.print(entry.getValue());
	        out.print("</td></tr>");
	    }
    }
    %>
</table>
<!-- </body> -->
</html>
