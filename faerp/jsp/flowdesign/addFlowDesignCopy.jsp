<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="com.alexander.flowdesign.util.IConstants" %>
<%@ page import="com.alexander.flowdesign.vo.FlowFileVo" %>
<%@ page import="gap.wf.wapi.state.ProcDefState" %>
<!--马啸添加start-->
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList,java.util.HashMap"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<!--马啸添加end-->
<%
    String typeId = (String)request.getAttribute(IConstants.TYPE_ID);
    String wf_PACKAGE = (String)request.getAttribute("WF_PACKAGE");
    FlowFileVo vo= (FlowFileVo)request.getAttribute(IConstants.RETURN_FLOW_FILE_VALUE);
%>

<script>
/*selfMax();*/
var typeId="<%=typeId%>";
var WF_STATE_NORMAL="<%=ProcDefState.WF_STATE_NORMAL.getCodeStr()%>";
var WF_STATE_NEW="<%=ProcDefState.WF_STATE_NEW.getCodeStr()%>";
</script>

<link href="../../css/venus.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body OnUnLoad="GraphNFlow.ReleaseGraph()">
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">
    writeTableTop('<fmt:message key="copy"/>','<%=request.getContextPath()%>/');
    function getFlowSection(event){
    var obj = window.showModalDialog('<venus:base/>/jsp/flowdesign/sectionFrame.jsp','','dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:yes;status:0;');
        if(obj) {
            document.form.WF_SECTION.value = obj["cascade_code"];
            document.form.WF_SECTION_NAME.value = obj["name"];
        }
}
</script>

<div id="ccParent1"> 
<table class="table_div_content">
    <tr> 
        <td><img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:alexanderHideshow('ccChild1','ccChild22')">
        <fmt:message key="copy_process_definition"/></td>
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
  
<form name="form" method="post">
    <input type="hidden" name="xpdl" value="">
    <input type="hidden" name="tbl" value="">
    <input type="hidden" name="WF_ID" value="">
    <input type="hidden" name="WF_TIME" value="">
    <!--马啸注释<input type="hidden" name="WF_SECTION" value="<%=typeId%>">-->
    <input type="hidden" name="WF_PACKAGE" value="<%=wf_PACKAGE%>">
    <input type="hidden" name="WF_STATE" value="<%=ProcDefState.WF_STATE_NEW.getCodeStr()%>">

  <tr nowrap> 
    <td class="th_1" nowrap><fmt:message key="process_name"/></td>
    <td>
    <input class="text_field" type="text" value="CopyOf<%=vo.getFileInfo().getWF_NAME()%>" name="WF_NAME" value="" size="25" validators="isNormalStrOnWeb;notNull" maxlength="50">
    </td>
    <td class="th_1" rowspan="2" nowrap ><fmt:message key="description"/></td>
    <td rowspan="2">
    <textarea name="WF_DESC" cols="35" rows="3" validators="isNormalStrOnWeb;notNull" maxlength="250"><%=vo.getFileInfo().getWF_DESC()%></textarea>
    </td>
  </tr>
  
  <tr nowrap>
    <td class="th_1" nowrap><fmt:message key="version"/></td>
    <td>
    <input type="text" class="text_field" value="<%=vo.getFileInfo().getWF_VERSION()%>" name="WF_VERSION" value="" size="25" maxlength="6" validators="isNormalStrOnWeb;notNull">
    </td>
  </tr>
    <!--马啸添加start-->
    <tr nowrap>
        <td class="th_1" nowrap><fmt:message key="process_type"/></td>
        <td>
            <input type="hidden" name="WF_SECTION" value="<%=typeId %>"/>
                <input id="WF_SECTION_NAME" name="WF_SECTION_NAME" type="text" class="text_field_reference"  value="<%=FlowSectionCache.getInstance().get(typeId) %>" validators="notNull"  readOnly="true"><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getFlowSection(event);" class="img_1">
        </td>
    </tr>
   <!--马啸添加end-->
    <tr nowrap>
        <td colspan="4">
            <input type="button" name="Submit0" value='<fmt:message key="save_process_as_draft"/>' class="button_ellipse" onClickto="toSaveFlow('designSubmit.do')">
            <input type="button" name="Submit1" value='<fmt:message key="save_and_inspection_process"/>' class="button_ellipse" onClickto="toSaveAndPublish('designSubmit.do')">
            <input type="button" name="Submit6" value='<fmt:message key="return" bundle="${applicationResources}" />' class="button_ellipse" onClick="history.go(-1)">
        </td>
    </tr>
    
  <input type="hidden" name="id" value="">
  <input type="hidden" name="not_delete_status" value="1">
  <input type="hidden" name="enable_status" value="1">
  <input type="hidden" name="formconfig" value="">
  
</form>
</table>
</div>

<div id="ccParent22"> 
<table class="table_div_control">
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
    <form name="formxx">
      <td>
      <textarea readOnly name="formconfig" cols="150" rows="20" id="formconfig"><%=vo.getFormConfig()==null?"":vo.getFormConfig().trim()%></textarea>
      </td>
    </form>
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