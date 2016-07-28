<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EmppostVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEmppostConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EmppostVo)request.getAttribute(IEmppostConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_1" ><fmt:message key="cust_name"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_name" inputName="客户名称" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="cust_code"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_code" inputName="客户编号" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="emp_code"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_code" inputName="唯一号" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="emp_name"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_name" inputName="员工姓名" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="send_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="send_id" inputName="委派单ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="quotation_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="quotation_id" inputName="报价单ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="emp_post_type"/></td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_post_type_bd", -1, gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_), "", "inputName='员工类型' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="apply_on_post_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="apply_on_post_date" id="apply_on_post_date" inputName="入职时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_on_post_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="charge_start_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="charge_start_date" id="charge_start_date" inputName="收费开始时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('charge_start_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="charge_end_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="charge_end_date" id="charge_end_date" inputName="收费结束时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('charge_end_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_employ_notice"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_employ_notice" inputName="是否入职通知" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_physical_examination"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_physical_examination" inputName="是否体检" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_import_client"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_import_client" inputName="是否导入客户端" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="security_unit_id"/></td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("security_unit_id", -1, gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_), "", "inputName='福利办理方' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="on_post_desc"/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="on_post_desc" inputName="入职备注" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="post_status"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="post_status_bd" inputName="入离职状态" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="on_post_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="on_post_date" id="on_post_date" inputName="报入职时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_post_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="on_post_user_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="on_post_user_id" inputName="报入职人" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="move_desc"/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="move_desc" inputName="转移备注" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="apply_off_post_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="apply_off_post_date" id="apply_off_post_date" inputName="员工离职时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_off_post_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="off_post_reason"/></td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("off_post_reason", -1, gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_), "", "inputName='离职原因' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="off_post_desc"/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="off_post_desc" inputName="离职备注" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="method_labor_get"/></td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("method_labor_get_bd", -1, gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_), "", "inputName='劳动手册领取方式' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="method_accu_move"/></td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("method_accu_move_bd", -1, gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_), "", "inputName='公积金转移方式' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="location_retrieve_doc"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="location_retrieve_doc" inputName="退档地" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="off_post_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="off_post_date" id="off_post_date" inputName="报离职时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('off_post_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="off_post_user_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="off_post_user_id" inputName="报离职人" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="first_notice_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="first_notice_date" id="first_notice_date" inputName="一次通知时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('first_notice_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="first_notice_result"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="first_notice_result" inputName="员工反馈1" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="second_notice_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="second_notice_date" id="second_notice_date" inputName="二次通知时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('second_notice_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="second_notice_result"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="second_notice_result" inputName="员工反馈2" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="third_notice_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="third_notice_date" id="third_notice_date" inputName="三次通知时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('third_notice_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="hird_notice_result"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="third_notice_result" inputName="员工反馈3" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="notice_desc"/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="notice_desc" inputName="入职通知备注" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="exam_process"/></td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("exam_process", -1, gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_), "", "inputName='体检情况' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="exam_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="exam_date" id="exam_date" inputName="体检日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('exam_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="exam_result"/></td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("exam_result", -1, gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_), "", "inputName='体检结果' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="mobile"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="mobile" inputName="联系手机" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="email"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="email" inputName="电子邮件" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
		</tr>
	</table>
 

            
   
   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
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
