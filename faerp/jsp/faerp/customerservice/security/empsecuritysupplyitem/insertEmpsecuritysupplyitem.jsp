<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.empsecuritysupplyitem.vo.EmpsecuritysupplyitemVo" %>
<%@ page import="rayoo.customerservice.security.empsecuritysupplyitem.util.IEmpsecuritysupplyitemConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EmpsecuritysupplyitemVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEmpsecuritysupplyitemConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EmpsecuritysupplyitemVo)request.getAttribute(IEmpsecuritysupplyitemConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/EmpsecuritysupplyitemAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/EmpsecuritysupplyitemAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EmpsecuritysupplyitemAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >security_supply_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="security_supply_id" inputName="security_supply_id" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >product_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="product_id" inputName="product_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >base</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="base" inputName="base" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >e_ratio</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="e_ratio" inputName="e_ratio" maxLength="24" integerDigits="18" decimalDigits="5" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >p_ratio</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="p_ratio" inputName="p_ratio" maxLength="24" integerDigits="18" decimalDigits="5" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >money</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="money" inputName="money" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >e_money</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="e_money" inputName="e_money" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >p_money</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="p_money" inputName="p_money" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >e_add_money</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="e_add_money" inputName="e_add_money" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >p_add_money</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="p_add_money" inputName="p_add_money" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >the_month</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="the_month" inputName="the_month" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >e_latefee</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="e_latefee" inputName="e_latefee" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >p_latefee</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="p_latefee" inputName="p_latefee" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
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
			<td class="td_1" >is_valid</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" value="1 " maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >exact_e_money</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="exact_e_money" inputName="exact_e_money" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >exact_p_money</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="exact_p_money" inputName="exact_p_money" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
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
