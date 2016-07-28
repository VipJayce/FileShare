<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<!--多选下拉框的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/multipleselect/jquery-multipleselect.css.jsp" type="text/css">
<!--提示框，选择框，确认框控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/dialog/jquery-dialog.css" type="text/css">
<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>

<!--提示框，选择框，确认框控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-impromptu.1.8.js"></script>

<!--多选下拉框的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-multiSelect.js"></script>

<title>多选下拉框</title>
<script type="text/javascript">
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
        
        jQuery("#control_7").multiSelect({ oneOrMoreSelected: '*',id:"input_7",text:"input_9" });//在页面只有多个多选下拉框时使用
        	
        jQuery("#control_8").multiSelect({ oneOrMoreSelected: '*',id:"input_8",text: "input_10" });//在页面只有多个多选下拉框时使用
	});


    
	function getOne_onClick() {  //从多选框到修改页面
		jQuery.prompt("第一个多选下拉框的值"+jQuery("#input_7").val());//当前页面有多个多选下拉框时，可以使用此代码获取多选下拉框的值。
	}
	
	function getTwo_onClick() {  //从多选框到修改页面
		jQuery.prompt("第二个多选下拉框的值"+jQuery("#input_8").val());//当前页面有多个多选下拉框时，可以使用此代码获取多选下拉框的值。
	}
</script>


</head>
<body>
<script language="javascript">
	writeTableTop('多选下拉框','<venus:base/>/');
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
							<input name="button_save" type="button" class="button_ellipse" value="第一个下拉多选框取值" onClick="getOne_onClick()">
						</td>
						<td valign="middle">
							<input name="button_save" type="button" class="button_ellipse" value="第二个下拉多选框取值" onClick="getTwo_onClick()">
						</td>
					</tr>
				</table>
				<table class="table_div_content">
					<tr>
						<td align="right">下拉框多项选择的值-1</td>
						<td align="left">
							<input id="input_7" type="text" tabindex="7" class="text_field"/>
						</td>
						<td align="right">下拉框多项选择的值-2</td>
						<td align="left">
							<input id="input_8" type="text" tabindex="7" class="text_field"/>
						</td>
					</tr>
					<tr>
						<td align="right">下拉框多项选择的内容-1</td>
						<td align="left">
							<input id="input_9" type="text" tabindex="9" class="text_field"/>
						</td>
						<td align="right">下拉框多项选择的内容-2</td>
						<td align="left">
							<input id="input_10" type="text" tabindex="10" class="text_field"/>
						</td>
					</tr>

					<tr>
						<td align="right">下拉框多项选择-1</td>
						<td align="left">
								<select id="control_7" name="control_7[]" multiple="multiple" >
									<option value=""></option>
									<option value="option_71_value">Option 71</option>
									<option value="option_72_value">Option 72</option>
									<option value="option_73_value">Option 73</option>
									<option value="option_74_value">Option 74</option>
									<option value="option_75_value">Option 75</option>
									<option value="option_76_value">Option 76</option>
									<option value="option_77_value">Option 77</option>
								</select>
						</td>
						<td align="right">下拉框多项选择-2</td>
						<td align="left">
								<select id="control_8" name="control_8[]" multiple="multiple" >
									<option value=""></option>
									<option value="option_81_value">Option 81</option>
									<option value="option_82_value">Option 82</option>
									<option value="option_83_value">Option 83</option>
									<option value="option_84_value">Option 84</option>
									<option value="option_85_value">Option 85</option>
									<option value="option_86_value">Option 86</option>
									<option value="option_87_value">Option 87</option>
								</select>
						</td>
					</tr>
				</table>
            </div>
            <div id="fragment-2" class="table_div_content">
            	<table class="table_div_content">
					<tbody>
						<tr>
							<td style="font-size:12px">
								<p >1.需要引入的css文件:<br>
								/css/ajax/jquery/multipleselect/jquery-multipleselect.css.jsp<br>
								</p>
								<p >2.需要引入的js文件:<br>
								/js/ajax/multipleselect/jquery-multiSelect.js<br>
								</p>
								<p>3.需要填写的HTML语句样例<br>
								&lt;select id="control_7" name="control_7[]" multiple="multiple" &gt;<br>
									&lt;option value=""&gt;&lt;/option&gt;							<br>
									&lt;option value="option_71_value"&gt;Option 71&lt;/option&gt;<br>
									&lt;option value="option_72_value"&gt;Option 72&lt;/option&gt;<br>
									&lt;option value="option_73_value"&gt;Option 73&lt;/option&gt;<br>
									&lt;option value="option_74_value"&gt;Option 74&lt;/option&gt;<br>
									&lt;option value="option_75_value"&gt;Option 75&lt;/option&gt;<br>
									&lt;option value="option_76_value"&gt;Option 76&lt;/option&gt;<br>
									&lt;option value="option_77_value"&gt;Option 77&lt;/option&gt;<br>
								&lt;/select&gt;<br>
								</p>
								<p >4.需要填写的js方法:<br></p>
								<p>
							    jQuery(function() {<br>
							        jQuery("#control_7").multiSelect({ oneOrMoreSelected: '*',id:"input_7" });//在页面只有多个多选下拉框时使用<br>
								});<br>
								<font color="#FF0000">
									参数解释:<br>
									1.#control_7:表示下拉多选框的id。<br>
									2,oneOrMoreSelected:表示显示用户选择的多个选项之见的占位符，"*"表示用“,”分隔。<br>
									3,selectAll:是否在下拉列表中显示"Select All"选项。值为true/false。默认为true。<br>
									4,selectAllText:更改下拉列表中显示"Select All"选项的显示值，默认为"Select All"。<br>
									5,noneSelected:更改下拉菜单输入框的默认显示。默认为“Select options”。<br>
									6,id:选中的选项的值填充的控件的id值。
									7,text:选中的选项的内容填充的控件的id值。
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