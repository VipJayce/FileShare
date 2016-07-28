<%@ page contentType="application/xml; charset=GBK"%>
<%@ page import="com.alexander.flowdesign.util.IConstants"%>
<%@ page import="com.alexander.flowdesign.vo.FlowFileVo"%>

<%
	FlowFileVo flowFileVo = (FlowFileVo) request
		.getAttribute(IConstants.RETURN_FLOW_FILE_VALUE);
	if (flowFileVo != null && flowFileVo.getTblContent() != null)
		out.println(flowFileVo.getTblContent());
%>