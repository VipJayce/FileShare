<jsp:directive.page import="java.util.*"/>

<jsp:directive.page import="com.gapext.sysutility.*"/>
<%

java.io.PrintWriter pw = response.getWriter();
       String parentId = request.getParameter("parentId");
        Object para1 = request.getParameter("__ajaxParam");
        String aa = (String)para1;
        //String pageXml = XmlUtil.getPageXmlInit();
        String outxml = "";
        

			List list=new ArrayList();
			outxml += ("<root><data>");
			//outxml += (pageXml);
			outxml += ("<f1>");
			outxml += ("<orgid>" + "99" + "</orgid>");
			outxml += ("<name>" + "99" + "name</name>");
			outxml += ("<parentorgid>" + 99 + "</parentorgid>");
			outxml += ("</f1>");			
			outxml += ("<f2>");
			outxml += ("<orgid>" + "88" + "</orgid>");
			outxml += ("<name>" + "88" + "name</name>");
			outxml += ("<parentorgid>" + 88 + "</parentorgid>");
			outxml += ("</f2>");		
			outxml += ("</data></root>");
		System.out.println(outxml);
		pw.print(outxml);
		pw.close();
 %>
