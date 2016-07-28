<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/DynamicQueryAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-page.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/view.js"></script>
<title><fmt:message key="common.list_template"></fmt:message></title>
<script>
	var moduleId ='<%=request.getAttribute("moduleId")%>';
	var condition ='<%=request.getAttribute("condition")%>';
	//定义翻页行为
	PageVoJs.prototype.action = getActionMap;
	//创建翻页对象
	var pageVo  = new PageVoJs();

	function getActionMap(){
		DynamicQueryAjax.query(moduleId,condition,pageVo,getMapResult);
	};
	
	function queryAll(){
		pageVo.initAction();
	}

	function fillTable(data){
		var div=document.getElementById("QueryListDiv");
		div.innerHTML=data;
	}
	  	
 	function exportPdf_onClick(){  //导出Excel
 		form.action = "<venus:base/>/DynamicQueryAction.do";
    	form.cmd.value = "exportPdf";
    	form.currentPage.value=pageVo.currentPage;
    	form.pageSize.value=pageVo.pageSize;
    	form.submit();
  	}
 	function exportExcel_onClick(){  //导出Excel
 		form.action = "<venus:base/>/DynamicQueryAction.do";
    	form.cmd.value = "exportExcel";
    	form.currentPage.value=pageVo.currentPage;
    	form.pageSize.value=pageVo.pageSize;
    	form.submit();
  	}
</script>
</head>
<body onload="queryAll();">
<script language="javascript">
	writeTableTop('<%=request.getParameter("moduleName")%>','<venus:base/>/');
</script>

<form name="form" method="post" action="">
<input type="hidden" name="cmd" value='' />
<input type="hidden" name="moduleId" value='<%=request.getAttribute("moduleId")%>' />
<input type="hidden" name="condition" value='<%=request.getAttribute("condition")%>' />
<input type="hidden" name="currentPage" value='' />
<input type="hidden" name="pageSize" value='' />
<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="common.detail_table"></fmt:message>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:exportPdf_onClick();"><img src="<venus:base/>/images/icon/pdf.gif" class="div_control_image"><fmt:message key="common.export_pdf"></fmt:message></td>
					<td class="button_ellipse" onClick="javascript:exportExcel_onClick();"><img src="<venus:base/>/images/icon/xls.gif" class="div_control_image"><fmt:message key="common.export_excel"></fmt:message></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
	<table class="table_div_content">
		<tr>
			<td>
				<div id="QueryListDiv"></div>
				<jsp:include page="/jsp/dd/include/ajaxpage.jsp" />
			</td>
		</tr>
	</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>