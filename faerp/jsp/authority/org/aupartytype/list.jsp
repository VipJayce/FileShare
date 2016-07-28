<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@ page import = "gap.authority.org.aupartytype.vo.AuPartyTypeVo"%>
<%@ page import = "gap.authority.util.VoHelperTools" %>
<%@ page import = "gap.authority.util.StringHelperTools" %>
<%@ page import = "gap.commons.xmlenum.EnumRepository" %>
<%@ page import = "gap.commons.xmlenum.EnumValueMap" %>
<%
EnumRepository er = EnumRepository.getInstance();
er.loadFromDir();
EnumValueMap typeMap = er.getEnumValueMap("TypeStatus");
%>
<title><fmt:message key='gap.authority.Query_Template' bundle='${applicationAuResources}' /></title>
<script>    
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function view_onClick(id){//查看详细页面
		form.action = "<venus:base/>/AuPartyTypeAction.do?cmd=detailPage&id=" + id+"&keywordconst="+document.form.keyword.value;
		form.submit();
	}
	function view_onButton(){
	    var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id = elementCheckbox[i].value;
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
		view_onClick(id);
	}
	function getRowHiddenId() {  //从事件取得本行的id
		var thisA = event.srcElement;  //定义事件来源对象
		var thisTr = thisA.parentElement.parentElement.parentElement.parentElement;  //定义本行的tr对象		
		var thisHidden = getObjectByNameRecursive(thisTr, "hiddenId");  //从thisTr递归的取出name是hiddenId的对象
		if(thisHidden != undefined && thisHidden != null) {  //如果thisHidden不为空
			return thisHidden.value;
		} else {
			return null;
		}
	}
	function getObjectByNameRecursive(thisObj, thisName) {  //从thisObj递归的取出name是thisName的对象
		var rtHiddenInput = null;  //定义返回的变量
		for(var i=0; i<thisObj.childNodes.length; i++) {  //循环thisObj的子节点
			var tempObj = thisObj.childNodes[i];  //定义当前临时节点
			if(jQuery(tempObj).attr("signName") == thisName) {  //如果当前临时节点的name等于thisName
				rtHiddenInput = tempObj;  //当前临时节点就是返回的对象
				break;  //完成了目标对象的查询,退出循环
			} else {
				rtHiddenInput = getObjectByNameRecursive(tempObj, thisName);  //递归的找自己的子节点
				if(rtHiddenInput != null) {  //如果返回值不为空
					break;  //完成了目标对象的查询,退出循环
				}
			}
		}
		return rtHiddenInput;
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
		form.action = "<venus:base/>/AuPartyTypeAction.do?cmd=find&ids=" + ids + "&keywordconst=" + document.form.keyword.value;
		form.submit();
	}
	function detail_onClick(thisId){
		form.action = "<venus:base/>/AuPartyTypeAction.do?cmd=find&ids=" + thisId;
		form.submit();
	}
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids += "'" + elementCheckbox[i].value + "',";
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
	    	form.action="<venus:base/>/AuPartyTypeAction.do?cmd=delete&ids=" + ids + "&keywordconst=" + document.form.keyword.value;
    		form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		window.location="<venus:base/>/jsp/authority/org/aupartytype/insert.jsp?keywordconst=" + document.form.keyword.value;
	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
	function enable_onClick() {  //从多选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
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
		
		form.action="<venus:base/>/AuPartyTypeAction.do?cmd=enable&ids=" + ids + "&keywordconst=" + document.form.keyword.value;
		form.submit();
	}   
	function disable_onClick() {  //从多选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
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
					
		form.action="<venus:base/>/AuPartyTypeAction.do?cmd=disable&ids=" + ids + "&keywordconst=" + document.form.keyword.value;
		form.submit();
	}  
	
	function initFocus(){ 
		var ctrl=document.getElementById("name"); 
		ctrl.focus(); 
	}  
</script>

</head>
<body onload="initFocus()">
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Check_list' bundle='${applicationAuResources}' />",'<venus:base/>/');
</script>

<form name="form" method="post" action="<venus:base/>/AuPartyTypeAction.do">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="keyword" value="">

<!-- 查询开始 -->
<div id="auDivParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<venus:base/>/')">
			<fmt:message key='gap.authority.Conditional_Query' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>

<div id="auDivChild0"> 
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap><fmt:message key='gap.authority.Name' bundle='${applicationAuResources}' /></td>
	<td width="30%"><input name="name" id="name" type="text" class="text_field" inputName="<fmt:message key='gap.authority.Name' bundle='${applicationAuResources}' />" validate="isSearch"></td>
	<td align="left"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message key='gap.authority.Inquiry' bundle='${applicationAuResources}' />" onclickto="javascript:simpleQuery_onClick();">
	</td>
</tr>
</table>

</div>

<div id="auDivParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.Details_Form' bundle='${applicationAuResources}' />
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Added' bundle='${applicationAuResources}' /></td>
					<!-- td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image">删除</td -->
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key='gap.authority.Modify' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:view_onButton();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key='gap.authority.View' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<venus:base/>/images/icon/refresh.gif" class="div_control_image"><fmt:message key='gap.authority.Refresh' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:enable_onClick();"><img src="<venus:base/>/images/icon/enable.bmp" class="div_control_image"><fmt:message key='gap.authority.Enabled' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:disable_onClick();"><img src="<venus:base/>/images/icon/disable.bmp" class="div_control_image"><fmt:message key='gap.authority.Disable' bundle='${applicationAuResources}' /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="auDivChild1"> 
<table class="table_div_content">
	<tr>
		<td>
		<layout:collection name="wy" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="40" title="" style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="id"/>
					<input type="radio" name="checkbox_template" value="<%=wy3%>"/>
					<input type="hidden" signName="hiddenId" value="<%=wy3%>"/>
				<bean:define id="wy4" name="wy1" property="name"/>
					<input type="hidden" name="hidden_name" value="<%=wy4%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="20"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<%="<a ondblclick='javascript:view_onClick(getRowHiddenId())'>"%>
			<layout:collectionItem width="130" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Name") %>' property="name" />	
			<layout:collectionItem width="80" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Type_Classification") %>'>	
			  <logic:notEmpty name="wy1" property = "keyword">  
				<bean:define id="wy4" name="wy1" property="keyword"/>
				<%=StringHelperTools.prt(typeMap.getLabel(wy4.toString()))%>		  
			  </logic:notEmpty> 
			</layout:collectionItem>	
            <layout:collectionItem width="100" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Which_tables_mapping") %>' property="table_name" />            
            <layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Notes") %>' >
            	<logic:notEmpty name="wy1" property = "remark">            	
                   <bean:define id="remark" name="wy1" property="remark" />
		               <%=StringHelperTools.prt(remark,50)%>
                </logic:notEmpty>
            </layout:collectionItem>               
            <layout:collectionItem width="40" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Status") %>' sortable="false" style="text-align:center;">
			   <bean:define id="enable_status" name="wy1" property="enable_status"/>
		       <%="1".equals(enable_status)?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Enabled"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Disable")%>
		    </layout:collectionItem>
		    <%="</a>"%>
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
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>

