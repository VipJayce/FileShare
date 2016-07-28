<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>

<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/JqueryReferenceAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>

<!--参照控件显示的样式-->
<link rel="stylesheet" href="<venus:base/>/css/jquery/flora.dialog.css" type="text/css">
<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">

<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>

<!--reference控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.dialog.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.draggable.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.resizable.js"></script>

<!--reference控件翻页的js文件-->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-jquery-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-jquery-reference.js"></script>

<title>参照页面</title>
<style>
    .referenceDetail{
        display:none;
        z-index:100;
        position:absolute;
        top:5%;
        left:5%;
        width:80%;
    }
</style>

<script type="text/javascript">
	var contextpath="<venus:base/>";//声明环境路径
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
        
        //注意:如果resizable为true,在页面上拉伸参照页面,会报"this.documentScroll.top(this.documentScroll.left)为空或不是对象"
        //请修改ui.resizable.js文件,把this.documentScroll.top修改为o.documentScroll.top,把this.documentScroll.left修改为o.documentScroll.left
		jQuery("#referenceDetail").dialog({ modal: true, height:350,autoOpen:false,resizable:true,width:800,overlay: { opacity: 0.5, background: "black" }});
	});
	
</script>


</head>
<body>
<script language="javascript">
	writeTableTop('参照页面','<venus:base/>/');
