<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>

<%@ page import="com.alexander.flowdesign.util.IConstants" %>
<%@ page import="gap.wf.wapi.state.ProcDefState" %>
<!--马啸添加start-->
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList,java.util.HashMap"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<!--马啸添加end-->
<%
	String wfsection=(String)request.getAttribute("WF_SECTION");
	String wfpackage=(String)request.getAttribute("WF_PACKAGE");
%>

<script language="javascript">
/*selfMax();*/
var WF_STATE_NORMAL="<%=ProcDefState.WF_STATE_NORMAL.getCodeStr()%>";
var WF_STATE_NEW="<%=ProcDefState.WF_STATE_NEW.getCodeStr()%>";

function getFlowSection(event){
    var obj = window.showModalDialog('<venus:base/>/jsp/flowdesign/sectionFrame.jsp','','dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:yes;status:0;');
        if(obj) {
            document.form.WF_SECTION.value = obj["cascade_code"];
            document.form.WF_SECTION_NAME.value = obj["name"];
        }
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body OnUnLoad="GraphNFlow.ReleaseGraph()">
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">
	writeTableTop('<fmt:message key="add" bundle="${applicationResources}"/>','<%=request.getContextPath()%>/');
</script>

<div id="ccParent1"> 
<table class="table_div_content">
	<tr> 
		<td>
		<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:alexanderHideshow('ccChild1','ccChild22')">
		<fmt:message key="add_process_definition"/></td>
		</td>
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
  <!--马啸注释<input type="hidden" name="WF_SECTION" value="<%=(wfsection==null)?"未分类流程":wfsection%>">-->
  <input type="hidden" name="WF_PACKAGE" value="<%=(wfpackage==null)?LocaleHolder.getMessage("gap.wf.not_sub_process"):wfpackage%>">
  <input type="hidden" name="WF_STATE" value="<%=ProcDefState.WF_STATE_NEW.getCodeStr()%>">
  
  <tr nowrap> 
    <td class="th_1" nowrap><fmt:message key="process_name"/></td>
    <td><input type="text" name="WF_NAME" class="text_field" value="" size="25" validators="isNormalStrOnWeb;notNull" maxlength="50"></td>
	<td class="th_1" rowspan="2" nowrap ><fmt:message key="description"/></td>
	<td rowspan="2"><textarea name=WF_DESC cols="35" rows="3" validators="isNormalStrOnWeb;notNull" maxlength="250"></textarea></td>
  </tr>
  
  <tr nowrap>
    <td class="th_1" nowrap><fmt:message key="version"/></td>
    <td><input type="text" name="WF_VERSION" class="text_field" value="" size="25" maxlength="6" validators="isNormalStrOnWeb;notNull"></td>
  </tr>
     <!--马啸添加start-->
	  <tr nowrap>
	    <td class="th_1" nowrap><fmt:message key="process_type"/></td>
	    <td>
			
				<input type="hidden" name="WF_SECTION" validators="notNull"/>
				<input id="WF_SECTION_NAME" name="WF_SECTION_NAME" type="text" class="text_field_reference"  validators="notNull" readOnly="true"><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getFlowSection(event);" class="img_1">
	    </td>
	  </tr>
    <!--马啸添加end-->
  <tr nowrap>
	<td colspan="4">
	<input type="button" name="Submitxx" value='<fmt:message key="save_process_as_draft"/>' onClickto="toSaveFlow('designSubmit.do')" class="button_ellipse">
	<input type="button" name="Submityy" value='<fmt:message key="save_and_inspection_process"/>' onClickto="toSaveAndPublish('designSubmit.do')" class="button_ellipse">
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
      <td><textarea readOnly name="formconfig" cols="150" rows="20" id="formconfig"></textarea></td>
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
</html>