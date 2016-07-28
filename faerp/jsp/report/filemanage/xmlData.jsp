<%
	 response.setHeader("Pragma","no-cache");    
    response.setHeader("Cache-Control","no-cache");    
    response.setDateHeader("Expires",   0);  
%>
<%@ page contentType="text/xml;charset=UTF-8" language="java" %>
<%@ page import="gap.report.util.tree.DeepTreeXmlHandler"%>
<%@ page import="gap.report.util.tree.DeepTreeVo"%>
<%@ page import="gap.report.filemanage.bs.IReportFileBs"%>
<%@ page import="gap.report.filemanage.vo.ReportFileVo"%> 
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%
try {
	String parent_code = request.getParameter("parent_code");

	IReportFileBs bs = (IReportFileBs) Helper.getBean("report_filemanage_bs");
	String queryCondition = " PARENT_CODE = '"+parent_code+"' ";
	List lChild = bs.queryByCondition(queryCondition,"ORDER_CODE",request);//子节点
	System.out.println(queryCondition);
	DeepTreeXmlHandler dt = new DeepTreeXmlHandler();
	for(Iterator itlChild = lChild.iterator(); itlChild.hasNext(); ) {
		ReportFileVo vo = (ReportFileVo) itlChild.next();
		DeepTreeVo dtv = new DeepTreeVo(vo.getTotal_code(), vo.getName(), "1".equals(vo.getIs_leaf()) ? "0" : "1", request.getContextPath()+"/jsp/report/filemanage/xmlData.jsp?parent_code="+vo.getTotal_code());
		dtv.addAttribute("isSubmit", "0");
		dtv.addAttribute("hrefPath",request.getContextPath()+"/ReportFileAction.do?cmd=detail&id="+vo.getId());
		dtv.addAttribute("target","detailReportFile");
		dt.addTreeNode(dtv);
	} 
    String xmlStr = dt.getStringFromDocument();
    out.print(xmlStr);
} catch(Exception e) {
	e.printStackTrace();
}
%>