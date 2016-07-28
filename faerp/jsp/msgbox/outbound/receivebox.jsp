<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.msg.util.VoHelperTools" %>

<title><fmt:message key='gap.message.Query_Template' bundle='${applicationMessageResources}' /></title>
<script>
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "receivebox";
    	form.submit();
  	}
	function detail_onClick(){
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id =  elementCheckbox[i].value ;
			}
		}
		if(number>1) {
			alert("<fmt:message key='gap.message.Can_only_select_a_record' bundle='${applicationMessageResources}' />!")
	  		return;
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.message.Please_select_a_record' bundle='${applicationMessageResources}' />!")
	  		return;
		}
		form.action = "<venus:base/>/MessageAction.do?cmd=findByMessageWithUserId&messageid=" + id;
		form.submit();
	}
	
	function reply_onClick(){
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id =  elementCheckbox[i].value ;
			}
		}
		if(number>1) {
			alert("<fmt:message key='gap.message.Can_only_select_a_record' bundle='${applicationMessageResources}' />!")
	  		return;
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.message.Please_select_a_record' bundle='${applicationMessageResources}' />!")
	  		return;
		}
		form.action = "<venus:base/>/MessageAction.do?cmd=replyMessage&messageid=" + id;
		form.submit();
	}
	
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids += elementCheckbox[i].value + ",";
			}
		}
		if(ids.length>0) {
			ids = ids.substr(0,ids.length-1);	
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.message.Please_delete' bundle='${applicationMessageResources}' />!")
	  		return;
		}
		if(confirm("<fmt:message key='gap.message.It_completely_remove_the_data_' bundle='${applicationMessageResources}' />")) {
	    	form.action="<venus:base/>/MessageAction.do?cmd=deleteMessage&ids=" + ids+"&subject=RECEIVER";
    		form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		window.location="<venus:base/>/jsp/msgbox/inbound/content.jsp";
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.message.Inbox' bundle='${applicationMessageResources}' />",'<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>//MessageAction.do">
<input type="hidden" name="cmd" value="">

<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			<fmt:message key='gap.message.Conditional_Query' bundle='${applicationMessageResources}' />
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap>标题</td>
	<td>
		<input name="messagetitle" type="text" class="text_field" validate="isSearch">
	</td>
	<td align="right" width="10%" nowrap>发送人</td>
	<td><input name="messagefrom" type="text" class="text_field" validate="isSearch">
	</td>
</tr>
<tr>
 	<td width="15%" align='right'>发送时间</td>
 	<td width="30%" align="left">
	<input id='in_start_time' type="text" class="text_field_half_reference_readonly" name='in_start_time' /><img src='<venus:base/>/js/calendar/images/day_arrow.gif' onClick="javascript:getYearMonthDay('in_start_time','<venus:base/>/');"  title="Calendar" class="img_1" style="cursor:hand;"/>&nbsp;<fmt:message key='gap.message.To_' bundle='${applicationMessageResources}' />&nbsp;<input id='in_end_time' type="text" class="text_field_half_reference_readonly"  name='in_end_time' /><img src='<venus:base/>/js/calendar/images/day_arrow.gif' onClick="javascript:getYearMonthDay('in_end_time','<venus:base/>/');"  title="Calendar" class="img_1" style="cursor:hand;"/> &nbsp;&nbsp;&nbsp;&nbsp;
 	</td> 
	<td align="right">是否已读</td>
	<td align="left"><input type="radio" name="readflag" value="0" />已读<input type="radio" name="readflag" value="1"/>未读</td>
 </tr>
<tr>
	<td  align="right" width="10%" nowrap>
	<input type="button" name="Submit" class="button_ellipse" value='查询' onClickTo="javascript:simpleQuery_onClick();">
	</td>
	<td>
	<input name="del" type="reset" id="del" value='删除信息' class="button_ellipse">
	</td>
</tr>

</table>
</div>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.message.Details_Form' bundle='${applicationMessageResources}' />
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.message.Create' bundle='${applicationMessageResources}' /></td>
					<td class="button_ellipse" onClick="javascript:reply_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.message.Reply' bundle='${applicationMessageResources}' /></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message key='gap.message.Delete' bundle='${applicationMessageResources}' /></td>
					<td class="button_ellipse" onClick="javascript:detail_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.message.Detailed' bundle='${applicationMessageResources}' /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td>
			<layout:collection name="wy" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
						<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
							<bean:define id="wy3" name="wy1" property="id"/>
							<input type="checkbox" name="checkbox_template" value="<%=wy3%>"/>
						</layout:collectionItem>
						<layout:collectionItem width="5%"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.message.Sequence") %>' style="text-align:center;">
							<venus:sequence/>
						</layout:collectionItem>
						<layout:collectionItem width="20%" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.message.Title") %>' property="msgTitle"/>
						<layout:collectionItem width="10%" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.message.From") %>' property="from"/>
						<layout:collectionItem width="30%" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.message.Addressee") %>'>
							<bean:define id="wy6" name="wy1" property="msgTo" type= "java.util.Collection" /> 
							<logic:iterate id="wy7" name="wy6">
								<bean:write name="wy7"/>
							</logic:iterate>
						</layout:collectionItem>
						<layout:collectionItem width="20%" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.message.Send_time") %>' property="sendTime"/>
						<layout:collectionItem width="10%" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.message.It_reads") %>'>
							<bean:define id="wy8" name="wy1" property="properties" type= "java.util.Map" /> 
							<bean:define id="wy9" name="wy8" property='msg_readflag' type="java.lang.String"/>
							<%=wy9.equals("1")?venus.frames.i18n.util.LocaleHolder.getMessage("gap.message.Unread"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.message.Has_read")%>
						</layout:collectionItem>
			</layout:collection>
			<jsp:include page="/jsp/include/page.jsp" />
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

