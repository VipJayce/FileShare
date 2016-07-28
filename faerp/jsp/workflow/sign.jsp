<%@ page contentType="image/jpeg"%>
<%@ page import="com.sun.image.codec.jpeg.JPEGImageEncoder"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="com.sun.image.codec.jpeg.JPEGCodec"%>

<%
        String sign = request.getParameter("sign");
        try {
            //设置页面不缓存
            //out.clear();
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
            encoder.encode((BufferedImage) session.getAttribute(sign));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            out.flush();
            out.close();
            out.clear();
            out = pageContext.pushBody();
            session.removeAttribute(sign);
        }
%>
