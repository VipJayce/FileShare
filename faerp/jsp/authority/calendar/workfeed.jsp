<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="venus.frames.mainframe.util.Helper" %>
<%@ page import="gap.authority.service.calendar.bs.IWorkCalendar" %>
<%@ page import="gap.authority.service.calendar.bo.EventObject" %>
<%
IWorkCalendar bs = (IWorkCalendar)Helper.getBean(gap.authority.service.calendar.util.IWorkCalendarConstants.BS_KEY);
EventObject vo[] = bs.search(request.getParameter("start")+"000",request.getParameter("end")+"000",gap.authority.helper.LoginHelper.getPartyId(request));//seconds -> millionseconds
out.write(JSONArray.fromObject(vo).toString());
%>