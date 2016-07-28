<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.pbcustomerservice.vo.PbcustomerserviceVo" %>
<%@ page import="rayoo.sales.pbcustomerservice.util.IPbcustomerserviceConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	PbcustomerserviceVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPbcustomerserviceConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (PbcustomerserviceVo)request.getAttribute(IPbcustomerserviceConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="rayoo.salse.pbcustomerservice.pbcustomerservice_resource" prefix="rayoo.salse.pbcustomerservice.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/PbcustomerserviceAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key="company_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="分公司ID" value="" maxLength="9.5" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span><fmt:message key="customer_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="customer_id" inputName="客户ID" value="" maxLength="9.5" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="contract_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="contract_id" inputName="合同ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="dept_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dept_id" inputName="经办人(客服)所属部门ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="user_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="user_id" inputName="经办人(客服)ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="user_name"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="user_name" inputName="用户名" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="role_type"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="role_type_bd" inputName="角色类型" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="effective_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="effective_date" id="effective_date" inputName="生效日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('effective_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="invalid_date"/></td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="invalid_date" id="invalid_date" inputName="失效日期" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('invalid_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
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
			<td class="td_1" ><fmt:message key="agent_id"/></td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="agent_id" inputName="供应商ID" value="" maxLength="9.5" />
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
