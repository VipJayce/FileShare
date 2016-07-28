<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.epoffimpdata.vo.EpOffImpDataVo" %>
<%@ page import="rayoo.employeepost.epoffimpdata.util.IEpOffImpDataConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EpOffImpDataVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEpOffImpDataConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EpOffImpDataVo)request.getAttribute(IEpOffImpDataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EpOffImpDataAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >姓名</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="employee_name" inputName="姓名" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >唯一号</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="employee_code" inputName="唯一号" value="" maxLength="10" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >客户编号</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_code" inputName="客户编号" value="" maxLength="20" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >报离职时间</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="off_post_date" inputName="报离职时间" value="" maxLength="20" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >收费截止时间</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="end_date" inputName="收费截止时间" value="" maxLength="20" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >离职原因</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="off_reason" inputName="离职原因" value="" maxLength="40" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >离职备注</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="off_memo" inputName="离职备注" value="" maxLength="100" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >劳动手册领取方式</td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("labor_notebook_type", -1, gap.rm.project.RmGlobalReference.get(IEpOffImpDataConstants.DICTIONARY_), "", "inputName='劳动手册领取方式' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >公积金转移方式</td>
			<td class="td_2" >
				<%=gap.rm.tools.helper.RmJspHelper.getSelectField("acc_transfer_type", -1, gap.rm.project.RmGlobalReference.get(IEpOffImpDataConstants.DICTIONARY_), "", "inputName='公积金转移方式' ", true) %>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >退档地</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fire_address" inputName="退档地" value="" maxLength="20" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >imp_flag</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="imp_flag" inputName="imp_flag" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >failure_reason</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="failure_reason" inputName="failure_reason" value="" maxLength="20" />
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
            
<input type="hidden" name="batch_id" value="">
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
