<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
</head>
	<body >
		<form name="form" method="post">
			<table border=1>
				<tr>
					<th><fmt:message key='gap.authority.Name' bundle='${applicationAuResources}' />
					</th>
					<th><fmt:message key='gap.authority.Button_effect' bundle='${applicationAuResources}' />
					</th>
					<th><fmt:message key='gap.authority.Notes' bundle='${applicationAuResources}' />
					</th>
				</tr>
				<tr><td>
				<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />1:<fmt:message key='gap.authority.Not_used' bundle='${applicationAuResources}' />authorityBtn<fmt:message key='gap.authority.Label' bundle='${applicationAuResources}' />
				</td>
				<td>
				<input name="button_name" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />1"  onClick="">
				</td>
				<td></td></tr>
				<tr><td>
				<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />2:<fmt:message key='gap.authority.Use' bundle='${applicationAuResources}' />authorityBtn<fmt:message key='gap.authority.Label' bundle='${applicationAuResources}' /> code="";<fmt:message key='gap.authority.And_test_results' bundle='${applicationAuResources}' />1<fmt:message key='gap.authority.As' bundle='${applicationAuResources}' />
				</td><td>
				<input name="button_name" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />2"  <au:authorityBtn code="" type="0"/> onClick="">
				</td>
				<td>code<fmt:message key='gap.authority.Attribute_is_used' bundle='${applicationAuResources}' />authorityBtn<fmt:message key='gap.authority.Label_required' bundle='${applicationAuResources}' />,<fmt:message key='gap.authority.If_you_do_not_have_the_property' bundle='${applicationAuResources}' />,jsp<fmt:message key='gap.authority.Compile_time_error_will_occur' bundle='${applicationAuResources}' /></td></tr>
				<tr><td>
				<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />3:<fmt:message key='gap.authority.Use' bundle='${applicationAuResources}' />authorityBtn<fmt:message key='gap.authority.Label' bundle='${applicationAuResources}' /> code="code_value";<fmt:message key='gap.authority.Effect_the_button_is_not_available' bundle='${applicationAuResources}' />				
				</td><td>				
				<input name="button_name" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />3"  <au:authorityBtn code="code_value" /> onClick="">
				</td>
				<td>code_value <fmt:message key='gap.authority.Is_registered_in_the_function_of_ID_' bundle='${applicationAuResources}' />KEYWORD<fmt:message key='gap.authority._The_value_of_the' bundle='${applicationAuResources}' /></td></tr>
				<tr><td>
				<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />4:<fmt:message key='gap.authority.Use' bundle='${applicationAuResources}' />authorityBtn<fmt:message key='gap.authority.Label' bundle='${applicationAuResources}' /> code="code_value" type="0";<fmt:message key='gap.authority.Effect_the_button_is_not_available' bundle='${applicationAuResources}' />				
				</td><td>				
				<input name="button_name" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />4"  <au:authorityBtn code="code_value" type="0"/> onClick="">
				</td>
				<td>type <fmt:message key='gap.authority.Access_Control_Type' bundle='${applicationAuResources}' /> 0 <fmt:message key='gap.authority.Unavailable' bundle='${applicationAuResources}' /> 1 <fmt:message key='gap.authority.Do_not_show' bundle='${applicationAuResources}' /> <fmt:message key='gap.authority.The_default_is' bundle='${applicationAuResources}' />0</td></tr>
				<tr><td>
				<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />5:<fmt:message key='gap.authority.Use' bundle='${applicationAuResources}' />authorityBtn<fmt:message key='gap.authority.Label' bundle='${applicationAuResources}' /> code="code_value" type="1";<fmt:message key='gap.authority.Effect_the_button_does_not_show' bundle='${applicationAuResources}' />
				</td><td>				
				<input name="button_name" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />4"  <au:authorityBtn code="code_value" type="1"/> onClick="">
				</td><td></td></tr>
		</table>
		</form>
	</body>
</html>

