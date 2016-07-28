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
<title><%=isModify?"修改页面":"新增页面"%></title>
<script>

function save_onclick(){ //插入数据到数据库
       var isModify = <%=isModify%>;
        var empId = document.all.empId.value;   
        var stDate = document.all.stDate.value;
        var edDate = document.all.edDate.value;
        var form1 = document.all.form;
        var id = document.all.id.value;
        var empCollege = document.all.empCollege.value;
        var empMajor = document.all.empMajor.value;
        if (!compareDate(stDate,edDate)) {
            alert(i18n.first_date_must_later_second);
            return;
        }
        
        if(checkAllForms()){
            var data={empId:empId,stDate:stDate,edDate:edDate,id:id,empCollege:empCollege,empMajor:empMajor};
            
             var url = "<venus:base/>/ChildTableAAction.do?cmd=insert"; 
             if(isModify) url = "<venus:base/>/ChildTableAAction.do?cmd=update";
            jQuery.get(url,data,function(){
                     parent.window.returnValue = empId;
                      parent.window.close();
            
           })
            
        }
    }   
    
  	

  	
  	function compareDate(dt1,dt2) { //比较两个日期,大于返回true,小于或等于返回false
  		var dt1 = dt1.replace(/-/g,"\/");
  		var dt2 = dt2.replace(/-/g,"\/");
		return dt1 < dt2;
  	}
  	
  	function transactionMessage() { //返回事务操作的类型
  		var cudType = "<%=cudType%>";
  		if (cudType == "insert" || cudType == "update") {
  			window.close(); 
  		}
  		if (cudType == "norecord") {
  			alert(i18n.please_save_the_main_table);
  			window.close(); 
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

<form name="form" method="post" >
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
		<td align="right"><font color="red">*</font><fmt:message key="Graduated"/></td>
		<td align="left">
			<input name="empCollege" type="text" class="text_field" validate="notNull"  inputName='<fmt:message key="Graduated"/>' value="">			
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="Profession"/></td>
		<td align="left">
			<input name="empMajor" type="text" class="text_field" inputName='<fmt:message key="Profession"/>' value="">			
		</td>
	</tr>
	<tr>
		<td align="right"><font color="red">*</font><fmt:message key="EntryDate"/></td>
		<td align="left">
			<input name="stDate" id="stDate" type="text" class="text_field_reference" validate="notNull" inputName='<fmt:message key="EntryDate"/>'  readonly="true" value=""><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('stDate','<venus:base/>/')" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><font color="red">*</font><fmt:message key="GraduationDate"/></td>
		<td align="left">
			<input name="edDate" id="edDate" type="text" class="text_field_reference" validate="notNull" inputName='<fmt:message key="GraduationDate"/>'  readonly="true" value=""><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('edDate','<venus:base/>/')" class="img_1">
		</td>
	</tr>	
	<tr>
		<td align="right"></td>
		<td align="left">
			<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save" bundle="${applicationResources}"/>' onClick="save_onclick()">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="cancel" value='<fmt:message key="return" bundle="${applicationResources}"/>' class="button_ellipse" onClick="parent.window.close()">
			
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