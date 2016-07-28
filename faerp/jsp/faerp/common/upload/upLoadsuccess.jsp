<%@ page language="java" contentType="text/html; charset=gb2312"%>
  
 
 <%@page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>

<%
    boolean sign = true;
    String errorMsg = "";
    AttachmentfileVo vo = new AttachmentfileVo();
    vo=(AttachmentfileVo) request.getAttribute("attachmentfileVo");
    
    
    if (sign == true) {
        String info = "['success','" + vo.getId() + "','"+vo.getAttachment_file_path()+"']";
        out.println("<script language='javascript'> ");
        out.println(" var result=" + info + ";");
        out.println(" parent.callback(" + info + ")");
        out.println("</script>");
        //System.out.println("<script language='javascript'> ");
        //System.out.println(" var result=" + info + ";");
        //System.out.println(" parent.callback(" + info + ")");
        //System.out.println("</script>");
    } else {
        out.println("<script>parent.callback(['failed','"+ errorMsg +"'])</script>");
    }
%>
