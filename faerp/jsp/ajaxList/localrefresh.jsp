<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<html>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>

<script language="javascript">
/**
 * 功能描述：取产品数据填入表格
 * 参数：	;
 */
function getProduct(){
	AjaxControl.getProducts(1,15,callback);
}

// 定义列数据对象数组
var cellfuncs = [
	function(data){return data.name},
	function(data){return data.price}
];

/**
 * 功能描述：动态填充表格内容
 * 参数：	data -- 填充表格对象数组
 */
function callback(data){
	//alert(dwr.util.toDescriptiveString(data, 2));
	//dwr.util.removeAllRows("productNotice");
	dwr.util.removeAllRows("productbody");
	dwr.util.addRows("productbody", data, cellfuncs,{
	    rowCreator:function(options) {
		    var row = document.createElement("tr");
		    var index = options.rowIndex * 50;
		    row.style.color = "rgb(" + index + ",0,0)";
		    return row;
	  	},
	  	cellCreator:function(options) {
	    var td = document.createElement("td");
	    var index = 255 - (options.rowIndex * 50);
	    td.style.backgroundColor = "rgb(" + index + ",255,255)";
	    td.style.fontWeight = "bold";
	    td.style.height = 18;
	    td.style.width=201;
	    return td;
	  }
	});
//
}

</script>
<body>
<script language="javascript">
	writeTableTop('查询列表','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			商品促销
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
	<tr><td><b>此处实时更新最新商品价格信息</b></td></tr>
	<tr>
		<td>
		<TABLE id="productNotice" cellSpacing=0 cellPadding=0 border=0 height="18">
		<TBODY id="productbody">
			<TR height=18>
				<TD width=201 height=18>·电视机
				</TD>
				<TD width=177 height=18>·10000元
				</TD>
			</TR>
			<TR>
				<TD height=18>·电风扇
				</TD>
				<TD height=18>·800
				</TD>
			</TR>
			<TR>
				<TD height=18>·IBM x61笔记本
				</TD>
				<TD height=18>·15000
				</TD>
			</TR>
		</TBODY>
		</TABLE>
		</td>
	</tr>
</table>
</div>
<!--
<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td>
			<input name="button_save" type="button" class="button_ellipse" value="确定" onClick="javascript:getProduct();">
		</td>
	</tr>
</table>
</div>
-->
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
	setInterval("getProduct()",1000);
</script>
</body>
</html>