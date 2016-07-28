<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.sample.company.vo.CompanyVo" %>
<%@ page import="gap.authority.sample.company.util.ICompanyConstants" %>
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
	
	//标识本页面是否为添加根节点所用
	boolean isAddRoot = false;  
	if(request.getParameter("isAddRoot") != null) {  //如果从request获得参数"isAddRoot"不为空
		isAddRoot = true;  //赋值isAddRoot为true
	}
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	<%
	if(isAddRoot) {
	%>
		form.action="<%=request.getContextPath()%>/CompanyAction.do?cmd=insertRoot";
	<%
	}else {
	%>
    	form.action="<%=request.getContextPath()%>/CompanyAction.do?cmd=insert";
    <%
    	}
    %>
    	var parentRelId = form.parentRelId.value;
    	if(parentRelId!="")
    		form.target="_parent";
	    form.submit();
	}
  	function update_onClick(id){  //保存修改后的单条数据
  	    if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/CompanyAction.do?cmd=update";
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
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Modify"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Added")%><%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Company0")%>
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
					<td width="30%" align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Company_Name' bundle='${applicationAuResources}' /></td>
					<td width="70%" align="left">
						<input type="text" class="text_field" name="company_name" inputName="<fmt:message key='gap.authority.Company_Name' bundle='${applicationAuResources}' />" validate="notNull;checkInvalidString;" value="" maxLength="300" />
					</td>
				</tr>
				<%
				if( !isAddRoot && ! isModify && ( parentRelId==null || "".equals(parentRelId) ) ) {
				%>
				<tr>
					<td align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Respective_companies' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field_reference_readonly" id="owner_party_name" name="owner_party_name" inputName="<fmt:message key='gap.authority.Respective_companies' bundle='${applicationAuResources}' />" maxlength="50" validate="notNull;" 
						hiddenInputId="owner_party_id"/><input type="hidden" id="owner_party_id" name="owner_party_id"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" 
						onClick="javascript: try { getTree(new Array('owner_party_id', 'owner_party_name'),'<venus:base/>','radio','','1','id','1','1'); }catch(e){alert('<fmt:message key='gap.authority.Insufficient_privileges' bundle='${applicationAuResources}' />')}"/>
					</td>
				</tr>
				<%
				}
				%>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_Number' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="company_no" inputName="<fmt:message key='gap.authority.Company_Number' bundle='${applicationAuResources}' />" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_referred_to' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="short_name" inputName="<fmt:message key='gap.authority.Company_referred_to' bundle='${applicationAuResources}' />" validate="checkInvalidString;" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Logo' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="company_flag" inputName="<fmt:message key='gap.authority.Logo' bundle='${applicationAuResources}' />" validate="checkInvalidString;" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Type' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="company_type" inputName="<fmt:message key='gap.authority.Type' bundle='${applicationAuResources}' />" validate="checkInvalidString;" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_level' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="company_level" inputName="<fmt:message key='gap.authority.Company_level' bundle='${applicationAuResources}' />" validate="checkInvalidString;" value="" maxLength="1" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Your_area' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="area" inputName="<fmt:message key='gap.authority.Your_area' bundle='${applicationAuResources}' />" validate="checkInvalidString;" value="" maxLength="300" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Contact' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="linkman" inputName="<fmt:message key='gap.authority.Contact0' bundle='${applicationAuResources}' />" validate="checkInvalidString;" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Tel' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="tel" inputName="<fmt:message key='gap.authority.Tel' bundle='${applicationAuResources}' />" validate="isTel;" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Fax' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="fax" inputName="<fmt:message key='gap.authority.Fax0' bundle='${applicationAuResources}' />" validate="isTel;" value="" maxLength="50" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Post_Code' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="postalcode" inputName="<fmt:message key='gap.authority.Zip_Code' bundle='${applicationAuResources}' />" validate="isPostalCode;" value="" maxLength="6" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Address0' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="address" inputName="<fmt:message key='gap.authority.Address' bundle='${applicationAuResources}' />" validate="checkInvalidString;" value="" maxLength="300" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.E_mail' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="email" inputName="<fmt:message key='gap.authority.E_mail' bundle='${applicationAuResources}' />" validate="isEmail;" value="" maxLength="300" />
					</td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Website' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="web" inputName="<fmt:message key='gap.authority.Website0' bundle='${applicationAuResources}' />" validate="checkInvalidString;" value="" maxLength="300" />
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
		</td>
	</tr>
</table>
</div>
<input type="hidden" name="enable_status" value="1">
<input type="hidden" name="enable_date">
<input type="hidden" name="create_date">
<input type="hidden" name="modify_date">
            
<input type="hidden" name="id" value="">
<input type="hidden" name="parentRelId" value="<%=parentRelId%>">
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
  		CompanyVo resultVo = null;  //定义一个临时的vo变量
  		if(request.getAttribute(ICompanyConstants.REQUEST_BEAN_VALUE) != null) {  //如果request中取出的bean不为空
  			resultVo = (CompanyVo)request.getAttribute(ICompanyConstants.REQUEST_BEAN_VALUE);  //从request中取出vo, 赋值给resultVo
  		}
  		if(resultVo != null) {  //如果vo不为空
			out.print(VoHelperTools.writeBackMapToForm(VoHelperTools.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
			out.print("writeBackMapToForm();\n");  //输出执行回写方法
		}
		out.print("</script>");  //输出script的声明结束
  	}
%>

