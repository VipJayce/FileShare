
<jsp:directive.page import="java.util.*"/>
<jsp:directive.page import="com.test.PeopleVO"/>
<jsp:directive.page import="com.test.t1.Person"/>
<jsp:directive.page import="com.gapext.sysutility.*"/>
<%

java.io.PrintWriter pw = response.getWriter();
       String parentId = request.getParameter("parentId");
        Object para1 = request.getParameter("__ajaxParam");
        String aa = (String)para1;
        String pageXml = XmlUtil.getPageXmlInit();
        String outxml = "";
        

			List list=new ArrayList();
			outxml += ("<root><data>");
			//outxml += (pageXml);
			outxml += ("<out1 id='" + i + "'>");
			outxml += ("<orgid>"+99+"</orgid>");
			outxml += ("<name>" + 99 + "name</name>");
			outxml += ("<parentorgid>" + 99 + "</parentorgid>");
			outxml += ("</out1>");			
			for(int i=0;i<14;i++ ){
				outxml += ("<out1 id='" + i + "'>");
				outxml += ("<orgid>"+i+"</orgid>");
				outxml += ("<name>" + i + "name</name>");
				outxml += ("<parentorgid>" + 99 + "</parentorgid>");
				outxml += ("</out1>");
				//list.add(new Person(i+"","person"+i));
			}
			outxml += ("</data></root>");
		System.out.println(outxml);
		pw.print(outxml);
		pw.close();
 %>
