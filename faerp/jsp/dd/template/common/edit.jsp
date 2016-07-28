<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<!-- <fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd."> -->
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<%@ include file="/jsp/dd/include/common.jsp" %>	
<%  //判断是否为修改页面
	boolean isModify = false;
	if(request.getAttribute("isModify") != null) {
		isModify = true;
	}
	boolean isZoom = false;
	if(request.getAttribute("isZoom") != null) {
		isZoom = true;
	}
	String condition = (String) request.getAttribute("condition");
	if(condition==null) {
		condition = "";
	}
	String primary = (String) request.getAttribute("primary");
	if(primary==null) {
		primary = "";
	}
	String primary_value = (String) request.getAttribute("primary_value");
	if(primary_value==null) {
		primary_value = "";
	}
	String ds = (String) request.getAttribute("dispStyle");
	int dispStyle=0;
	if(ds!=null) {
		dispStyle =new Integer(ds).intValue();
	}
	String ids=(String)request.getAttribute("ids") ;
	int idIndex=0;
	int idLength=0;
	if(isModify==true || isZoom==true){
	  idLength=ids.split(",").length;
	  idIndex = Integer.parseInt(request.getAttribute("idIndex").toString());
	}
%>
<script>
	var detailView ='<%=request.getParameter("detailView")%>';
	var tableView ='<%=request.getParameter("tableView")%>';
	var queryView ='<%=request.getParameter("queryView")%>';
	var toolView ='<%=request.getParameter("toolView")%>';
	var moduleName ='<%=request.getParameter("moduleName")%>';
	

	function insert_onClick(){  //增加记录
		if(checkAllForms()){
    		form.action = "<venus:base/>/CommonTemplateAction.do?cmd=insert&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
    		form.submit();
    	}
  	}
  	function update_onClick(){
	  	if(checkAllForms()){
  			form.action = "<venus:base/>/CommonTemplateAction.do?cmd=update&ids=<%=ids%>&idIndex=<%=idIndex%>&condition=<%=request.getAttribute("condition")%>&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
  			form.submit();
  		}
  	}
  	
  	function cancel_onClick(){
  		window.location="<venus:base/>/jsp/dd/template/common/list.jsp?moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
  	}

  	function prev_onClick(){
  		form.action="<venus:base/>/CommonTemplateAction.do?cmd=<%=isZoom?"find4zoom":"find4update"%>&ids=<%=ids%>&idIndex=<%=idIndex-1%>&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
  		form.submit();
  	}

  	function next_onClick(){
  		form.action="<venus:base/>/CommonTemplateAction.do?cmd=<%=isZoom?"find4zoom":"find4update"%>&ids=<%=ids%>&idIndex=<%=idIndex+1%>&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
  		form.submit();
  	}

</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<%=isModify?LocaleHolder.getMessage("gap.dd.common.modify_template"):LocaleHolder.getMessage("gap.dd.common.add_template")%>','<venus:base/>/');
</script>

<form name="form"   method="post">
<input type="hidden" name="primary" value="<%=primary%>">
<input type="hidden" name="primary_value" value="<%=primary_value%>">
<table class="table_noframe">
	<tr>
		<td valign="middle">
		<%
			if(isZoom == false){
		%>
			<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>;">
		<%
			}
		%>
			<input name="button_close" type="button" class="button_ellipse" value='<fmt:message key="close"  bundle="${applicationResources}"></fmt:message>'  onClick="javascript:cancel_onClick()">
		<%
			if(isModify == true || isZoom == true){
		%>
			<input name="button_prev" <%=(idIndex==0)?"disabled":""%> type="button" class="button_ellipse" value='<fmt:message key="gap.dd.common.prev_record"  bundle="${dd}"></fmt:message>'  onClick="javascript:prev_onClick()">
			<input name="button_next" <%=(idIndex==idLength-1)?"disabled":""%> type="button" class="button_ellipse" value='<fmt:message key="gap.dd.common.next_record"  bundle="${dd}"></fmt:message>'  onClick="javascript:next_onClick()">
			第<%=idIndex+1 %>条/共<%=idLength %>条
		<%
			}
		%>
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tbody><tr> 
		<td>
			<img onclick="javascript:hideshow('ccParent2',this,'<venus:base/>/')" class="div_control_image" src="<venus:base/>/images/icon/07-0.gif">
		</td>
	</tr>
</tbody></table>
</div>

<div id="ccParent2">
<dd:editView code='<%=request.getParameter("detailView")%>' condition="<%=condition%>" dispStyle="<%=dispStyle%>"/>
<input type="hidden" name="code" value='<%=request.getParameter("detailView")%>' />
</div>


</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>