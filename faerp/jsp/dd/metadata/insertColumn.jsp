<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List"%>
<%@ page import="gap.dd.util.VoHelper" %>
<%@ page import="gap.dd.metadata.vo.ColumnVo" %>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<%@ page import="venus.frames.i18n.util.LocaleHolder"%>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<%
	ColumnVo columnVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		columnVo = (ColumnVo)request.getAttribute("ColumnVo");  //从request中取出vo, 赋值给columnVo
		VoHelper.null2Nothing(columnVo); //把vo中null值替换为""
	}
	EnumRepository er = EnumRepository.getInstance();
    er.loadFromDir();
    EnumValueMap cTypeMap = er.getEnumValueMap( "ColumnType" );
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>gap.rm-based architecture project</title>
<script language="javascript">
	var rmActionName = "ColumnAction";
	function insert_onClick(){  //插入单条数据
		if( ! checkValue()) {
			return false;
		}
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=insertColumn";
		form.submit();
	}
  	function update_onClick(id){  //保存修改后的单条数据
    	if( ! getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		if( ! checkValue()) {
			return false;
		}
	    form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=updateColumn";
    	form.submit();
	}
	function checkValue() {
		var pass = true;
		
		if(form.isprimary[0].checked) {
			var result = notNull(form.primaryname.value, form.primaryname) ;
			if(pass==true && result==false) {
				pass = false;
			}
		}
		if(form.isindex[0].checked) {
			var result =  notNull(form.indexname.value, form.indexname);
			if(pass==true && result==false) {
				pass = false;
			}
		}
		
		return pass;
	}
	function changeDefaultValue() {
		//设置默认的字段长度
    	if(form.columntype.value=="<%=cTypeMap.getValue("char")%>") {
    		form.columnlen.value = "10";
    	}else if(form.columntype.value=="<%=cTypeMap.getValue("varchar")%>") {
    		form.columnlen.value = "50";
    	}else if(form.columntype.value=="<%=cTypeMap.getValue("numeric")%>") {
    		form.columnlen.value = "9";
    	}else {
    		form.columnlen.value = "";
    	}
	}
	function return_onClick(){  //实现转到列表页面
		var tableid = form.tableid.value;
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=queryColumns&tableid="+tableid;
		form.submit();
	}
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<%=isModify?LocaleHolder.getMessage("modify_page"):LocaleHolder.getMessage("new_page")%>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td><input name="button_save" class="button_ellipse" type="button" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClickTo="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>">
			<input name="button_cancel" class="button_ellipse" type="button" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>'  onClick="javascript:return_onClick()" >
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><%=isModify?LocaleHolder.getMessage("modify"):LocaleHolder.getMessage("add")%>列
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
<tr><td> 
	<table class="table_div_content_inner">
		<tr>
			<td align="right" width="15%" ><span class="style_required_red">* </span><fmt:message key="metadata.columnname"></fmt:message></td>
			<td align="left" width="35%" >
				<input type="text" class="text_field" name="columnname" inputName='<fmt:message key="metadata.columnname"></fmt:message>' value="" maxLength="64" validate="notNull;"/>
			</td>
			<td width="15%" align="right">&nbsp;</td>
			<td width="35%" align="left">&nbsp;</td>
		</tr>
		<tr>
			<td align="right"><span class="style_required_red">* </span><fmt:message key="metadata.zh_name"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="displayname" inputName='<fmt:message key="metadata.zh_name"></fmt:message>' value="" maxLength="64" validate="notNull;"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.columntype"></fmt:message></td>
			<td align="left">
			<select name="columntype"  class="text_field" inputName='<fmt:message key="metadata.columntype"></fmt:message>' validate="notNull;" onchange="javascript:changeDefaultValue()">
				<%
					List al = cTypeMap.getEnumList();
					for(int i=0;i<al.size();i++){%>
					<option value="<%=cTypeMap.getValue(al.get(i).toString())%>"><%=al.get(i)%></option>
     			 <%}%>
			</select>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.columnlen"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="columnlen" inputName='<fmt:message key="metadata.columnlen"></fmt:message>' value="10" maxLength="5" validate="isNum;"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.columnprec"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="columnprec" inputName='<fmt:message key="metadata.columnprec"></fmt:message>' value="" maxLength="5" validate="isNum;"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.defaultvalue"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="defaultval" inputName='<fmt:message key="metadata.defaultvalue"></fmt:message>' value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.isextends"></fmt:message></td>
			<td align="left">
				<input type="radio" name="inheritflag"  value="1" /><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="inheritflag"  value="0" checked/><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.whether_null"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isnullable"  value="1" checked/><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="isnullable"  value="0" /><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.isdummy"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isvirtual"  value="1" /><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="isvirtual"  value="0" checked/><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.whether_unique"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isunique"  value="1" /><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="isunique"  value="0" checked/><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.whether_primarykey"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isprimary"  value="1" /><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="isprimary"  value="0" checked/><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.primarykey_name"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="primaryname" inputName='<fmt:message key="metadata.primarykey_name"></fmt:message>' value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.whether_index"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isindex"  value="1" /><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="isindex"  value="0" checked/><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.index_name"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="indexname" inputName='<fmt:message key="metadata.index_name"></fmt:message>' value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.index_type"></fmt:message></td>
			<td align="left">
				<select name="indextype"  class="text_field" inputName='<fmt:message key="metadata.index_type"></fmt:message>'>
				    <option value="normal">normal</option>
					<option value="unique">unique</option>
				</select>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.isforeignkey"></fmt:message></td>
			<td align="left">
				<input type="radio" name="isforeign"  value="1" /><fmt:message key="common.yes"></fmt:message>
				<input type="radio" name="isforeign"  value="0" checked/><fmt:message key="common.no"></fmt:message>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.foreignkey_name"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="spare4" inputName='<fmt:message key="metadata.foreignkey_name"></fmt:message>' value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.foreignkey_table"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="reftable" inputName='<fmt:message key="metadata.foreignkey_table"></fmt:message>' value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.foreignkey_column"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="refcolumn" inputName='<fmt:message key="metadata.foreignkey_column"></fmt:message>' value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="metadata.constraint_expression"></fmt:message></td>
			<td align="left">
				<input type="text" class="text_field" name="formula" inputName='<fmt:message key="metadata.constraint_expression"></fmt:message>' value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"><fmt:message key="remark"  bundle="${applicationResources}"></fmt:message></td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName='<fmt:message key="remark"  bundle="${applicationResources}"></fmt:message>' maxLength="512" ></textarea>
			</td>
		</tr>
	</table>
</td></tr>
</table>
</div>
            
<input type="hidden" name="id" value="">
<input type="hidden" name="tableid" value="<%=request.getParameter("tableid")%>" />
<input type="hidden" name="tablename" value="<%=request.getParameter("tablename")%>"/>
<input type="hidden" name="status"  value="1"/>
<input type="hidden" name="iscreated"  value="0"/>
</form>			
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
</fmt:bundle>
<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(VoHelper.writeBackMapToForm(VoHelper.getMapFromVo(columnVo)));  //输出表单回写方法的脚本
		out.print("writeBackMapToForm();\n");  //输出执行回写方法  	
  	}
%>
</script>
