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
<%
try {

	String root_code = request.getParameter("root_code");
	IReportFileBs bs = (IReportFileBs) Helper.getBean("report_filemanage_bs");
	String queryCondition = " TOTAL_CODE = '"+root_code+"'";
	List lParent = bs.queryByCondition(queryCondition);//根节点
	System.out.println(queryCondition);
	DeepTreeXmlHandler dt = new DeepTreeXmlHandler();
    if(lParent!=null && lParent.size()>0) {
		ReportFileVo vo = (ReportFileVo) lParent.get(0);
		DeepTreeVo dtv = new DeepTreeVo(vo.getTotal_code(), vo.getName(), "1".equals(vo.getIs_leaf()) ? "0" : "1", request.getContextPath()+"/jsp/report/filemanage/xmlData.jsp?parent_code="+vo.getTotal_code());
		dtv.setDefaultOpen("1");
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