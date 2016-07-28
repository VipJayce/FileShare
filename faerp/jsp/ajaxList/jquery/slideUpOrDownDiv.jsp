<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<!-- firefox中,需要把上面的语句删除 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<!--tab控件的样式-->
<link rel="stylesheet" href="<venus:base/>/css/ajax/jquery/tab/jquery-tabs.css" type="text/css">
<!--tab控件的js文件-->
<script language="javascript" src="<venus:base/>/js/jquery/ui.core.js"></script>
<script language="javascript" src="<venus:base/>/js/jquery/ui.tabs.js"></script>
	
<script language="javascript" src="<venus:base/>/js/ajax/gap-ajaxList-jquery.js"></script>

<title>层的收放效果</title>
<script type="text/javascript">
    jQuery(function() {
        jQuery('#container-1 > ul').tabs();//tab控件初始化
        	
  		 //层的收缩start
  		 var idMap = {"image0":"ccChild0","image1":"ccChild1"};
		slideUpOrDown(idMap);
		//层的收缩end
	});
</script>


</head>
<body>
<script language="javascript">
	writeTableTop('层的收放效果','<venus:base/>/');
</script>
        <div id="container-1">
            <ul>
                <li><a href="#fragment-1"><span>示例演示</span></a></li>
                <li><a href="#fragment-2"><span>源码讲解</span></a></li>


            </ul>
            <div id="fragment-1" class="table_div_content">
				<!-- 查询开始 -->
				<div id="ccParent0"> 
				<table class="table_div_control">
					<tr> 
						<td>
							<!--<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">-->
							<img src="<venus:base/>/images/icon/07-0.gif" id="image0" class="div_control_image">
							按条件查询
						</td>
					</tr>
				</table>
				</div>
				<div id="ccChild0"> 
				<table class="table_div_content">
				<tr>
					<td align="right" width="10%" nowrap>书名</td>
					<td>
						<input name="bookName" type="text" class="text_field" inputName="书名" validate="isSearch" rubber_id="build_Id">
					</td>
				</tr>
				<tr>
					<td align="right" width="10%" nowrap>作者</td>
					<td><input name="author" type="text" class="text_field" inputName="作者" validate="isSearch">
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
								<p>1.需要在代码的第一行定义下面的语句:<br>
								<font color="red">
									&lt;!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"&gt;
								</font>
								</p>
								<p>2.需要引入的js文件<br>
								/js/ajax/gap-ajaxList-jquery.js<br>
								</p>
								<p >3.需要填写的js方法:<br>
									jQuery(function() {<br>
									&nbsp;&nbsp;var idMap = {"image0":"ccChild0","image1":"ccChild1"};<br>
									&nbsp;&nbsp;slideUpOrDown(idMap);<br>
									});<br>
									<font color="red">
									idMap中的键是图片的id值，值是要收放的层的id值。调用slideUpOrDown方法执行层的收放。
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