<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.empsecurity.vo.EmpsecurityVo" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EmpsecurityVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,<fmt:message key='insertEmpsecurity0001'/>(<fmt:message key='insertEmpsecurity0002'/>)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEmpsecurityConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EmpsecurityVo)request.getAttribute(IEmpsecurityConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.insertEmpsecurity_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"<fmt:message key='insertEmpsecurity0010'/>"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //<fmt:message key='insertEmpsecurity0010'/>后返回列表页面
        form.action="<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" ><fmt:message key='insertEmpsecurity0011'/>ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="<fmt:message key='insertEmpsecurity0011'/>ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key='insertEmpsecurity0013'/>ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_post_id" inputName="<fmt:message key='insertEmpsecurity0013'/>ID" value="" maxLength="9.5" validate="isNum;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0015'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_code" inputName="<fmt:message key='insertEmpsecurity0015'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0017'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_name" inputName="<fmt:message key='insertEmpsecurity0017'/>" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0021'/>明细ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="service_classify_item_id" inputName="<fmt:message key='insertEmpsecurity0021'/>明细ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0021'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="service_classify" inputName="<fmt:message key='insertEmpsecurity0021'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0023'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="social_unit_id" inputName="<fmt:message key='insertEmpsecurity0023'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0025'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_social_not_stop" inputName="<fmt:message key='insertEmpsecurity0025'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0027'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="social_copy_month" inputName="<fmt:message key='insertEmpsecurity0027'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0029'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="apply_man" inputName="<fmt:message key='insertEmpsecurity0029'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0031'/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="apply_date" id="apply_date" inputName="<fmt:message key='insertEmpsecurity0031'/>" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='insertEmpsecurity0033'/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="apply_remark" inputName="<fmt:message key='insertEmpsecurity0033'/>" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0035'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="transact_man" inputName="<fmt:message key='insertEmpsecurity0035'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0037'/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="transact_date" id="transact_date" inputName="<fmt:message key='insertEmpsecurity0037'/>" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('transact_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0039'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="transact_type_id" inputName="<fmt:message key='insertEmpsecurity0039'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='insertEmpsecurity0041'/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="transact_remarks" inputName="<fmt:message key='insertEmpsecurity0041'/>" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0043'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="start_month" inputName="<fmt:message key='insertEmpsecurity0043'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0045'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="end_month" inputName="<fmt:message key='insertEmpsecurity0045'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0047'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="report_month" inputName="<fmt:message key='insertEmpsecurity0047'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0049'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fund_month" inputName="<fmt:message key='insertEmpsecurity0049'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0051'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="old_cust_name" inputName="<fmt:message key='insertEmpsecurity0051'/>" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" ><fmt:message key='insertEmpsecurity0053'/></td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="average_wage" inputName="<fmt:message key='insertEmpsecurity0053'/>" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" ><fmt:message key='insertEmpsecurity0055'/></td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="old_average_wage" inputName="<fmt:message key='insertEmpsecurity0055'/>" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='insertEmpsecurity0057'/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="back_reason" inputName="<fmt:message key='insertEmpsecurity0057'/>" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0059'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="provider_id" inputName="<fmt:message key='insertEmpsecurity0059'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0061'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="stop_man" inputName="<fmt:message key='insertEmpsecurity0061'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0063'/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="stop_date" id="stop_date" inputName="<fmt:message key='insertEmpsecurity0063'/>" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('stop_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0065'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="stop_type_id" inputName="<fmt:message key='insertEmpsecurity0065'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0067'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="stop_reason_bd" inputName="<fmt:message key='insertEmpsecurity0067'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='insertEmpsecurity0069'/></td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="stop_remarks" inputName="<fmt:message key='insertEmpsecurity0069'/>" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0071'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="security_status_bd" inputName="<fmt:message key='insertEmpsecurity0071'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0073'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="serial_no" inputName="<fmt:message key='insertEmpsecurity0073'/>" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0075'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_update_user_id" inputName="<fmt:message key='insertEmpsecurity0075'/>" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0077'/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="<fmt:message key='insertEmpsecurity0077'/>" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key='insertEmpsecurity0079'/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_del" inputName="<fmt:message key='insertEmpsecurity0079'/>" value="'0'" maxLength="64" />
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
</fmt:bundle>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
