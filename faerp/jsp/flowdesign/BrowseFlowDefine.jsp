<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="com.alexander.flowdesign.util.IConstants" %>
<%@ page import="com.alexander.flowdesign.vo.FlowFileVo" %>
<!--马啸添加start-->
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList,java.util.HashMap"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<!--马啸添加end-->
<%
	String typeId = (String)request.getAttribute(IConstants.TYPE_ID);
	FlowFileVo vo= (FlowFileVo)request.getAttribute(IConstants.RETURN_FLOW_FILE_VALUE);
	//马啸添加start
	EnumRepository er = EnumRepository.getInstance();
	er.loadFromDir();
	EnumValueMap map = er.getEnumValueMap( "Section" );
	String	sectionLabel = (String)FlowSectionCache.getInstance().get(typeId );
	//马啸添加end
%>

<SCRIPT>
/*selfMax();*/
var typeId="<%=typeId%>";
</SCRIPT>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body OnUnLoad="GraphNFlow.ReleaseGraph()">
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">
	writeTableTop('<fmt:message key="view" bundle="${applicationResources}"/>','<%=request.getContextPath()%>/');
</script>

<div id="ccParent1"> 
<table class="table_div_content">
	<tr> 
		<td><img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:alexanderHideshow('ccChild1','ccChild22')">
		<fmt:message key="view_process_definition"/></td>
	</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content2">

  <tr nowrap>
  	<td colspan="4">
	<!-- object begin --><jsp:include page="/activex/ocxobject.jsp" flush="true"/><!-- object end -->
	</td>
  </tr>
  
  <tr>
    <td nowrap class="th_1"><fmt:message key="process_code"/></td>
    <td nowrap><%=request.getParameter("id")%></td>
	<td class="th_1"><fmt:message key="process_state"/></td>
    <td><%=vo.getFileInfo().getWfStateName()%></td>
  </tr>
  
  <tr> 
    <td class="th_1"><fmt:message key="process_name"/></td>
    <td><%=vo.getFileInfo().getWF_NAME()%></td>
    <!--马啸添加start-->
    <td class="th_1"><fmt:message key="process_type"/></td>
    <td ><%=sectionLabel%></td>
    <!--马啸添加end-->
  </tr>
  
  <tr nowrap> 
    <td class="th_1"><fmt:message key="version"/></td>
    <td><%=vo.getFileInfo().getWF_VERSION()%></td>
    <td class="th_1" ><fmt:message key="description"/></td>
    <td ><%=vo.getFileInfo().getWF_DESC()%></td>
  </tr>
  
	<tr nowrap>
		<td colspan="4">
		<input type="button" name="Submitgohome" value='<fmt:message key="return" bundle="${applicationResources}" />' onClick="history.go(-1)" class="button_ellipse">
		</td>
	</tr>
    
</table>
</div>

<div id="ccParent22"> 
<table class="table_div_content">
	<tr>
		<td>
		<img src="<%=request.getContextPath()%>/images/icon/07.gif" onClick="javascript:alexanderHideshow('ccChild1','ccChild22')">
		<fmt:message key="form_configuration"/>
		</td>
	</tr>
</table>
</div>
<div id="ccChild22">
  <table class="table_div_content">
    <tr>
      <td><textarea readOnly name="formconfig" cols="150" rows="20" id="formconfig"><%=vo.getFormConfig()==null?"":vo.getFormConfig().trim()%></textarea></td>
    </tr>
  </table>
</div>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');
	hideshow('ccChild22',this,'<%=request.getContextPath()%>/');
	//initMyKeyDown();
</script>
</fmt:bundle>
<jsp:include page="/activex/ocxfooter.jsp" flush="true"/>
</body>
<%@page import="com.alexander.flowdesign.util.FlowSectionCache"%>
</html>