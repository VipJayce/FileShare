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


<title>提示框</title>
<script type="text/javascript">
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
	});


    
	function findCheckbox_onClick() {  
			jQuery.prompt(i18n.please_select_a_record);//提示框
	}
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
				<div id="ccParent1"> 
				<table class="table_div_control">
					<tr > 
						<td>
							<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;提示框
						</td>
						<td> 
							<table>
								<tr> 
									<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image">请点击</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				</div>
            </div>
            <div id="fragment-2" class="table_div_content">
            	<table class="table_div_content">
					<tbody>
						<tr>
							<td style="font-size:12px">
								<p >1.需要引入的css文件:<br>
									&nbsp;&nbsp;&nbsp;&nbsp;/css/ajax/jquery/dialog/jquery-dialog.css<br>
								</p>
								<p >2.需要引入的js文件:<br>
									&nbsp;&nbsp;&nbsp;&nbsp;/js/jquery/plugin/jquery-impromptu.1.8.js<br>
								</p>
								<p >3.需要填写的js方法:<br>
									&nbsp;&nbsp;&nbsp;&nbsp;function findCheckbox_onClick() {  <br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;jQuery.prompt('请选择一条记录!');//提示框<br>
									&nbsp;&nbsp;&nbsp;&nbsp;}<br>
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