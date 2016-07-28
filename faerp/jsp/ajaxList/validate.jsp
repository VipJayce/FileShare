<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<title>数据验证例子</title>
<script src="<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwrsample/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwrsample/util.js" type="text/javascript"></script> 
<script>
	function eh(msg) { 
		alert(i18n.error_message+msg); 
		var div_msg=document.getElementById("msg");
  		div_msg.innerHTML=msg;
	} 
	function validate_onClick(){  //增加记录
		if(checkAllForms()==false) return;
		var person_name=dwr.util.byId("person_name");
			DWREngine.setErrorHandler(eh); 
			//DWREngine.setWarningHandler(eh);
			AjaxControl.validate(person_name.value,getMsg);
  	}
  	function getMsg(data){
  		var div_msg=document.getElementById("msg");
  		div_msg.innerHTML=data;
  	}
  	
  	function checkKeyDown(){
  		 if(event.keyCode==13){   
			  validate_onClick();   
		  }   
  	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('数据验证页面','<venus:base/>/');
</script>

<form name="form" method="post">
<input type="hidden" name="id" value="">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">数据验证
		</td>
	</tr>
</table>
</div>
<div id="msg">
</div>
<div id="ccChild1"> 
<table class="table_div_content">
	<tr> 
		<td align="right" width="20%" nowrap><fmt:message key="validate.guest_name"/>(<fmt:message key="validate.please_enter"/>"马啸")</td>
		<td align="left">
			<input name="person_name" id="person_name" type="text" value="" class="text_field" inputName="<fmt:message key="validate.guest_name"/>" validate="notNull"  onkeydown="checkKeyDown()">
			<input name="button_save" type="button" class="button_ellipse" value="<fmt:message key="validate.verification"/>" onClick="javascript:validate_onClick();">
	</tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>