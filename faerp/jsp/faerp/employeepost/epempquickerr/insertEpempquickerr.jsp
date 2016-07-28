<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.epempquickerr.vo.EpempquickerrVo" %>
<%@ page import="rayoo.employeepost.epempquickerr.util.IEpempquickerrConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EpempquickerrVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEpempquickerrConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EpempquickerrVo)request.getAttribute(IEpempquickerrConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/EpempquickerrAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/EpempquickerrAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EpempquickerrAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
<script language="javascript">
    if(<%=isModify%>)
        writeTableTop('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTop('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td><br>&nbsp;&nbsp;&nbsp;&nbsp;<input name="button_save" class="button_ellipse" type="button" value='<fmt:message key="save"/>' onClickTo="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>">
			<input name="button_cancel" class="button_ellipse" type="button" value='<fmt:message key="cancel"/>'  onClick="javascript:cancel_onClick()" >
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
            <c:if test="<%=isModify%>">
                <fmt:message key="update_detail"/>
            </c:if>
            <c:if test="<%=(isModify==false)%>">
                <fmt:message key="add_detail"/>
            </c:if>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
<tr><td> 
	<table class="table_div_content_inner">
		<tr>
			<td align="right">emp_code</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code" inputName="emp_code" value="" maxLength="25" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_name</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" inputName="emp_name" value="" maxLength="50" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_code</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" value="" maxLength="25" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" value="" maxLength="50" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cost_center_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_id" inputName="cost_center_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cost_center_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_name" inputName="cost_center_name" value="" maxLength="50" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">error_msg</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="error_msg" inputName="error_msg" maxLength="500" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">last_update_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">last_update_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="last_update_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_valid</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" value="'1' " maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">city_name</td>
			<td align="left">
				<input type="text" class="text_field" name="city_name" inputName="city_name" value="" maxLength="50" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">city_code</td>
			<td align="left">
				<input type="text" class="text_field" name="city_code" inputName="city_code" value="" maxLength="25" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">contract_type</td>
			<td align="left">
				<input type="text" class="text_field" name="contract_type" inputName="contract_type" value="" maxLength="25" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">quotation_id</td>
			<td align="left">
				<input type="text" class="text_field" name="quotation_id" inputName="quotation_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="'0' " maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</td></tr>
</table>
</div>
            
<input type="hidden" name="contract" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
