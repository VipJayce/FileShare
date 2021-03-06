<%@ include file="/jsp/authority/tree/include/globalTreeCache.jsp" %>
<%@ page contentType="text/xml;charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.tree.DeepTreeXmlHandler"%>
<%@ page import="gap.authority.util.tree.DeepTreeVo"%>
<%@ page import="gap.authority.au.aufunctree.bs.IAuFunctreeBs"%>
<%@ page import="gap.authority.au.aufunctree.vo.AuFunctreeVo"%> 
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="java.util.List"%>
<%
try {
	String root_code = request.getParameter("root_code");
	
	IAuFunctreeBs bs = (IAuFunctreeBs) Helper.getBean("AuFunctree_bs");
	String queryCondition = " TOTAL_CODE = '"+root_code+"'";
	List lParent = bs.queryByCondition(queryCondition);//根节点
	
	DeepTreeXmlHandler dt = new DeepTreeXmlHandler();
    if(lParent!=null && lParent.size()>0) {
		AuFunctreeVo vo = (AuFunctreeVo) lParent.get(0);
		DeepTreeVo dtv = new DeepTreeVo(vo.getTotal_code(), vo.getName(), "1".equals(vo.getIs_leaf()) ? "0" : "1", request.getContextPath()+"/jsp/authority/au/aufunctree/lazyTreeXmlData.jsp?parent_code="+vo.getTotal_code());
		dtv.setDefaultOpen("1");
		dtv.addAttribute("isSubmit", "0");
		//设置菜单链接页面的URL
		dtv.addAttribute("hrefPath","");
		dtv.addAttribute("thisType","root");
		dtv.addAttribute("target","contentFrame");
		dt.addTreeNode(dtv);
	}
    String xmlStr = dt.getStringFromDocument();
    out.print(xmlStr);
} catch(Exception e) {
	e.printStackTrace();
}
%>

