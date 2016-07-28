<%@ page contentType="application/xml; charset=UTF-8"%>

<%
        Object str = request.getAttribute("processsnoptdata");
        if (str != null) {
            out.println((String) str);
            //out.write(((String) str).replaceFirst("encoding=\"GBK\"","encoding=\"GBK\""));
        }
    %>
