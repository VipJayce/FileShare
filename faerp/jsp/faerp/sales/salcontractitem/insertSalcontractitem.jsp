<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontractitem.vo.SalcontractitemVo" %>
<%@ page import="rayoo.sales.salcontractitem.util.ISalcontractitemConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	SalcontractitemVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ISalcontractitemConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SalcontractitemVo)request.getAttribute(ISalcontractitemConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/SalcontractitemAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/SalcontractitemAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/SalcontractitemAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" ><span class="style_required_red">* </span>合同ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="contract_id" inputName="合同ID" value="" maxLength="9.5" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >合同模板ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="contract_template_id" inputName="合同模板ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >合同模板子条款ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="contract_template_item_id" inputName="合同模板子条款ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>合同条款名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="contract_content_item_name" inputName="合同条款名称" value="" maxLength="50" validate="notNull;"/>
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">合同条款内容</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="contract_template_itme_content" inputName="合同条款内容" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >合同模板条款英文名称</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="english_name" inputName="合同模板条款英文名称" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">合同模板条款英文内容</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="english_content" inputName="合同模板条款英文内容" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td  class="td_1" >合同条款序列</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="serial_no" inputName="合同条款序列" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >合同条款父ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="parent_id" inputName="合同条款父ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >edit_type</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="edit_type" inputName="edit_type" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >node_type</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="node_type" inputName="node_type" value="" maxLength="1" />
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
