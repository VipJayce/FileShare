<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.Iterator"%>
<%@ page import="venus.pub.util.VoHelper" %>

<%@ page import="gap.warning.object.model.WarningObject"%>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<%  
        WarningObject warningObject=(WarningObject)request.getAttribute("vo");
        
        if(warningObject==null) warningObject=new WarningObject();
        
        VoHelper.null2Nothing(warningObject);
	%> 
<title><fmt:message key="jsp.warning_object_add"/></title>
<script>

	function insert_onClick(){  //增加记录
		if(checkAllForms()){
    		form.action = "<venus:base/>/WarningObjectAction.do?cmd=addWarningObject";
    		form.submit();
    	}
  	}

	
	function getInterfaceInfo(){//获取选择的BeanId的方法列表
		form.action="<venus:base/>/WarningObjectAction.do?cmd=getInterfaceInfo";
		form.submit();
	}
	
	function interface_onClick(){//显示选择BeanId页面
	   //window.showModalDialog("<venus:base/>/jsp/warning/interface/interfaceFrame.jsp",window);
	
		var obj=window.showModalDialog("<venus:base/>/jsp/warning/interface/interfaceFrame.jsp",'','dialogHeight:350px;dialogWidth:450px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
        if(obj){
            document.form.beanId.value = obj[0];
            getInterfaceInfo();
        }
	}
	
	function method_onClick(){
		var interfaceName=document.getElementById("interfaceName").value;
		//window.showModalDialog("<venus:base/>/jsp/warning/interface/methodFrame.jsp?interfaceName="+interfaceName,window)
		var obj=window.showModalDialog("<venus:base/>/jsp/warning/interface/methodFrame.jsp?interfaceName="+interfaceName,'','dialogHeight:350px;dialogWidth:450px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
        if(obj){
            document.form.functionName.value = obj[0];
        }
	}
	
	function goBack(){
		location.href="<%=request.getContextPath()%>/WarningObjectAction.do?cmd=queryAllWarningObjects";
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="jsp.warning_object_add"/>','<venus:base/>/');
</script>

<form name="form" method="post">
<input type="hidden" name="id" value="">
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:insert_onClick()">
			<input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>"  onClick="javascript:goBack()">
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="jsp.warning_object_add"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr> 
		<td align="right" width="15%" nowrap><font color="red">*</font><fmt:message key="jsp.warning_object_name"/></td>
		<td align="left">
			<input name="objectName" type="text" class="text_field" inputName="<fmt:message key="jsp.warning_object_name"/>" validate="notNull;isSearch" value="<%=warningObject.getObjectName() %>">			
		</td>
	</tr>
	<tr>
		<td align="right"><font color="red">*</font>BeanId</td>	
		<td align="left">
			<input name="beanId" inputName="BeanId" type="text"  class="text_field_reference" id="beanId" value="<%=warningObject.getBeanId()%>"size="20" readOnly="true"  validate="notNull;isNormalStrOnWeb"><img src="<venus:base/>/images/icon/reference.gif" class="img_1" onClick="javascript:interface_onClick();"/>
		</td>
	</tr>
	<tr>
		<td align="right"><font color="red">*</font><fmt:message key="jsp.warning_object_instance_name"/></td>
		<td>
			<select name="interfaceName" id="interfaceName" style="width:370"><!--style="width:370"-->
		<%if(warningObject.getInterfaceNameList()!=null){
		
		Iterator interfaceIterator=(Iterator)warningObject.getInterfaceNameList().iterator();
		  while(interfaceIterator.hasNext()){
		  	  String interfaceName=(String)interfaceIterator.next();
		 %>
		 <option value="<%=interfaceName%>"><%=interfaceName%></option>
		 <%
		  }}else{
		%>
		<option value=""></option>
		<%}%>
		</select>
		</td>
   </tr>
	
	<tr>
		<td align="right"><font color="red">*</font><fmt:message key="jsp.method_name"/></td>
		<td align="left">
			<input name="functionName"  type="text" inputName="<fmt:message key="jsp.method_name"/>" class="text_field_reference" id="functionName" validate="notNull;isSearch" value="<%=warningObject.getFunctionName()%>"size="20"  readOnly="true" ><img src="<venus:base/>/images/icon/reference.gif" class="img_1" onClick="javascript:method_onClick();"/>
	    </td>
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
