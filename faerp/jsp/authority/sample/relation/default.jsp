<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>default</title>
</head>
<body>
	<br>
	<br>
	<table class="table_noFrame" width="96%" align="center"> 
        <tr> 
			<td align="left"><img src="<%=request.getContextPath()%>/images/au/yq_bt<au:i18next/>.jpg" width="73" height="14"> <br> <br>
				<fmt:message key='gap.authority.Please_click_on_the_left_tree_select_your_organization_to_operate_the_node_' bundle='${applicationAuResources}' /> <br> <br>
				<fmt:message key='gap.authority.If_you_add_modify_or_delete_the_organization_the_organization_did_not_update_the_tree_please' bundle='${applicationAuResources}' />IE<fmt:message key='gap.authority.Menu' bundle='${applicationAuResources}' />"<fmt:message key='gap.authority.Tool' bundle='${applicationAuResources}' />"->"Internet<fmt:message key='gap.authority.Options' bundle='${applicationAuResources}' />"->"<fmt:message key='gap.authority.Conventional' bundle='${applicationAuResources}' />"->"<fmt:message key='gap.authority.Set_up' bundle='${applicationAuResources}' />"<fmt:message key='gap.authority.Select' bundle='${applicationAuResources}' />"<fmt:message key='gap.authority.Every_visit_to_the_page' bundle='${applicationAuResources}' />"<fmt:message key='gap.authority.Can_' bundle='${applicationAuResources}' /><br><br> 
				<fmt:message key='gap.authority.If_you_click_on_the_left_of_the_organization_tree_node_while_the_right_side_of_the_interface_has_not_changed_then_you_may_not_have_permission_to_operate_the_node_' bundle='${applicationAuResources}' />
			</td> 
		</tr> 
    </table>
</body>
</html>
	

