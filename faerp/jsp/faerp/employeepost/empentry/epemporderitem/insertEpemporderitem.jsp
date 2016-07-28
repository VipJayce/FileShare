<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.empentry.epemporderitem.vo.EpemporderitemVo" %>
<%@ page import="rayoo.employeepost.empentry.epemporderitem.util.IEpemporderitemConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EpemporderitemVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEpemporderitemConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EpemporderitemVo)request.getAttribute(IEpemporderitemConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/EpemporderitemAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/EpemporderitemAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EpemporderitemAction.do?cmd=queryAll&backFlag=true";
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
			<td  class="td_1" >基数</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="base" inputName="基数" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" ><span class="style_required_red">* </span>金额</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="money" inputName="金额" maxLength="21" integerDigits="18" decimalDigits="2" validate="notNull;"/>
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >个人金额</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="p_money" inputName="个人金额" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >企业金额</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="e_money" inputName="企业金额" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >个人比例</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="p_ratio" inputName="个人比例" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >企业比例</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="e_ratio" inputName="企业比例" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >收费开始时间</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="start_date" id="start_date" inputName="收费开始时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('start_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >收费截止时间</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="end_date" id="end_date" inputName="收费截止时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('end_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >财务计算申报的起始时间</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="on_apply_date" id="on_apply_date" inputName="财务计算申报的起始时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('on_apply_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >报入职时间</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="start_apply_date" id="start_apply_date" inputName="报入职时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('start_apply_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >财务计算申报的截止时间</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="off_apply_date" id="off_apply_date" inputName="财务计算申报的截止时间" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('off_apply_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >报离职日期</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="end_apply_date" id="end_apply_date" inputName="报离职日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('end_apply_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >单位附加金额</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="e_add_money" inputName="单位附加金额" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >个人附加金额</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="p_add_money" inputName="个人附加金额" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否预收</td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_prepay", -1, gap.rm.project.RmGlobalReference.get(IEpemporderitemConstants.DICTIONARY_), "", "inputName='是否预收' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >收费频率</td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("frequency_bd", -1, gap.rm.project.RmGlobalReference.get(IEpemporderitemConstants.DICTIONARY_), "", "inputName='收费频率' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否服务办理好收费</td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_charge_on_security", -1, gap.rm.project.RmGlobalReference.get(IEpemporderitemConstants.DICTIONARY_), "", "inputName='是否服务办理好收费' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >最后修改人</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_update_user_id" inputName="最后修改人" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >最后修改日期</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="最后修改日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >收费状态</td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_effected", -1, gap.rm.project.RmGlobalReference.get(IEpemporderitemConstants.DICTIONARY_), "", "inputName='收费状态' ", true) %>
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
