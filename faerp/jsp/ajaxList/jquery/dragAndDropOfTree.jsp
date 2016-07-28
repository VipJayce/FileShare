<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>


<!--提示框，选择框，确认框控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-simple.tree.js"></script>

<style>
body
{
	font: normal 12px arial, tahoma, helvetica, sans-serif;
	margin:0;
	padding:20px;
}
.simpleTree
{
	
	margin:0;
	padding:0;
	/*
	overflow:auto;
	width: 250px;
	height:350px;
	overflow:auto;
	border: 1px solid #444444;
	*/
}
.simpleTree li
{
	list-style: none;
	margin:0;
	padding:0 0 0 34px;
	line-height: 14px;
}
.simpleTree li span
{
	display:inline;
	clear: left;
	white-space: nowrap;
}
.simpleTree ul
{
	margin:0; 
	padding:0;
}
.simpleTree .root
{
	margin-left:-16px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/root.gif) no-repeat 16px 0 #ffffff;
}
.simpleTree .line
{
	margin:0 0 0 -16px;
	padding:0;
	line-height: 3px;
	height:3px;
	font-size:3px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/line_bg.gif) 0 0 no-repeat transparent;
}
.simpleTree .line-last
{
	margin:0 0 0 -16px;
	padding:0;
	line-height: 3px;
	height:3px;
	font-size:3px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/spacer.gif) 0 0 no-repeat transparent;
}
.simpleTree .line-over
{
	margin:0 0 0 -16px;
	padding:0;
	line-height: 3px;
	height:3px;
	font-size:3px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/line_bg_over.gif) 0 0 no-repeat transparent;
}
.simpleTree .line-over-last
{
	margin:0 0 0 -16px;
	padding:0;
	line-height: 3px;
	height:3px;
	font-size:3px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/line_bg_over_last.gif) 0 0 no-repeat transparent;
}
.simpleTree .folder-open
{
	margin-left:-16px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/collapsable.gif) 0 -2px no-repeat #fff;
}
.simpleTree .folder-open-last
{
	margin-left:-16px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/collapsable-last.gif) 0 -2px no-repeat #fff;
}
.simpleTree .folder-close
{
	margin-left:-16px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/expandable.gif) 0 -2px no-repeat #fff;
}
.simpleTree .folder-close-last
{
	margin-left:-16px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/expandable-last.gif) 0 -2px no-repeat #fff;
}
.simpleTree .doc
{
	margin-left:-16px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/leaf.gif) 0 -1px no-repeat #fff;
}
.simpleTree .doc-last
{
	margin-left:-16px;
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/leaf-last.gif) 0 -1px no-repeat #fff;
}
.simpleTree .ajax
{
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/spinner.gif) no-repeat 0 0 #ffffff;
	height: 16px;
	display:none;
}
.simpleTree .ajax li
{
	display:none;
	margin:0; 
	padding:0;
}
.simpleTree .trigger
{
	display:inline;
	margin-left:-32px;
	width: 28px;
	height: 11px;
	cursor:pointer;
}
.simpleTree .text
{
	cursor: default;
}
.simpleTree .active
{
	cursor: default;
	background-color:#F7BE77;
	padding:0px 2px;
	border: 1px dashed #444;
}
#drag_container
{
	background:#ffffff;
	color:#000;
	font: normal 11px arial, tahoma, helvetica, sans-serif;
	border: 1px dashed #767676;
}
#drag_container ul
{
	list-style: none;
	padding:0;
	margin:0;
}

#drag_container li
{
	list-style: none;
	background-color:#ffffff;
	line-height:18px;
	white-space: nowrap;
	padding:1px 1px 0px 16px;
	margin:0;
}
#drag_container li span
{
	padding:0;
}

#drag_container li.doc, #drag_container li.doc-last
{
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/leaf.gif) no-repeat -17px 0 #ffffff;
}
#drag_container .folder-close, #drag_container .folder-close-last
{
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/expandable.gif) no-repeat -17px 0 #ffffff;
}

#drag_container .folder-open, #drag_container .folder-open-last
{
	background: url(<%=request.getContextPath()%>/images/ajaxList/tree/collapsable.gif) no-repeat -17px 0 #ffffff;
}

</style>


<title>提示框</title>
	
	
<script type="text/javascript">
	var simpleTreeCollection;
    $(function() {
        $('#container-1 > ul').tabs();//tab控件初始化
        	
		simpleTreeCollection = $('.simpleTree').simpleTree({
			autoclose: false,
			afterClick:function(node){
				//alert("text-"+$('span:first',node).text());
			},
			afterDblClick:function(node){
				//alert("text-"+$('span:first',node).text());
			},
			afterMove:function(destination, source, pos){
				//alert("destination-"+destination.attr('id')+" source-"+source.attr('id')+" pos-"+pos);
			},
			afterAjax:function()
			{
				//alert('Loaded');
			}
			//animate:true
			//,docToFolderConvert:true
		});
        	
        	
	});

