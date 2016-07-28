<html>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="venus.pub.util.VoHelper" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/MasterDetailTemplateAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<title><fmt:message key="common.modify_template"></fmt:message></title>
<script>
	var params = dialogArguments;
	var id='<%=request.getParameter("id")%>';
	var primary='<%=request.getParameter("primary")%>';
	var primary_value='<%=request.getParameter("primary_value")%>';
	var detailView ='<%=request.getParameter("detailView")%>';
	var tableView ='<%=request.getParameter("tableView")%>';
	var masterTableView='<%=request.getParameter("masterTableView")%>';
	var masterIdKey='<%=request.getParameter("masterIdKey")%>';
	var handleSort ='<%=request.getParameter("handleSort")%>';
	//var handleSort ='cache';//database   //cache
	var handleState ='insert';
	function submit_onClick(detailObj){  //子表新增提交
		if(checkAllForms()){
			MasterDetailTemplateAjax.getViewVo($("code").value,function(data){
					var fields=null;
					if(null!=data) fields = data.fields;
					var m={"sessionId":detailObj.sessionId,"state":detailObj.state,"serial":detailObj.serial,"handleSort":handleSort,"handleState":handleState,"tableView":tableView,"detailView":detailView,"masterTableView":masterTableView,"masterIdKey":masterIdKey}; 
					var detailMap={};
					if(handleState=="update") detailMap[primary]=primary_value;
					if(null!=fields&&fields.length>0){
							for( var i=0;i<fields.length;i++){
								var fieldVo = fields[i];
								
								//不考虑未启用的字段
								if (fieldVo.status=="0"){
									continue;
								}
								//不考虑不显示的字段
								if (fieldVo.display=="0"){
									continue;
								}				
								if (fieldVo.columnName!=""&&null!=$(fieldVo.name)) {//非虚拟字段
									var value;
									if(fieldVo.displayType==9)
									{
										value = getRadioValue(document.getElementsByName(fieldVo.name));
									}
									else
									{
										value = $name(fieldVo.name).value;
									}
									if(value!=null && trim(value)!=""&&trim(value)!='null') {
										detailMap[fieldVo.name]=value;
										
									}
								}
							}
					}
					MasterDetailTemplateAjax.executeDetail(m,detailMap,populateReturn);
					//window.close();
				});
    	}
    }
	function trim (str)
	{
	    return str.replace(/(^\s*)|(\s*$)/g, '');
	}
	
	function populateReturn(data){
		window.returnValue = data;
		window.close();
	}
	
	function loadDetailHTML(detailObj){
		var m={"sessionId":detailObj.sessionId,"state":detailObj.state,"serial":detailObj.serial,"detailView":detailView}; 
		MasterDetailTemplateAjax.find4updateFromCache(m,function(data){
			var detailViewHTML=document.getElementById("detailViewHTML");
			detailViewHTML.innerHTML=data;
		})
	}
</script>

<head></head>
<body onload="javascript:loadDetailHTML(params[0]);">
<script language="javascript">
	writeTableTop('<fmt:message key="modify_page"  bundle="${applicationResources}"></fmt:message>','<venus:base/>/');
</script>

<form name="form" method="post">

<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:submit_onClick(params[0])"><!--params[0]-->
			<input name="button_cancel" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>'  onClick="javascript:window.close();">
		</td>
	</tr>
</table>

<div id="detailViewHTML"> </div>
<input type="hidden" name="code" value='<%=request.getParameter("detailView")%>' />

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