<%@page language="java" contentType="application/x-msdownload" pageEncoding="GBK"%><%@page import="venus.frames.mainframe.util.Helper"%><%@page import="com.alexander.businessdata.bs.AttachmentDownloadService"%><%
  AttachmentDownloadService service = (AttachmentDownloadService) Helper.getBean("attachmentDownloadService");
  String attachmentId = request.getParameter("attachmentId");
  service.download(request, response, attachmentId);
%>