</script>


</head>
<body>
<script language="javascript">
	writeTableTop('提示框','<venus:base/>/');
</script>
        <div id="container-1">
            <ul>
                <li><a href="#fragment-1"><span>示例演示</span></a></li>
                <li><a href="#fragment-2"><span>源码讲解</span></a></li>


            </ul>
            <div id="fragment-1" class="table_div_content">

				<ul class="simpleTree">
					<li class="root" id='1'><span>Tree Root 1</span>
						<ul>
							
							<li class="open" id='2'><span>Tree Node 1</span>
								<ul>
									
									<li id='3'><span>Tree Node 1-1</span>
										<ul class="ajax">
											<li id='4'>{url:loadTree.php?tree_id=1}</li>
										</ul>
									</li>
									
								</ul>
							</li>
							
							<li id='5'><span>Tree Node 2</span>
								<ul>
									
									<li id='6'><span>Tree Node 2-1</span>
										<ul>
											
											<li id='7'><span>Tree Node 2-1-1</span></li>
											
											<li id='8'><span>Tree Node 2-1-2</span></li>
											
											<li id='9'><span>Tree Node 2-1-3</span></li>
											
											<li id='10'><span>Tree Node 2-1-4</span>
												<ul class="ajax">
													<li id='11'>{url:loadTree.php?tree_id=1}</li>
												</ul>
											</li>
											
										</ul>
									</li>
									
									<li id='12'><span>Tree Node 2-2</span>
										<ul>
											
											<li id='13'><span>Tree Node 2-2-1</span></li>
											
										</ul>
									</li>
									
									
									<li id='14'><span>Tree Node 2-3</span>
										<ul>
											
											<li id='15'><span>Tree Node 2-3-1</span>
													<ul>
														
														<li id='16'><span>Tree Node 2-3-1-1</span></li>
														
														<li id='17'><span>Tree Node 2-3-1-2</span></li>
														
														<li id='18'><span>Tree Node 2-3-1-3</span>
															<ul>
																
																<li id='19'><span>Tree Node 2-3-1-3-1</span></li>
																
															</ul>
														</li>
														
														<li id='20'><span>Tree Node 2-3-1-4</span></li>
														
														<li id='21'><span>Tree Node 2-3-1-5</span></li>
														
														<li id='22'><span>Tree Node 2-3-1-6</span>
															<ul>
																
																<li id='23'><span>Tree Node 2-3-1-6-1</span></li>
																
															</ul>
														</li>
														
														<li id='24'><span>Tree Node 2-3-1-7</span></li>
														
														<li id='25'><span>Tree Node 2-3-1-8</span></li>
														
														<li id='26'><span>Tree Node 2-3-1-9</span>
															<ul>
																
																<li id='27'><span>Tree Node 2-3-1-9-1</span></li>
																
															</ul>
														</li>
														
													</ul>
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
								<p >1.需要引入的js文件:<br>
								/js/ajax/tree/jquery-simple.tree.js<br>
								</p>
								<p >2.需要填写的js方法:<br>
									simpleTreeCollection = $('.simpleTree').simpleTree({<br>
									&nbsp;&nbsp;autoclose: true,<br>
									&nbsp;&nbsp;afterClick:function(node){<br>
									&nbsp;&nbsp;&nbsp;&nbsp;//alert("text-"+$('span:first',node).text());<br>
									&nbsp;&nbsp;},<br>
									&nbsp;&nbsp;afterDblClick:function(node){<br>
									&nbsp;&nbsp;&nbsp;&nbsp;//alert("text-"+$('span:first',node).text());<br>
									&nbsp;&nbsp;},<br>
									&nbsp;&nbsp;afterMove:function(destination, source, pos){<br>
									&nbsp;&nbsp;&nbsp;&nbsp;//alert("destination-"+destination.attr('id')+" source-"+source.attr('id')+" pos-"+pos);<br>
									&nbsp;&nbsp;},<br>
									&nbsp;&nbsp;afterAjax:function()<br>
									&nbsp;&nbsp;{<br>
									&nbsp;&nbsp;&nbsp;&nbsp;//alert('Loaded');<br>
									&nbsp;&nbsp;}<br>
									});<br>
									<font color="red">
										参数解释:<br>
										1.autoclose:点击其他节点，上个节点下的子节点是否自动收缩。值为“true/false”。<br>
										2.afterClick:响应当前节点的鼠标单击事件。node参数代表当前节点对象。<br>
										3.afterDblClick:响应当前节点的鼠标双击事件。node参数代表当前节点对象。<br>
										4.afterMove:响应当前节点的拖拽到其他节点下的事件。destination代表目标节点的li的id，source代表当前节点的li的id，pos代表节点移动后属于第几级节点。<br>
										5.afterAjax:响应动态的记载子节点事件。<br>
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