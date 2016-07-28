<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.ppssasalarytempletitem.vo.PpssasalarytempletitemVo" %>
<%@ page import="rayoo.pps.ppssasalarytempletitem.util.IPpssasalarytempletitemConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	PpssasalarytempletitemVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPpssasalarytempletitemConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (PpssasalarytempletitemVo)request.getAttribute(IPpssasalarytempletitemConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/PpssasalarytempletitemAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/PpssasalarytempletitemAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/PpssasalarytempletitemAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >company_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="company_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >salary_temp_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="salary_temp_id" inputName="salary_temp_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >salary_class_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="salary_class_id" inputName="salary_class_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >sa_item_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="sa_item_code" inputName="sa_item_code" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >sa_item_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="sa_item_name" inputName="sa_item_name" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >sa_item_ename</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="sa_item_ename" inputName="sa_item_ename" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >item_cost_group</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="item_cost_group" inputName="item_cost_group" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >compute_level</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="compute_level" inputName="compute_level" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >item_type</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="item_type" inputName="item_type" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ishide</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ishide" inputName="ishide" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_system</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_system" inputName="is_system" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >payroll_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="payroll_name" inputName="payroll_name" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_tax</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_tax" inputName="is_tax" value="'1'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >data_source</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="data_source" inputName="data_source" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >source_item</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="source_item" inputName="source_item" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >compute_order</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="compute_order" inputName="compute_order" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_display</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_display" inputName="is_display" value="'1'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >display_order</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="display_order" inputName="display_order" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_bonus</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_bonus" inputName="is_bonus" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_labor</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_labor" inputName="is_labor" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bonus_months_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bonus_months_bd" inputName="bonus_months_bd" value="'4'" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >property</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="property" inputName="property" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >item_serial_id</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="item_serial_id" inputName="item_serial_id" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >item_serial_new_id</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="item_serial_new_id" inputName="item_serial_new_id" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >old_id</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="old_id" inputName="old_id" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >decimal_num</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="decimal_num" inputName="decimal_num" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_valid</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" value="'1'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_del</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="last_update_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >welfare_display_order</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="welfare_display_order" inputName="welfare_display_order" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >salary_type</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="salary_type" inputName="salary_type" value="" maxLength="5" />
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
