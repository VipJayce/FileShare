<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.quickemppost.vo.QuickemppostVo" %>
<%@ page import="rayoo.employeepost.quickemppost.util.IQuickemppostConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	QuickemppostVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IQuickemppostConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (QuickemppostVo)request.getAttribute(IQuickemppostConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/QuickemppostAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/QuickemppostAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/QuickemppostAction.do?cmd=queryAll&backFlag=true";
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
			<td align="right">cust_code</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" value="" maxLength="25" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_id" inputName="emp_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
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
			<td align="right">send_id</td>
			<td align="left">
				<input type="text" class="text_field" name="send_id" inputName="send_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_post_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_post_type_bd" inputName="emp_post_type_bd" value="" maxLength="25" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">apply_on_post_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="apply_on_post_date" id="apply_on_post_date" inputName="apply_on_post_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_on_post_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">charge_start_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="charge_start_date" id="charge_start_date" inputName="charge_start_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('charge_start_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">charge_end_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="charge_end_date" id="charge_end_date" inputName="charge_end_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('charge_end_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_employ_notice</td>
			<td align="left">
				<input type="text" class="text_field" name="is_employ_notice" inputName="is_employ_notice" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_physical_examination</td>
			<td align="left">
				<input type="text" class="text_field" name="is_physical_examination" inputName="is_physical_examination" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_import_client</td>
			<td align="left">
				<input type="text" class="text_field" name="is_import_client" inputName="is_import_client" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">security_unit_id</td>
			<td align="left">
				<input type="text" class="text_field" name="security_unit_id" inputName="security_unit_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">on_post_desc</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="on_post_desc" inputName="on_post_desc" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">post_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="post_status_bd" inputName="post_status_bd" value="" maxLength="25" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">on_post_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="on_post_date" id="on_post_date" inputName="on_post_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_post_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">on_post_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="on_post_user_id" inputName="on_post_user_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">move_pre_post_id</td>
			<td align="left">
				<input type="text" class="text_field" name="move_pre_post_id" inputName="move_pre_post_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">move_aft_post_id</td>
			<td align="left">
				<input type="text" class="text_field" name="move_aft_post_id" inputName="move_aft_post_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">move_desc</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="move_desc" inputName="move_desc" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">apply_off_post_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="apply_off_post_date" id="apply_off_post_date" inputName="apply_off_post_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_off_post_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">off_post_reason</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="off_post_reason" inputName="off_post_reason" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">off_post_desc</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="off_post_desc" inputName="off_post_desc" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">method_labor_get_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="method_labor_get_bd" inputName="method_labor_get_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">method_accu_move_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="method_accu_move_bd" inputName="method_accu_move_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">location_retrieve_doc</td>
			<td align="left">
				<input type="text" class="text_field" name="location_retrieve_doc" inputName="location_retrieve_doc" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">off_post_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="off_post_date" id="off_post_date" inputName="off_post_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('off_post_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">off_post_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="off_post_user_id" inputName="off_post_user_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">first_notice_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="first_notice_date" id="first_notice_date" inputName="first_notice_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('first_notice_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">first_notice_result</td>
			<td align="left">
				<input type="text" class="text_field" name="first_notice_result" inputName="first_notice_result" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">second_notice_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="second_notice_date" id="second_notice_date" inputName="second_notice_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('second_notice_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">second_notice_result</td>
			<td align="left">
				<input type="text" class="text_field" name="second_notice_result" inputName="second_notice_result" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">third_notice_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="third_notice_date" id="third_notice_date" inputName="third_notice_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('third_notice_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">third_notice_result</td>
			<td align="left">
				<input type="text" class="text_field" name="third_notice_result" inputName="third_notice_result" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">notice_desc</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="notice_desc" inputName="notice_desc" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">exam_process</td>
			<td align="left">
				<input type="text" class="text_field" name="exam_process" inputName="exam_process" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">exam_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="exam_date" id="exam_date" inputName="exam_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('exam_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">exam_result</td>
			<td align="left">
				<input type="text" class="text_field" name="exam_result" inputName="exam_result" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">mobile</td>
			<td align="left">
				<input type="text" class="text_field" name="mobile" inputName="mobile" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">email</td>
			<td align="left">
				<input type="text" class="text_field" name="email" inputName="email" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
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
			<td align="right">notice_status</td>
			<td align="left">
				<input type="text" class="text_field" name="notice_status" inputName="notice_status" value="'1' " maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">notice_desc2</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="notice_desc2" inputName="notice_desc2" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">internal_code</td>
			<td align="left">
				<input type="text" class="text_field" name="internal_code" inputName="internal_code" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">import_id</td>
			<td align="left">
				<input type="text" class="text_field" name="import_id" inputName="import_id" value="" maxLength="9.5" />
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
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" value="null " maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_entry_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_entry_bd" inputName="emp_entry_bd" value="'1' " maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">fund_security_unit_id</td>
			<td align="left">
				<input type="text" class="text_field" name="fund_security_unit_id" inputName="fund_security_unit_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">hire_security_unit_id</td>
			<td align="left">
				<input type="text" class="text_field" name="hire_security_unit_id" inputName="hire_security_unit_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">off_notice_status</td>
			<td align="left">
				<input type="text" class="text_field" name="off_notice_status" inputName="off_notice_status" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">job_num</td>
			<td align="left">
				<input type="text" class="text_field" name="job_num" inputName="job_num" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">hro</td>
			<td align="left">
				<input type="text" class="text_field" name="hro" inputName="hro" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">business</td>
			<td align="left">
				<input type="text" class="text_field" name="business" inputName="business" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_status</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_status" inputName="emp_status" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">ge_off_post_reason</td>
			<td align="left">
				<input type="text" class="text_field" name="ge_off_post_reason" inputName="ge_off_post_reason" value="" maxLength="64" />
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
