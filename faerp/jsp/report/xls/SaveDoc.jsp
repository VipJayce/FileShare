<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" import="java.util.*,java.io.*,org.w3c.dom.*,javax.xml.parsers.*,sun.misc.*" %>

	<script language="javascript">
		alert("test");
	</script>
<%
	try
	{
		DocumentBuilderFactory factory=DocumentBuilderFactory.newInstance();
		DocumentBuilder builder=factory.newDocumentBuilder();
		Document doc = builder.parse(request.getInputStream());
		
		Element root = doc.getDocumentElement();
		Node xml_File1 = root.getFirstChild();
		NamedNodeMap attList = xml_File1.getAttributes();

		String fileN = "";
		String fileExt = "";
		for (int i = 0; i < attList.getLength(); i++)
		{
		  Node currentNode = attList.item(i);
		  if(currentNode.getNodeName().equals("FileName"))
		  {
			fileN = currentNode.getNodeValue();
			fileExt = fileN.substring(fileN.length()-4);
			fileExt = fileExt.toLowerCase();
			break;
		  }
		}
		//开发者注意：这里用扩展名限制客户端上传文档的类型。开发者可根据需要添加其他可上传文档类型。
		if((fileExt.equals(".doc"))||(fileExt.equals(".xls"))||(fileExt.equals(".ppt")))
		{
			Node textNode = xml_File1.getFirstChild();
			BASE64Decoder de = new BASE64Decoder();
			//下面的字节数组b就是SOAOffice控件提交到服务器的文档流。开发者可编程将b存入数据库字段里，
			//或作其他任何处理。这是SOAOffice专门为开发者提供的灵活性。
			byte[] b= de.decodeBuffer(textNode.getNodeValue());
			//此处的路径，由开发者根据实际情况自由确定。path=request.getRealPath("/")+"doc\\"+fileN;
			FileOutputStream fos = new FileOutputStream(request.getRealPath("/WEB-INF/xls/doc")+"\\"+fileN);
			fos.write(b);
			fos.close();
		}
	}
	catch(Exception e)
	{
		out.print("Save Erro."); 
	}
	
//保存文档成功，必须返回"Save OK."。
//本页面里请不要添加其他out.print(); 
out.print("Save OK."); 
%>