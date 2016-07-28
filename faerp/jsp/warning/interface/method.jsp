<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<head>
<title><fmt:message key="jsp.method_list"/></title>
</head>
<script language="javascript">
function add_onClick(){
	var selectedIndex = -1;
    var form1 = document.getElementById("form");
    var methods =  "";
    for (var i=0;i<document.forms.length;i++) {
    	for (var j=0;j<document.forms[i].elements.length;j++) {
    		var thisInput = document.forms[i].elements[j];
    		if(thisInput.type=="radio" && thisInput.checked){
	    		selectedIndex = i;
	            //alert("您选择项的 value 是：" + form1.beanId[i].value);
	            methods += thisInput.value;
    		}
    	}
    }

	
    if (selectedIndex < 0)
    {
        alert(i18n.please_select_a_record);
        return;
    }
	var returnArray = new Array();
	returnArray[0] = methods;
	parent.window.returnValue = returnArray;
    //window.dialogArguments.form.functionName.value=methods;
	parent.window.close();

}


    
    
function cancel_onClick(){
	parent.window.close();
}

</script>
<base target="_self">
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="jsp.method_list"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="">
<input type="hidden" name="cmd" value="">
<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="jsp.method_list"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:add_onClick();"><img src="<venus:base/>/images/icon/confirm.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="confirm"/></td>
					<td class="button_ellipse" onClick="javascript:cancel_onClick();"><img src="<venus:base/>/images/icon/return.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="close"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table width="200" class="table_div_content" >
  <tr>    	
   <td>
	<div style="width=100%;overflow-x:auto;">
	   <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" class="listCss">
	   	   <tr><td valign="top">
	   	   <table cellspacing="1" cellpadding="1" border="0" width="100%">
			<tr valign="top">
			<th class="listCss" width="5%"></th>
			<th class="listCss" width="5%"><fmt:message bundle='${applicationResources}'  key="sequence"/></th>
			<th class="listCss" width="30%"><fmt:message key="jsp.method_name"/></th>
			</tr>
		    <%
		    	List result=(List)request.getAttribute("methods");
				if(result!=null){
				Iterator it=result.iterator();
		    	int i=0;
		        while(it.hasNext()){
		        	String methodName=(String) it.next();;
		    %>
		  <tr>
		    <td class="listCss" style="text-align:center;" width="10%"><input type="radio" name="checkbox_template" value="<%=methodName%>"></td>
			<td class="listCss" style="text-align:center;" width="10%"><%=++i%></td>
		    <td class="listCss" width="80%" nowrap><%=methodName%></td>
		  </tr>
		  		
		  		
		  	<%}}%>
		</table>
	</div>
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