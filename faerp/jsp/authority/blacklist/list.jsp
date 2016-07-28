<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="venus.pub.util.VoHelper" %>

<%@ page import="gap.authority.service.blacklist.vo.BlackOrWhiteVo"%>

<title><fmt:message key='gap.authority.Query_Template' bundle='${applicationAuResources}' /></title>
<script>
	function simpleQuery_onClick(){  //简单的模糊查询
//		form.queryCondition.value = buildQueryCondition();
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function exportExcel_onClick(){  //导出Excel
		oldCmd = form.cmd.value;
    	form.cmd.value = "exportExcel";
    	form.submit();
    	form.cmd.value = oldCmd;
  	}
	function exportPdf_onClick(){  //导出Pdf
		oldCmd = form.cmd.value;
    	form.cmd.value = "exportPdf";
    	form.submit();
    	form.cmd.value = oldCmd;
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
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		form.action = "<venus:base/>/BlackListAction.do?cmd=find&ids=" + ids;
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
            alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
            return;
        }
        if(number > 1) {
            alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
            return;
        }
        form.action = "<venus:base/>/BlackListAction.do?cmd=detail&ids=" + ids;
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
	  		alert("<fmt:message key='gap.authority.Please_delete' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(confirm("<fmt:message key='gap.authority.It_completely_remove_the_data_' bundle='${applicationAuResources}' />")) {
	    	form.action="<venus:base/>/BlackListAction.do?cmd=delete&ids=" + ids;
    		form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		window.location="<venus:base/>/jsp/authority/blacklist/insertBlack.jsp";
	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
	/*
	function buildQueryCondition() {
		var queryCondition = "";
		var qca = new Array();
		pushCondition(qca, "name");
		pushCondition(qca, "build_Id");
		
		if(qca.length >= 1) {  //组装查询条件
			queryCondition += " " + qca[0] + " ";
		}
		for(var i=1; i<qca.length; i++) {
			queryCondition += " and " + qca[i] + " ";
		}
		return queryCondition;
	}
	*/
	function getBuildList() {
		var obj = window.showModalDialog('<venus:base/>/jsp/authority/blacklist/blacklistframe.jsp','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
		if(obj) {
			document.form.blacklistname.value = obj[1];
			document.form.blacklistid.value = obj[0];
		}
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Check_list' bundle='${applicationAuResources}' />",'<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/BlackListAction.do">
<input type="hidden" name="cmd" value="">

<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			<fmt:message key='gap.authority.Conditional_Query' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap><fmt:message key='gap.authority.List_Name' bundle='${applicationAuResources}' /></td>
	<td>
		<input name="blacklistname" type="text" class="text_field_reference_readonly" inputName="<fmt:message key='gap.authority.List_Name' bundle='${applicationAuResources}' />" validate="isSearch" readOnly="true" rubber_id="blacklistname"><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getBuildList();" class="img_1">
		<input type="hidden" name="blacklistid" id="blacklistid" value="">
	</td>
</tr>
<tr>
	<td align="right" width="10%" nowrap><fmt:message key='gap.authority.List_of_contents' bundle='${applicationAuResources}' /></td>
	<td><input name="blackname" type="text" class="text_field" inputName="<fmt:message key='gap.authority.List_of_contents' bundle='${applicationAuResources}' />" validate="isSearch"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message key='gap.authority.Inquiry' bundle='${applicationAuResources}' />" onClickTo="javascript:simpleQuery_onClick();">
	</td>
</tr>
</table>

</div>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.Details_Form' bundle='${applicationAuResources}' />
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Added' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message key='gap.authority.Delete' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key='gap.authority.Modify' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:detail_onClick();"><img src="<venus:base/>/images/icon/search.gif" class="div_control_image"><fmt:message key='gap.authority.View' bundle='${applicationAuResources}' /></td>
					<!--  <td class="button_ellipse" onClick="javascript:exportExcel_onClick();"><img src="<venus:base/>/images/icon/xls.gif" class="div_control_image">导出Excel</td>-->
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
        <layout:collection name="beans" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
            <layout:collectionItem width="3%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;" >
                <bean:define id="wy3" name="wy1" property="id"/>
                    <input type="checkbox" name="checkbox_template" value="<%=wy3%>"/>
            </layout:collectionItem>
            <layout:collectionItem width="4%"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
                <venus:sequence/>
            </layout:collectionItem>
            <layout:collectionItem width="33%" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Blacklist_Name") %>' property="blacklist_id" sortable="true">
            <bean:define id="wy2" name="wy1" property="blackList.name"/>
                    <%=String.valueOf(wy2)%>
            </layout:collectionItem>
            <layout:collectionItem width="60%" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Blacklist") %>' property="content" sortable="true"/>
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
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>

