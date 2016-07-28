<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.au.auuser.util.IAuUserConstants" %>
<%@ page import="gap.commons.xmlenum.EnumRepository" %>
<%@ page import="gap.commons.xmlenum.EnumValueMap" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/authority/org/aupartyrelation/organizeTooltip.jsp" %>
<%
	String system_id = (String)request.getAttribute("system_id");
	if(system_id==null || system_id.length()==0) {
		system_id = request.getParameter("system_id");
		if(system_id==null) {
			system_id = "";
		}
	}
	String func_code = (String)request.getAttribute("func_code");
	if(func_code==null || func_code.length()==0) {
		func_code = request.getParameter("func_code");
		if(func_code==null) {
			func_code = "";
		}
	}
	boolean isAdmin = gap.authority.helper.LoginHelper.getIsAdmin(request);
	EnumRepository er = EnumRepository.getInstance();
    er.loadFromDir();
	EnumValueMap enableStatusMap = er.getEnumValueMap("EnableStatus");	
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.User_Management' bundle='${applicationAuResources}' /></title>
<script language="javascript">
    var insertCount = '<%=session.getAttribute("insertCount")%>';
    <%session.removeAttribute("insertCount");%>
	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				ids.push(elementCheckbox[i].value);  //加入选中的checkbox
			}
		}
		return ids;
	}
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		<%if(!isAdmin) {%>
			var thisHidden = getLayoutHiddenObjectById(ids[0]);
			var is_admin = jQuery(thisHidden).attr("is_admin");
			if(is_admin=="1") {
				alert("<fmt:message key='gap.authority.You_do_not_have_permission_to_modify_the_super_administrator' bundle='${applicationAuResources}' />!")
				return;
			}
		<%}%>
		form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=find&id=" + ids;
		form.submit();
	}  
	function view_onClick(){//查看详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		detail_onClick(ids);
	}
	function getCompanyTree() {
		
		var deeptreePath = '<venus:base/>/jsp/comm/tree/deeptree/deeptree_window.jsp?inputType=radio&rootXmlSource=<venus:base/>/jsp/comm/tree/rootXmlData_limit.jsp?root_code=101%26submit_type%3D0%26is_submit_all%3Dyes%26return_type%3Doriginal_id';
		
		var rtObj = window.showModalDialog(deeptreePath, new Object(),'dialogHeight=600px;dialogWidth=350px;');
		if(rtObj != undefined && rtObj.length > 0){
			form.child_name.value = rtObj[0]['childName'];
			form.child_code.value = rtObj[0]['returnValue']; 
		}
	}
	function resetPassword_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=resetPassword&id=" + ids;
		form.submit();
	} 
	function enable_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		var thisHidden = getLayoutHiddenObjectById(ids[0]);
		var enable_status = jQuery(thisHidden).attr("enable_status");
		if(enable_status=="1") {
			alert("<fmt:message key='gap.authority.Is_already_enabled' bundle='${applicationAuResources}' />!")
			return;
		}
		form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=enable&id=" + ids;
		form.submit();
	}   
	function disable_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		
		var thisHidden = getLayoutHiddenObjectById(ids[0]);
		var is_admin = jQuery(thisHidden).attr("is_admin");
		var enable_status = jQuery(thisHidden).attr("enable_status");
		if(is_admin=="1") {
			alert("<fmt:message key='gap.authority.Super_Administrators_can_not_disable' bundle='${applicationAuResources}' />!")
			return;
		}
		if(enable_status=="0") {
			alert("<fmt:message key='gap.authority.Already_disabled' bundle='${applicationAuResources}' />!")
			return;
		} 
		
		form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=disable&id=" + ids;
	   //   alert(document.getElementById("form"));
	    // document.getElementById("myform").submit();
	
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert("<fmt:message key='gap.authority.Please_Select_Records' bundle='${applicationAuResources}' />!")
			return;
		}
		for(var i=0; i<ids.length; i++) {
			var thisHidden = getLayoutHiddenObjectById(ids[i]);
			var is_admin = jQuery(thisHidden).attr("is_admin");
			if(is_admin=="1") {
				alert("<fmt:message key='gap.authority.Super_Administrators_can_not_remove' bundle='${applicationAuResources}' />!")
				return;
			}
		}
		if(confirm("<fmt:message key='gap.authority.It_completely_remove_the_data_' bundle='${applicationAuResources}' />")) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=deleteMulti&ids=" + ids;
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
		if(checkAllForms()){
			//form.VENUS_PAGE_NO_KEY.value = 1; //切换状态后,从第一页开始显示
    		form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=simpleQuery";
    		form.submit();
   		}
  	}
	function queryAll_onClick(){  //查询全部数据列表
		form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=simpleQuery";
		form.submit();
	}
	function toAdd_onClick() {  //到增加记录页面
		window.location="<%=request.getContextPath()%>/jsp/authority/au/auuser/insertAuUser.jsp?system_id=<%=system_id%>&func_code=<%=func_code%>";
	}
	function toAddMulti_onClick() { //创建多个账号
		var treePath = "<venus:base/>/jsp/authority/tree/treeRef.jsp?inputType=checkbox&nodeRelationType=noRelation&submitType=parentPriority&rootXmlSource=<venus:base/>/jsp/authority/au/auuser/xmlData.jsp?submit_all%3D1%26parent_code%3D%26return_type%3Dcode";
		var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
		if(rtObj != undefined && rtObj.length > 0) { 
			form.code.value = ""; 
			var code = form.code.value;
			for(var i=0; i<rtObj.length-1; i++) {
				if (code.indexOf(rtObj[i]['returnValue']) != -1) //过滤重复的参数
					continue;
				form.code.value += rtObj[i]['returnValue'] + ",";
			}
			if (code.indexOf(rtObj[rtObj.length-1]['returnValue']) != -1) { //过滤重复的参数
				form.code.value = code.substring(0,code.length-1);
			} else {
				form.code.value += rtObj[rtObj.length-1]['returnValue'];
			}
	    	form.action = "<%=request.getContextPath()%>/AuUserAction.do?cmd=insertMulti";
	    	form.submit();
		} 		
	}	
	function detail_onClick(thisId){  //实现转到详细页面
		var thisHidden = getLayoutHiddenObjectById(thisId);
	   var is_admin = jQuery(thisHidden).attr("is_admin");
		//if(is_admin=="1") {
		//	alert("<fmt:message key='gap.authority.Super_Administrator_can_not_see' bundle='${applicationAuResources}' />!")
	//		return;
	//	}
		form.id.value = thisId;  //赋值thisId给隐藏值id
		form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=detail";
		form.submit();
	}
	function checkAllList_onClick(thisObj){  //全选，全不选
		if(thisObj.checked) {  //如果选中
			selectAllRows('template');  //全选checkbox
		} else {
			unSelectAllRows('template');  //全不选checkbox
		}
	}
	function initFocus(){ 
		//var ctrl=document.getElementById("login_id"); 
		//ctrl.focus(); 
	}  
	function clear_onClick() { //清空查询条件
		form.login_id.value = "";
		form.name.value = "";
		form.department.value = "";
		form.hid_department.value = "";
		form.enableStatus.options[0].selected = true;
	}	
	function search_onKeyDown() {//回车后执行页面查询功能
		if (event.keyCode == 13) { 
			simpleQuery_onClick();
		}
	}	
