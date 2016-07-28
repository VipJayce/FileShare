<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.received.fininvoice.vo.FininvoiceVo" %>
<%@ page import="rayoo.finance.received.fininvoice.util.IFininvoiceConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	FininvoiceVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IFininvoiceConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (FininvoiceVo)request.getAttribute(IFininvoiceConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FininvoiceAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >公司ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="公司ID" value="" maxLength="9.5" />
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
			<td class="td_1" >客户唯一号</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_code" inputName="客户唯一号" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >客户名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_name" inputName="客户名称" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >成本中心名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cost_center_name" inputName="成本中心名称" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >成本中心ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cost_center_id" inputName="成本中心ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >开票发票ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="invoice_id" inputName="开票发票ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >发票金额</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="amout" inputName="发票金额" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >发票状态</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="type_bd" inputName="发票状态" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="inv_desc" inputName="备注" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >取消日期</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="cancel_date" id="cancel_date" inputName="取消日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('cancel_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">取消原因</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="cancel_reason" inputName="取消原因" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >取消用户ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cancel_user_id" inputName="取消用户ID" value="" maxLength="9.5" />
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
