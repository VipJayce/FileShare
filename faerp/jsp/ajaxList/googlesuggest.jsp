<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<style>

.leftspan{
float:left; font-weight:normal; font-size:11px;
}
.rightspan{
float:right;font-weight:normal;font-size:10px; color:Green;
}

body,div {
	font-family:verdana;
	line-height:100%;
	font-size:9pt;
}

h1 {
	text-align:center;
	font-size:2.2em;
}
#divf {
	margin:10px;
	font-size:0.8em;
	text-align:left;
}
#divc {
	border:1px solid #333333;
}
.des {
	width:500px;
	background-color:lightyellow;
	border:1px solid #333;
	padding:20px;
	margin-top:20px;
}
.mouseover {
	color:#ffffff;
	background-color:highlight;
	width:100%;
	cursor:default;
}
.mouseout {
	color:#000000;
	width:100%;
	background-color:#ffffff;
	cursor:default;
}
</style>
 <script type='text/javascript' src='<venus:base/>/js/ajax/ajax-googlesuggest.js'></script>
 <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
 <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<venus:base/>/js/ajax/gap-ajaxList.js"></script>

<script language="javascript">
/**
 * 功能描述：生成存放提示结果的javascript对象
 * 参数描述：id -- 提示的前提条件对应的id
 *                    collectionId -- 根据前提条件产生的提示结果存放的控件id;
 */  
function displaySuggestion(id,collectionId){
    if(DWRUtil.byId(id).value == ""){
        return;
    }
    jsAutoInstance._msg = [];
    jsAutoInstance.item(DWRUtil.byId(collectionId).value);
}
function makeSuggestion(func) {//取工厂名
	if (form.factoryName.value == "") {
		form.factoryId.value = "";
		return;
	}else if(isDigit(form.factoryName.value)){
		AjaxControl.findFactory(form.factoryId.value,function(data) {
			if(null==data){
				alert("不存在以输入值为尾码的工厂,请确认!");
			}else{
				setInput(data,'factoryName');
				AjaxControl.findProductsOfFactory(form.factoryId.value,function(data){
				if(null==data){
					}else{
						setInput(data,'products');
					}
				});
			}
		});
		
	}else{
		alert("只能输入数字");
		form.factoryName.value = "";
	}
}

function hiddenSuggestion(){
	jsAutoInstance._o.style.visibility = "hidden";
}

</script>
<body onclick="hiddenSuggestion();">
<script language="javascript">
	writeTableTop('查询列表','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<!-- 查询开始 -->

<div id="queryDiv" style="display:block;"> 
	<table class="table_div_content">
	<tr>
		<td align="right" width="10%" nowrap>厂家名称</td>
		<td>
			<div id="factory">
			<input name="factoryName" id="factoryName" type="text" class="text_field" inputName="厂家名称" validate="isSearch"  rubber_id="factoryId" onblur="makeSuggestion(inputTransfer('1099100300000000001','factoryId','factoryName'))" >
			<input type="hidden" name="factoryId" id="factoryId" value="">
			<input name="products" id="products" type="hidden" value="">
		</td>
		<td>(输入代码尾数，可以自动转换为工厂名称，比如输入：1)</td>
	</tr>
	<tr>
		<td align="right" width="10%" nowrap>产品名称</td>
		<td>
			<div id="product">
			<input id="productName" name="productName" type="text" class="text_field" inputName="产品名称"  validate="isSearch" onkeydown="displaySuggestion('factoryId','products')"  onkeyup="jsAutoInstance.handleEvent(this.value,'productName',event)" >
			</div>
		</td>
		<td>(输入工厂后，在这里输入产品名，可出现提示产品完整名称，比如输入：x)</td>
	</tr>
	</table>
</div>
<div id="divc">
	<!--this is the autocomplete container.-->
</div>
<div id="divf">
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
	var jsAutoInstance = new jsAuto("jsAutoInstance","divc");
</script>
</body>
</html>