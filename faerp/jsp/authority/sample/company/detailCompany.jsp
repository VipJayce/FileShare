<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="gap.authority.sample.company.vo.CompanyVo" %>
<%@ page import="gap.authority.sample.company.util.ICompanyConstants" %>
<%  //取出本条记录
	CompanyVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (CompanyVo)request.getAttribute(ICompanyConstants.REQUEST_BEAN_VALUE);  //从request中取出vo, 赋值给resultVo
	VoHelperTools.replaceToHtml(resultVo);  //把vo中的每个值过滤

	boolean isReadOnly = false;  //定义变量,标识本页面是否为只读页面
	if(request.getParameter("isReadOnly") != null) {  //如果从request获得参数"isReadOnly"不为空
		isReadOnly = true;  //赋值isReadOnly为true
	}
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GAP<fmt:message key='gap.authority.Organizational_competence_system' bundle='${applicationAuResources}' /></title>
<script language="javascript">
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/RelationAction.do";
		form.cmd.value = "go2Add";
		form.submit();
	}
	function toSort_onClick() {  //到排序页面
		var parentRelId = document.form.relationId.value;
		window.location="<%=request.getContextPath()%>/jsp/authority/sample/relation/sort.jsp?parentRelId="+parentRelId;
	}
	function find_onClick(){  //直接点到修改页面
		form.action="<%=request.getContextPath()%>/CompanyAction.do";
		form.cmd.value = "find";
		form.submit();
	}
	function delete_onClick(){  //直接点删除单条记录
		//if(!confirm("本操作将删除该公司的组织关系信息\n\n"
		//+ "该公司的基本信息不会被删除，如果要删除基本信息请到公司档案管理页面进行删除\n\n"
		if(!confirm("<fmt:message key='gap.authority.This_operation_will_completely_remove_the_company' bundle='${applicationAuResources}' />\n"
		+ "<fmt:message key='gap.authority.Are_you_sure_you_do_this_' bundle='${applicationAuResources}' />")) {
			return false;
		}
		form.action="<%=request.getContextPath()%>/CompanyAction.do";
		form.cmd.value = "delete";
		form.target="_parent";
		form.submit();
	}
	function goBack() {
		form.action="<%=request.getContextPath()%>/CompanyAction.do";
		form.cmd.value = "queryAll";
		form.submit();
	}
</script>
</head>
<body>
<div id="right">
<script language="javascript">
	writeTableTopFesco("<fmt:message key='gap.authority.Detailed_Page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="get">
<table class="table_noFrame">
	<tr>
		<td>
			<%
			if(isReadOnly) {
			%>
				<input name="button_back" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Return' bundle='${applicationAuResources}' />"  onclick="javascript:goBack()" >
			<%
			}else {
			%>
				<input name="button_add" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Add' bundle='${applicationAuResources}' />"  onclick="javascript:toAdd_onClick();" >
				<input name="button_update" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Modify' bundle='${applicationAuResources}' />" onClick="javascript:find_onClick();">
				<input name="button_delete" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Delete' bundle='${applicationAuResources}' />" onClick="javascript:delete_onClick();">
				<input name="button_sort" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Sort' bundle='${applicationAuResources}' />" onClick="javascript:toSort_onClick();">
				<input name="button_change" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Tone_level' bundle='${applicationAuResources}' />" onClick="javascript:getChangeTree(new Array(),'<venus:base/>','radio','','1','','1','1');">
			<%
			}
			%>
		</td>
	</tr>
</table>

<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Company0")%><fmt:message key='gap.authority.Details0' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
	<tr>
		<td>
			<table class="table_div_content_inner">
				<tr>
					<td width="30%" align="right"><fmt:message key='gap.authority.Company_Name_' bundle='${applicationAuResources}' /></td>
					<td width="70%" align="left"><%=StringHelperTools.prt(resultVo.getCompany_name())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Code_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getCompany_no())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_Abbreviation_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getShort_name())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_ID_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getCompany_flag())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Type_0' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getCompany_type())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_level_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getCompany_level())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Your_area_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getArea())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Contact_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getLinkman())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Tel_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getTel())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Fax_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getFax())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Postal_Code_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getPostalcode())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Address_0' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getAddress())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.E_mail_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getEmail())%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Website_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getWeb())%></td>
				</tr>
				<!--tr>
					<td align="right">备用字段：</td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getColumn1())%></td>
				</tr>
				<tr>
					<td align="right">备用字段：</td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getColumn2())%></td>
				</tr>
				<tr>
					<td align="right">备用字段：</td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getColumn3())%></td>
				</tr-->
				<tr>
					<td align="right"><fmt:message key='gap.authority.Remarks_' bundle='${applicationAuResources}' /></td>
					<td colspan="3" align="left"><%=StringHelperTools.prt(resultVo.getRemark())%></td>
				</tr>
				<!--tr>
					<td align="right">可用状态：</td>
					<td align="left"><%="1".equals(resultVo.getEnable_status())?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Enabled"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Disable")%></td>
				</tr>
				<tr>
					<td align="right">启用/禁用时间：</td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getEnable_date(),19)%></td>
				</tr-->
				<tr>
					<td align="right"><fmt:message key='gap.authority.Created_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getCreate_date(),19)%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Modified_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(resultVo.getModify_date(),19)%></td>
				</tr>
				</table>
</td></tr>
</table>
</div>
<!-- 所属关系示意图的代码  开始-->
<%if(isReadOnly) {%>
<div id="auDivParent2"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild2',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.Schematic_diagram_of_their_relationship' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>
<div id="auDivChild2"> 
<table class="table_div_content">
	<tr>
		<td>
             <table class="table_div_content_inner" width="100%"> 
                <tr>
                    <td width="100%" align="left">
                    	<iframe name="myTree" width="100%" height="150" frameborder="0" 
                    		src="<venus:base/>/jsp/authority/tree/deeptree_iframe.jsp?rootXmlSource=<venus:base/>/jsp/authority/tree/partyDetailTreeRoot.jsp?party_id%3D<%=resultVo.getId()%>">
                    	</iframe>
                    </td> 
                </tr> 
            </table> 
		</td> 
	</tr>
</table>
</div>
<%}%>
<!-- 所属关系示意图的代码  结束-->
<input type="hidden" name="cmd" value="">
<input type="hidden" name="id" value="<%=resultVo.getId()%>">
<input type="hidden" name="relationId" value="<%=request.getParameter("relationId")%>">
<input type="hidden" name="partyType" value="<%=request.getParameter("type")%>">
</form>
</div>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
	

