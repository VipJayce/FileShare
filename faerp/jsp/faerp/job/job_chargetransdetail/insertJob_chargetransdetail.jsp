<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_chargetransdetail.vo.Job_chargetransdetailVo" %>
<%@ page import="rayoo.job.job_chargetransdetail.util.IJob_chargetransdetailConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	Job_chargetransdetailVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IJob_chargetransdetailConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (Job_chargetransdetailVo)request.getAttribute(IJob_chargetransdetailConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >费用划转单主表</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="chargetransferbill_id" inputName="费用划转单主表" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >职位ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="position_id" inputName="职位ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >客户ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_id" inputName="客户ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >PM主键</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pm_id" inputName="PM主键" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pmteam</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pmteam" inputName="pmteam" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >顾问ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="counselor_id" inputName="顾问ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >员工ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="employee_id" inputName="员工ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >外派开始日期</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="sendstartdate" id="sendstartdate" inputName="外派开始日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('sendstartdate','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >外派截止日期</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="sendenddate" id="sendenddate" inputName="外派截止日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('sendenddate','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >外派期限</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="sendperiod" inputName="外派期限" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >费用项目</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="expenseitem" inputName="费用项目" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >费用金额</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="expenseamount" inputName="费用金额" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >划入部门</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="cutindept_id" inputName="划入部门" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否显示</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="showed" inputName="是否显示" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >显示序号</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="serialno" inputName="显示序号" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >客服确认人</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="serviceconfirmor" inputName="客服确认人" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >顾问确认人</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="counselconfirmor" inputName="顾问确认人" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >财务确认人</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="financeconfirmor" inputName="财务确认人" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >备注</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="description" inputName="备注" value="" maxLength="100" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否有效</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_valid" inputName="是否有效" value="'1'" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >是否删除</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_del" inputName="是否删除" value="'0'" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >分公司ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="分公司ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >创建用户名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="create_user_name" inputName="创建用户名称" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >最后更改用户ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_update_user_id" inputName="最后更改用户ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >最后更改用户名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_update_user_name" inputName="最后更改用户名称" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >最后更改日期</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="最后更改日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
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