</script>
<!--必须有此隐藏域-->
<input name="tableBody" type="hidden" value="" class="text_field" >
	
        <div id="container-1">
            <ul>
                <li><a href="#fragment-1"><span>示例演示</span></a></li>
                <li><a href="#fragment-2"><span>源码讲解</span></a></li>


            </ul>
            <div id="fragment-1" class="table_div_content">

					<div id="referenceDetail" title="参照页面">
					</div>
					工厂参照
					<input name="factory_Id" type="text" value="" class="text_field" >
					<input name="factory_name" type="text" value="" class="text_field_reference" inputName="工厂名称" validate="notNull" readonly="true"><img src="<venus:base/>/images/icon/reference.gif"  class="img_1" onclick="reference('referenceDetail','factoryTableBody');">
					<br>
					产品参照
					<input name="product_Id" type="text" value="" class="text_field" >
					<input name="product_name" type="text" value="" class="text_field_reference" inputName="产品名称" validate="notNull" readonly="true"><img src="<venus:base/>/images/icon/reference.gif"  class="img_1" onclick="reference('referenceDetail','productTableBody');">

            </div>
            <div id="fragment-2" class="table_div_content">
            	<table class="table_div_content">
					<tbody>
						<tr>
							<td style="font-size:12px">
								<p >1.需要引入的css文件:<br>
								&nbsp;&nbsp;&nbsp;&nbsp;/css/jquery/flora.dialog.css<br>
								</p>
								<p >2.需要引入的js文件:<br>
								&nbsp;&nbsp;&nbsp;&nbsp;/js/jquery/ui.dialog.js<br>
								&nbsp;&nbsp;&nbsp;&nbsp;/js/jquery/ui.draggable.js<br>
								&nbsp;&nbsp;&nbsp;&nbsp;/js/jquery/ui.resizable.js<br>
								&nbsp;&nbsp;&nbsp;&nbsp;/js/ajax/gap-ajaxList-jquery-page.js<br>
								&nbsp;&nbsp;&nbsp;&nbsp;/js/ajax/gap-ajaxList-jquery-reference.js<br>
								</p>
								<p>3.需要填写的html语句:<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;input name="tableBody" type="hidden" value="" class="text_field"&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;div id="referenceDetail" title="参照页面"&gt;&lt;/div&gt;<br>
								<font color="red">
									请注意:<br>
									此隐藏域必须有，用以保存当前参照页面显示的tbody的id。<br>
									该div为参照页面要在其区域内显示的div。<br>
								</font>
								</p>
								<p >4.需要填写的参照页面的html语句:<br>
								请参照样例代码中的reference_factory.jsp和reference_product.jsp文件源码<br>
								<font color="red">
									请注意:<br>
									1,点击参照页面上的“确定”按钮需要调用returnValue方法,方法参数1是显示参数页面的div的id,方法参数2和方法参数3都是参照页面返回值要赋值的输入框的id。该方法的参数可扩展。<br>
									2,点击参照页面上的“取消”按钮需要调用closed方法，方法参数为显示参数页面的div的id。<br>
								</font>
								</p>
									
								<p>5.需要填写的js语句:<br>
									<p>
									var contextpath="&lt;venus:base/&gt;";//声明环境路径
									</p>
											
									<p>
									    jQuery(function() {<br>
											&nbsp;&nbsp;&nbsp;&nbsp;jQuery("#referenceDetail").dialog({ modal: true, height:250,autoOpen:false,resizable:false,width:800,overlay: { opacity: 0.5, background: "black" }});<br>
										});<br>
										<font color="red">
											参数介绍:<br>
											1, jQuery("#referenceDetail"):referenceDetail是要显示参照页面的div的id。<br>
											2，modal：是否为模式窗口。<br>
											3，autoOpen：是否默认打开。<br>
											4，resizable：是否可以拉伸窗口大小。<br>
											5, overlay:以Key/value的形式设置样式。<br>
											其他参数可参考：http://docs.jquery.com/UI/Dialog/dialog#options<br>
										</font>
									</p>
									<p>6.需要在gap-ajaxList-jquery-reference.js文件中完善的方法<br>
									  /*<br>
									  *加载参照页面时候调用,需要用户修改<br>
									  */<br>
									  function loadPage(dialogDivId,tablebody){<br>
									  	  &nbsp;&nbsp;&nbsp;&nbsp;if(tablebody == "factoryTableBody"){<br>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jQuery("#"+dialogDivId).load('&lt;venus:base/&gt;/JqueryReferenceAction.do',{cmd:'forwardFactoryReferencePage'},function(){getActionMap();});<br>
									  	  &nbsp;&nbsp;&nbsp;&nbsp;}<br>
									  	  &nbsp;&nbsp;&nbsp;&nbsp;if(tablebody == "productTableBody"){<br>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jQuery("#"+dialogDivId).load('&lt;venus:base/&gt;/JqueryReferenceAction.do',{cmd:'forwardProductReferencePage'},function(){getActionMap();});<br>
									  	  &nbsp;&nbsp;&nbsp;&nbsp;}<br>
									  }<br>
									  <font color="red">
									  	  需要用户修改的地方：<br>
									  	  1, factoryTableBody,productTableBody: 显示参照页面内容的tableBody的id。<br>
									  	  2，&lt;venus:base/&gt;/JqueryReferenceAction.do:表示页面要调用的路径名。<br>
									  	  3, cmd:'forwardFactoryReferencePage'：表示页面要调用的方法名。<br>
									  </font>
									</p>
										  
									<p>
										 /*<br>
										 *该方法为参照页面加载数据，根据参数获取要调用的后台方法,需要用户修改<br>
										 */<br>
										function getAjaxURL(tableBody){<br>
											&nbsp;&nbsp;&nbsp;&nbsp;if(tableBody == "factoryTableBody"){<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JqueryReferenceAjax.queryAllFromFactory(pageVo,pageVo.getOrderSortStr(),getMapResult);<br>
											&nbsp;&nbsp;&nbsp;&nbsp;} <br>
											&nbsp;&nbsp;&nbsp;&nbsp;if(tableBody == "productTableBody"){<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JqueryReferenceAjax.queryAllFromProduct(pageVo,pageVo.getOrderSortStr(),getMapResult);<br>
											&nbsp;&nbsp;&nbsp;&nbsp;} <br>
										}<br>
									  <font color="red">
									  	  需要用户修改的地方：<br>
									  	  1，factoryTableBody: 显示参照页面内容的tableBody的id。<br>
									  	  2, JqueryReferenceAjax.queryAllFromFactory：该方法是查询参照页面的数据。可参考样例源码。<br>
									  </font>
									</p>
										
									<p>
										/*<br>
										*根据参数设置不同的翻页信息对象pageVo,需要用户修改<br>
										*/<br>
										function getPageVojs(tbodyid){<br>
											&nbsp;&nbsp;&nbsp;&nbsp;if(oldTableBody != tbodyid){<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(tbodyid=="factoryTableBody"){<br>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pageVo  = new PageVoJs();<br>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//设置默认排序方式<br>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pageVo.setOrderStr("factoryid");<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(tbodyid == "productTableBody"){<br>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pageVo  = new PageVoJs();<br>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//设置默认排序方式<br>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pageVo.setOrderStr("productid");<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>
											&nbsp;&nbsp;&nbsp;&nbsp;}<br>
										}<br>
									  <font color="red">
									  	  需要用户修改的地方：<br>
									  	  1，factoryTableBody: 显示参照页面内容的tableBody的id。<br>
									  	  2, pageVo.setOrderStr("factoryid");：设置默认排序方式。<br>
									  </font>
									</p>
									
									<p>
										/*<br>
										*根据参数获取参照页面显示的表头信息,需要用户修改<br>
										*/<br>
										function getListFields(tableBody){<br>
											&nbsp;&nbsp;&nbsp;&nbsp;if(tableBody == "factoryTableBody"){<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return getFactoryListFields();<br>
											&nbsp;&nbsp;&nbsp;&nbsp;} <br>
											&nbsp;&nbsp;&nbsp;&nbsp;if(tableBody == "productTableBody"){<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return getProductListFields();<br>
											&nbsp;&nbsp;&nbsp;&nbsp;} <br>
										}<br>
										  <br>
										 /*<br>
										 *返回工厂参照页面显示的表头信息,需要用户修改<br>
										 */<br>
										function getFactoryListFields(){<br>
											&nbsp;&nbsp;&nbsp;&nbsp;var column0 = buildSerial;<br>
										    &nbsp;&nbsp;&nbsp;&nbsp;//获得公共的checkbox的输出代码<br>
											&nbsp;&nbsp;&nbsp;&nbsp;var column1 = function(data){<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var checkObj = document.createElement("&lt;input type='checkbox'  name='checkbox_template' value='' /&gt;");<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;checkObj.value = data.factoryid+":"+data.name;<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return checkObj;<br>
											&nbsp;&nbsp;&nbsp;&nbsp;};<br>
											&nbsp;&nbsp;&nbsp;&nbsp;var column2=  function(data) { return data['factoryid']};<br>
										   	&nbsp;&nbsp;&nbsp;&nbsp;var column3 = function(data) { return data.name};<br>
											&nbsp;&nbsp;&nbsp;&nbsp;return [column0,column1,column2,column3];<br>
										}<br>
										 /*<br>
										 *返回产品参照页面显示的表头信息,需要用户修改<br>
										 */<br>
										function getProductListFields(){<br>
											&nbsp;&nbsp;&nbsp;&nbsp;var column0 = buildSerial;<br>
										    &nbsp;&nbsp;&nbsp;&nbsp;//获得公共的checkbox的输出代码<br>
											&nbsp;&nbsp;&nbsp;&nbsp;var column1 = function(data){<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var checkObj = document.createElement("&lt;input type='checkbox'  name='checkbox_template' value='' /&gt;");<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;checkObj.value = data.productid+":"+data.name;<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return checkObj;<br>
											&nbsp;&nbsp;&nbsp;&nbsp;};<br>
											&nbsp;&nbsp;&nbsp;&nbsp;var column2=  function(data) { return data['productid']};<br>
										   	&nbsp;&nbsp;&nbsp;&nbsp;var column3 = function(data) { return data.name};<br>
											&nbsp;&nbsp;&nbsp;&nbsp;return [column0,column1,column2,column3];<br>
										}<br>
											
									  <font color="red">
									  	  需要用户修改的地方：<br>
									  	  1，getListFields: 根据显示参照页面内容的tableBody的id返回不同的表头数组。<br>
									  	  2, getFactoryListFields：组装表头数据。<br>
									  </font>
									</p>
								</p>
							</td>
						</tr>
					</tbody>
				</table>
            </div>
        </div>


<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>