
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<!--多选数控件的css文件-->
<link type="text/css" rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tree/jquery-checktree.css.jsp" >	
	
<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>
<!--多选数控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-checktree.js"></script>


<title>多选树</title>
<script type="text/javascript">
    $(function() {
        $('#container-1 > ul').tabs();//tab控件初始化
        	
		$("ul.tree").checkTree({
			
			// You can add callbacks to the expand, collapse, check, uncheck, and  halfcheck
			// events of the tree. The element you use as the argument is the LI element of
			// the object that fired the event.
			onExpand: function(el) {
				//alert("expanded:  "+el.find("label:first").text());
			},
			onCollapse: function(el) {
				//alert("collapsed:  "+el.find("label:first").text());
			},
			onCheck: function(el) {
				//alert("checked text:  "+el.find("label:first").text());
				//alert("checked html:  "+el.html());
				//alert("checked value:  "+el.find("input:first").val());
			},
			onUnCheck: function(el) {
				//alert("un checked:  "+el.find("label:first").text());
			},
			onHalfCheck: function(el) {
				//alert("half checked:  "+el.find("label:first").text());
			}

			/*
			// You can set the labelAction variable to either "check" or "expand" 
			// to change what happens when you click on the label item.
			// The default is expand, which expands the tree. Check will toggle
			// the checked state of the items.
			labelAction: "expand"
			*/
			/*
			// You can also change what happens when you hover over a label (over and out)
			onLabelHoverOver: function(el) { alert("You hovered over " + el.text()); },
			onLabelHoverOut: function(el) { alert("You hovered out of " + el.text()); }
			*/
		});
        	
        	
	});

</script>


</head>
<body>
<script language="javascript">
	writeTableTop('多选树','<venus:base/>/');
</script>
        <div id="container-1">
            <ul>
                <li><a href="#fragment-1"><span>示例演示</span></a></li>
                <li><a href="#fragment-2"><span>源码讲解</span></a></li>


            </ul>
            <div id="fragment-1" >

				<ul class="tree" style="margin-left: 15px;">
					<li>
					    <input type="checkbox" value="earth">
					    <label>Earth</label>
						<ul>
							<li>
							    <input type="checkbox" value="United_States">
							    <label>United States</label>
							    <ul>
									<li>
									<input type="checkbox" name="geo" value="pennsylvania">
							        <label>Pennsylvania</label>
								    </li>
								</ul>
							</li>
							<li>
								<input type="checkbox" value="canadia">
								<label>Canadia</label>
								<ul>
									<li>
										<input type="checkbox" name="geo" value="province in canadia">
										<label>Province In Canadia</label>
									</li>
								</ul>
							</li>
							<li>
								<input type="checkbox" name="geo" value="afghanistan">
								<label>Afghanistan</label>
							</li>

							<li>
								<input type="checkbox" value="sealand">
							    <label>Sealand</label>
								<ul>
									<li>
										<input type="checkbox" name="geo" value="tree_city">
										<label>Tree City</label>
									</li>

									<li>
										<input type="checkbox" name="geo" value="oil_province">
										<label>Oil Province</label>
										<ul>
											<li>
												<input type="checkbox" name="geo" value="oil_city">
												<label>Oil City</label>
											</li>

										</ul>
									</li>
									<li>
										<input type="checkbox" value="fun_province_checkbox">
										<label>Fun Province</label>
										<ul>
											<li>
												<input type="checkbox" name="geo" value="fun_city">

													<label>Fun City</label>
												</li>
												<li>
													<input type="checkbox" name="geo" value="not_fun_city">
													<label>Not Fun City</label>
												</li>
											</ul>
										</li>

									</ul>
							    </li>
						</ul>
					</li>
				</ul>

            </div>
            <div id="fragment-2" class="table_div_content">
            	<table class="table_div_content">
					<tbody>
						<tr>
							<td style="font-size:12px">
								<p >1.需要引入的css文件:<br>
								&nbsp;&nbsp;/css/ajax/jquery/tree/jquery-checktree.css.jsp<br>
								</p>
								<p >2.需要引入的js文件:<br>
								&nbsp;&nbsp;/js/ajax/tree/jquery-checktree.js<br>
								</p>
								<p >3.显示多选树的HTML语句样例:<br>
									&lt;ul class="tree" style="margin-left: 15px;"&gt;<br>
									&nbsp;&nbsp;&lt;li&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;input type="checkbox" value="United_States"&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;label&gt;United States&lt;/label&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;ul&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;input type="checkbox" name="geo" value="pennsylvania"&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;label&gt;Pennsylvania&lt;/label&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/li&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;/ul&gt;<br>
									&nbsp;&nbsp;&lt;/li&gt;<br>
									&nbsp;&nbsp;&lt;li&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;input type="checkbox" value="fun_province_checkbox"&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;label&gt;Fun Province&lt;/label&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;ul&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;input type="checkbox" name="geo" value="fun_city"&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;label&gt;Fun City&lt;/label&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/li&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;li&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;input type="checkbox" name="geo" value="not_fun_city"&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;label&gt;Not Fun City&lt;/label&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/li&gt;<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/ul&gt;<br>
									&nbsp;&nbsp;&lt;/li&gt;<br>
									&lt;/ul&gt;<br>
								</p>
								<p>4.需要填写的js语句<br>
									&nbsp;&nbsp;$("ul.tree").checkTree({<br>
									&nbsp;&nbsp;&nbsp;&nbsp;onExpand: function(el) {<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//alert("expanded:  "+el.find("label:first").text());<br>
									&nbsp;&nbsp;&nbsp;&nbsp;},<br>
									&nbsp;&nbsp;&nbsp;&nbsp;onCollapse: function(el) {<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//alert("collapsed:  "+el.find("label:first").text());<br>
									&nbsp;&nbsp;&nbsp;&nbsp;},<br>
									&nbsp;&nbsp;&nbsp;&nbsp;onCheck: function(el) {<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//alert("checked text:  "+el.find("label:first").text());<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//alert("checked html:  "+el.html());<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//alert("checked value:  "+el.find("input:first").val());<br>
									&nbsp;&nbsp;&nbsp;&nbsp;},<br>
									&nbsp;&nbsp;&nbsp;&nbsp;onUnCheck: function(el) {<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//alert("un checked:  "+el.find("label:first").text());<br>
									&nbsp;&nbsp;&nbsp;&nbsp;},<br>
									&nbsp;&nbsp;&nbsp;&nbsp;onHalfCheck: function(el) {<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//alert("half checked:  "+el.find("label:first").text());<br>
									&nbsp;&nbsp;&nbsp;&nbsp;}<br>
									&nbsp;&nbsp;});<br>
									<font color="red">
									参数解释:<br>
									1.ul.tree:默认填写，不需要用户修改。<br>
									2.onExpand:节点展开的时候调用该方法。<br>
									3.onCollapse:节点收起的时候调用该方法。<br>
									4.onCheck:节点被选择的时候调用该方法。<br>
									5.onUnCheck:节点被反选的时候调用该方法。<br>
									6.onHalfCheck:子节点被选中或反选的时候，其逐级的父节点都会调用此方法。<br>
									7.el.html()：获取当前节点的HTML语句。<br>
									8.el.find("label:first").text()：获取当前节点的显示内容。<br>
									9.el.find("input:first").val():获取当前节点的多选框的值。
									</font>
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