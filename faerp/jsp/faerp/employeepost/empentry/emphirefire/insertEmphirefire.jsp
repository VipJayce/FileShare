<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.empentry.emphirefire.vo.EmphirefireVo" %>
<%@ page import="rayoo.employeepost.empentry.emphirefire.util.IEmphirefireConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EmphirefireVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEmphirefireConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EmphirefireVo)request.getAttribute(IEmphirefireConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emphirefire.emphirefire_resource" prefix="rayoo.employeepost.empentry.emphirefire.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/EmphirefireAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/EmphirefireAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EmphirefireAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" ><fmt:message key="now_the_files_are_located"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="archives_address" inputName="现档案所在地" value="" maxLength="75" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="employment_begin_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="hire_start_date" id="hire_start_date" inputName="用工起始日" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_start_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="employment_address"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hire_address" inputName="用工所在地" value="" maxLength="75" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="handle_employment_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="hire_handle_date" id="hire_handle_date" inputName="办理用工日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_handle_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="archive_cards"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="file_card" inputName="存档卡" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="office_srfm_labor_and_employment"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hire_handler_id" inputName="办用工劳动专管员id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="hire_operate_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="hire_operate_date" id="hire_operate_date" inputName="系统记录用工日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('hire_operate_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="social_unit"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="social_unit" inputName="用工方" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="hire_fire_status"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hire_fire_status_bd" inputName="用退工状态" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="fire_handle_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="fire_handle_date" id="fire_handle_date" inputName="办理退工日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('fire_handle_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="fire_mode"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fire_mode_bd" inputName="退工方式" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="fire_memo"/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="fire_memo" inputName="退工备注" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="hire_memo"/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="hire_memo" inputName="用工备注" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="fire_resident_address"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fire_resident_address" inputName="退工户籍地址" value="" maxLength="75" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="cancel_reason"/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="cancel_reason" inputName="撤销原因" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="back_reason"/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="back_reason" inputName="回退原因" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="transfer_type"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="transfer_type_bd" inputName="退工证明转移方式" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="last_icst_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_icst_id" inputName="上次用工服务明细ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="last_eoop_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_eoop_id" inputName="上次用工入离职ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_laborbook"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_laborbook_bd" inputName="是否有劳动手册" value="0 " maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_fire_prove"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_fire_prove_bd" inputName="是否有退工单" value="0 " maxLength="64" />
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
