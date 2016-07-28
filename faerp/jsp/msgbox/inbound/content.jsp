<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.msg.util.VoHelperTools" %>
<%@ page import="gap.msg.util.LoginControllerAdaptor" %>
<%@ page import="venus.frames.mainframe.util.Helper" %>
	<%
		String partyIdValue = "";
		LoginControllerAdaptor loginAdaptor=(LoginControllerAdaptor) Helper.getBean(LoginControllerAdaptor.ImplBeanName);
	%>
<title><fmt:message key='gap.message.Create_message' bundle='${applicationMessageResources}' /></title>
<script language="javascript" src="<%=request.getContextPath()%>/js/im/gap-message.js"></script>
<script>

	function insert_onClick(){  //增加记录
		if(document.form.msgTo.value==''){
			alert("<fmt:message key='gap.message.Please_select_the_recipient_' bundle='${applicationMessageResources}' />");
			return false;	
		}
		if(checkAllForms()){
    		form.action = "<venus:base/>/MessageAction.do?cmd=send";
    		form.submit();
    	}
  	}
  	function organizationRefrenceTree(inputHiden, inputShow){
	      getOrganizationTree(new Array(inputHiden,inputShow),
	    "<%=request.getContextPath()%>/",
	    "<%=request.getContextPath()%>/jsp/reference/deeptree.jsp"
	        +"?inputType=checkbox"
	        +"&enableCookie=true"
	        +"&submitType=submitAll"
	        +"&nodeRelationType=noRelation"
	        +"&rootXmlSource=<%=request.getContextPath()%>/jsp/reference/orgModel4Ref.jsp");
	}
	
	function getOrganizationTree(inputArray,path,deeptreePath,width,height){
	    if(path == undefined) {
	        path = "../../";
	    }
	    if(width == undefined) {
	        width = 550;
	    }
	    if(height == undefined) {
	        height = 550;
	    }
	    var myObject = new Object();
	    var rtObj = window.showModalDialog(deeptreePath,myObject,'dialogHeight='+height+'px;dialogWidth='+width+'px;');
	    toDoWriteOrganizationTree(inputArray, rtObj);
	}
	
	function toDoWriteOrganizationTree(inputArray,rtObj){
	    var textValue = inputArray[0];
	    var textName = inputArray[1];
	    if(rtObj != undefined && rtObj.length > 0){
	        var allTextValue = "";
	        var allTextName = "";
	        for(var i=0; i<rtObj.length -1; i++) {
	            allTextValue += rtObj[i]['returnValue'] + ";";
	            allTextName += rtObj[i]['childName'] + ",";
	        }
	        allTextValue += rtObj[rtObj.length-1]['returnValue'];
	        allTextName += rtObj[rtObj.length-1]['childName'];
	        textValue.value = allTextValue;
	        textName.value = allTextName;
	    } else {
	        return;
	    }
	}  	
</script>

</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.message.Create_message' bundle='${applicationMessageResources}' />",'<venus:base/>/');
</script>
<form name="form" method="post">
<input type="hidden" name="id" value="">
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value=<fmt:message key='gap.message.Send' bundle='${applicationMessageResources}' /> onClick="javascript:insert_onClick();">
			<input name="button_cancel" type="button" class="button_ellipse" value=<fmt:message key='gap.message.Cancel' bundle='${applicationMessageResources}' />  onClick="javascript:history.go(-1);">
		</td>
	</tr>
</table>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key='gap.message.Create_message' bundle='${applicationMessageResources}' />
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr> 
		<td align="right" width="10%" nowrap><fmt:message key='gap.message.SMS_Title' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<input name="id" type="hidden" value="<layout:write name='wy' property='id'/>">
			<input name="msgTitle" type="text" value="<layout:write name='wy' property='msgTitle'/>" class="text_field" inputName=<fmt:message key='gap.message.SMS_Title' bundle='${applicationMessageResources}' /> validate="notNull"></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='gap.message.From' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<input name="msgFrom" type="text" class="text_field" inputName=<fmt:message key='gap.message.From' bundle='${applicationMessageResources}' /> readonly value=<%=loginAdaptor.getOperName(request)%>>				
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='gap.message.Addressee' bundle='${applicationMessageResources}'  /></td>
		<td align="left">
			<input id="msgToUser" type="hidden" id="msgToUser" name="msgToUser" value="<layout:write name='wy' property='msgFromId'/>" />
			<input id="msgTo" readonly="readonly" id="msgTo"  name="msgTo"  class="text_field_reference" value="<layout:write name='wy' property='from'/>"/>
			<img src="<%=request.getContextPath()%>/images/icon/reference.gif" class="img_1"  onClick="javascript:organizationRefrenceTree(document.all('msgToUser'),document.all('msgTo'));"  title=<fmt:message key='gap.message.Organization' bundle='${applicationMessageResources}' /> style="cursor:hand;" />		
		</td>
	</tr>
		<tr>
		<td align="right"><fmt:message key='gap.message.Send_method' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<input name="sendChannel" type="checkbox" inputName=<fmt:message key='gap.message.Send_method' bundle='${applicationMessageResources}' /> value="msnmessage" >MSN&nbsp;&nbsp;
			<input name="sendChannel" type="checkbox" inputName=<fmt:message key='gap.message.Send_method' bundle='${applicationMessageResources}' /> value="mailmessage" >Email&nbsp;&nbsp;
			<input name="sendChannel" type="checkbox" inputName=<fmt:message key='gap.message.Send_method' bundle='${applicationMessageResources}' /> onclick="this.checked=!this.checked" value="webmessage" checked><fmt:message key='gap.message.Post_a_New_Message' bundle='${applicationMessageResources}' />(<fmt:message key='gap.message.Required' bundle='${applicationMessageResources}' />)
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='gap.message.SMS_content' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<textarea name="msgContent"  cols="60" rows="6" maxLength="1000" id="msgContent" class="textarea_limit_words"><layout:write name='wy' property='msgContent'/></textarea>			
		</td>
	</tr>
</table>
</div>
</form>
<jsp:include page="/jsp/msgbox/outbound/recevie.jsp" />
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>

