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


<title>单选框，复选框取值</title>
<script type="text/javascript">
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
	});
	function findCheckbox_onClick() {  //从多选框取值
		if(getCheckBoxSizeByName("checkbox_template")==0){
	  		jQuery.prompt('请选择一条记录!');//提示框
			return ;
		}

		jQuery.prompt(getCheckBoxValByName("checkbox_template"));
	}
	
	function findradio_onClick() {  //从单选框取值
		if(getCheckBoxSizeByName("radio_template")==0){
	  		jQuery.prompt('请选择一条记录!');//提示框
			return ;
		}
		
		jQuery.prompt(getRadioValByName("radio_template"));
	}
</script>


</head>
<body>
<script language="javascript">
	writeTableTop('单选框，复选框取值','<venus:base/>/');
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
							<input name="button_save" type="button" class="button_ellipse" value="复选框取值" onClick="findCheckbox_onClick()">
						</td>
						<td valign="middle">
							<input name="button_save" type="button" class="button_ellipse" value="单选框取值" onClick="findradio_onClick()">
						</td>
					</tr>
				</table>
				<table class="table_div_content">
					<tr> 
						<td align="right" width="10%" nowrap><font color="red">*</font>楼栋名称</td>
						<td align="left">
							<input type="checkbox" name="checkbox_template" value="太平家园_value"/>太平家园
						</td>
						<td align="left">
							<input type="checkbox" name="checkbox_template" value="北苑家园_value"/>北苑家园
						</td>
						<td align="left">
							<input type="checkbox" name="checkbox_template" value="百万家园_value"/>百万家园
						</td>
					</tr>
					<tr> 
						<td align="right" width="10%" nowrap><font color="red">*</font>楼栋类型</td>
						<td align="left">
							<input type="radio" name="radio_template" value="经济适用房_value"/>经济适用房
						</td>
						<td align="left">
							<input type="radio" name="radio_template" value="两限房_value"/>两限房
						</td>
						<td align="left">
							<input type="radio" name="radio_template" value="商品房_value"/>商品房
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
								&nbsp;&nbsp;&nbsp;&nbsp;/js/ajax/gap-ajaxList-jquery.js<br>
								</p>
								<p >2.复选框的HTML语句样例:<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&lt;input type="checkbox" name="checkbox_template" value="太平家园_value"/&gt;太平家园<br>
								</p>
								<p>3.单选框的HTML语句样例：<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&lt;input type="radio" name="radio_template" value="经济适用房_value"/&gt;经济适用房<br>
								</p>
								<p>4.获取被选中的复选框或者单选框的个数的jsp语句：<br>
									&nbsp;&nbsp;&nbsp;&nbsp;getCheckBoxSizeByName("checkbox_template")<br>
									<font color="red">参数为单选框或者复选框的name值</font><br>
								</p>
								<p>5.获取被选中的复选框值的jsp语句：<br>
									&nbsp;&nbsp;&nbsp;&nbsp;getCheckBoxValByName("checkbox_template")<br>
									<font color="red">参数为复选框的name值</font><br>
								</p>
								<p>6.获取被选中的单选框值的jsp语句：<br>
									&nbsp;&nbsp;&nbsp;&nbsp;getRadioValByName("radio_template")<br>
									<font color="red">参数为单选框的name值</font><br>
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