<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/DataTransService.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/common/gap-waiting.js'></script>
<script language="javascript">
jQuery(function(){
	jbase = jQuery("#base");//0
	jextable = jQuery("#extable");//1
	jexdata = jQuery("#exdata");//2
	//prepare for dwr
	DWREngine.setPreHook(function() {
		jQuery("#delay").html("<div id='wait'ALIGN='center'><font style=' font-size: 24px;'>"+i18n_dd.exporting+"</font></div>");
	});
	DWREngine.setPostHook(function() {
	   jQuery("#delay").html("");
	});
	jQuery("#export_btn").click(function(){
			status = "";
			if(jbase.attr("checked")){
				status = status + "0";
			}
			if(jextable.attr("checked")){
				status = status + "1";
			}
			if(jexdata.attr("checked")){
				status = status + "2";
			}
			showBlockPage();
			DataTransService.exportData(status,function(data){
			alert(data);
			hideBlockPage();
		});
	});

});



 </script>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="trans.export_data"></fmt:message>','<venus:base/>/');
</script>
<div id="ccParent0" class="table_div_control" style="Padding:5px;"> 
			<div style="float:right"> 
				<input type='button' style="float:right" class="button_ellipse"  id="export_btn" value='<fmt:message key="trans.export"></fmt:message>'></input>
			</div>
</div>
<div id="ccChild0">
<form>
<table class="table_div_content" >
<tr></tr>
<tr>
	<td width="5%"></td><td ><fmt:message key="trans.export_intro"></fmt:message></td>
</tr>
<tr></tr>
<tr>
	<td width="5%"></td><td ><fmt:message key="trans.export_intro_section1"></fmt:message></td>
</tr>
<tr>
	<td width="5%"></td><td ><fmt:message key="trans.export_intro_section2"></fmt:message></td>
</tr>
<tr>
	<td width="5%"></td><td ><fmt:message key="trans.export_intro_section3"></fmt:message></td>
</tr>
<tr>
	<td width="5%"></td><td ><fmt:message key="trans.export_intro_section4"></fmt:message></td>
</tr>
<tr>
	<td width="5%"></td><td ><fmt:message key="trans.export_intro_section5"></fmt:message></td>
</tr>
<tr>
	<td width="5%"></td><td ><fmt:message key="trans.export_intro_section6"></fmt:message></td>
</tr>
	<tr></tr>
<tr>
	<td width="5%"></td><td ><fmt:message key="trans.export_intro_choice_item"></fmt:message></td>
</tr>
<tr></tr>
<tr>
	<td width="5%"></td><td ><input type=checkbox id="base"><fmt:message key="trans.export_basetable_and_data"></fmt:message></input><input type=checkbox id="extable"><fmt:message key="trans.export_exttable"></fmt:message></input><input type=checkbox id="exdata"><fmt:message key="trans.export_exttabledata"></fmt:message></input></td>
</tr>
</table>
</form>
</div>
<div id="delay"></div>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>