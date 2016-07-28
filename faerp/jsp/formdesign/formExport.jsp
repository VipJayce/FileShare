<%@page language="java" contentType="application/x-msdownload" import="java.io.*,java.net.*" pageEncoding="GBK"%><%
//    response.reset();
    response.setContentType("application/x-download");
    String fileName = request.getParameter("txtFileName") + ".html";
    fileName = URLEncoder.encode(fileName,"UTF-8");
    response.addHeader("Content-Disposition","attachment;filename=" + fileName);
    OutputStream output = null;
    FileInputStream fis = null;
    try {
        output  = response.getOutputStream();
        output.write(request.getParameter("content").getBytes());
        output.flush();
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(fis != null) {
            fis.close();
            fis = null;
        }
        if(output != null) {
            output.close();
            output = null;
        }
    }
%>