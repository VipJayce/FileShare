<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.laborcontractmail.vo.LaborcontractmailVo" %>
<%@ page import="rayoo.customerservice.laborcontractmail.util.ILaborcontractmailConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	LaborcontractmailVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ILaborcontractmailConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (LaborcontractmailVo)request.getAttribute(ILaborcontractmailConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/LaborcontractmailAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/LaborcontractmailAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/LaborcontractmailAction.do?cmd=queryAll&backFlag=true";
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
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" value="null " maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_post_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_post_id" inputName="emp_post_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_code</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code" inputName="emp_code" value="" maxLength="64" />
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
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" value="" maxLength="50" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_code</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" value="" maxLength="64" />
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
			<td align="right">start_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="start_date" id="start_date" inputName="start_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('start_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">end_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="end_date" id="end_date" inputName="end_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('end_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">salary</td>
			<td align="left">
				<input type="text" class="text_field" name="salary" inputName="salary" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">try_start_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="try_start_date" id="try_start_date" inputName="try_start_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('try_start_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">try_end_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="try_end_date" id="try_end_date" inputName="try_end_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('try_end_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">try_salary</td>
			<td align="left">
				<input type="text" class="text_field" name="try_salary" inputName="try_salary" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">subscribe_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="subscribe_date" id="subscribe_date" inputName="subscribe_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('subscribe_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">labor_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="labor_status_bd" inputName="labor_status_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">labor_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="labor_type_bd" inputName="labor_type_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_deadline</td>
			<td align="left">
				<input type="text" class="text_field" name="is_deadline" inputName="is_deadline" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_work_out</td>
			<td align="left">
				<input type="text" class="text_field" name="is_work_out" inputName="is_work_out" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">welfare_address</td>
			<td align="left">
				<input type="text" class="text_field" name="welfare_address" inputName="welfare_address" value="" maxLength="50" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">working_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="working_bd" inputName="working_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">send_start_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="send_start_date" id="send_start_date" inputName="send_start_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('send_start_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">send_end_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="send_end_date" id="send_end_date" inputName="send_end_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('send_end_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">remind_status</td>
			<td align="left">
				<input type="text" class="text_field" name="remind_status" inputName="remind_status" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">position</td>
			<td align="left">
				<input type="text" class="text_field" name="position" inputName="position" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">备注</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="remark" inputName="备注" maxLength="1000" ></textarea>
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
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="'0'" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">old_id</td>
			<td align="left">
				<input type="text" class="text_field" name="old_id" inputName="old_id" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">contract_properties</td>
			<td align="left">
				<input type="text" class="text_field" name="contract_properties" inputName="contract_properties" value="'1' " maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">contractmail_type</td>
			<td align="left">
				<input type="text" class="text_field" name="contractmail_type" inputName="contractmail_type" value="" maxLength="8" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">contractmail_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="contractmail_status_bd" inputName="contractmail_status_bd" value="" maxLength="8" />
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
            
<input type="hidden" name="id" value="">
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
