<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<!--提示框，选择框，确认框控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/dialog/jquery-dialog.css" type="text/css">
<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>

<!--提示框，选择框，确认框控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-impromptu.1.8.js"></script>
<!--输入框限制的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/plugin/jquery-maskedinput-1.2.1.pack.js"></script>

<title>输入框限制</title>
<script type="text/javascript">
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
        	
		jQuery.mask.definitions['~']='[+-]';
		jQuery('#date').mask('99/99/9999');
		jQuery('#phone').mask('(999) 999-9999');
		jQuery('#phoneext').mask("(999) 999-9999? x99999");
		jQuery("#tin").mask("99-9999999");
		jQuery("#ssn").mask("999-99-9999");
		//jQuery("#product").mask("a*-999-a999",{placeholder:" ",completed:function(){alert("You typed the following: "+this.val());}});
		jQuery("#product").mask("a*-999-a999",{placeholder:" ",completed:function(){$.prompt("You typed the following: "+this.val());}});
		jQuery("#eyescript").mask("~9.99 ~9.99 999");

	});



</script>


</head>
<body>
<script language="javascript">
	writeTableTop('输入框限制','<venus:base/>/');
</script>
        <div id="container-1" >
            <ul>
                <li><a href="#fragment-1"><span>示例演示</span></a></li>
                <li><a href="#fragment-2"><span>源码讲解</span></a></li>


            </ul>
            <div id="fragment-1" class="table_div_content"> 
				<table class="table_div_content">
					<tbody>
						<tr>
							<td>Date</td>

							<td><input id="date" type="text" tabindex="1" class="text_field" /></td>
							<td>99/99/9999</td>
						</tr>
						<tr>
							<td>Phone</td>
							<td><input id="phone" type="text" tabindex="3" class="text_field"/></td>
							<td>(999) 999-9999</td>
						</tr>
						<tr>
							<td>Phone + Ext</td>
							<td><input id="phoneext" type="text" tabindex="4" class="text_field"/></td>
							<td>(999) 999-9999? x99999</td>

						</tr>
						<tr>
							<td>Tax ID</td>
							<td><input id="tin" type="text" tabindex="5" class="text_field"/></td>
							<td>99-9999999</td>
						</tr>
						<tr>
							<td>SSN</td>
							<td><input id="ssn" type="text" tabindex="6" class="text_field"/></td>
							<td>999-99-9999</td>
						</tr>
						<tr>
							<td>Product Key</td>

							<td><input id="product" type="text" tabindex="7" class="text_field"/></td>
							<td>a*-999-a999</td>
						</tr>
						<tr>
							<td>Eye Script</td>
							<td><input id="eyescript" type="text" tabindex="8" class="text_field"/></td>
							<td>~9.99 ~9.99 999</td>
						</tr>
					</tbody>
				</table>

            </div>
            <div id="fragment-2" class="table_div_content">
            	<table class="table_div_content">
					<tbody>
						<tr>
							<td style="font-size:12px">
								<p >1.需要引入的js文件:<br>
								&nbsp;&nbsp;&nbsp;&nbsp;/js/jquery/plugin/jquery-maskedinput-1.2.1.pack.js<br>
								</p>
								<p >2.需要填写的js方法:<br>
									jQuery(function() {<br>
									&nbsp;&nbsp;&nbsp;&nbsp;jQuery.mask.definitions['~']='[+-]';<br>
									&nbsp;&nbsp;&nbsp;&nbsp;jQuery('#date').mask('99/99/9999');<br>
									&nbsp;&nbsp;&nbsp;&nbsp;jQuery('#phone').mask('(999) 999-9999');<br>
									&nbsp;&nbsp;&nbsp;&nbsp;jQuery('#phoneext').mask("(999) 999-9999? x99999");<br>
									&nbsp;&nbsp;&nbsp;&nbsp;jQuery("#tin").mask("99-9999999");<br>
									&nbsp;&nbsp;&nbsp;&nbsp;jQuery("#ssn").mask("999-99-9999");<br>
									&nbsp;&nbsp;&nbsp;&nbsp;jQuery("#product").mask("a*-999-a999",{placeholder:" ",completed:function(){$.prompt("You typed the following: "+this.val());}});<br>
									&nbsp;&nbsp;&nbsp;&nbsp;jQuery("#eyescript").mask("~9.99 ~9.99 999");<br>
									});<br>
									<br>
									<font color="red">
									请注意:<br>
									1.jQuery.mask.definitions['~']='[+-]':定义“~”为“+-”中任一一个符号<br>
									2.9:代表一个数字，(0-9)。<br>
									3.a:代表一个字符，(A-Z,a-z)。<br>
									4.*:代表数字或者字符， (A-Z,a-z,0-9)。<br>
									5,jQuery('#date').mask('99/99/9999',{placeholder:" "}):改变占位符，把“_”改变为“ ”，例如原先为“__/__/____”，改变成“  /  /    ”。<br>
									6,jQuery("#product").mask("a*-999-a999",{placeholder:" ",completed:function(){$.prompt("You typed the following: "+this.val());}}):当用户输入数据后调用completed定义的方法，this.val()表示获取用户输入的数据。
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