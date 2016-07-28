<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="venus.pub.util.VoHelper" %>

<%  //判断是否为修改页面
	boolean isModify = false;
	if(request.getParameter("isModify") != null) {
		isModify = true;
	}
	EnumRepository er = EnumRepository.getInstance();
    er.loadFromDir();
    String empId = request.getParameter("empId");
    String id = request.getParameter("id");
    String cudType = (String)request.getAttribute("cudType");
%>
<fmt:bundle basename="gap.template.complex_resource" prefix="gap.template.complex.">
<title>
           <%if(isModify){ %>
                        <fmt:message key="UpdatePage"/>
                <%}else{ %>
                       <fmt:message key="InsertPage"/>
                <% }%>
</title>
<script>

	function save_onClick(){ //插入数据到数据库
	    var isModify = <%=isModify%>;
	    var id = document.all.id.value;  
  		var empId = document.all.empId.value;	
  		var empCompany = document.all.empCompany.value;  
  		var empProfession = document.all.empProfession.value;
  		var jobPeriod = document.all.jobPeriod.value;
  		var empIntroduce = document.getElementById("empIntroduce").value;  
  		var data = {id:id,empId:empId,empCompany:empCompany,empProfession:empProfession,jobPeriod:jobPeriod,empIntroduce:empIntroduce};
		if(checkAllForms()){
		   //在chrome中调用window.close之后，form不会submit，原因未知，所以改成ajax实现。
			/*form.action = "<venus:base/>/ChildTableBAction.do?cmd=insert";
    		form.submit();
	  		parent.window.returnValue = empId;
	  		parent.window.close();*/ 
	  		var url = "<venus:base/>/ChildTableBAction.do?cmd=insert";
	  		if(isModify) url = "<venus:base/>/ChildTableBAction.do?cmd=update"
	  		jQuery.get(url,data,function(){
	  		    parent.window.returnValue = empId;
                parent.window.close(); 
	  		})
    	}
  	}	
  	

  	function transactionMessage() { //返回事务操作的类型
  		var cudType = "<%=cudType%>";
  		if (cudType == "insert" || cudType == "update") {
  			parent.window.close(); 
  		}
  		if (cudType == "norecord") {
  			alert(i18n.please_save_the_main_table);
  			parent.window.close(); 
  		}
  	}    	
  	
</script>
</head>
<body>
<script language="javascript">
	             <%if(isModify){ %>
                        writeTableTop('<fmt:message key="modify_page" bundle="${applicationResources}"/>','<venus:base/>/');
                <%}else{ %>
                        writeTableTop('<fmt:message key="new_page" bundle="${applicationResources}"/>','<venus:base/>/');
                <% }%>
</script>

<form name="form" method="post">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="empId" value="<%=empId%>">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
			 <%if(isModify){ %>
                        <fmt:message key="modify_page" bundle="${applicationResources}"/>
                <%}else{ %>
                       <fmt:message key="new_page" bundle="${applicationResources}"/>
                <% }%>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
	<table class="table_div_content">
	<tr>
		<td align="right"><font color="red">*</font><fmt:message key="Company"/></td>
		<td align="left">
			<input name="empCompany" type="text" class="text_field" validate="notNull" inputName='<fmt:message key="Company"/>'  value="">			
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="Post"/></td>
		<td align="left">
			<input name="empProfession" type="text" class="text_field" inputName='<fmt:message key="Post"/>'  value="">			
		</td>
	</tr>
	<tr>
		<td align="right"><font color="red">*</font><fmt:message key="WorkTime"/></td>
		<td align="left">
			<input name="jobPeriod" type="text" class="text_field"  style="width:30px;" validate="notNull;isInteger" maxlength="2"   inputName='<fmt:message key="WorkTime"/>'  value="0">年
		</td>
	</tr>		
	<tr>
		<td align="right"><fmt:message key="StaffProfile"/></td>
		<td align="left">
			<textarea cols="40" rows="5" name="empIntroduce" id="empIntroduce" maxLength="500"></textarea>
		</td>
	</tr>	
	<tr>
		<td align="right"></td>
		<td align="left">
			<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save" bundle="${applicationResources}"/>' onClick="javascript:save_onClick();">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="cancel" value='<fmt:message key="return" bundle="${applicationResources}"/>' class="button_ellipse" onClick="javascript:parent.window.close();">
		</td>
	</tr>	
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
	transactionMessage();
</script>
</body>
</fmt:bundle>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>