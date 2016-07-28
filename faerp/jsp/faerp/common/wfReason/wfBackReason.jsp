<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<title>编写驳回原因</title>
<script>
	function save_onClick(){  //提交页面
		var elementReason = document.getElementById("reason_text");
		if(elementReason.value.trim() == "") {
	  		alert("请填写驳回原因!");
	  		elementReason.value="";
	  		return;
		}
		var returnArray = new Array();
		//alert("1111"+elementReason.value);
		returnArray[0] = elementReason.value;
		window.returnValue = returnArray;
		window.close();
  	}
	function close_onClick(){  //关闭页面
		window.close();
  	}
  	
  	String.prototype.trim   =   function()
{
         //   用正则表达式将前后空格
         //   用空字符串替代。
         return   this.replace(/(^\s*)|(\s*$)/g,   "");
}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('编写驳回原因','<venus:base/>/');
</script>
<form name="form" method="post">
<table class="table_noframe">
	<tr>
		<td valign="right">
			<input name="button_save" type="button" class="button_ellipse" value="确定" onClick="save_onClick()">
			<input name="button_close" type="button" class="button_ellipse" value="关闭" onClick="close_onClick()">
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">编写驳回原因
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td align="right" width="15%">驳回原因</td>
		<td align="left" width="85%">
			<textarea id="reason_text" name="reason_text" cols="80" rows="8" style="width: 430px"></textarea>		
		</td>
	</tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>');
</script>
</body>
</html>