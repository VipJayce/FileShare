<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.sample.department.vo.DepartmentVo" %>
<%@ page import="gap.authority.sample.department.util.IDepartmentConstants" %>
<%  //判断是否为修改页面
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
	}
	
	//获取上级节点的关系表主键，该主键不仅仅用来新增节点，而且还用来区分要跳转的页面
	String parentRelId = request.getParameter("parentRelId");//如果是组织机构管理页面跳转过来的且该页面为新增页面，该值不为空
	if(parentRelId==null) {
		if(isModify) {
			parentRelId = request.getParameter("relationId");//如果是组织机构管理页面跳转过来的且该页面为修改页面，该值不为空
			if(parentRelId==null) {
				parentRelId = "";//如果为空说明不是从组织机构管理页面跳转过来的，该值用来判断下一步要跳转的页面
			}
		}else {
			parentRelId = "";//如果为空说明不是从组织机构管理页面跳转过来的，该值用来判断下一步要跳转的页面
		}
	}
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
    	form.action="<%=request.getContextPath()%>/DepartmentAction.do?cmd=insert";
 		var parentRelId = form.parentRelId.value;
    	if(parentRelId!="")
    		form.target="_parent";
	    form.submit();
	}
  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/DepartmentAction.do?cmd=update";
	    var parentRelId = form.parentRelId.value;
    	if(parentRelId!="")
    		form.target="_parent";
    	form.submit();
	}
</script>
</head>
<body>
<div id="right">
<script language="javascript">
	writeTableTopFesco('<%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Modify_page"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.New_page")%>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td>
			<input name="button_save" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Save' bundle='${applicationAuResources}' />" onClickTo="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>">
			<input name="button_cancel" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />"  onClick="javascript:returnBack()" >
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Modify"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Added")%><%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Department0")%>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td> 
			<table class="table_div_content_inner">
				<tr>
					<td width="30%" align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Department_name' bundle='${applicationAuResources}' /></td>
					<td width="70%" align="left">
						<input type="text" class="text_field" name="dept_name" inputName="<fmt:message key='gap.authority.Department_name' bundle='${applicationAuResources}' />" validate="notNull;isSearch;" value="" maxLength="300" />
					</td>
				</tr>
				<%
				if( ! isModify && ( parentRelId==null || "".equals(parentRelId) ) ) {
				%>
				<tr>
					<td align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Owned_companies_or_departments_' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field_reference_readonly" id="owner_party_name" name="owner_party_name" inputName="<fmt:message key='gap.authority.Owned_companies_or_departments_' bundle='${applicationAuResources}' />" maxlength="50" validate="notNull;" 
						hiddenInputId="owner_party_id"/><input type="hidden" id="owner_party_id" name="owner_party_id"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" 
						onClick="javascript: try { getTree(new Array('owner_party_id', 'owner_party_name'),'<venus:base/>','radio','','1','id','2','1'); }catch(e){alert('<fmt:message key='gap.authority.Insufficient_privileges' bundle='${applicationAuResources}' />')}"/>
					</td>
				</tr>
				<%
				}
				%>
				<!--tr>
					<td align="right" nowrap>部门编号</td>
					<td align="left">
						<input type="text" class="text_field" name="dept_no" inputName="部门编号" value="" maxLength="50" />
					</td>
				</tr-->
				<tr>
					<td align="right"><fmt:message key='gap.authority.Department_logo' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="dept_flag" inputName="<fmt:message key='gap.authority.Department_logo' bundle='${applicationAuResources}' />" validate="isSearch;" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Department_Type' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="dept_type" inputName="<fmt:message key='gap.authority.Department_Type' bundle='${applicationAuResources}' />" validate="isSearch;" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Sectoral_level' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="dept_level" inputName="<fmt:message key='gap.authority.Sectoral_level' bundle='${applicationAuResources}' />" validate="isSearch;" value="" maxLength="1" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Responsible_person' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="dept_leader" inputName="<fmt:message key='gap.authority.Person_in_charge' bundle='${applicationAuResources}' />" validate="isSearch;" value="" maxLength="50" />
					</td>
				</tr>
				<!--tr>
					<td align="right">备用字段</td>
					<td align="left">
						<input type="text" class="text_field" name="column1" inputName="备用字段" value="" maxLength="300" />
					</td>
				</tr>
				<tr>
					<td align="right">备用字段</td>
					<td align="left">
						<input type="text" class="text_field" name="column2" inputName="备用字段" value="" maxLength="300" />
					</td>
				</tr>
				<tr>
					<td align="right">备用字段</td>
					<td align="left">
						<input type="text" class="text_field" name="column3" inputName="备用字段" value="" maxLength="300" />
					</td>
				</tr-->
				<tr>
					<td align="right"><fmt:message key='gap.authority.Remarks' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<textarea class="textarea_limit_words" cols="60" rows="5" name="remark" maxLength="500" id="remarkId"></textarea>
					</td>
				</tr>
				</table>
</td></tr>
</table>
</div>
<input type="hidden" name="enable_status" value="1">
<input type="hidden" name="enable_date">
<input type="hidden" name="create_date">
<input type="hidden" name="modify_date">        
    
<input type="hidden" name="id" value="">
<input type="hidden" name="parentRelId" value="<%=parentRelId%>">
<input type="hidden" name="dept_no">
</form>		
</div>	
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
  		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
  		DepartmentVo resultVo = null;  //定义一个临时的vo变量
  		if(request.getAttribute(IDepartmentConstants.REQUEST_BEAN_VALUE) != null) {  //如果request中取出的bean不为空
  			resultVo = (DepartmentVo)request.getAttribute(IDepartmentConstants.REQUEST_BEAN_VALUE);  //从request中取出vo, 赋值给resultVo
  		}
  		if(resultVo != null) {  //如果vo不为空
			out.print(VoHelperTools.writeBackMapToForm(VoHelperTools.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
			out.print("writeBackMapToForm();\n");  //输出执行回写方法
		}
		out.print("</script>");  //输出script的声明结束
  	}
%>