</script>

</head>
<body onload="initFocus()">
<form id="form"  method="post">
<input type="hidden" name="code" value=""/>
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">用户管理</div>
	</div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="174" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div></td>
    <td width="75">登录账号</td>
    <td width="310"><input name="login_id" type="text" class="sText" id="login_id" value=""/></td>
    <td width="73">真实姓名</td>
    <td width="304"><input name="name" type="text" class="sText" id="name" value=""/></td>
    <td width="176">&nbsp;</td>
    </tr>
  <tr>
    <td>用户状态</td>
    <td><select name="enableStatus" class="sSelect" id="enableStatus">
      <option value="">请选择</option>
      <option value="1">启用</option>
      <option value="0">禁用</option>
    </select></td>
    <td>所属机构</td>
    <td >					<input type="text" class="text_field_reference_readonly" validate="isSearch" id="department" name="department" inputName="<fmt:message key='gap.authority.Department' bundle='${applicationAuResources}' />" maxLength="50" hiddenInputId="hid_department" value=""/><input type="hidden" id="hid_department"  name="hid_department"/><img class="refButtonClass" alt="<fmt:message key='gap.authority.Select_department' bundle='${applicationAuResources}' />" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array('hid_department', 'department'),'<venus:base/>','radio','','1','','2','1');"/>
	
    
    </td>
    <td><input name="submit22" type="button" class="icon_1" value="查询" onClick="javascript:simpleQuery_onClick()" /></td>
    </tr>
    </table>
  </div>
    <!--查询 end-->
    <!--按钮-->
    	<div class="button">
            <div class="button_right">
            	<ul>
				  <li class="c"><a onClick="javascript:toAdd_onClick();">新增</a></li>
                  <li class="b"><a onClick="javascript:findCheckbox_onClick();">修改</a></li>
				  <li class="g"><a onClick="javascript:enable_onClick();">启用</a></li>
				  <li class="f"><a onClick="javascript:disable_onClick();">禁用</a></li>
				  <li class="a"><a onClick="javascript:view_onClick();">查看</a></li>
				  
				 
              </ul>
            </div>
            <div class="clear"></div>
        </div>
    <!--按钮 end-->
    <!--表格 -->
    <div class="box" id="values_div">
      
      <layout:collection name="beans" id="rmBean" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" onRowClick="javascript:showMessageBox(getRowHiddenId());" onRowMouseOver="javascript:closeMessageBox();">
			
			<layout:collectionItem width="30" title="" style="text-align:center;">
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="rmDisplayName" name="rmBean" property="id"/>
				<input type="radio" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="30"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="login_id" name="rmBean" property="login_id"/>
				<bean:define id="real_name" name="rmBean" property="name"/>
				<bean:define id="party_id" name="rmBean" property="party_id"/>
				<bean:define id="is_admin" name="rmBean" property="is_admin"/>
				<bean:define id="enable_status" name="rmBean" property="enable_status"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>" login_id="<%=login_id%>" real_name="<%=real_name%>" party_id="<%=party_id%>" is_admin="<%=is_admin%>" enable_status="<%=enable_status%>"/>
			</layout:collectionItem>
			
			<%="<a onDblClick='javascript:detail_onClick(getRowHiddenId())'>"%>
		<layout:collectionItem width="15%" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Number") %>' property="party_id" sortable="false"/>
		<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Login_Account") %>' property="login_id" sortable="false"/>
		<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Real_Name") %>' property="name" sortable="false"/>
		<layout:collectionItem title='供应商名称' property="agent_name" sortable="false"/>
		<%if (organizeTooltip == null) { %>
		<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Organization") %>' sortable="false">
			<logic:notEmpty name="rmBean" property="owner_org">
				<bean:define id="owner_org" name="rmBean"  property="owner_org"/>
				 <%=StringHelperTools.replaceStringToHtml(owner_org)%>
			 </logic:notEmpty>
		</layout:collectionItem>		
		<%} %>
		<layout:collectionItem width="60" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Status") %>' sortable="false" style="text-align:center;">
			<bean:define id="enable_status" name="rmBean" property="enable_status"/>
		    <%="1".equals(enable_status)?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Enabled"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Disable")%>
		</layout:collectionItem>
		<layout:collectionItem width="150" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Created") %>' sortable="false">
			<bean:define id="create_date" name="rmBean" property="create_date"/>
		    <%=StringHelperTools.prt(create_date,19)%>
		</layout:collectionItem>
		<layout:collectionItem width="150" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Password_expiration") %>'  sortable="false">
			<logic:notEmpty name="rmBean" property="retire_date">
				<bean:define id="retire_date" name="rmBean" property="retire_date"/>
		    	<%=StringHelperTools.prt(retire_date,19)%>
			</logic:notEmpty>
		</layout:collectionItem>
		<%="</a>"%>
		</layout:collection>
   
  </div>
    <!--表格 end-->
    <!--翻页 -->
<jsp:include page="/jsp/include/page.jsp" />
    <!--翻页 end-->
    </div>
</div>

<input type="hidden" name="id" value="">
<input type="hidden" name="queryCondition" value="">

<input type="hidden" name="system_id" value="<%=system_id%>">
<input type="hidden" name="func_code" value="<%=func_code%>">
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	if (insertCount ==0 ) //当批量分配帐号时，没有新增加帐号后给予提示
	   alert("<fmt:message key='gap.authority.Employees_within_the_organization_accounts_have_been_allocated_' bundle='${applicationAuResources}' />");
</script>
</body>
</html>
<%  //表单回写
	if(request.getAttribute(IAuUserConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的bean不为空
		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute(IAuUserConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
		out.print("writeBackMapToForm();\n");  //输出执行回写方法
		out.print("</script>");  //输出script的声明结束
	}
%>

