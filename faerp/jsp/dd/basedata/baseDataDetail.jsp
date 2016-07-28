<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<!--业务信息-->
<input id="typeId" name="typeId" type="hidden" class="text_field"  validate="notNull"  readonly="true" value=""/><!-- 类型 -->
<input id="typeCode" name="typeCode" type="hidden" class="text_field"  validate="notNull"  readonly="true" value=""/><!-- 类型 -->
<!--树信息-->
<input id="levelNum" name="levelNum" type="hidden" class="text_field"  validate="notNull"  readonly="true" value=""/><!-- 级次 -->
<input id="isLeaf" name="isLeaf" type="hidden" class="text_field"  validate="notNull"  readonly="true" value=""/><!-- 是否底级 -->
<input id="treeCode" name="treeCode" type="hidden" class="text_field"  validate="notNull"  readonly="true" value=""/><!-- 级次编码 -->
<input id="parentId" name="parentId" type="hidden" class="text_field"  validate="notNull"  readonly="true" value=""/><!-- 父级编码 -->
<!--系统信息-->
<input id="createdBy" name="createdBy" type="hidden" class="text_field"  validate="notNull"  readonly="true" value=""/><!-- 创建者 -->
<input id="updatedBy" name="updatedBy" type="hidden" class="text_field"  validate="notNull"  readonly="true" value=""/><!-- 修改者 -->

<table name class="table_div_content">
	<!--业务信息-->
	<tr>
		<td align="right" width="15%"><span class="style_required_red">* </span><fmt:message key="common.code"/></td>		
		<td align="left">
			<input name="code" type="text" class="text_field" inputName='<fmt:message key="common.code"/>' validate="isSearch,notNull" value=""/>
		</td>
	</tr>
	<tr>
		<td align="right"><span class="style_required_red">* </span><fmt:message key="name"  bundle="${applicationResources}"></fmt:message></td>
		<td align="left">
			<input name="name" type="text" class="text_field" inputName='<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>' validate="notNull"  value=""/>		
		</td>
	</tr>
	   <tr>
        <td align="right"><span class="style_required_red">* </span><fmt:message key="name_en"  bundle="${applicationResources}"></fmt:message></td>
        <td align="left">
            <input name="name_en" type="text" class="text_field" inputName='<fmt:message key="name_en"  bundle="${applicationResources}"></fmt:message>' validate="notNull"  value=""/>       
        </td>
    </tr>
	<tr>
		<td align="right"><fmt:message key="common.status"/></td>
		<td align="left"><input type="radio" name="status" value="1"
			checked/><fmt:message key="common.enable"/><input type="radio" name="status" value="0"/><fmt:message key="common.disable"/></td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="basedata.basedata_isbncode"/></td>
		<td align="left">
			<input name="isbnCode" type="text" class="text_field" inputName='<fmt:message key="basedata.basedata_isbncode"/>' validate="isSearch"   value=""/>
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="basedata.basedata_hintcode"/></td>
		<td align="left">
			<input name="hintCode" type="text" class="text_field" inputName='<fmt:message key="basedata.basedata_hintcode"/>' validate="isSearch"   value=""/>
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="basedata.basedata_startdate"/></td>
		<td align="left">
			<input id="startDate" name="startDate" type="text" class="text_field_reference" inputName='<fmt:message key="basedata.basedata_startdate"/>'  validate="" readonly="true" ><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('startDate','<%=request.getContextPath()%>/')" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="basedata.basedata_enddate"/></td>
		<td align="left">
			<input id="endDate" name="endDate" type="text" class="text_field_reference" inputName='<fmt:message key="basedata.basedata_enddate"/>'   validate="" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate','<%=request.getContextPath()%>/')" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="basedata.basedata_seqno"/></td>
		<td align="left">
			<input name="seqNo" type="text" class="text_field" inputName='<fmt:message key="basedata.basedata_seqno"/>' validate="notNull,isInteger"   value="0"/>
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="common.description"/></td>
		<td align="left">
			<textarea name="description" cols="36"
					rows="5" name="help" maxLength="150" class="textarea_limit_words" inputName=<fmt:message key="common.description"/> validate=""  value=""></textarea>
		</td>
	</tr>

</table>
</fmt:bundle>