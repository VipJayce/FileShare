
<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>


<%@page pageEncoding="UTF-8"%>

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
		
			for(int i=0;i<5;i++ ){
				outxml += ("<out1 id='" + i + "'>");
				outxml += ("<orgid>"+i+"</orgid>");
				outxml += ("<name>" + i + "name</name>");
				outxml += ("<parentorgid>" + 99 + "</parentorgid>");
				outxml += ("</out1>");
				//list.add(new Person(i+"","person"+i));
			}
			for(int j=0;j<4;j++ ){
				outxml += ("<out2 id='" + j + "'>");
				outxml += ("<orgid>"+j+"</orgid>");
				outxml += ("<name>" + j + "sssssname</name>");
				outxml += ("<parentorgid>" + 99 + "</parentorgid>");
				outxml += ("</out2>");
				//list.add(new Person(i+"","person"+i));
			}
			outxml += ("</data></root>");
		System.out.println(outxml);
		pw.print(outxml);
		pw.close();
 %>
