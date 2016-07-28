<%    
     //文件下载
    String filename = request.getParameter("attach_name");    
    String filepath = "C:\\VenusTools2010\\workspace\\FAERP\\"+request.getParameter("attach_address");
    System.out.println("filepath====="+filepath);
    //String filepath =request.getParameter("attach_address");
    response.setContentType("application/octet-stream");   
    response.setHeader("Location",filename);
    response.setHeader("Content-Disposition", "attachment; filename=" + filename); //filename应该是编码后的(utf-8)
    java.io.OutputStream outputStream = response.getOutputStream();
    java.io.InputStream inputStream = new  java.io.FileInputStream(filepath);
    byte[] buffer = new byte[1024];
    int i = -1;
    while ((i = inputStream.read(buffer)) != -1) {
     outputStream.write(buffer, 0, i);
     }
    outputStream.flush();
    outputStream.close();
    inputStream.close();
    outputStream = null;
    out.clear();
    //out=pageContext.pushBody();

%>  