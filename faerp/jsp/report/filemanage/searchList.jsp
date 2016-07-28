<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ page import="gap.report.util.VoHelperTools"%>
<fmt:bundle basename="gap.report.report_resource" prefix="gap.report.">
<%
        String parentCode = (String) request.getAttribute("parent_code");
%>
<script>
	var staticRelationTypeId='';
	function view_onClick(id){
		//document.frames[0].location.href="<venus:base/>/ReportFileAction.do?cmd=detail&id="+id;
		parent.document.all.detailReportFile.src="<venus:base/>/ReportFileAction.do?cmd=detail&id="+id;
	}
	function view_onButton(){
	    var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = null;
		var relaid=null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert(i18n.please_select_a_record)
	  		return;
		}
		if(number > 1) {
	  		alert(i18n.can_only_select_a_record)
	  		return;
		}
		view_onClick(id,relaid);
	}
	function getRowHiddenId() {  //从事件取得本行的id
		var thisA = event.srcElement;  //定义事件来源对象
		var thisTr = thisA.parentElement.parentElement;  //定义本行的tr对象
		var thisHidden = getObjectByNameRecursive(thisTr, "hiddenId");  //从thisTr递归的取出name是hiddenId的对象
		if(thisHidden != undefined && thisHidden != null) {  //如果thisHidden不为空
			return thisHidden.value;
		} else {
			return null;
		}
	}
    function getObjectByNameRecursive(thisObj, thisName) {  //从thisObj递归的取出name是thisName的对象
	    var rtHiddenInput = null;  //定义返回的变量
	    for(var i=0; i<thisObj.childNodes.length; i++) {  //循环thisObj的子节点
		    var tempObj = thisObj.childNodes[i];  //定义当前临时节点
		    if(tempObj.signName == thisName) {  //如果当前临时节点的name等于thisName
		    	rtHiddenInput = tempObj;  //当前临时节点就是返回的对象
			    break;  //完成了目标对象的查询,退出循环
		} else {
			rtHiddenInput = getObjectByNameRecursive(tempObj, thisName);  //递归的找自己的子节点
			if(rtHiddenInput != null) {  //如果返回值不为空
				break;  //完成了目标对象的查询,退出循环
			}
		}
	}
	return rtHiddenInput;
}
</script>

</head>
<body>
<form name="form" method="post" ><input
	type="hidden" name="cmd" value=""> <input type="hidden" name="name"
	value="">
<div id="auDivParent1">
<table class="table_div_control">
	<tr>
		<td><img src="<venus:base/>/images/icon/07-0.gif"
			class="div_control_image"
			onClick="javascript:hideshow('auDivChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="filemanage.query_result"/>
		</td>
		<td>
		<table align="right">
			<tr>
				<td class="button_ellipse" onClick="javascript:view_onButton();"><img
					src="<venus:base/>/images/icon/modify.gif"
					class="div_control_image"><fmt:message key="filemanage.view_report"/></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>

<div id="auDivChild1">
<table class="table_div_content">
	<tr>
		<td><layout:collection name="wy" id="wy1" styleClass="listCss"
			width="100%" indexId="orderNumber" align="center" sortAction="0">
			<layout:collectionItem width="40" title="" style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="id" />
				<input type="radio" name="checkbox_template" value="<%=wy3%>" />
				<input type="hidden" signName="hiddenId" value="<%=wy3%>" />
			</layout:collectionItem>
			<layout:collectionItem width="20" title='<fmt:message key="sequence"  bundle="${applicationResources}"></fmt:message>'
				style="text-align:center;">
				<venus:sequence />
			</layout:collectionItem>
			<%="<a onclick='javascript:view_onClick(getRowHiddenId())'>"%>
			<layout:collectionItem width="130" title='<fmt:message key="filemanage.name"/>' property="name" />
			<layout:collectionItem width="130" title='<fmt:message key="filemanage.code"/>' property="total_code" />
			<layout:collectionItem width="130" title='<fmt:message key="filemanage.author"/>' property="author" />
			<layout:collectionItem width="130" title='<fmt:message key="filemanage.function_description"/>' property="help" />
			<%="</a>"%>
		</layout:collection> <jsp:include page="/jsp/include/page.jsp" /></td>
	</tr>
</table>
</div>
</form>
</div>
</body>
</fmt:bundle>
</html>
<% //表单回写
        if (request.getAttribute("writeBackFormValues") != null) {
            out.print("<script language=\"javascript\">\n");
            out.print(VoHelperTools.writeBackMapToForm((java.util.Map) request.getAttribute("writeBackFormValues")));
            out.print("writeBackMapToForm();\n");
            out.print("</script>");
        }
%>
