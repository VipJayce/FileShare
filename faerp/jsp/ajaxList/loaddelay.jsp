<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@ page import="gap.ajax.function.core.AjaxControl" %>
<div id="loading" style="width:80px;left:250px;top:250px;padding-left:5px;position:absolute;line-height:22px;z-index=2">正在读取...<img src="<venus:base/>/images/ajaxList/progress_bar.gif"></div>
<%
	AjaxControl ajaxControl = new AjaxControl();
	List list = ajaxControl.getProductsList(1,1000);
	request.setAttribute("wy", list);
%>
<html>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>

<script language="javascript">


 function init() {
 	//useLoadingImage("/images/progress_bar.gif");
 }
 
window.onload=function(){
  var a = document.getElementById("loading");
  a.parentNode.removeChild(a);
}
//document.write('<div id="loading" style="width:80px;left:250px;top:250px;padding-left:5px;position:absolute;line-height:22px;z-index=2">正在读取...<img src="<venus:base/>/images/ajaxList/progress_bar.gif"></div>');
</script>
<body >
<script language="javascript">
	writeTableTop('查询列表','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<div id="ccChild1"> 
<table id="dataTable" class="table_div_content" >
	<tbody id="peoplebody" >
    <tr id="pattern" >
		<td>
		<layout:collection name="wy" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="productid"/>
				<input type="hidden" signName="hiddenId" value="<%=wy3%>"/>
				<input type="checkbox" name="checkbox_template" value="<%=wy3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="5%"  title="序" style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title="工厂名称" property="factoryid" sortable="false">
				<bean:define id="wy6" name="wy1" property="factoryid"/>
					<%=ReferenceFilter.get(String.valueOf(wy6))%>
					<input type="hidden" signName="hiddenId" value="<%=wy6%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title="产品名称 " property="name" sortable="false"/>
			<layout:collectionItem width="10%" title="产品价格" property="price" sortable="false"/>
			<layout:collectionItem width="10%" title="产品类型" property="categoryid" sortable="false">
				<bean:define id="wy2" name="wy1" property="categoryid"/>
					<%=ReferenceFilter.get("ProductType",String.valueOf(wy2))%>
			</layout:collectionItem>
			<layout:collectionItem width="12%" title="生产日期" property="beginDate" sortable="false">
			<bean:define id="wy7" name="wy1" property="beginDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
			<layout:collectionItem width="12%" title="保质日期" property="endDate" sortable="false">
			<bean:define id="wy7" name="wy1" property="endDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
		</layout:collection>
		</td>
	</tr>
	</tbody>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>