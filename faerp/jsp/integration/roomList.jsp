<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="gap.wf.wapi.state.TaskItemState"%>
<%@ page import="venus.pub.util.VoHelper" %>
<fmt:bundle basename="gap.template.simple_resource" prefix="gap.template.simple.">

<title><fmt:message key="QueryTemplate"/></title>
<script>
	function simpleQuery_onClick(){  //简单的模糊查询
//		form.queryCondition.value = buildQueryCondition();
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function findCheckbox_onClick() {  //从多选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert(i18n.please_select_a_record)
	  		return;
		}
		if(number > 1) {
	  		alert(i18n.can_only_select_a_record)
	  		return;
		}
		form.action = "<venus:base/>/TemplateAction.do?cmd=find&ids=" + ids;
		form.submit();
	}
	function detail_onClick(){
        var elementCheckbox = document.getElementsByName("checkbox_template");
        var number = 0;
        var ids = null;
        for(var i=0;i<elementCheckbox.length;i++){
            if(elementCheckbox[i].checked) {
                number += 1;
                ids = elementCheckbox[i].value;
            }
        }
        if(number == 0) {
            alert(i18n.please_select_a_record)
            return;
        }
        if(number > 1) {
            alert(i18n.can_only_select_a_record)
            return;
        }
        form.action = "<venus:base/>/ApplyRoomAction.do?cmd=done&ids=" + ids;
        form.submit();
	}

	function delete_onClick(){  //从多选框物理删除单条记录
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id =elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert(i18n.please_select_a_record)
	  		return;
		}
		if(number>1){
		      alert(i18n.can_only_select_a_record)
            return;
		}
		if(confirm('<fmt:message key="SureToDelete" />')) {
	    	form.action="<venus:base/>/ApplyRoomAction.do?cmd=delete&roomId=" + id;
    		form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		window.location="<venus:base/>/jsp/integration/insertRoom.jsp";
	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
	
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="QueryList"/>','<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/ApplyRoomAction.do">
<input type="hidden" name="cmd" value="">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="DetailTable"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key="add" bundle="${applicationResources}"/></td>
					<td class="button_ellipse" onClick="javascript:delete_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete" bundle="${applicationResources}"/></td>
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
			<layout:collection name="rooms" id="room4wf" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
				<layout:collectionItem width="5%"  style="text-align:center;"  title="">
						<input type="radio" name="checkbox_template" value="${room4wf.id}"/>
				</layout:collectionItem>
				<layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence") %>' style="text-align:center;">
					<venus:sequence/>
				</layout:collectionItem>
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.simple.BuildingName") %>' property="build_Id" >
				翠微阁
				</layout:collectionItem>
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.simple.RoomName") %>' property="name" />
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.simple.BuildingArea") %>'property="area" />
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.template.simple.RoomRate") %>' property="price" />
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.current_state") %>' property="state">
				    <bean:define id="state" name="room4wf" property="state"></bean:define>
				    <%=TaskItemState.getState(Integer.parseInt(state.toString())).getDesc() %>
				</layout:collectionItem>
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("remark") %>' property="brief"/>
				<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.operation") %>' style="text-align:center;">
				     <bean:define id="taskState" name="room4wf" property="state"/>
				    <a href="<venus:base/>/${room4wf.wfhandleurl}">
				     <%if(TaskItemState.Actived.getCode() == Integer.parseInt(taskState.toString())||TaskItemState.Running.getCode()==Integer.parseInt(taskState.toString())){
				         %><%=LocaleHolder.getMessage("gap.wf.dispose") %> <%
				     }else{
				         %><fmt:message key="view" bundle="${applicationResources}"/><%
				     }%>    
				     </a>
				</layout:collectionItem>
			</layout:collection>
			<jsp:include page="/jsp/include/page.jsp" />
			</td>
		</tr>
	</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>