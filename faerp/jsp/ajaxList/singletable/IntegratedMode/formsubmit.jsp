<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@ page import="gap.ajax.function.core.AjaxControl" %>

<html>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>

<script language="javascript">
/**
 * 功能描述：构造Bean类型的参数对象
 * 参数：	;
 */   
function buildProduct(){
	var product= {
		productid:"",
		categoryid:"",
		name:"",
		price:0,
		beginDate:"",
		endDate:"",
		factoryid:"",
		factoryName:""
	} ;
	return product;
}

function query_onClick(){
	var product = buildProduct();
	include('/jsp/ajaxList/singletable/IntegratedMode/producttable.jsp','forward',getTbodyColor);
}

</script>
<body>
<script language="javascript">
	writeTableTop('查询列表','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_content">
	<tr>
		<td align="right"><input type="button" name="Submit" class="button_ellipse" value="我要查询" onclick="javascript:query_onClick();"></td>
		<td align="left">
			<input name="productid" type="hidden" class="text_field" value="">
		</td>
	</tr>
</table>
</div>

</div>
</form>
<div id="forward"></div>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>