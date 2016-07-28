<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<!--提示框，选择框，确认框控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/dialog/jquery-dialog.css" type="text/css">
<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<script language="javascript" src="<venus:base/>/js/ajax/gap-ajaxList-jquery.js"></script>
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>

<!--提示框，选择框，确认框控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-impromptu.1.8.js"></script>

<!--双列表选取控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-doublemultipleselect.js"></script>
	
<title>双列表选取</title>
<script type="text/javascript">
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化

		jQuery("#select_left").multiSelect("#select_right", {trigger: "#options_right"});
		jQuery("#select_right").multiSelect("#select_left", {trigger: "#options_left"});
	});


    
	function findLeftSelect_onClick() {  //从左多选框取值
		var selectVal=getListBoxBySelectid("select_left");
		jQuery.prompt('左选框的值为='+selectVal);//提示框
	}
	
	function findRightSelect_onClick() {  //从右多选框取值
		var selectVal=getListBoxBySelectid("select_right");
		jQuery.prompt('右选框的值为='+selectVal);//提示框
	}

	/*
	 *选中一个的option上移，上移到顶部后停止上移
	 *选中多个的option上移，上移到顶部后停止上移
	 */
	function upRightSelect_onClick(){
		selected_options=jQuery("#select_right option:selected");
		selected_options.each(function(){
			var j = jQuery("#select_right option").index(this);
			if(j==0) return false;

			var prevOption = jQuery(jQuery("#select_right option").get(j-1)).clone();
			jQuery(jQuery("#select_right option").get(j-1)).replaceWith(this);
			jQuery(jQuery("#select_right option").get(j-1)).after(prevOption);
		})
	}


	/*
	 *选中一个的option下移，下移到底部后停止下移
	 *选中多个的option下移，下移到底部后停止下移
	 */
	function downRightSelect_onClick(){
		//获取所有被选中的option集合
		selected_options=jQuery("#select_right option:selected");
		//把option集合倒序排列
		var reveser_options=new Array();
		selected_options.each(function(i) {
			reveser_options[selected_options.size()-i-1]=this;
		});
		//下移
		for(var i=0;i<reveser_options.length;i++){
			var j = jQuery("#select_right option").index(reveser_options[i]);
			//当最下被选中的option的序号到底的时候，停止循环
			if(j==jQuery("#select_right option").size()-1) return false;
			     //下一个节点克隆
				var nextOption = jQuery(jQuery("#select_right option").get(j+1)).clone();
				//把下个节点插在当前节点之前
				jQuery(jQuery("#select_right option").get(j)).before(nextOption);
				//删除下个节点
				jQuery(jQuery("#select_right option").get(j+2)).remove();
		}
	}
</script>


</head>
<body>
<script language="javascript">
	writeTableTop('双列表选取','<venus:base/>/');
</script>
        <div id="container-1">
            <ul>
                <li><a href="#fragment-1"><span>示例演示</span></a></li>
                <li><a href="#fragment-2"><span>源码讲解</span></a></li>


            </ul>
            <div id="fragment-1" class="table_div_content">
				<table class="table_noframe">
					<tr>
						<td valign="middle">
							<input name="button_save" type="button" class="button_ellipse" value="从左多选框取值" onClick="findLeftSelect_onClick()">
						</td>
						<td valign="middle">
							<input name="button_save" type="button" class="button_ellipse" value="从右多选框取值" onClick="findRightSelect_onClick()">
						</td>
					</tr>
				</table>
				<table>
				  <tr>
				     <td align="right" width="20%" nowrap><select name="left[]" id="select_left" multiple="multiple" size="6">
				        <option value="Item 1 value">Item 1</option>
				        <option value="Item 2 value">Item 2</option>
				        <option value="Item 3 value">Item 3</option>
				        <option value="Item 4 value">Item 4</option>
				     </select></td>
				     
				     <td align="middle" width="5%">
				        <p><a id="options_right" href="#">
				           <img src="<venus:base/>/images/ajaxList/arrow_right.gif" alt="&gt;" />
				        </a></p>

				       <p><a id="options_left" href="#"> 
				           <img src="<venus:base/>/images/ajaxList/arrow_left.gif" alt="&lt;" />
				        </a></p>
				     </td>

				     <td align="left" width="20%">
					     <select name="right[]" id="select_right" multiple="multiple" size="6">
					        <option value="Item 5 value">Item 5</option>
					        <option value="Item 6 value">Item 6</option>
					        <option value="Item 7 value">Item 7</option>
					        <option value="Item 8 value">Item 8</option>
					     </select>
				    </td>

				     <td align="left" width="5%">
				        <p><a id="options_up" href="#">
				           <img src="<venus:base/>/images/ajaxList/arrow_up.gif" alt="上移" onclick="upRightSelect_onClick()"/>
				        </a></p>

				       <p><a id="options_down" href="#"> 
				           <img src="<venus:base/>/images/ajaxList/arrow_down.gif" alt="下移" onclick="downRightSelect_onClick()"/>
				        </a></p>
				     </td>
					<td width="50%">
						&nbsp;
					</td>
				  </tr>
				</table>

            </div>
            <div id="fragment-2" class="table_div_content">
            	<table class="table_div_content">
					<tbody>
						<tr>
							<td style="font-size:12px">
								<p >1.需要引入的js文件:<br>
								/js/jquery/plugin/jquery-doublemultipleselect.js<br>
								</p>
								<p>2.需要填写的HTML语句<br>
								多选框HTML语句样例如下<br>
							     &nbsp;&nbsp;&nbsp;&nbsp;&lt;select name="right[]" id="select_right" multiple="multiple" size="6"&gt;   <br>
							     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;option value="Item 5 value"&gt;Item 5&lt;/option&gt;<br>
							     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;option value="Item 6 value"&gt;Item 6&lt;/option&gt;<br>
							     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;option value="Item 7 value"&gt;Item 7&lt;/option&gt;<br>
							     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;option value="Item 8 value"&gt;Item 8&lt;/option&gt;<br>
							     &nbsp;&nbsp;&nbsp;&nbsp;&lt;/select&gt;<br>
							     
							     按钮用例如下:<br>
								&nbsp;&nbsp;&nbsp;&lt;a id="options_right" href="#"&gt;<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;img src="&lt;venus:base/&gt;/images/ajaxList/arrow_right.gif" alt="&gt;" /&gt;<br>
								&nbsp;&nbsp;&nbsp;&lt;/a&gt;<br>
								</p>
								<p >2.需要填写的js方法:<br>
								&nbsp;&nbsp;&nbsp;&nbsp;jQuery("#select_left").multiSelect("#select_right", {trigger: "#options_right"});<br>
								<font color="red">
								参数解释:<br>
								1.#select_left:表示多选框的id。<br>
								2.#select_right:表示目标多选框的id。<br>
								3,trigger: "#options_right":trigger参数表示选择多选框中的选项往目标多选框中添加的事件，options_right表示触发该事件按钮的id。<br>
								</font>
								</p>
								<p>3.获取列表中的值<br>
									1.需要引入的js文件<br>
									/js/ajax/gap-ajaxList-jquery.js<br>
									2.需要编写的js语句<br>
									var selectVal=getListBoxBySelectid("select_left");<br>
									参数解释:<br>
									<font color="red">select_left:是列表的id。</font>
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